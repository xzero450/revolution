// Copyright (C) 1999-2000 Id Software, Inc.
//
/*
=======================================================================

CREDITS

=======================================================================
*/


#include "ui_local.h"


typedef struct {
	menuframework_s	menu;
} creditsmenu_t;

static creditsmenu_t	s_credits;


/*
=================
UI_CreditMenu_Key
=================
*/
static sfxHandle_t UI_CreditMenu_Key( int key ) {
	if( key & K_CHAR_FLAG ) {
		return 0;
	}

	trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
	return 0;
}


/*
===============
UI_CreditMenu_Draw
===============
*/ /*
static void UI_CreditMenu_Draw( void ) {
	int		y;

	y = 12;
	UI_DrawProportionalString( 320, y, "id Software is:", UI_CENTER|UI_SMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Programming", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "John Carmack, Robert A. Duffy, Jim Dose'", UI_CENTER|UI_EXTRASMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Art", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Adrian Carmack, Kevin Cloud,", UI_CENTER|UI_EXTRASMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Kenneth Scott, Seneca Menard, Fred Nilsson", UI_CENTER|UI_EXTRASMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Game Designer", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Graeme Devine", UI_CENTER|UI_EXTRASMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Level Design", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Tim Willits, Christian Antkow, Paul Jaquays", UI_CENTER|UI_EXTRASMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "CEO", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Todd Hollenshead", UI_CENTER|UI_EXTRASMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Director of Business Development", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Marty Stratton", UI_CENTER|UI_EXTRASMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Biz Assist and id Mom", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Donna Jackson", UI_CENTER|UI_EXTRASMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Development Assistance", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Eric Webb", UI_CENTER|UI_EXTRASMALLFONT, color_white );

	y += 1.35 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	//UI_DrawString( 320, y, "To order: 1-800-idgames     www.quake3arena.com     www.idsoftware.com", UI_CENTER|UI_SMALLFONT, color_red );
	//y += SMALLCHAR_HEIGHT;
	UI_DrawString( 320, y, "Visit www.Quake-Revolution.com - You'll love it.", UI_CENTER|UI_SMALLFONT, color_main );
	y += SMALLCHAR_HEIGHT;
	UI_DrawString( 320, y, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color_main );
}*/

