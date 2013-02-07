export Com_Error
code
proc Com_Error 1032 12
file "../ui_atoms.c"
line 16
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/**********************************************************************
;4:	UI_ATOMS.C
;5:
;6:	User interface building blocks and support functions.
;7:**********************************************************************/
;8:#include "ui_local.h"
;9:
;10:uiStatic_t		uis;
;11:qboolean		m_entersound;		// after a frame, so caching won't disrupt the sound
;12:
;13:// these are here so the functions in q_shared.c can link
;14:#ifndef UI_HARD_LINKED
;15:
;16:void QDECL Com_Error( int level, const char *error, ... ) {
line 20
;17:	va_list		argptr;
;18:	char		text[1024];
;19:
;20:	va_start (argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 21
;21:	vsprintf (text, error, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 22
;22:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 24
;23:
;24:	trap_Error( va("%s", text) );
ADDRGP4 $70
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 25
;25:}
LABELV $68
endproc Com_Error 1032 12
export Com_Printf
proc Com_Printf 1032 12
line 27
;26:
;27:void QDECL Com_Printf( const char *msg, ... ) {
line 31
;28:	va_list		argptr;
;29:	char		text[1024];
;30:
;31:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 32
;32:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 33
;33:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 35
;34:
;35:	trap_Print( va("%s", text) );
ADDRGP4 $70
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 36
;36:}
LABELV $71
endproc Com_Printf 1032 12
export UI_ClampCvar
proc UI_ClampCvar 0 0
line 46
;37:
;38:#endif
;39:
;40:/*
;41:=================
;42:UI_ClampCvar
;43:=================
;44:*/
;45:float UI_ClampCvar( float min, float max, float value )
;46:{
line 47
;47:	if ( value < min ) return min;
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRF4
GEF4 $74
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $73
JUMPV
LABELV $74
line 48
;48:	if ( value > max ) return max;
ADDRFP4 8
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $76
ADDRFP4 4
INDIRF4
RETF4
ADDRGP4 $73
JUMPV
LABELV $76
line 49
;49:	return value;
ADDRFP4 8
INDIRF4
RETF4
LABELV $73
endproc UI_ClampCvar 0 0
export UI_StartDemoLoop
proc UI_StartDemoLoop 0 8
line 57
;50:}
;51:
;52:/*
;53:=================
;54:UI_StartDemoLoop
;55:=================
;56:*/
;57:void UI_StartDemoLoop( void ) {
line 58
;58:	trap_Cmd_ExecuteText( EXEC_APPEND, "d1\n" );
CNSTI4 2
ARGI4
ADDRGP4 $79
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 59
;59:}
LABELV $78
endproc UI_StartDemoLoop 0 8
export UI_PushMenu
proc UI_PushMenu 16 8
line 67
;60:
;61:/*
;62:=================
;63:UI_PushMenu
;64:=================
;65:*/
;66:void UI_PushMenu( menuframework_s *menu )
;67:{
line 72
;68:	int				i;
;69:	menucommon_s*	item;
;70:
;71:	// avoid stacking menus invoked by hotkeys
;72:	for (i=0 ; i<uis.menusp ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $84
JUMPV
LABELV $81
line 73
;73:	{
line 74
;74:		if (uis.stack[i] == menu)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+24
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $86
line 75
;75:		{
line 76
;76:			uis.menusp = i;
ADDRGP4 uis+16
ADDRLP4 0
INDIRI4
ASGNI4
line 77
;77:			break;
ADDRGP4 $83
JUMPV
LABELV $86
line 79
;78:		}
;79:	}
LABELV $82
line 72
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $84
ADDRLP4 0
INDIRI4
ADDRGP4 uis+16
INDIRI4
LTI4 $81
LABELV $83
line 81
;80:
;81:	if (i == uis.menusp)
ADDRLP4 0
INDIRI4
ADDRGP4 uis+16
INDIRI4
NEI4 $90
line 82
;82:	{
line 83
;83:		if (uis.menusp >= MAX_MENUDEPTH)
ADDRGP4 uis+16
INDIRI4
CNSTI4 8
LTI4 $93
line 84
;84:			trap_Error("UI_PushMenu: menu stack overflow");
ADDRGP4 $96
ARGP4
ADDRGP4 trap_Error
CALLV
pop
LABELV $93
line 86
;85:
;86:		uis.stack[uis.menusp++] = menu;
ADDRLP4 12
ADDRGP4 uis+16
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+24
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 87
;87:	}
LABELV $90
line 89
;88:
;89:	uis.activemenu = menu;
ADDRGP4 uis+20
ADDRFP4 0
INDIRP4
ASGNP4
line 92
;90:
;91:	// default cursor position
;92:	menu->cursor      = 0;
ADDRFP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 93
;93:	menu->cursor_prev = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 95
;94:
;95:	m_entersound = qtrue;
ADDRGP4 m_entersound
CNSTI4 1
ASGNI4
line 97
;96:
;97:	trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 100
;98:
;99:	// force first available item to have focus
;100:	for (i=0; i<menu->nitems; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $103
JUMPV
LABELV $100
line 101
;101:	{
line 102
;102:		item = (menucommon_s *)menu->items[i];
ADDRLP4 4
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
ASGNP4
line 103
;103:		if (!(item->flags & (QMF_GRAYED|QMF_MOUSEONLY|QMF_INACTIVE)))
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 26624
BANDU4
CNSTU4 0
NEU4 $104
line 104
;104:		{
line 105
;105:			menu->cursor_prev = -1;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 -1
ASGNI4
line 106
;106:			Menu_SetCursor( menu, i );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 107
;107:			break;
ADDRGP4 $102
JUMPV
LABELV $104
line 109
;108:		}
;109:	}
LABELV $101
line 100
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $103
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $100
LABELV $102
line 111
;110:
;111:	uis.firstdraw = qtrue;
ADDRGP4 uis+11448
CNSTI4 1
ASGNI4
line 112
;112:}
LABELV $80
endproc UI_PushMenu 16 8
export UI_PopMenu
proc UI_PopMenu 4 8
line 120
;113:
;114:/*
;115:=================
;116:UI_PopMenu
;117:=================
;118:*/
;119:void UI_PopMenu (void)
;120:{
line 121
;121:	trap_S_StartLocalSound( menu_out_sound, CHAN_LOCAL_SOUND );
ADDRGP4 menu_out_sound
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 123
;122:
;123:	uis.menusp--;
ADDRLP4 0
ADDRGP4 uis+16
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 125
;124:
;125:	if (uis.menusp < 0)
ADDRGP4 uis+16
INDIRI4
CNSTI4 0
GEI4 $109
line 126
;126:		trap_Error ("UI_PopMenu: menu stack underflow");
ADDRGP4 $112
ARGP4
ADDRGP4 trap_Error
CALLV
pop
LABELV $109
line 128
;127:
;128:	if (uis.menusp) {
ADDRGP4 uis+16
INDIRI4
CNSTI4 0
EQI4 $113
line 129
;129:		uis.activemenu = uis.stack[uis.menusp-1];
ADDRGP4 uis+20
ADDRGP4 uis+16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+24-4
ADDP4
INDIRP4
ASGNP4
line 130
;130:		uis.firstdraw = qtrue;
ADDRGP4 uis+11448
CNSTI4 1
ASGNI4
line 131
;131:	}
ADDRGP4 $114
JUMPV
LABELV $113
line 132
;132:	else {
line 133
;133:		UI_ForceMenuOff ();
ADDRGP4 UI_ForceMenuOff
CALLV
pop
line 134
;134:	}
LABELV $114
line 135
;135:}
LABELV $107
endproc UI_PopMenu 4 8
export UI_ForceMenuOff
proc UI_ForceMenuOff 4 8
line 138
;136:
;137:void UI_ForceMenuOff (void)
;138:{
line 139
;139:	uis.menusp     = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 140
;140:	uis.activemenu = NULL;
ADDRGP4 uis+20
CNSTP4 0
ASGNP4
line 142
;141:
;142:	trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 143
;143:	trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 144
;144:	trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $124
ARGP4
ADDRGP4 $125
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 145
;145:}
LABELV $121
endproc UI_ForceMenuOff 4 8
export UI_LerpColor
proc UI_LerpColor 12 0
line 153
;146:
;147:/*
;148:=================
;149:UI_LerpColor
;150:=================
;151:*/
;152:void UI_LerpColor(vec4_t a, vec4_t b, vec4_t c, float t)
;153:{
line 157
;154:	int i;
;155:
;156:	// lerp and clamp each component
;157:	for (i=0; i<4; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $127
line 158
;158:	{
line 159
;159:		c[i] = a[i] + t*(b[i]-a[i]);
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 8
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 160
;160:		if (c[i] < 0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $131
line 161
;161:			c[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $132
JUMPV
LABELV $131
line 162
;162:		else if (c[i] > 1.0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $133
line 163
;163:			c[i] = 1.0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $133
LABELV $132
line 164
;164:	}
LABELV $128
line 157
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $127
line 165
;165:}
LABELV $126
endproc UI_LerpColor 12 0
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
line 326
;166:
;167:/*
;168:=================
;169:UI_DrawProportionalString2
;170:=================
;171:*/
;172:static int	propMap[128][3] = {
;173:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;174:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;175:
;176:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;177:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;178:
;179:{0, 0, PROP_SPACE_WIDTH},		// SPACE
;180:{11, 122, 7},	// !
;181:{154, 181, 14},	// "
;182:{55, 122, 17},	// #
;183:{79, 122, 18},	// $
;184:{101, 122, 23},	// %
;185:{153, 122, 18},	// &
;186:{9, 93, 7},		// '
;187:{207, 122, 8},	// (
;188:{230, 122, 9},	// )
;189:{177, 122, 18},	// *
;190:{30, 152, 18},	// +
;191:{85, 181, 7},	// ,
;192:{34, 93, 11},	// -
;193:{110, 181, 6},	// .
;194:{130, 152, 14},	// /
;195:
;196:{22, 64, 17},	// 0
;197:{41, 64, 12},	// 1
;198:{58, 64, 17},	// 2
;199:{78, 64, 18},	// 3
;200:{98, 64, 19},	// 4
;201:{120, 64, 18},	// 5
;202:{141, 64, 18},	// 6
;203:{204, 64, 16},	// 7
;204:{162, 64, 17},	// 8
;205:{182, 64, 18},	// 9
;206:{59, 181, 7},	// :
;207:{35,181, 7},	// ;
;208:{203, 152, 14},	// <
;209:{56, 93, 14},	// =
;210:{228, 152, 14},	// >
;211:{177, 181, 18},	// ?
;212:
;213:{28, 122, 22},	// @
;214:{5, 4, 18},		// A
;215:{27, 4, 18},	// B
;216:{48, 4, 18},	// C
;217:{69, 4, 17},	// D
;218:{90, 4, 13},	// E
;219:{106, 4, 13},	// F
;220:{121, 4, 18},	// G
;221:{143, 4, 17},	// H
;222:{164, 4, 8},	// I
;223:{175, 4, 16},	// J
;224:{195, 4, 18},	// K
;225:{216, 4, 12},	// L
;226:{230, 4, 23},	// M
;227:{6, 34, 18},	// N
;228:{27, 34, 18},	// O
;229:
;230:{48, 34, 18},	// P
;231:{68, 34, 18},	// Q
;232:{90, 34, 17},	// R
;233:{110, 34, 18},	// S
;234:{130, 34, 14},	// T
;235:{146, 34, 18},	// U
;236:{166, 34, 19},	// V
;237:{185, 34, 29},	// W
;238:{215, 34, 18},	// X
;239:{234, 34, 18},	// Y
;240:{5, 64, 14},	// Z
;241:{60, 152, 7},	// [
;242:{106, 151, 13},	// '\'
;243:{83, 152, 7},	// ]
;244:{128, 122, 17},	// ^
;245:{4, 152, 21},	// _
;246:
;247:{134, 181, 5},	// '
;248:{5, 4, 18},		// A
;249:{27, 4, 18},	// B
;250:{48, 4, 18},	// C
;251:{69, 4, 17},	// D
;252:{90, 4, 13},	// E
;253:{106, 4, 13},	// F
;254:{121, 4, 18},	// G
;255:{143, 4, 17},	// H
;256:{164, 4, 8},	// I
;257:{175, 4, 16},	// J
;258:{195, 4, 18},	// K
;259:{216, 4, 12},	// L
;260:{230, 4, 23},	// M
;261:{6, 34, 18},	// N
;262:{27, 34, 18},	// O
;263:
;264:{48, 34, 18},	// P
;265:{68, 34, 18},	// Q
;266:{90, 34, 17},	// R
;267:{110, 34, 18},	// S
;268:{130, 34, 14},	// T
;269:{146, 34, 18},	// U
;270:{166, 34, 19},	// V
;271:{185, 34, 29},	// W
;272:{215, 34, 18},	// X
;273:{234, 34, 18},	// Y
;274:{5, 64, 14},	// Z
;275:{153, 152, 13},	// {
;276:{11, 181, 5},	// |
;277:{180, 152, 13},	// }
;278:{79, 93, 17},	// ~
;279:{0, 0, -1}		// DEL
;280:};
;281:
;282:static int propMapB[26][3] = {
;283:{11, 12, 33},
;284:{49, 12, 31},
;285:{85, 12, 31},
;286:{120, 12, 30},
;287:{156, 12, 21},
;288:{183, 12, 21},
;289:{207, 12, 32},
;290:
;291:{13, 55, 30},
;292:{49, 55, 13},
;293:{66, 55, 29},
;294:{101, 55, 31},
;295:{135, 55, 21},
;296:{158, 55, 40},
;297:{204, 55, 32},
;298:
;299:{12, 97, 31},
;300:{48, 97, 31},
;301:{82, 97, 30},
;302:{118, 97, 30},
;303:{153, 97, 30},
;304:{185, 97, 25},
;305:{213, 97, 30},
;306:
;307:{11, 139, 32},
;308:{42, 139, 51},
;309:{93, 139, 32},
;310:{126, 139, 31},
;311:{158, 139, 25},
;312:};
;313:
;314:#define PROPB_GAP_WIDTH		4
;315:#define PROPB_SPACE_WIDTH	12
;316:#define PROPB_HEIGHT		36
;317:
;318:// bk001205 - code below duplicated in cgame/cg_drawtools.c
;319:// bk001205 - FIXME: does this belong in ui_shared.c?
;320:/*
;321:=================
;322:UI_DrawBannerString
;323:=================
;324:*/
;325:static void UI_DrawBannerString2( int x, int y, const char* str, vec4_t color )
;326:{
line 339
;327:	const char* s;
;328:	unsigned char	ch; // bk001204 - unsigned
;329:	float	ax;
;330:	float	ay;
;331:	float	aw;
;332:	float	ah;
;333:	float	frow;
;334:	float	fcol;
;335:	float	fwidth;
;336:	float	fheight;
;337:
;338:	// draw the colored text
;339:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 341
;340:	
;341:	ax = x * uis.scale + uis.bias;
ADDRLP4 8
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 uis+11436
INDIRF4
MULF4
ADDRGP4 uis+11440
INDIRF4
ADDF4
ASGNF4
line 342
;342:	ay = y * uis.scale;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 uis+11436
INDIRF4
MULF4
ASGNF4
line 344
;343:
;344:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $140
JUMPV
LABELV $139
line 346
;345:	while ( *s )
;346:	{
line 347
;347:		ch = *s & 127;
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
line 348
;348:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $142
line 349
;349:			ax += ((float)PROPB_SPACE_WIDTH + (float)PROPB_GAP_WIDTH)* uis.scale;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1098907648
ADDRGP4 uis+11436
INDIRF4
MULF4
ADDF4
ASGNF4
line 350
;350:		}
ADDRGP4 $143
JUMPV
LABELV $142
line 351
;351:		else if ( ch >= 'A' && ch <= 'Z' ) {
ADDRLP4 40
ADDRLP4 0
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 65
LTI4 $145
ADDRLP4 40
INDIRI4
CNSTI4 90
GTI4 $145
line 352
;352:			ch -= 'A';
ADDRLP4 0
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 65
SUBI4
CVIU4 4
CVUU1 4
ASGNU1
line 353
;353:			fcol = (float)propMapB[ch][0] / 256.0f;
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
line 354
;354:			frow = (float)propMapB[ch][1] / 256.0f;
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
line 355
;355:			fwidth = (float)propMapB[ch][2] / 256.0f;
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
line 356
;356:			fheight = (float)PROPB_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1041235968
ASGNF4
line 357
;357:			aw = (float)propMapB[ch][2] * uis.scale;
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
ADDRGP4 uis+11436
INDIRF4
MULF4
ASGNF4
line 358
;358:			ah = (float)PROPB_HEIGHT * uis.scale;
ADDRLP4 24
CNSTF4 1108344832
ADDRGP4 uis+11436
INDIRF4
MULF4
ASGNF4
line 359
;359:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, uis.charsetPropB );
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
ADDRGP4 uis+11416
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 360
;360:			ax += (aw + (float)PROPB_GAP_WIDTH * uis.scale);
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1082130432
ADDRGP4 uis+11436
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 361
;361:		}
LABELV $145
LABELV $143
line 362
;362:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 363
;363:	}
LABELV $140
line 345
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $139
line 365
;364:
;365:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 366
;366:}
LABELV $135
endproc UI_DrawBannerString2 52 36
export UI_DrawBannerString
proc UI_DrawBannerString 44 16
line 368
;367:
;368:void UI_DrawBannerString( int x, int y, const char* str, int style, vec4_t color ) {
line 375
;369:	const char *	s;
;370:	int				ch;
;371:	int				width;
;372:	vec4_t			drawcolor;
;373:
;374:	// find the width of the drawn text
;375:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
line 376
;376:	width = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $156
JUMPV
LABELV $155
line 377
;377:	while ( *s ) {
line 378
;378:		ch = *s;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 379
;379:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRI4
CNSTI4 32
NEI4 $158
line 380
;380:			width += PROPB_SPACE_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
line 381
;381:		}
ADDRGP4 $159
JUMPV
LABELV $158
line 382
;382:		else if ( ch >= 'A' && ch <= 'Z' ) {
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $160
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $160
line 383
;383:			width += propMapB[ch - 'A'][2] + PROPB_GAP_WIDTH;
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
line 384
;384:		}
LABELV $160
LABELV $159
line 385
;385:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 386
;386:	}
LABELV $156
line 377
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $155
line 387
;387:	width -= PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 389
;388:
;389:	switch( style & UI_FORMATMASK ) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $165
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $167
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $168
ADDRGP4 $165
JUMPV
LABELV $167
line 391
;390:		case UI_CENTER:
;391:			x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 392
;392:			break;
ADDRGP4 $165
JUMPV
LABELV $168
line 395
;393:
;394:		case UI_RIGHT:
;395:			x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 396
;396:			break;
line 400
;397:
;398:		case UI_LEFT:
;399:		default:
;400:			break;
LABELV $165
line 403
;401:	}
;402:
;403:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $170
line 404
;404:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
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
line 405
;405:		drawcolor[3] = color[3];
ADDRLP4 12+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 406
;406:		UI_DrawBannerString2( x+2, y+2, str, drawcolor );
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
line 407
;407:	}
LABELV $170
line 409
;408:
;409:	UI_DrawBannerString2( x, y, str, color );
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
line 410
;410:}
LABELV $154
endproc UI_DrawBannerString 44 16
export UI_ProportionalStringWidth
proc UI_ProportionalStringWidth 16 0
line 413
;411:
;412:
;413:int UI_ProportionalStringWidth( const char* str ) {
line 419
;414:	const char *	s;
;415:	int				ch;
;416:	int				charWidth;
;417:	int				width;
;418:
;419:	s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 420
;420:	width = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $177
JUMPV
LABELV $176
line 421
;421:	while ( *s ) {
line 422
;422:		ch = *s & 127;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
ASGNI4
line 423
;423:		charWidth = propMap[ch][2];
ADDRLP4 4
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
ASGNI4
line 424
;424:		if ( charWidth != -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $180
line 425
;425:			width += charWidth;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 426
;426:			width += PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 427
;427:		}
LABELV $180
line 428
;428:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 429
;429:	}
LABELV $177
line 421
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $176
line 431
;430:
;431:	width -= PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
SUBI4
ASGNI4
line 432
;432:	return width;
ADDRLP4 12
INDIRI4
RETI4
LABELV $175
endproc UI_ProportionalStringWidth 16 0
proc UI_DrawProportionalString2 48 36
line 436
;433:}
;434:
;435:static void UI_DrawProportionalString2( int x, int y, const char* str, vec4_t color, float sizeScale, qhandle_t charset )
;436:{
line 441
;437:	const char* s;
;438:	unsigned char	ch; // bk001204 - unsigned
;439:	float	ax;
;440:	float	ay;
;441:	float	aw = 0; // bk001204 - init
ADDRLP4 8
CNSTF4 0
ASGNF4
line 449
;442:	float	ah;
;443:	float	frow;
;444:	float	fcol;
;445:	float	fwidth;
;446:	float	fheight;
;447:
;448:	// draw the colored text
;449:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 451
;450:	
;451:	ax = x * uis.scale + uis.bias;
ADDRLP4 12
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 uis+11436
INDIRF4
MULF4
ADDRGP4 uis+11440
INDIRF4
ADDF4
ASGNF4
line 452
;452:	ay = y * uis.scale;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 uis+11436
INDIRF4
MULF4
ASGNF4
line 454
;453:
;454:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $187
JUMPV
LABELV $186
line 456
;455:	while ( *s )
;456:	{
line 457
;457:		ch = *s & 127;
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
line 458
;458:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $189
line 459
;459:			aw = (float)PROP_SPACE_WIDTH * uis.scale * sizeScale;
ADDRLP4 8
CNSTF4 1090519040
ADDRGP4 uis+11436
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 460
;460:		}
ADDRGP4 $190
JUMPV
LABELV $189
line 461
;461:		else if ( propMap[ch][2] != -1 ) {
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $192
line 462
;462:			fcol = (float)propMap[ch][0] / 256.0f;
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
line 463
;463:			frow = (float)propMap[ch][1] / 256.0f;
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
line 464
;464:			fwidth = (float)propMap[ch][2] / 256.0f;
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
line 465
;465:			fheight = (float)PROP_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1037565952
ASGNF4
line 466
;466:			aw = (float)propMap[ch][2] * uis.scale * sizeScale;
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
ADDRGP4 uis+11436
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 467
;467:			ah = (float)PROP_HEIGHT * uis.scale * sizeScale;
ADDRLP4 24
CNSTF4 1104674816
ADDRGP4 uis+11436
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 468
;468:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, charset );
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
line 469
;469:		}
LABELV $192
LABELV $190
line 471
;470:
;471:		ax += (aw + (float)PROP_GAP_WIDTH * uis.scale * sizeScale);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1077936128
ADDRGP4 uis+11436
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 472
;472:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 473
;473:	}
LABELV $187
line 455
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $186
line 475
;474:
;475:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 476
;476:}
LABELV $182
endproc UI_DrawProportionalString2 48 36
export UI_ProportionalSizeScale
proc UI_ProportionalSizeScale 0 0
line 483
;477:
;478:/*
;479:=================
;480:UI_ProportionalSizeScale
;481:=================
;482:*/
;483:float UI_ProportionalSizeScale( int style ) {
line 484
;484:	if ( style & UI_EXTRASMALLFONT ) {
ADDRFP4 0
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $202
line 485
;485:		return 0.40f;
CNSTF4 1053609165
RETF4
ADDRGP4 $201
JUMPV
LABELV $202
line 487
;486:	}
;487:	if ( style & UI_SMALLFONT ) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $204
line 488
;488:		return PROP_SMALL_SIZE_SCALE;
CNSTF4 1061158912
RETF4
ADDRGP4 $201
JUMPV
LABELV $204
line 491
;489:	}
;490:
;491:	return 1.00;
CNSTF4 1065353216
RETF4
LABELV $201
endproc UI_ProportionalSizeScale 0 0
export UI_DrawProportionalString
proc UI_DrawProportionalString 36 24
line 500
;492:}
;493:
;494:
;495:/*
;496:=================
;497:UI_DrawProportionalString
;498:=================
;499:*/
;500:void UI_DrawProportionalString( int x, int y, const char* str, int style, float sizeScale, vec4_t color ) {
line 507
;501:	vec4_t	drawcolor;
;502:	int		width;
;503:	//float	sizeScale;
;504:
;505:	//sizeScale = UI_ProportionalSizeScale( style );
;506:
;507:	switch( style & UI_FORMATMASK ) {
ADDRLP4 20
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $208
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $210
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $211
ADDRGP4 $208
JUMPV
LABELV $210
line 509
;508:		case UI_CENTER:
;509:			width = UI_ProportionalStringWidth( str ) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRFP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 510
;510:			x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 511
;511:			break;
ADDRGP4 $208
JUMPV
LABELV $211
line 514
;512:
;513:		case UI_RIGHT:
;514:			width = UI_ProportionalStringWidth( str ) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
CVIF4 4
ADDRFP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 515
;515:			x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ASGNI4
line 516
;516:			break;
line 520
;517:
;518:		case UI_LEFT:
;519:		default:
;520:			break;
LABELV $208
line 523
;521:	}
;522:
;523:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $213
line 524
;524:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ASGNF4
line 525
;525:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 526
;526:		UI_DrawProportionalString2( x+2, y+2, str, drawcolor, sizeScale, uis.charsetProp );
ADDRLP4 32
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 32
INDIRI4
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
ADDRLP4 32
INDIRI4
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 uis+11408
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 527
;527:	}
LABELV $213
line 529
;528:
;529:	if ( style & UI_INVERSE ) {
ADDRFP4 12
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $219
line 530
;530:		drawcolor[0] = color[0] * 0.7;
ADDRLP4 0
CNSTF4 1060320051
ADDRFP4 20
INDIRP4
INDIRF4
MULF4
ASGNF4
line 531
;531:		drawcolor[1] = color[1] * 0.7;
ADDRLP4 0+4
CNSTF4 1060320051
ADDRFP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
line 532
;532:		drawcolor[2] = color[2] * 0.7;
ADDRLP4 0+8
CNSTF4 1060320051
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 533
;533:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 534
;534:		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, uis.charsetProp );
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
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 uis+11408
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 535
;535:		return;
ADDRGP4 $206
JUMPV
LABELV $219
line 538
;536:	}
;537:
;538:	if ( style & UI_PULSE ) {
ADDRFP4 12
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $225
line 539
;539:		drawcolor[0] = color[0] * 0.7;
ADDRLP4 0
CNSTF4 1060320051
ADDRFP4 20
INDIRP4
INDIRF4
MULF4
ASGNF4
line 540
;540:		drawcolor[1] = color[1] * 0.7;
ADDRLP4 0+4
CNSTF4 1060320051
ADDRFP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
line 541
;541:		drawcolor[2] = color[2] * 0.7;
ADDRLP4 0+8
CNSTF4 1060320051
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 542
;542:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 543
;543:		UI_DrawProportionalString2( x, y, str, color, sizeScale, uis.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 uis+11408
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 545
;544:
;545:		drawcolor[0] = color[0];
ADDRLP4 0
ADDRFP4 20
INDIRP4
INDIRF4
ASGNF4
line 546
;546:		drawcolor[1] = color[1];
ADDRLP4 0+4
ADDRFP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 547
;547:		drawcolor[2] = color[2];
ADDRLP4 0+8
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 548
;548:		drawcolor[3] = 0.5 + 0.5 * sin( uis.realtime / PULSE_DIVISOR );
ADDRGP4 uis+4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+12
CNSTF4 1056964608
ADDRLP4 28
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 549
;549:		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, uis.charsetPropGlow );
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
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 uis+11412
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 550
;550:		return;
ADDRGP4 $206
JUMPV
LABELV $225
line 553
;551:	}
;552:
;553:	UI_DrawProportionalString2( x, y, str, color, sizeScale, uis.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 uis+11408
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 554
;554:}
LABELV $206
endproc UI_DrawProportionalString 36 24
export UI_DrawProportionalString_AutoWrapped
proc UI_DrawProportionalString_AutoWrapped 1064 24
line 561
;555:
;556:/*
;557:=================
;558:UI_DrawProportionalString_Wrapped
;559:=================
;560:*/
;561:void UI_DrawProportionalString_AutoWrapped( int x, int y, int xmax, int ystep, const char* str, int style, vec4_t color ) {
line 568
;562:	int width;
;563:	char *s1,*s2,*s3;
;564:	char c_bcp;
;565:	char buf[1024];
;566:	float   sizeScale;
;567:
;568:	if (!str || str[0]=='\0')
ADDRLP4 1048
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $240
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $238
LABELV $240
line 569
;569:		return;
ADDRGP4 $237
JUMPV
LABELV $238
line 571
;570:	
;571:	sizeScale = UI_ProportionalSizeScale( style );
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 1052
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 1052
INDIRF4
ASGNF4
line 573
;572:	
;573:	Q_strncpyz(buf, str, sizeof(buf));
ADDRLP4 24
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 574
;574:	s1 = s2 = s3 = buf;
ADDRLP4 0
ADDRLP4 24
ASGNP4
ADDRLP4 4
ADDRLP4 24
ASGNP4
ADDRLP4 12
ADDRLP4 24
ASGNP4
ADDRGP4 $242
JUMPV
LABELV $241
line 576
;575:
;576:	while (1) {
LABELV $244
line 577
;577:		do {
line 578
;578:			s3++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 579
;579:		} while (*s3!=' ' && *s3!='\0');
LABELV $245
ADDRLP4 1056
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 32
EQI4 $247
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $244
LABELV $247
line 580
;580:		c_bcp = *s3;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 581
;581:		*s3 = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 582
;582:		width = UI_ProportionalStringWidth(s1) * sizeScale;
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 1060
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 583
;583:		*s3 = c_bcp;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI1
ASGNI1
line 584
;584:		if (width > xmax) {
ADDRLP4 16
INDIRI4
ADDRFP4 8
INDIRI4
LEI4 $248
line 585
;585:			if (s1==s2)
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $250
line 586
;586:			{
line 588
;587:				// fuck, don't have a clean cut, we'll overflow
;588:				s2 = s3;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 589
;589:			}
LABELV $250
line 590
;590:			*s2 = '\0';
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 591
;591:			UI_DrawProportionalString(x, y, s1, style, sizeScale, color);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRF4
ARGF4
ADDRFP4 24
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 592
;592:			y += ystep;
ADDRFP4 4
ADDRFP4 4
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
ASGNI4
line 593
;593:			if (c_bcp == '\0')
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $252
line 594
;594:      {
line 599
;595:        // that was the last word
;596:        // we could start a new loop, but that wouldn't be much use
;597:        // even if the word is too long, we would overflow it (see above)
;598:        // so just print it now if needed
;599:        s2++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 600
;600:        if (*s2 != '\0') // if we are printing an overflowing line we have s2 == s3
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $243
line 601
;601:          UI_DrawProportionalString(x, y, s2, style, sizeScale, color);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRF4
ARGF4
ADDRFP4 24
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 602
;602:				break; 
ADDRGP4 $243
JUMPV
LABELV $252
line 604
;603:      }
;604:			s2++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 605
;605:			s1 = s2;
ADDRLP4 12
ADDRLP4 4
INDIRP4
ASGNP4
line 606
;606:			s3 = s2;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 607
;607:		} else {
ADDRGP4 $249
JUMPV
LABELV $248
line 608
;608:			s2 = s3;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 609
;609:			if (c_bcp == '\0') // we reached the end
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $256
line 610
;610:			{
line 611
;611:				UI_DrawProportionalString(x, y, s1, style, sizeScale, color);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRF4
ARGF4
ADDRFP4 24
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 612
;612:				break;
ADDRGP4 $243
JUMPV
LABELV $256
line 614
;613:			}
;614:		}
LABELV $249
line 615
;615:	}
LABELV $242
line 576
ADDRGP4 $241
JUMPV
LABELV $243
line 616
;616:}
LABELV $237
endproc UI_DrawProportionalString_AutoWrapped 1064 24
proc UI_DrawString2 76 36
line 624
;617:
;618:/*
;619:=================
;620:UI_DrawString2
;621:=================
;622:*/
;623:static void UI_DrawString2( int x, int y, const char* str, vec4_t color, int charw, int charh )
;624:{
line 627
;625:	const char* s;
;626:	char	ch;
;627:	int forceColor = qfalse; //APSFIXME;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 636
;628:	vec4_t	tempcolor;
;629:	float	ax;
;630:	float	ay;
;631:	float	aw;
;632:	float	ah;
;633:	float	frow;
;634:	float	fcol;
;635:
;636:	if (y < -charh)
ADDRFP4 4
INDIRI4
ADDRFP4 20
INDIRI4
NEGI4
GEI4 $259
line 638
;637:		// offscreen
;638:		return;
ADDRGP4 $258
JUMPV
LABELV $259
line 641
;639:
;640:	// draw the colored text
;641:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 643
;642:	
;643:	ax = x * uis.scale + uis.bias;
ADDRLP4 8
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 uis+11436
INDIRF4
MULF4
ADDRGP4 uis+11440
INDIRF4
ADDF4
ASGNF4
line 644
;644:	ay = y * uis.scale;
ADDRLP4 44
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 uis+11436
INDIRF4
MULF4
ASGNF4
line 645
;645:	aw = charw * uis.scale;
ADDRLP4 12
ADDRFP4 16
INDIRI4
CVIF4 4
ADDRGP4 uis+11436
INDIRF4
MULF4
ASGNF4
line 646
;646:	ah = charh * uis.scale;
ADDRLP4 48
ADDRFP4 20
INDIRI4
CVIF4 4
ADDRGP4 uis+11436
INDIRF4
MULF4
ASGNF4
line 648
;647:
;648:	s = str;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $267
JUMPV
LABELV $266
line 649
;649:	while ( *s ) {
line 650
;650:		if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $269
ADDRLP4 56
CNSTI4 94
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 56
INDIRI4
NEI4 $269
ADDRLP4 60
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $269
ADDRLP4 60
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $269
line 651
;651:			if ( !forceColor ) {
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $271
line 652
;652:				memcpy( tempcolor, g_color_table[ColorIndex(s[1])], sizeof( tempcolor ) );
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 64
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 24
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
line 653
;653:				tempcolor[3] = color[3];
ADDRLP4 24+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 654
;654:				trap_R_SetColor( tempcolor );
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 655
;655:			}
LABELV $271
line 656
;656:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 657
;657:			continue;
ADDRGP4 $267
JUMPV
LABELV $269
line 660
;658:		}
;659:
;660:		ch = *s & 255;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CVII1 4
ASGNI1
line 661
;661:		if (ch != ' ') {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $274
line 662
;662:			frow = (ch>>4)*0.0625;
ADDRLP4 16
CNSTF4 1031798784
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 4
RSHI4
CVIF4 4
MULF4
ASGNF4
line 663
;663:			fcol = (ch&15)*0.0625;
ADDRLP4 20
CNSTF4 1031798784
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 15
BANDI4
CVIF4 4
MULF4
ASGNF4
line 664
;664:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + 0.0625, frow + 0.0625, uis.charset );
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 72
CNSTF4 1031798784
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ARGF4
ADDRGP4 uis+11404
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 665
;665:		}
LABELV $274
line 667
;666:
;667:		ax += aw;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
line 668
;668:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 669
;669:	}
LABELV $267
line 649
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $266
line 671
;670:
;671:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 672
;672:}
LABELV $258
endproc UI_DrawString2 76 36
export UI_DrawString
proc UI_DrawString 92 24
line 680
;673:
;674:/*
;675:=================
;676:UI_DrawString
;677:=================
;678:*/
;679:void UI_DrawString( int x, int y, const char* str, int style, vec4_t color )
;680:{
line 689
;681:	int		len;
;682:	int		charw;
;683:	int		charh;
;684:	vec4_t	newcolor;
;685:	vec4_t	lowlight;
;686:	float	*drawcolor;
;687:	vec4_t	dropcolor;
;688:
;689:	if( !str ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $278
line 690
;690:		return;
ADDRGP4 $277
JUMPV
LABELV $278
line 693
;691:	}
;692:
;693:	if ((style & UI_BLINK) && ((uis.realtime/BLINK_DIVISOR) & 1))
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRFP4 12
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 64
INDIRI4
EQI4 $280
ADDRGP4 uis+4
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
ADDRLP4 64
INDIRI4
EQI4 $280
line 694
;694:		return;
ADDRGP4 $277
JUMPV
LABELV $280
line 696
;695:
;696:	if (style & UI_SMALLFONT || style & UI_EXTRASMALLFONT) {
ADDRLP4 68
ADDRFP4 12
INDIRI4
ASGNI4
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 72
INDIRI4
NEI4 $285
ADDRLP4 68
INDIRI4
CNSTI4 32768
BANDI4
ADDRLP4 72
INDIRI4
EQI4 $283
LABELV $285
line 697
;697:		charw =	SMALLCHAR_WIDTH;
ADDRLP4 0
CNSTI4 8
ASGNI4
line 698
;698:		charh =	SMALLCHAR_HEIGHT;
ADDRLP4 4
CNSTI4 16
ASGNI4
line 699
;699:	} else if (style & UI_GIANTFONT) {
ADDRGP4 $284
JUMPV
LABELV $283
ADDRFP4 12
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $286
line 700
;700:		charw =	GIANTCHAR_WIDTH;
ADDRLP4 0
CNSTI4 32
ASGNI4
line 701
;701:		charh =	GIANTCHAR_HEIGHT;
ADDRLP4 4
CNSTI4 48
ASGNI4
line 702
;702:	} else {
ADDRGP4 $287
JUMPV
LABELV $286
line 703
;703:		charw =	BIGCHAR_WIDTH;
ADDRLP4 0
CNSTI4 16
ASGNI4
line 704
;704:		charh =	BIGCHAR_HEIGHT;
ADDRLP4 4
CNSTI4 16
ASGNI4
line 705
;705:	}
LABELV $287
LABELV $284
line 707
;706:
;707:	if (style & UI_PULSE) {
ADDRFP4 12
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $288
line 708
;708:		lowlight[0] = 0.8*color[0]; 
ADDRLP4 8
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
INDIRF4
MULF4
ASGNF4
line 709
;709:		lowlight[1] = 0.8*color[1];
ADDRLP4 8+4
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
line 710
;710:		lowlight[2] = 0.8*color[2];
ADDRLP4 8+8
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 711
;711:		lowlight[3] = 0.8*color[3];
ADDRLP4 8+12
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ASGNF4
line 712
;712:		UI_LerpColor(color,lowlight,newcolor,0.5+0.5*sin(uis.realtime/PULSE_DIVISOR));
ADDRGP4 uis+4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 76
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 44
ARGP4
CNSTF4 1056964608
ADDRLP4 76
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 UI_LerpColor
CALLV
pop
line 713
;713:		drawcolor = newcolor;
ADDRLP4 24
ADDRLP4 44
ASGNP4
line 714
;714:	} else
ADDRGP4 $289
JUMPV
LABELV $288
line 715
;715:		drawcolor = color;
ADDRLP4 24
ADDRFP4 16
INDIRP4
ASGNP4
LABELV $289
line 717
;716:
;717:	switch (style & UI_FORMATMASK) {
ADDRLP4 76
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 1
EQI4 $297
ADDRLP4 76
INDIRI4
CNSTI4 2
EQI4 $298
ADDRGP4 $295
JUMPV
LABELV $297
line 720
;718:		case UI_CENTER:
;719:			// center justify at x
;720:			len = strlen(str);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 84
INDIRI4
ASGNI4
line 721
;721:			x   = x - len*charw/2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 60
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 722
;722:			break;
ADDRGP4 $295
JUMPV
LABELV $298
line 726
;723:
;724:		case UI_RIGHT:
;725:			// right justify at x
;726:			len = strlen(str);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 88
INDIRI4
ASGNI4
line 727
;727:			x   = x - len*charw;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 60
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
SUBI4
ASGNI4
line 728
;728:			break;
line 732
;729:
;730:		default:
;731:			// left justify at x
;732:			break;
LABELV $295
line 735
;733:	}
;734:
;735:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $299
line 736
;736:		dropcolor[0] = dropcolor[1] = dropcolor[2] = 0;
ADDRLP4 84
CNSTF4 0
ASGNF4
ADDRLP4 28+8
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 28
ADDRLP4 84
INDIRF4
ASGNF4
line 737
;737:		dropcolor[3] = drawcolor[3];
ADDRLP4 28+12
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 738
;738:		UI_DrawString2(x+2,y+2,str,dropcolor,charw,charh);
ADDRLP4 88
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 88
INDIRI4
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
ADDRLP4 88
INDIRI4
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawString2
CALLV
pop
line 739
;739:	}
LABELV $299
line 741
;740:
;741:	UI_DrawString2(x,y,str,drawcolor,charw,charh);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawString2
CALLV
pop
line 742
;742:}
LABELV $277
endproc UI_DrawString 92 24
export UI_DrawChar
proc UI_DrawChar 2 20
line 750
;743:
;744:/*
;745:=================
;746:UI_DrawChar
;747:=================
;748:*/
;749:void UI_DrawChar( int x, int y, int ch, int style, vec4_t color )
;750:{
line 753
;751:	char	buff[2];
;752:
;753:	buff[0] = ch;
ADDRLP4 0
ADDRFP4 8
INDIRI4
CVII1 4
ASGNI1
line 754
;754:	buff[1] = '\0';
ADDRLP4 0+1
CNSTI1 0
ASGNI1
line 756
;755:
;756:	UI_DrawString( x, y, buff, style, color );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 757
;757:}
LABELV $304
endproc UI_DrawChar 2 20
export UI_IsFullscreen
proc UI_IsFullscreen 4 0
line 759
;758:
;759:qboolean UI_IsFullscreen( void ) {
line 760
;760:	if ( uis.activemenu && ( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $307
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $307
line 761
;761:		return uis.activemenu->fullscreen;
ADDRGP4 uis+20
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
RETI4
ADDRGP4 $306
JUMPV
LABELV $307
line 764
;762:	}
;763:
;764:	return qfalse;
CNSTI4 0
RETI4
LABELV $306
endproc UI_IsFullscreen 4 0
proc NeedCDAction 0 8
line 767
;765:}
;766:
;767:static void NeedCDAction( qboolean result ) {
line 768
;768:	if ( !result ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $312
line 769
;769:		trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
CNSTI4 2
ARGI4
ADDRGP4 $314
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 770
;770:	}
LABELV $312
line 771
;771:}
LABELV $311
endproc NeedCDAction 0 8
proc NeedCDKeyAction 0 8
line 773
;772:
;773:static void NeedCDKeyAction( qboolean result ) {
line 774
;774:	if ( !result ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $316
line 775
;775:		trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
CNSTI4 2
ARGI4
ADDRGP4 $314
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 776
;776:	}
LABELV $316
line 777
;777:}
LABELV $315
endproc NeedCDKeyAction 0 8
export UI_SetActiveMenu
proc UI_SetActiveMenu 8 12
line 779
;778:
;779:void UI_SetActiveMenu( uiMenuCommand_t menu ) {
line 782
;780:	// this should be the ONLY way the menu system is brought up
;781:	// enusure minumum menu data is cached
;782:	Menu_Cache();
ADDRGP4 Menu_Cache
CALLV
pop
line 784
;783:
;784:	switch ( menu ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $319
ADDRLP4 0
INDIRI4
CNSTI4 6
GTI4 $319
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $332
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $332
address $322
address $323
address $328
address $324
address $326
address $330
address $330
code
LABELV $322
line 786
;785:	case UIMENU_NONE:
;786:		UI_ForceMenuOff();
ADDRGP4 UI_ForceMenuOff
CALLV
pop
line 787
;787:		return;
ADDRGP4 $318
JUMPV
LABELV $323
line 789
;788:	case UIMENU_MAIN:
;789:		UI_MainMenu();
ADDRGP4 UI_MainMenu
CALLV
pop
line 790
;790:		return;
ADDRGP4 $318
JUMPV
LABELV $324
line 792
;791:	case UIMENU_NEED_CD:
;792:		UI_ConfirmMenu( "Insert the CD", (voidfunc_f)NULL, NeedCDAction );
ADDRGP4 $325
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 NeedCDAction
ARGP4
ADDRGP4 UI_ConfirmMenu
CALLV
pop
line 793
;793:		return;
ADDRGP4 $318
JUMPV
LABELV $326
line 795
;794:	case UIMENU_BAD_CD_KEY:
;795:		UI_ConfirmMenu( "Bad CD Key", (voidfunc_f)NULL, NeedCDKeyAction );
ADDRGP4 $327
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 NeedCDKeyAction
ARGP4
ADDRGP4 UI_ConfirmMenu
CALLV
pop
line 796
;796:		return;
ADDRGP4 $318
JUMPV
LABELV $328
line 803
;797:	case UIMENU_INGAME:
;798:		/*
;799:		//GRank
;800:		UI_RankingsMenu();
;801:		return;
;802:		*/
;803:		trap_Cvar_Set( "cl_paused", "1" );
ADDRGP4 $124
ARGP4
ADDRGP4 $329
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 804
;804:		UI_InGameMenu();
ADDRGP4 UI_InGameMenu
CALLV
pop
line 805
;805:		return;
ADDRGP4 $318
JUMPV
LABELV $330
LABELV $319
line 812
;806:		
;807:	// bk001204
;808:	case UIMENU_TEAM:
;809:	case UIMENU_POSTGAME:
;810:	default:
;811:#ifndef NDEBUG
;812:	  Com_Printf("UI_SetActiveMenu: bad enum %d\n", menu );
ADDRGP4 $331
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 814
;813:#endif
;814:	  break;
LABELV $320
line 816
;815:	}
;816:}
LABELV $318
endproc UI_SetActiveMenu 8 12
export UI_KeyEvent
proc UI_KeyEvent 16 8
line 823
;817:
;818:/*
;819:=================
;820:UI_KeyEvent
;821:=================
;822:*/
;823:void UI_KeyEvent( int key, int down ) {
line 826
;824:	sfxHandle_t		s;
;825:
;826:	if (!uis.activemenu) {
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $334
line 827
;827:		return;
ADDRGP4 $333
JUMPV
LABELV $334
line 830
;828:	}
;829:
;830:	if (!down) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $337
line 831
;831:		return;
ADDRGP4 $333
JUMPV
LABELV $337
line 834
;832:	}
;833:
;834:	if (uis.activemenu->key)
ADDRGP4 uis+20
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $339
line 835
;835:		s = uis.activemenu->key( key );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 uis+20
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $340
JUMPV
LABELV $339
line 837
;836:	else
;837:		s = Menu_DefaultKey( uis.activemenu, key );
ADDRGP4 uis+20
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 Menu_DefaultKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $340
line 839
;838:
;839:	if ((s > 0) && (s != menu_null_sound))
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $344
ADDRLP4 0
INDIRI4
ADDRGP4 menu_null_sound
INDIRI4
EQI4 $344
line 840
;840:		trap_S_StartLocalSound( s, CHAN_LOCAL_SOUND );
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
LABELV $344
line 841
;841:}
LABELV $333
endproc UI_KeyEvent 16 8
export UI_MouseEvent
proc UI_MouseEvent 24 8
line 849
;842:
;843:/*
;844:=================
;845:UI_MouseEvent
;846:=================
;847:*/
;848:void UI_MouseEvent( int dx, int dy )
;849:{
line 853
;850:	int				i;
;851:	menucommon_s*	m;
;852:
;853:	if (!uis.activemenu)
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $347
line 854
;854:		return;
ADDRGP4 $346
JUMPV
LABELV $347
line 857
;855:
;856:	// update mouse screen position
;857:	uis.cursorx += dx;
ADDRLP4 8
ADDRGP4 uis+8
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
ASGNI4
line 858
;858:	if (uis.cursorx < 0)
ADDRGP4 uis+8
INDIRI4
CNSTI4 0
GEI4 $351
line 859
;859:		uis.cursorx = 0;
ADDRGP4 uis+8
CNSTI4 0
ASGNI4
ADDRGP4 $352
JUMPV
LABELV $351
line 860
;860:	else if (uis.cursorx > SCREEN_WIDTH)
ADDRGP4 uis+8
INDIRI4
CNSTI4 640
LEI4 $355
line 861
;861:		uis.cursorx = SCREEN_WIDTH;
ADDRGP4 uis+8
CNSTI4 640
ASGNI4
LABELV $355
LABELV $352
line 863
;862:
;863:	uis.cursory += dy;
ADDRLP4 12
ADDRGP4 uis+12
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
line 864
;864:	if (uis.cursory < 0)
ADDRGP4 uis+12
INDIRI4
CNSTI4 0
GEI4 $360
line 865
;865:		uis.cursory = 0;
ADDRGP4 uis+12
CNSTI4 0
ASGNI4
ADDRGP4 $361
JUMPV
LABELV $360
line 866
;866:	else if (uis.cursory > SCREEN_HEIGHT)
ADDRGP4 uis+12
INDIRI4
CNSTI4 480
LEI4 $364
line 867
;867:		uis.cursory = SCREEN_HEIGHT;
ADDRGP4 uis+12
CNSTI4 480
ASGNI4
LABELV $364
LABELV $361
line 870
;868:
;869:	// region test the active menu items
;870:	for (i=0; i<uis.activemenu->nitems; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $371
JUMPV
LABELV $368
line 871
;871:	{
line 872
;872:		m = (menucommon_s*)uis.activemenu->items[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
ASGNP4
line 874
;873:
;874:		if (m->flags & (QMF_GRAYED|QMF_INACTIVE))
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 24576
BANDU4
CNSTU4 0
EQU4 $374
line 875
;875:			continue;
ADDRGP4 $369
JUMPV
LABELV $374
line 877
;876:
;877:		if ((uis.cursorx < m->left) ||
ADDRGP4 uis+8
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LTI4 $384
ADDRGP4 uis+8
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
GTI4 $384
ADDRGP4 uis+12
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
LTI4 $384
ADDRGP4 uis+12
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
LEI4 $376
LABELV $384
line 881
;878:			(uis.cursorx > m->right) ||
;879:			(uis.cursory < m->top) ||
;880:			(uis.cursory > m->bottom))
;881:		{
line 883
;882:			// cursor out of item bounds
;883:			continue;
ADDRGP4 $369
JUMPV
LABELV $376
line 887
;884:		}
;885:
;886:		// set focus to item at cursor
;887:		if (uis.activemenu->cursor != i)
ADDRGP4 uis+20
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $385
line 888
;888:		{
line 889
;889:			Menu_SetCursor( uis.activemenu, i );
ADDRGP4 uis+20
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 890
;890:			((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor_prev]))->flags &= ~QMF_HASMOUSEFOCUS;
ADDRLP4 20
ADDRGP4 uis+20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 4294966783
BANDU4
ASGNU4
line 892
;891:
;892:			if ( !(((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor]))->flags & QMF_SILENT ) ) {
ADDRGP4 uis+20
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 1048576
BANDU4
CNSTU4 0
NEU4 $391
line 893
;893:				trap_S_StartLocalSound( menu_move_sound, CHAN_LOCAL_SOUND );
ADDRGP4 menu_move_sound
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 894
;894:			}
LABELV $391
line 895
;895:		}
LABELV $385
line 897
;896:
;897:		((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor]))->flags |= QMF_HASMOUSEFOCUS;
ADDRLP4 20
ADDRGP4 uis+20
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 512
BORU4
ASGNU4
line 898
;898:		return;
ADDRGP4 $346
JUMPV
LABELV $369
line 870
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $371
ADDRLP4 4
INDIRI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $368
line 901
;899:	}  
;900:
;901:	if (uis.activemenu->nitems > 0) {
ADDRGP4 uis+20
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
LEI4 $397
line 903
;902:		// out of any region
;903:		((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor]))->flags &= ~QMF_HASMOUSEFOCUS;
ADDRLP4 16
ADDRGP4 uis+20
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 4294966783
BANDU4
ASGNU4
line 904
;904:	}
LABELV $397
line 905
;905:}
LABELV $346
endproc UI_MouseEvent 24 8
bss
align 1
LABELV $403
skip 1024
export UI_Argv
code
proc UI_Argv 0 12
line 907
;906:
;907:char *UI_Argv( int arg ) {
line 910
;908:	static char	buffer[MAX_STRING_CHARS];
;909:
;910:	trap_Argv( arg, buffer, sizeof( buffer ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $403
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 912
;911:
;912:	return buffer;
ADDRGP4 $403
RETP4
LABELV $402
endproc UI_Argv 0 12
bss
align 1
LABELV $405
skip 1024
export UI_Cvar_VariableString
code
proc UI_Cvar_VariableString 0 12
line 916
;913:}
;914:
;915:
;916:char *UI_Cvar_VariableString( const char *var_name ) {
line 919
;917:	static char	buffer[MAX_STRING_CHARS];
;918:
;919:	trap_Cvar_VariableStringBuffer( var_name, buffer, sizeof( buffer ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $405
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 921
;920:
;921:	return buffer;
ADDRGP4 $405
RETP4
LABELV $404
endproc UI_Cvar_VariableString 0 12
export UI_Cache_f
proc UI_Cache_f 0 0
line 930
;922:}
;923:
;924:
;925:/*
;926:=================
;927:UI_Cache
;928:=================
;929:*/
;930:void UI_Cache_f( void ) {
line 932
;931:	//MainMenu_Cache();
;932:	InGame_Cache();
ADDRGP4 InGame_Cache
CALLV
pop
line 933
;933:	ConfirmMenu_Cache();
ADDRGP4 ConfirmMenu_Cache
CALLV
pop
line 934
;934:	PlayerModel_Cache();
ADDRGP4 PlayerModel_Cache
CALLV
pop
line 935
;935:	PlayerSettings_Cache();
ADDRGP4 PlayerSettings_Cache
CALLV
pop
line 936
;936:	Controls_Cache();
ADDRGP4 Controls_Cache
CALLV
pop
line 937
;937:	Demos_Cache();
ADDRGP4 Demos_Cache
CALLV
pop
line 938
;938:	UI_CinematicsMenu_Cache();
ADDRGP4 UI_CinematicsMenu_Cache
CALLV
pop
line 939
;939:	Preferences_Cache();
ADDRGP4 Preferences_Cache
CALLV
pop
line 940
;940:	ServerInfo_Cache();
ADDRGP4 ServerInfo_Cache
CALLV
pop
line 941
;941:	SpecifyServer_Cache();
ADDRGP4 SpecifyServer_Cache
CALLV
pop
line 942
;942:	ArenaServers_Cache();
ADDRGP4 ArenaServers_Cache
CALLV
pop
line 943
;943:	StartServer_Cache();
ADDRGP4 StartServer_Cache
CALLV
pop
line 944
;944:	ServerOptions_Cache();
ADDRGP4 ServerOptions_Cache
CALLV
pop
line 945
;945:	DriverInfo_Cache();
ADDRGP4 DriverInfo_Cache
CALLV
pop
line 946
;946:	GraphicsOptions_Cache();
ADDRGP4 GraphicsOptions_Cache
CALLV
pop
line 947
;947:	UI_DisplayOptionsMenu_Cache();
ADDRGP4 UI_DisplayOptionsMenu_Cache
CALLV
pop
line 948
;948:	UI_SoundOptionsMenu_Cache();
ADDRGP4 UI_SoundOptionsMenu_Cache
CALLV
pop
line 949
;949:	UI_NetworkOptionsMenu_Cache();
ADDRGP4 UI_NetworkOptionsMenu_Cache
CALLV
pop
line 950
;950:	UI_SPLevelMenu_Cache();
ADDRGP4 UI_SPLevelMenu_Cache
CALLV
pop
line 951
;951:	UI_SPSkillMenu_Cache();
ADDRGP4 UI_SPSkillMenu_Cache
CALLV
pop
line 952
;952:	UI_SPPostgameMenu_Cache();
ADDRGP4 UI_SPPostgameMenu_Cache
CALLV
pop
line 953
;953:	TeamMain_Cache();
ADDRGP4 TeamMain_Cache
CALLV
pop
line 954
;954:	UI_AddBots_Cache();
ADDRGP4 UI_AddBots_Cache
CALLV
pop
line 955
;955:	UI_RemoveBots_Cache();
ADDRGP4 UI_RemoveBots_Cache
CALLV
pop
line 956
;956:	UI_SetupMenu_Cache();
ADDRGP4 UI_SetupMenu_Cache
CALLV
pop
line 959
;957://	UI_LoadConfig_Cache();
;958://	UI_SaveConfigMenu_Cache();
;959:	UI_BotSelectMenu_Cache();
ADDRGP4 UI_BotSelectMenu_Cache
CALLV
pop
line 960
;960:	UI_CDKeyMenu_Cache();
ADDRGP4 UI_CDKeyMenu_Cache
CALLV
pop
line 961
;961:	UI_ModsMenu_Cache();
ADDRGP4 UI_ModsMenu_Cache
CALLV
pop
line 963
;962:
;963:}
LABELV $406
endproc UI_Cache_f 0 0
export UI_ConsoleCommand
proc UI_ConsoleCommand 40 8
line 971
;964:
;965:
;966:/*
;967:=================
;968:UI_ConsoleCommand
;969:=================
;970:*/
;971:qboolean UI_ConsoleCommand( int realTime ) {
line 974
;972:	char	*cmd;
;973:
;974:	cmd = UI_Argv( 0 );
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 977
;975:
;976:	// ensure minimum menu data is available
;977:	Menu_Cache();
ADDRGP4 Menu_Cache
CALLV
pop
line 979
;978:
;979:	if ( Q_stricmp (cmd, "levelselect") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $410
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $408
line 980
;980:		UI_SPLevelMenu_f();
ADDRGP4 UI_SPLevelMenu_f
CALLV
pop
line 981
;981:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $407
JUMPV
LABELV $408
line 984
;982:	}
;983:
;984:	if ( Q_stricmp (cmd, "postgame") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $413
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $411
line 985
;985:		UI_SPPostgameMenu_f();
ADDRGP4 UI_SPPostgameMenu_f
CALLV
pop
line 986
;986:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $407
JUMPV
LABELV $411
line 989
;987:	}
;988:
;989:	if ( Q_stricmp (cmd, "ui_cache") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $416
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $414
line 990
;990:		UI_Cache_f();
ADDRGP4 UI_Cache_f
CALLV
pop
line 991
;991:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $407
JUMPV
LABELV $414
line 994
;992:	}
;993:
;994:	if ( Q_stricmp (cmd, "ui_cinematics") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $419
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $417
line 995
;995:		UI_CinematicsMenu_f();
ADDRGP4 UI_CinematicsMenu_f
CALLV
pop
line 996
;996:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $407
JUMPV
LABELV $417
line 999
;997:	}
;998:
;999:	if ( Q_stricmp (cmd, "ui_teamOrders") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $422
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $420
line 1000
;1000:		UI_TeamOrdersMenu_f();
ADDRGP4 UI_TeamOrdersMenu_f
CALLV
pop
line 1001
;1001:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $407
JUMPV
LABELV $420
line 1004
;1002:	}
;1003:
;1004:	if ( Q_stricmp (cmd, "iamacheater") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $425
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $423
line 1005
;1005:		UI_SPUnlock_f();
ADDRGP4 UI_SPUnlock_f
CALLV
pop
line 1006
;1006:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $407
JUMPV
LABELV $423
line 1009
;1007:	}
;1008:
;1009:	if ( Q_stricmp (cmd, "iamamonkey") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $428
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $426
line 1010
;1010:		UI_SPUnlockMedals_f();
ADDRGP4 UI_SPUnlockMedals_f
CALLV
pop
line 1011
;1011:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $407
JUMPV
LABELV $426
line 1014
;1012:	}
;1013:
;1014:	if ( Q_stricmp (cmd, "ui_cdkey") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $429
line 1015
;1015:		UI_CDKeyMenu_f();
ADDRGP4 UI_CDKeyMenu_f
CALLV
pop
line 1016
;1016:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $407
JUMPV
LABELV $429
line 1019
;1017:	}
;1018:
;1019:	return qfalse;
CNSTI4 0
RETI4
LABELV $407
endproc UI_ConsoleCommand 40 8
export UI_Shutdown
proc UI_Shutdown 0 0
line 1027
;1020:}
;1021:
;1022:/*
;1023:=================
;1024:UI_Shutdown
;1025:=================
;1026:*/
;1027:void UI_Shutdown( void ) {
line 1028
;1028:}
LABELV $432
endproc UI_Shutdown 0 0
export UI_Init
proc UI_Init 0 4
line 1035
;1029:
;1030:/*
;1031:=================
;1032:UI_Init
;1033:=================
;1034:*/
;1035:void UI_Init( void ) {
line 1036
;1036:	UI_RegisterCvars();
ADDRGP4 UI_RegisterCvars
CALLV
pop
line 1038
;1037:
;1038:	UI_InitGameinfo();
ADDRGP4 UI_InitGameinfo
CALLV
pop
line 1041
;1039:
;1040:	// cache redundant calulations
;1041:	trap_GetGlconfig( &uis.glconfig );
ADDRGP4 uis+56
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 1044
;1042:
;1043:	// for 640x480 virtualized screen
;1044:	uis.scale = uis.glconfig.vidHeight * (1.0/480.0);
ADDRGP4 uis+11436
CNSTF4 990414985
ADDRGP4 uis+56+11308
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1045
;1045:	if ( uis.glconfig.vidWidth * 480 > uis.glconfig.vidHeight * 640 ) {
CNSTI4 480
ADDRGP4 uis+56+11304
INDIRI4
MULI4
CNSTI4 640
ADDRGP4 uis+56+11308
INDIRI4
MULI4
LEI4 $438
line 1047
;1046:		// wide screen
;1047:		uis.bias = 0.5 * ( uis.glconfig.vidWidth - ( uis.glconfig.vidHeight * (640.0/480.0) ) );
ADDRGP4 uis+11440
CNSTF4 1056964608
ADDRGP4 uis+56+11304
INDIRI4
CVIF4 4
CNSTF4 1068149419
ADDRGP4 uis+56+11308
INDIRI4
CVIF4 4
MULF4
SUBF4
MULF4
ASGNF4
line 1048
;1048:	}
ADDRGP4 $439
JUMPV
LABELV $438
line 1049
;1049:	else {
line 1051
;1050:		// no wide screen
;1051:		uis.bias = 0;
ADDRGP4 uis+11440
CNSTF4 0
ASGNF4
line 1052
;1052:	}
LABELV $439
line 1055
;1053:
;1054:	// initialize the menu system
;1055:	Menu_Cache();
ADDRGP4 Menu_Cache
CALLV
pop
line 1057
;1056:
;1057:	uis.activemenu = NULL;
ADDRGP4 uis+20
CNSTP4 0
ASGNP4
line 1058
;1058:	uis.menusp     = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 1059
;1059:}
LABELV $433
endproc UI_Init 0 4
export UI_AdjustFrom640
proc UI_AdjustFrom640 16 0
line 1068
;1060:
;1061:/*
;1062:================
;1063:UI_AdjustFrom640
;1064:
;1065:Adjusted for resolution and screen aspect ratio
;1066:================
;1067:*/
;1068:void UI_AdjustFrom640( float *x, float *y, float *w, float *h ) {
line 1070
;1069:	// expect valid pointers
;1070:	*x = *x * uis.scale + uis.bias;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 uis+11436
INDIRF4
MULF4
ADDRGP4 uis+11440
INDIRF4
ADDF4
ASGNF4
line 1071
;1071:	*y *= uis.scale;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 uis+11436
INDIRF4
MULF4
ASGNF4
line 1072
;1072:	*w *= uis.scale;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 uis+11436
INDIRF4
MULF4
ASGNF4
line 1073
;1073:	*h *= uis.scale;
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 uis+11436
INDIRF4
MULF4
ASGNF4
line 1074
;1074:}
LABELV $452
endproc UI_AdjustFrom640 16 0
export UI_DrawNamedPic
proc UI_DrawNamedPic 16 36
line 1076
;1075:
;1076:void UI_DrawNamedPic( float x, float y, float width, float height, const char *picname ) {
line 1079
;1077:	qhandle_t	hShader;
;1078:
;1079:	hShader = trap_R_RegisterShaderNoMip( picname );
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1080
;1080:	UI_AdjustFrom640( &x, &y, &width, &height );
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
line 1081
;1081:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 1, 1, hShader );
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
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1082
;1082:}
LABELV $458
endproc UI_DrawNamedPic 16 36
export UI_DrawHandlePic
proc UI_DrawHandlePic 16 36
line 1084
;1083:
;1084:void UI_DrawHandlePic( float x, float y, float w, float h, qhandle_t hShader ) {
line 1090
;1085:	float	s0;
;1086:	float	s1;
;1087:	float	t0;
;1088:	float	t1;
;1089:
;1090:	if( w < 0 ) {	// flip about vertical
ADDRFP4 8
INDIRF4
CNSTF4 0
GEF4 $460
line 1091
;1091:		w  = -w;
ADDRFP4 8
ADDRFP4 8
INDIRF4
NEGF4
ASGNF4
line 1092
;1092:		s0 = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1093
;1093:		s1 = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 1094
;1094:	}
ADDRGP4 $461
JUMPV
LABELV $460
line 1095
;1095:	else {
line 1096
;1096:		s0 = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1097
;1097:		s1 = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1098
;1098:	}
LABELV $461
line 1100
;1099:
;1100:	if( h < 0 ) {	// flip about horizontal
ADDRFP4 12
INDIRF4
CNSTF4 0
GEF4 $462
line 1101
;1101:		h  = -h;
ADDRFP4 12
ADDRFP4 12
INDIRF4
NEGF4
ASGNF4
line 1102
;1102:		t0 = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 1103
;1103:		t1 = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1104
;1104:	}
ADDRGP4 $463
JUMPV
LABELV $462
line 1105
;1105:	else {
line 1106
;1106:		t0 = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1107
;1107:		t1 = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1108
;1108:	}
LABELV $463
line 1110
;1109:	
;1110:	UI_AdjustFrom640( &x, &y, &w, &h );
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
line 1111
;1111:	trap_R_DrawStretchPic( x, y, w, h, s0, t0, s1, t1, hShader );
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
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1112
;1112:}
LABELV $459
endproc UI_DrawHandlePic 16 36
export UI_FillRect
proc UI_FillRect 4 36
line 1121
;1113:
;1114:/*
;1115:================
;1116:UI_FillRect
;1117:
;1118:Coordinates are 640*480 virtual values
;1119:=================
;1120:*/
;1121:void UI_FillRect( float x, float y, float width, float height, const float *color ) {
line 1122
;1122:	trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1124
;1123:
;1124:	UI_AdjustFrom640( &x, &y, &width, &height );
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
line 1125
;1125:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 0, 0, uis.whiteShader );
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
ADDRGP4 uis+11392
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1127
;1126:
;1127:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1128
;1128:}
LABELV $464
endproc UI_FillRect 4 36
export UI_DrawRect
proc UI_DrawRect 24 36
line 1137
;1129:
;1130:/*
;1131:================
;1132:UI_DrawRect
;1133:
;1134:Coordinates are 640*480 virtual values
;1135:=================
;1136:*/
;1137:void UI_DrawRect( float x, float y, float width, float height, const float *color ) {
line 1138
;1138:	trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1140
;1139:
;1140:	UI_AdjustFrom640( &x, &y, &width, &height );
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
line 1142
;1141:
;1142:	trap_R_DrawStretchPic( x, y, width, 1, 0, 0, 0, 0, uis.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
CNSTF4 1065353216
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
ADDRGP4 uis+11392
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1143
;1143:	trap_R_DrawStretchPic( x, y, 1, height, 0, 0, 0, 0, uis.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 uis+11392
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1144
;1144:	trap_R_DrawStretchPic( x, y + height - 1, width, 1, 0, 0, 0, 0, uis.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ADDRLP4 8
INDIRF4
SUBF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 uis+11392
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1145
;1145:	trap_R_DrawStretchPic( x + width - 1, y, 1, height, 0, 0, 0, 0, uis.whiteShader );
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 uis+11392
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1147
;1146:
;1147:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1148
;1148:}
LABELV $466
endproc UI_DrawRect 24 36
export UI_SetColor
proc UI_SetColor 0 4
line 1150
;1149:
;1150:void UI_SetColor( const float *rgba ) {
line 1151
;1151:	trap_R_SetColor( rgba );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1152
;1152:}
LABELV $471
endproc UI_SetColor 0 4
export UI_UpdateScreen
proc UI_UpdateScreen 0 0
line 1154
;1153:
;1154:void UI_UpdateScreen( void ) {
line 1155
;1155:	trap_UpdateScreen();
ADDRGP4 trap_UpdateScreen
CALLV
pop
line 1156
;1156:}
LABELV $472
endproc UI_UpdateScreen 0 0
export UI_Refresh
proc UI_Refresh 20 20
line 1164
;1157:
;1158:/*
;1159:=================
;1160:UI_Refresh
;1161:=================
;1162:*/
;1163:void UI_Refresh( int realtime )
;1164:{
line 1165
;1165:	uis.frametime = realtime - uis.realtime;
ADDRGP4 uis
ADDRFP4 0
INDIRI4
ADDRGP4 uis+4
INDIRI4
SUBI4
ASGNI4
line 1166
;1166:	uis.realtime  = realtime;
ADDRGP4 uis+4
ADDRFP4 0
INDIRI4
ASGNI4
line 1168
;1167:
;1168:	if ( !( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $476
line 1169
;1169:		return;
ADDRGP4 $473
JUMPV
LABELV $476
line 1172
;1170:	}
;1171:
;1172:	UI_UpdateCvars();
ADDRGP4 UI_UpdateCvars
CALLV
pop
line 1174
;1173:
;1174:	if ( uis.activemenu )
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $478
line 1175
;1175:	{
line 1176
;1176:		if (uis.activemenu->fullscreen)
ADDRGP4 uis+20
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $481
line 1177
;1177:		{
line 1179
;1178:			// draw the background
;1179:			if( uis.activemenu->showlogo ) {
ADDRGP4 uis+20
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 0
EQI4 $484
line 1180
;1180:				UI_DrawHandlePic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, uis.menuBackShader );
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRGP4 uis+11396
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1181
;1181:			}
ADDRGP4 $485
JUMPV
LABELV $484
line 1182
;1182:			else {
line 1183
;1183:				UI_DrawHandlePic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, uis.menuBackNoLogoShader );
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRGP4 uis+11400
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1184
;1184:			}
LABELV $485
line 1185
;1185:		}
LABELV $481
line 1187
;1186:
;1187:		if (uis.activemenu->draw)
ADDRGP4 uis+20
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $489
line 1188
;1188:			uis.activemenu->draw();
ADDRGP4 uis+20
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
CALLV
pop
ADDRGP4 $490
JUMPV
LABELV $489
line 1190
;1189:		else
;1190:			Menu_Draw( uis.activemenu );
ADDRGP4 uis+20
INDIRP4
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
LABELV $490
line 1192
;1191:
;1192:		if( uis.firstdraw ) {
ADDRGP4 uis+11448
INDIRI4
CNSTI4 0
EQI4 $494
line 1193
;1193:			UI_MouseEvent( 0, 0 );
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_MouseEvent
CALLV
pop
line 1194
;1194:			uis.firstdraw = qfalse;
ADDRGP4 uis+11448
CNSTI4 0
ASGNI4
line 1195
;1195:		}
LABELV $494
line 1196
;1196:	}
LABELV $478
line 1199
;1197:
;1198:	// draw cursor
;1199:	UI_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 1200
;1200:	UI_DrawHandlePic( uis.cursorx-16, uis.cursory-16, 32, 32, uis.cursor);
ADDRLP4 4
CNSTI4 16
ASGNI4
ADDRGP4 uis+8
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRGP4 uis+12
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 8
CNSTF4 1107296256
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 uis+11420
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1203
;1201:
;1202:#ifndef NDEBUG
;1203:	if (uis.debug)
ADDRGP4 uis+11388
INDIRI4
CNSTI4 0
EQI4 $501
line 1204
;1204:	{
line 1206
;1205:		// cursor coordinates
;1206:		UI_DrawString( 0, 0, va("(%d,%d)",uis.cursorx,uis.cursory), UI_LEFT|UI_SMALLFONT, colorRed );
ADDRGP4 $504
ARGP4
ADDRGP4 uis+8
INDIRI4
ARGI4
ADDRGP4 uis+12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 colorRed
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1207
;1207:	}
LABELV $501
line 1213
;1208:#endif
;1209:
;1210:	// delay playing the enter sound until after the
;1211:	// menu has been drawn, to avoid delay while
;1212:	// caching images
;1213:	if (m_entersound)
ADDRGP4 m_entersound
INDIRI4
CNSTI4 0
EQI4 $507
line 1214
;1214:	{
line 1215
;1215:		trap_S_StartLocalSound( menu_in_sound, CHAN_LOCAL_SOUND );
ADDRGP4 menu_in_sound
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1216
;1216:		m_entersound = qfalse;
ADDRGP4 m_entersound
CNSTI4 0
ASGNI4
line 1217
;1217:	}
LABELV $507
line 1218
;1218:}
LABELV $473
endproc UI_Refresh 20 20
export UI_DrawTextBox
proc UI_DrawTextBox 24 20
line 1221
;1219:
;1220:void UI_DrawTextBox (int x, int y, int width, int lines)
;1221:{
line 1222
;1222:	UI_FillRect( x + BIGCHAR_WIDTH/2, y + BIGCHAR_HEIGHT/2, ( width + 1 ) * BIGCHAR_WIDTH, ( lines + 1 ) * BIGCHAR_HEIGHT, colorBlack );
ADDRLP4 0
CNSTI4 8
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 8
CNSTI4 16
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LSHI4
ADDRLP4 8
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
ADDRLP4 4
INDIRI4
LSHI4
ADDRLP4 8
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRGP4 colorBlack
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 1223
;1223:	UI_DrawRect( x + BIGCHAR_WIDTH/2, y + BIGCHAR_HEIGHT/2, ( width + 1 ) * BIGCHAR_WIDTH, ( lines + 1 ) * BIGCHAR_HEIGHT, colorWhite );
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 16
CNSTI4 4
ASGNI4
ADDRLP4 20
CNSTI4 16
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRLP4 20
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRLP4 20
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawRect
CALLV
pop
line 1224
;1224:}
LABELV $509
endproc UI_DrawTextBox 24 20
export UI_CursorInRect
proc UI_CursorInRect 8 0
line 1227
;1225:
;1226:qboolean UI_CursorInRect (int x, int y, int width, int height)
;1227:{
line 1228
;1228:	if (uis.cursorx < x ||
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRGP4 uis+8
INDIRI4
ADDRLP4 0
INDIRI4
LTI4 $519
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 uis+12
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $519
ADDRGP4 uis+8
INDIRI4
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
GTI4 $519
ADDRGP4 uis+12
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
LEI4 $511
LABELV $519
line 1232
;1229:		uis.cursory < y ||
;1230:		uis.cursorx > x+width ||
;1231:		uis.cursory > y+height)
;1232:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $510
JUMPV
LABELV $511
line 1234
;1233:
;1234:	return qtrue;
CNSTI4 1
RETI4
LABELV $510
endproc UI_CursorInRect 8 0
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
bss
export uis
align 4
LABELV uis
skip 11452
export m_entersound
align 4
LABELV m_entersound
skip 4
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
LABELV $504
byte 1 40
byte 1 37
byte 1 100
byte 1 44
byte 1 37
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $431
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $428
byte 1 105
byte 1 97
byte 1 109
byte 1 97
byte 1 109
byte 1 111
byte 1 110
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $425
byte 1 105
byte 1 97
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $422
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $419
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $416
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $413
byte 1 112
byte 1 111
byte 1 115
byte 1 116
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $410
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $331
byte 1 85
byte 1 73
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 117
byte 1 109
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $329
byte 1 49
byte 1 0
align 1
LABELV $327
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 67
byte 1 68
byte 1 32
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $325
byte 1 73
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 67
byte 1 68
byte 1 0
align 1
LABELV $314
byte 1 113
byte 1 117
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $125
byte 1 48
byte 1 0
align 1
LABELV $124
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $112
byte 1 85
byte 1 73
byte 1 95
byte 1 80
byte 1 111
byte 1 112
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 58
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $96
byte 1 85
byte 1 73
byte 1 95
byte 1 80
byte 1 117
byte 1 115
byte 1 104
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 58
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $79
byte 1 100
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $70
byte 1 37
byte 1 115
byte 1 0