/*
===============
UI_CreditMenu_Draw
===============
*/
static void UI_CreditMenu_Draw( void ) {
	int		y;

	y = 12;
	//Line 0
	UI_DrawProportionalString( 320, y, "id Software is:", UI_CENTER, 0.75f, g_color_table[60] );

	//Line 1
	y += 1.42 * PROP_HEIGHT * 0.75;
	UI_DrawProportionalString( 20, y, "Programming", 0, 0.5f, g_color_table[60] );
	UI_DrawProportionalString( 230, y, "Art", 0, 0.5f, g_color_table[60] );
	UI_DrawProportionalString( 440, y, "Level Design", 0, 0.5f, g_color_table[60] );

	//Line 2
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "John Carmack", 0, 0.5f, color_white );
	UI_DrawProportionalString( 230, y, "Adrian Carmack", 0, 0.5f, color_white );
	UI_DrawProportionalString( 440, y, "Tim Willits", 0, 0.5f, color_white );

	//Line 3
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "Robert A. Duffy", 0, 0.5f, color_white );
	UI_DrawProportionalString( 230, y, "Kevin Cloud", 0, 0.5f, color_white );
	UI_DrawProportionalString( 440, y, "Christian Antkow", 0, 0.5f, color_white );

	//Line 4
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "Jim Dose'", 0, 0.5f, color_white );
	UI_DrawProportionalString( 230, y, "Kenneth Scott", 0, 0.5f, color_white );
	UI_DrawProportionalString( 440, y, "Paul Jaquays", 0, 0.5f, color_white );

	//Line 5
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 230, y, "Seneca Menard", 0, 0.5f, color_white );

	//Line 6
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 230, y, "Fred Nilsson", 0, 0.5f, color_white );
	

	//Second branch -- Line 7
	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 20, y, "Game Designer", 0, 0.5f, g_color_table[60] );
	UI_DrawProportionalString( 230, y, "Biz Assist and id Mom", 0, 0.5f, g_color_table[60] );
	
	UI_DrawProportionalString( 440, y, "CEO", 0, 0.5f, g_color_table[60] );

	//Line 8
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "Graeme Devine", 0, 0.5f, color_white );
	UI_DrawProportionalString( 230, y, "Donna Jackson", 0, 0.5f, color_white );
	UI_DrawProportionalString( 440, y, "Todd Hollenshead", 0, 0.5f, color_white );

	//extras
	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 20, y, "Director of Business Development", 0, 0.5f, g_color_table[60] );
	UI_DrawProportionalString( 420, y, "Development Assistance", 0, 0.5f, g_color_table[60] );
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "Marty Stratton", 0, 0.5f, color_white );
	UI_DrawProportionalString( 440, y, "Eric Webb", 0, 0.5f, color_white );

	//Mod Developers
	y += 1.42 * PROP_HEIGHT * 0.75;
	UI_DrawProportionalString( 20, y, "Mod Developers:", 0, 0.75f, g_color_table[60] );
	UI_DrawProportionalString( 370, y, "Other Contributors:", 0, 0.75f, g_color_table[60] );
	y += 1.42 * PROP_HEIGHT * 0.75;
	UI_DrawProportionalString( 20, y, "Jonathan \"Evolution\" Murphy", 0, 0.5f, color_white );
	UI_DrawProportionalString( 370, y, "ProMode Team", 0, 0.5f, color_white );
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "Curtis \"Lucron\"  Click", 0, 0.5f, color_white );
	UI_DrawProportionalString( 370, y, "Reactance team", 0, 0.5f, color_white );
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "William \"Spike\" Kimerer", 0, 0.5f, color_white );
	UI_DrawProportionalString( 370, y, "C.J. \"methejuggler\" Manca", 0, 0.5f, color_white );
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "John \"M^onk^K\" Minadeo", 0, 0.5f, color_white );
	UI_DrawProportionalString( 370, y, "Darrell \"Doolittle\" Bircsak", 0, 0.5f, color_white );
	y += PROP_HEIGHT * 0.5;
	//This is fun
	UI_DrawProportionalString( 20, y, "Robin \"Arcaon\" Blomberg", 0, 0.5f, color_white );
	UI_DrawProportionalString( 370, y, "Neil \"haste\" Toronto", 0, 0.5f, color_white );
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "John \"Dwel13R\" Rokosky", 0, 0.5f, color_white );
	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 20, y, "Graphics", 0, 0.5f, g_color_table[60] );
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "Vesa \"Decky\" Autio", 0, 0.5f, color_white );
	y += PROP_HEIGHT * 0.5;
	UI_DrawProportionalString( 20, y, "Max \"Maxeh\" Nystrom", 0, 0.5f, color_white );
	
	

	//y += 1.35 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	y = 480 - 36;
	//UI_DrawString( 320, y, "To order: 1-800-idgames     www.quake3arena.com     www.idsoftware.com", UI_CENTER|UI_SMALLFONT, color_red );
	//y += SMALLCHAR_HEIGHT;
	UI_DrawString( 320, y, "Visit www.Quake-Revolution.net - You'll love it.", UI_CENTER|UI_SMALLFONT, color_main );
	y += SMALLCHAR_HEIGHT;
	UI_DrawString( 320, y, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color_main );
}


/*
===============
UI_CreditMenu
===============
*/
void UI_CreditMenu( void ) {
	memset( &s_credits, 0 ,sizeof(s_credits) );

	s_credits.menu.draw = UI_CreditMenu_Draw;
	s_credits.menu.key = UI_CreditMenu_Key;
	s_credits.menu.fullscreen = qtrue;
	UI_PushMenu ( &s_credits.menu );
}
