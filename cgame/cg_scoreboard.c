// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_scoreboard -- draw the scoreboard on top of the game screen
#include "cg_local.h"


#define	SCOREBOARD_X		(0)

#define SB_HEADER			86
#define SB_TOP				(SB_HEADER+32)

// Where the status bar starts, so we don't overwrite it
#define SB_STATUSBAR		420

#define SB_NORMAL_HEIGHT	40
#define SB_INTER_HEIGHT		16 // interleaved height

#define SB_MAXCLIENTS_NORMAL  ((SB_STATUSBAR - SB_TOP) / SB_NORMAL_HEIGHT)
#define SB_MAXCLIENTS_INTER   ((SB_STATUSBAR - SB_TOP) / SB_INTER_HEIGHT - 1)

// Used when interleaved



#define SB_LEFT_BOTICON_X	(SCOREBOARD_X+0)
#define SB_LEFT_HEAD_X		(SCOREBOARD_X+32)
#define SB_RIGHT_BOTICON_X	(SCOREBOARD_X+64)
#define SB_RIGHT_HEAD_X		(SCOREBOARD_X+96)
// Normal
#define SB_BOTICON_X		(SCOREBOARD_X+32)
#define SB_HEAD_X			(SCOREBOARD_X+64)
//#define SB_HEAD_X			(SCOREBOARD_X+48)

#define SB_SCORELINE_X		112

#define SB_RATING_WIDTH	    (6 * BIGCHAR_WIDTH - 2) // width 6
#define SB_SCORE_X			(SB_SCORELINE_X + BIGCHAR_WIDTH - 2) // width 6
#define SB_RATING_X			(SB_SCORELINE_X + 6 * BIGCHAR_WIDTH - 2) // width 6
#define SB_PING_X			(SB_SCORELINE_X + 12 * BIGCHAR_WIDTH + 8 - 2) // width 5
#define SB_TIME_X			(SB_SCORELINE_X + 17 * BIGCHAR_WIDTH + 8 - 2) // width 5
#define SB_NAME_X			(SB_SCORELINE_X + 22 * BIGCHAR_WIDTH - 2) // width 15

// The new and improved score board
//
// In cases where the number of clients is high, the score board heads are interleaved
// here's the layout

//
//	0   32   80  112  144   240  320  400   <-- pixel position
//  bot head bot head score ping time name
//
//  wins/losses are drawn on bot icon now

static qboolean localClient; // true if local client has been displayed

#define	DISTANCE_TO_HEAD	64

/*
=================
CG_DrawScoreboard
=================
*/
static void CG_DrawClientScore( int y, score_t *score, float *color, float fade, qboolean largeFormat ) {
	char	string[128];
	vec3_t	headAngles;
	clientInfo_t	*ci;
	int iconx, headx, x/*, i, length*/;
	vec4_t	drawcolor = {1.0f, 1.0f, 1.0f, 1.0f};
	char	cscore[128], cnet[128], cping[128], ctime[128], cwinloss[16];
	int		multi_weap = 0;
//	int		n1, n2;
	int		maxClients;

	if ( score->client < 0 || score->client >= cgs.maxclients ) {
		Com_Printf( "Bad score->client: %i\n", score->client );
		return;
	}

	ci = &cgs.clientinfo[score->client];

	iconx = SB_BOTICON_X + (SB_RATING_WIDTH / 2);
	headx = SB_HEAD_X + (SB_RATING_WIDTH / 2);

	if ( cg.numScores > SB_MAXCLIENTS_NORMAL ) {
		maxClients = SB_MAXCLIENTS_INTER;
	} else {
		maxClients = SB_MAXCLIENTS_NORMAL;
	}

	if ( cg_oldScoreboard.integer & 32 )
        largeFormat = qfalse;//Force smallFormat

	if ( cg.time > cg.score_time && cg.scoreBoardShowing ) {
		qboolean foundWeapon = qfalse;
		qboolean cycleRepeated = qfalse;
		cg.score_time = cg.time + 1000;

		cg.alternateHandicap = !cg.alternateHandicap;//Will alternate the handicap render

		while ( !foundWeapon ) {
			cg.score_weapon++;

			if ( cg.score_weapon == WP_NUM_WEAPONS - 1 ) {
				if ( cycleRepeated ) {
					cg.score_weapon = 0;
					break;
				}
				cg.score_weapon = 1;
				cycleRepeated = qtrue;
			}

			if ( cgs.picked_up & (1 << (cg.score_weapon - 1)) ) {
				foundWeapon = qtrue;
			}
		}
	}

	// highlight your position
	if ( score->client == cg.snap->ps.clientNum ) {
		float	hcolor[4];
		int		rank;

		localClient = qtrue;

		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR
			|| cgs.gametype >= GT_TEAM ) {
			rank = -1;
		} else {
			rank = cg.snap->ps.persistant[PERS_RANK] & ~RANK_TIED_FLAG;
		}
		if ( rank == 0 ) {
			hcolor[0] = 0;
			hcolor[1] = 0;
			hcolor[2] = 0.7f;
		} else if ( rank == 1 ) {
			hcolor[0] = 0.7f;
			hcolor[1] = 0;
			hcolor[2] = 0;
		} else if ( rank == 2 ) {
			hcolor[0] = 0.7f;
			hcolor[1] = 0.7f;
			hcolor[2] = 0;
		} else {
			hcolor[0] = 0.7f;
			hcolor[1] = 0.7f;
			hcolor[2] = 0.7f;
		}

		hcolor[3] = fade * 0.7;
		CG_FillRect( SB_SCORELINE_X + BIGCHAR_WIDTH + (SB_RATING_WIDTH / 2) + 26, y,
			640 - SB_SCORELINE_X - BIGCHAR_WIDTH, BIGCHAR_HEIGHT+1, hcolor );

		if ( cg_oldScoreboard.integer & 2 || cg_oldScoreboard.integer & 4 ) {
			if ( cg_draw3dIcons.integer ) {
				if ( largeFormat ) {
					CG_FillRect( 75, y,
						cg_oldScoreboard.integer&4?(126):(90),
						BIGCHAR_HEIGHT+1, hcolor );
				} else {
					CG_FillRect( 105, y,
						cg_oldScoreboard.integer&4?(96):(70),
						BIGCHAR_HEIGHT+1, hcolor );
				}
			} else {
				if ( largeFormat ) {
					CG_FillRect( 75, y,
						cg_oldScoreboard.integer&4?(126):(90),
						BIGCHAR_HEIGHT+1, hcolor );
				} else {
					CG_FillRect( 105, y+1,//This is different
						cg_oldScoreboard.integer&4?(96):(70),
						BIGCHAR_HEIGHT, hcolor );
				}
			}
		}
	}
	//& 8 outlines self, & 16 outlines everyone
	if ( (cg_oldScoreboard.integer & 8 && score->client == cg.snap->ps.clientNum) || cg_oldScoreboard.integer & 16) {
		if ( cg_draw3dIcons.integer ) {
			if ( largeFormat ) {
				CG_FillRect( 75, y-1, 1, BIGCHAR_HEIGHT+3, colorWhite );
				CG_FillRect( 76, y-1, 640-75, 1, colorWhite );
				CG_FillRect( 76, y+BIGCHAR_HEIGHT+1, 640-75, 1, colorWhite );
			} else {
				CG_FillRect( 105, y, 1, BIGCHAR_HEIGHT+1, colorWhite );
				CG_FillRect( 106, y, 640-104, 1, colorWhite );
				CG_FillRect( 106, y+BIGCHAR_HEIGHT, 640-104, 1, colorWhite );
			}
		} else {
			if ( largeFormat ) {
				CG_FillRect( 75, y, 1, BIGCHAR_HEIGHT+1, colorWhite );
				CG_FillRect( 75, y-1, 640-76, 1, colorWhite );
				CG_FillRect( 75, y+BIGCHAR_HEIGHT+1, 640-76, 1, colorWhite );
			} else {
				CG_FillRect( 105, y, 1, BIGCHAR_HEIGHT+1, colorWhite );
				CG_FillRect( 106, y, 640-104, 1, colorWhite );
				CG_FillRect( 106, y+BIGCHAR_HEIGHT, 640-104, 1, colorWhite );
			}
		}
	}


	// draw the handicap or bot skill marker (unless player has flag)
	if ( cg_draw3dIcons.integer ) {
		if ( largeFormat ) {
			if ( ci->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
				CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD - 4, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_FREE, qfalse );
			} else if ( ci->powerups & ( 1 << PW_REDFLAG ) ) {
				CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD - 4, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_RED, qfalse );
			} else if ( ci->powerups & ( 1 << PW_BLUEFLAG ) ) {
				CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD - 4, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_BLUE, qfalse );
			} else {
				if ( ci->handicap < 100 && !ci->botSkill ) {
					Com_sprintf( string, sizeof( string ), "%2i", ci->handicap );
					if ( cgs.gametype == GT_TOURNAMENT ) {
						CG_DrawStringExt( iconx + DISTANCE_TO_HEAD + 8, y - 6, string, color, qtrue, qfalse, 8, 12, 0, 0, 0);
					} else {
						CG_DrawStringExt( iconx + DISTANCE_TO_HEAD + 2, y, string, color, qtrue, qfalse, 8, 16, 0, 0, 0);
					}
				}

				// draw the wins / losses
				if ( cgs.gametype == GT_TOURNAMENT ) {
					Com_sprintf( cwinloss, sizeof( cwinloss ), "%i/%i", ci->wins, ci->losses );
					CG_DrawStringExt( iconx + DISTANCE_TO_HEAD, y + 8, cwinloss, color, qtrue, qfalse, 8, 14, 0, 0, 0);
				}
			}

			if ( ci->botSkill > 0 && ci->botSkill <= 5 ) {
				if ( cg_drawIcons.integer ) {
					if ( cg_oldScoreboard.integer & 64 ) {
						CG_DrawPic( 274, y - 8, 32, 32, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
					} else {
						CG_DrawPic( SB_SCORELINE_X + SB_RATING_WIDTH + 75, y - 8, 32, 32, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
					}
				}
			}

			if ( ci->team != TEAM_SPECTATOR && cg.score_weapon != 0 ) {
				if (score->hits[cg.score_weapon] > 0) {
					float	percent_calc;
					percent_calc = ((float)score->hits[cg.score_weapon] / (float)(score->shots[cg.score_weapon] + .0001) * 100.01f);
					Com_sprintf(string, sizeof( string ), "%3.2f", percent_calc);
				} else {
					Com_sprintf(string, sizeof( string ), "  0.00", 0);
				}
				CG_DrawPic( iconx + DISTANCE_TO_HEAD - 18, y, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, cg_weapons[cg.score_weapon].weaponIcon );
				CG_DrawStringExt( iconx - 2, y, string, colorWhite, qfalse, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
			}

			// draw the face
			VectorClear( headAngles );
			headAngles[YAW] = 180;
			CG_DrawHead( headx + 56, y - ( ICON_SIZE - BIGCHAR_HEIGHT - 16 ) / 2, ICON_SIZE - 16, ICON_SIZE - 16, score->client, headAngles );
		} else {
			//Draw 3dIcons + smallFormat
			if ( ci->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
					CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD + 16, y, 16, 16, TEAM_FREE, qfalse );
			} else if ( ci->powerups & ( 1 << PW_REDFLAG ) ) {
					CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD + 16, y, 16, 16, TEAM_RED, qfalse );
			} else if ( ci->powerups & ( 1 << PW_BLUEFLAG ) ) {
					CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD + 16, y, 16, 16, TEAM_BLUE, qfalse );
			} else {
				if ( ci->handicap < 100 && !ci->botSkill ) {
					Com_sprintf( string, sizeof( string ), "%2i", ci->handicap );
					if ( cgs.gametype == GT_TOURNAMENT ) {
						if ( cg.alternateHandicap ) {
							//We're going to draw this in the same place as the tournament round/score
							CG_DrawStringExt( iconx + DISTANCE_TO_HEAD + 22, y + 2, string, color, qtrue, qfalse, 6, 14, 0, 0, 0);
						}
					} else {
						CG_DrawStringExt( iconx + DISTANCE_TO_HEAD + 18, y + 2, string, color, qtrue, qfalse, 6, 14, 0, 0, 0);
					}
				}

				// draw the wins / losses
				if ( cgs.gametype == GT_TOURNAMENT && (ci->botSkill || (!cg.alternateHandicap  && ci->handicap < 100) ) ) {
					Com_sprintf( cwinloss, sizeof( cwinloss ), "%i/%i", ci->wins, ci->losses );
					CG_DrawStringExt( iconx + DISTANCE_TO_HEAD + 16, y + 2, cwinloss, color, qtrue, qfalse, 6, 14, 0, 0, 0);
				}
			}

			if ( ci->botSkill > 0 && ci->botSkill <= 5 ) {
				if ( cg_drawIcons.integer ) {
					if ( cg_oldScoreboard.integer & 64 ) {
						CG_DrawPic( 282, y, 16, 16, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
					} else {
						CG_DrawPic( SB_SCORELINE_X + SB_RATING_WIDTH + 90, y, 16, 16, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
					}
				}
			}

			if ( ci->team != TEAM_SPECTATOR && cg.score_weapon != 0 ) {
				if (score->hits[cg.score_weapon] > 0) {
					float	percent_calc;
					percent_calc = ((float)score->hits[cg.score_weapon] / (float)(score->shots[cg.score_weapon] + .0001) * 100.01f);
					Com_sprintf(string, sizeof( string ), "%3.2f", percent_calc);
				} else {
					Com_sprintf(string, sizeof( string ), "  0.00", 0);
				}

				CG_DrawPic( iconx + DISTANCE_TO_HEAD + 2, y + 2, 14, 14, cg_weapons[cg.score_weapon].weaponIcon );
				CG_DrawStringExt( iconx + 30, y + 2, string, colorWhite, qfalse, qfalse, 6, 14, 0, 0, 0 );
			}

			// draw the face
			VectorClear( headAngles );
			headAngles[YAW] = 180;
			CG_DrawHead( headx + 68, y, 16, 16, score->client, headAngles );
		}
	} else {
		//because the 2d icons take up more space, we'll have to use different positions
		if ( largeFormat ) {
			if ( ci->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
				CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD - 2, y - 4, 24, 24, TEAM_FREE, qfalse );
			} else if ( ci->powerups & ( 1 << PW_REDFLAG ) ) {
				CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD - 2, y - 4, 24, 24, TEAM_RED, qfalse );
			} else if ( ci->powerups & ( 1 << PW_BLUEFLAG ) ) {
				CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD - 2, y - 4, 24, 24, TEAM_BLUE, qfalse );
			} else {
				if ( ci->handicap < 100 && !ci->botSkill ) {
					Com_sprintf( string, sizeof( string ), "%2i", ci->handicap );
					if ( cgs.gametype == GT_TOURNAMENT ) {
						CG_DrawStringExt( iconx + DISTANCE_TO_HEAD + 8, y - 6, string, color, qtrue, qfalse, 8, 12, 0, 0, 0);
					} else {
						CG_DrawStringExt( iconx + DISTANCE_TO_HEAD + 2, y, string, color, qtrue, qfalse, 8, 16, 0, 0, 0);
					}
				}

				// draw the wins / losses
				if ( cgs.gametype == GT_TOURNAMENT ) {
					Com_sprintf( cwinloss, sizeof( cwinloss ), "%i/%i", ci->wins, ci->losses );
					CG_DrawStringExt( iconx + DISTANCE_TO_HEAD, y + 8, cwinloss, color, qtrue, qfalse, 8, 14, 0, 0, 0);
				}
			}

			if ( ci->botSkill > 0 && ci->botSkill <= 5 ) {
				if ( cg_drawIcons.integer ) {
					if ( cg_oldScoreboard.integer & 64 ) {
						CG_DrawPic( 274, y - 8, 32, 32, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
					} else {
						CG_DrawPic( SB_SCORELINE_X + SB_RATING_WIDTH + 75, y - 8, 32, 32, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
					}
				}
			}

			if ( ci->team != TEAM_SPECTATOR && cg.score_weapon != 0 ) {
				if (score->hits[cg.score_weapon] > 0) {
					float	percent_calc;
					percent_calc = ((float)score->hits[cg.score_weapon] / (float)(score->shots[cg.score_weapon] + .0001) * 100.01f);
					Com_sprintf(string, sizeof( string ), "%3.2f", percent_calc);
				} else {
					Com_sprintf(string, sizeof( string ), "  0.00", 0);
				}
				CG_DrawPic( iconx + DISTANCE_TO_HEAD - 18, y, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, cg_weapons[cg.score_weapon].weaponIcon );
				CG_DrawStringExt( iconx - 2, y, string, colorWhite, qfalse, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
			}

			// draw the face
			VectorClear( headAngles );
			headAngles[YAW] = 180;
			CG_DrawHead( headx + 56, y - ( ICON_SIZE - BIGCHAR_HEIGHT - 16 ) / 2, ICON_SIZE - 16, ICON_SIZE - 16, score->client, headAngles );
		} else {
			//Draw 2dIcons + smallFormat
			if ( ci->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
					CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD + 12, y, 16, 16, TEAM_FREE, qfalse );
			} else if ( ci->powerups & ( 1 << PW_REDFLAG ) ) {
					CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD + 12, y, 16, 16, TEAM_RED, qfalse );
			} else if ( ci->powerups & ( 1 << PW_BLUEFLAG ) ) {
					CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD + 12, y, 16, 16, TEAM_BLUE, qfalse );
			} else {
				if ( ci->handicap < 100 && !ci->botSkill ) {
					Com_sprintf( string, sizeof( string ), "%2i", ci->handicap );
					if ( cgs.gametype == GT_TOURNAMENT ) {
						if ( cg.alternateHandicap ) {
							//We're going to draw this in the same place as the tournament round/score
							CG_DrawStringExt( iconx + DISTANCE_TO_HEAD + 22, y + 2, string, color, qtrue, qfalse, 6, 14, 0, 0, 0);
						}
					} else {
						CG_DrawStringExt( iconx + DISTANCE_TO_HEAD + 18, y + 2, string, color, qtrue, qfalse, 6, 14, 0, 0, 0);
					}
				}

				// draw the wins / losses
				if ( cgs.gametype == GT_TOURNAMENT && (ci->botSkill || (!cg.alternateHandicap  && ci->handicap < 100) ) ) {
					Com_sprintf( cwinloss, sizeof( cwinloss ), "%i/%i", ci->wins, ci->losses );
					CG_DrawStringExt( iconx + DISTANCE_TO_HEAD + 16, y + 2, cwinloss, color, qtrue, qfalse, 6, 14, 0, 0, 0);
				}
			}

			if ( ci->botSkill > 0 && ci->botSkill <= 5 ) {
				if ( cg_drawIcons.integer ) {
					if ( cg_oldScoreboard.integer & 64 ) {
						CG_DrawPic( 282, y, 16, 16, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
					} else {
						CG_DrawPic( SB_SCORELINE_X + SB_RATING_WIDTH + 90, y, 16, 16, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
					}
				}
			}

			if ( ci->team != TEAM_SPECTATOR && cg.score_weapon != 0 ) {
				if (score->hits[cg.score_weapon] > 0) {
					float	percent_calc;
					percent_calc = ((float)score->hits[cg.score_weapon] / (float)(score->shots[cg.score_weapon] + .0001) * 100.01f);
					Com_sprintf(string, sizeof( string ), "%3.2f", percent_calc);
				} else {
					Com_sprintf(string, sizeof( string ), "  0.00", 0);
				}

				CG_DrawPic( iconx + DISTANCE_TO_HEAD + 2, y + 2, 14, 14, cg_weapons[cg.score_weapon].weaponIcon );
				CG_DrawStringExt( iconx + 30, y + 2, string, colorWhite, qfalse, qfalse, 6, 14, 0, 0, 0 );
			}

			// draw the face
			VectorClear( headAngles );
			headAngles[YAW] = 180;
			CG_DrawHead( headx + 68, y, 16, 16, score->client, headAngles );
		}
	}

#ifdef MISSIONPACK
	// draw the team task
	if ( ci->teamTask != TEAMTASK_NONE ) {
		if ( ci->teamTask == TEAMTASK_OFFENSE ) {
			CG_DrawPic( headx + 48, y, 16, 16, cgs.media.assaultShader );
		} else if ( ci->teamTask == TEAMTASK_DEFENSE ) {
			CG_DrawPic( headx + 48, y, 16, 16, cgs.media.defendShader );
		}
	}
#endif

	if ( score->ping <= 5) {
		drawcolor[0] = 0.0;
		drawcolor[1] = 1.0;
		drawcolor[2] = 1.0;
	} else if ( score->ping <= 45 ) {
		drawcolor[0] = 0.0;
		drawcolor[1] = 1.0;
		drawcolor[2] = (1.00 - (float)(score->ping/45));
	} else if ( score->ping <= 125 ) {
		drawcolor[0] = (float)(score->ping/125);
		drawcolor[1] = 1.0;
		drawcolor[2] = 0.0;
	} else if ( score->ping <= 170 ) {
		drawcolor[0] = 1.0;
		drawcolor[1] = (1.00 - (float)(score->ping/170));
		drawcolor[2] = 0.0;
	} else {
		drawcolor[0] = 1.0;
		drawcolor[1] = 0.0;
		drawcolor[2] = 0.0;
	}

	drawcolor[3] = 1.0;


    if ( score->ping == -1 ) {
		x = SB_SCORELINE_X + (SB_RATING_WIDTH / 2) + BIGCHAR_WIDTH + 8;
		Com_sprintf(cscore, sizeof(cscore), "Connecting", 0);
		Com_sprintf(cnet, sizeof(cnet), "", 0);
		Com_sprintf(cping, sizeof(cping), "", 0);
		Com_sprintf(ctime, sizeof(ctime), "", 0);
        //FIXME: This isn't aligned properly - was 18
        CG_DrawStringExt( x + 12, y, cscore, colorWhite, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
	} else {
		//Can't 'buffer' for center aligning
		if ( score->specnum != 0 && cg_oldScoreboard.integer & 1) { //Lucron: specspy
			Com_sprintf(cscore, sizeof(cscore), "%.15s ^1%c", cgs.clientinfo[ score->specnum - 1 ].name, (char)K_BACKSPACE);//This doesn't line up quite right, still.
			Com_sprintf(cping, sizeof(cping), ""); 
			Com_sprintf(ctime, sizeof(ctime), "");
			CG_DrawStringExt( ((SB_SCORELINE_X + (SB_RATING_WIDTH / 2)) + 91), y + 4, cscore, colorWhite, qfalse, qtrue, BIGCHAR_WIDTH - 6, BIGCHAR_HEIGHT - 6, 0, 50, -1 );
		} else if ( cg_oldScoreboard.integer & 64 ) {
			if ( ci->team == TEAM_SPECTATOR ) {
				x = SB_SCORELINE_X + (SB_RATING_WIDTH / 2) + BIGCHAR_WIDTH;
				Com_sprintf(cscore, sizeof(cscore), "SPEC", 0);//Almost shouldn't center align this
				Com_sprintf(cping, sizeof(cping), "%i", score->ping);
				Com_sprintf(ctime, sizeof(ctime), "%i", score->time);
			} else {
				x = SB_SCORELINE_X + (SB_RATING_WIDTH / 2);
				Com_sprintf(cscore, sizeof(cscore), "%i", score->score);
				Com_sprintf(cnet, sizeof(cnet), "%i", score->deaths);
				Com_sprintf(cping, sizeof(cping), "%i", score->ping);
				Com_sprintf(ctime, sizeof(ctime), "%i", score->time);
			}
			//Center align numbers
			CG_DrawStringExt( 202, y, cscore, colorWhite, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 50, -1 );
			if ( score->ping != -1 ) {
				if ( !ci->botSkill || !cg_drawIcons.integer) {
					CG_DrawStringExt( 270, y, cping, drawcolor, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 40, -1 );
				}
				CG_DrawStringExt( 325, y, ctime, colorWhite, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 40, -1 );
			}
		} else {
			if ( ci->team == TEAM_SPECTATOR ) {
				x = SB_SCORELINE_X + (SB_RATING_WIDTH / 2) + BIGCHAR_WIDTH;
				Com_sprintf(cscore, sizeof(cscore), "SPEC", 0);//This doesn't line up quite right, still.
				Com_sprintf(cping, sizeof(cping), "%4i", score->ping);
				Com_sprintf(ctime, sizeof(ctime), "%4i", score->time);
			} else {
				x = SB_SCORELINE_X + (SB_RATING_WIDTH / 2);
				Com_sprintf(cscore, sizeof(cscore), "%5i", score->score);
				Com_sprintf(cnet, sizeof(cnet), "%4i", score->deaths);
				Com_sprintf(cping, sizeof(cping), "%4i", score->ping);
				Com_sprintf(ctime, sizeof(ctime), "%4i", score->time);
			}
			CG_DrawStringExt( x + 18, y, cscore, colorWhite, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
			if ( !ci->botSkill || !cg_drawIcons.integer) {
				CG_DrawStringExt( ((SB_SCORELINE_X + (SB_RATING_WIDTH / 2)) + 91), y, cping, drawcolor, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
			}
			CG_DrawStringExt( ((SB_SCORELINE_X + (SB_RATING_WIDTH / 2)) + 145), y, ctime, colorWhite, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
		}
	}
	CG_DrawStringExt( ((SB_SCORELINE_X + (SB_RATING_WIDTH / 2)) + 217), y, ci->name, colorWhite, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );


	// add the "ready" marker for intermission exiting
	if ( cg.snap->ps.stats[ STAT_CLIENTS_READY ] & ( 1 << score->client ) ) {
//freeze
		if ( !Q_Isfreeze( score->client ) )
//freeze
		//Replace this.
		CG_DrawBigStringColor( iconx + DISTANCE_TO_HEAD, y, "READY", color );
	}
}

/*
=================
CG_NewDrawClientScore
=================
*/
static void CG_NewDrawClientScore( int y, score_t *score, float *color, float fade, qboolean largeFormat ) {
//	char	string[128];
	vec3_t	headAngles;
	clientInfo_t	*ci;
	int iconx, headx, x/*, i, length*/;
	vec4_t	drawcolor = {1.0f, 1.0f, 1.0f, 1.0f};
	char	cscore[128], cnet[128], cping[128], ctime[128], cwinloss[16];
	int		multi_weap = 0;
//	int		n1, n2;
	int		maxClients;
	vec4_t	sred = { 1.0f, 0.12f, 0.12f, 0.2f };
	vec4_t	sblue = { 0.12f, 0.12f, 1.0f, 0.2f };

	if ( score->client < 0 || score->client >= cgs.maxclients ) {
		Com_Printf( "Bad score->client: %i\n", score->client );
		return;
	}

	ci = &cgs.clientinfo[score->client];

	iconx = SB_BOTICON_X + (SB_RATING_WIDTH / 2);
	headx = SB_HEAD_X + (SB_RATING_WIDTH / 2);

	maxClients = SB_MAXCLIENTS_INTER;

	if ( cg.time > cg.score_time && cg.scoreBoardShowing ) {
		cg.score_time = cg.time + 1000;
		if ( g_gamemode.integer == 2 ) {
			cg.score_weapon = WP_RAILGUN;
		} else {
			qboolean foundWeapon = qfalse;
			qboolean cycleRepeated = qfalse;

			while ( !foundWeapon ) {
				cg.score_weapon++;

				if ( cg.score_weapon == WP_NUM_WEAPONS - 1 ) {
					if ( cycleRepeated ) {
						cg.score_weapon = 0;
						break;
					}
					cg.score_weapon = 1;
					cycleRepeated = qtrue;
				}

				if ( cgs.picked_up & (1 << (cg.score_weapon - 1)) ) {
					foundWeapon = qtrue;
				}
			}
		}
	}


	// draw the handicap or bot skill marker (unless player has flag)
	//CG_Printf("%i -- %i -- %i - ", score->client, ci->powerups, score->powerups);
	if ( ci->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
	//	CG_Printf("Flag\n");
		if( largeFormat ) {
			CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_FREE, qfalse );
		} else {
			CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD, y, 16, 16, TEAM_FREE, qfalse );
		}
	} else if ( ci->powerups & ( 1 << PW_REDFLAG ) ) {
	//	CG_Printf("Flag\n");
		if( largeFormat ) {
			CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_RED, qfalse );
		} else {
			CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD, y, 16, 16, TEAM_RED, qfalse );
		}
	} else if ( ci->powerups & ( 1 << PW_BLUEFLAG ) ) {
	//	CG_Printf("Flag\n");
		if( largeFormat ) {
			CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_BLUE, qfalse );
		} else {
			CG_DrawFlagModel( iconx + DISTANCE_TO_HEAD, y, 16, 16, TEAM_BLUE, qfalse );
		}
	} else {

		// draw the wins / losses
		if ( cgs.gametype == GT_TOURNAMENT ) {
			Com_sprintf( cwinloss, sizeof( cwinloss ), "%i/%i", ci->wins, ci->losses );
			if( ci->handicap < 100 && !ci->botSkill ) {
				CG_DrawStringExt( iconx + DISTANCE_TO_HEAD, y + SMALLCHAR_HEIGHT/2, cwinloss, color, qtrue, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0);
			} else {
				CG_DrawStringExt( iconx + DISTANCE_TO_HEAD, y, cwinloss, color, qtrue, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0);
			}
		}
	}

	// draw the face
	VectorClear( headAngles );
	headAngles[YAW] = 180;
	if( largeFormat ) {
		CG_DrawHead( headx + 28, y - ( ICON_SIZE - BIGCHAR_HEIGHT - 16 ) / 2, ICON_SIZE - 16, ICON_SIZE - 16,
			score->client, headAngles );
	} else {
		if ( ci->team == TEAM_RED ) {
			CG_DrawHead( 16, y, 14, 14, score->client, headAngles );
		} else if ( ci->team == TEAM_BLUE ) {
			CG_DrawHead( 336, y, 14, 14, score->client, headAngles );
		}
	}

#ifdef MISSIONPACK
	// draw the team task
	if ( ci->teamTask != TEAMTASK_NONE ) {
		if ( ci->teamTask == TEAMTASK_OFFENSE ) {
			CG_DrawPic( headx + 48, y, 16, 16, cgs.media.assaultShader );
		} else if ( ci->teamTask == TEAMTASK_DEFENSE ) {
			CG_DrawPic( headx + 48, y, 16, 16, cgs.media.defendShader );
		}
	}
#endif
	// draw the score line
	if ( score->ping == -1 ) {
	//	Com_sprintf(string, sizeof(string), " connecting    %s", ci->name);
		x = SB_SCORELINE_X + (SB_RATING_WIDTH / 2) + (BIGCHAR_WIDTH * 2);
		Com_sprintf(cscore, sizeof(cscore), "Connnecting", 0);
		Com_sprintf(cnet, sizeof(cnet), "", 0);
		Com_sprintf(cping, sizeof(cping), "", 0);
		Com_sprintf(ctime, sizeof(ctime), "", 0);
	} else {
	//	Com_sprintf(string, sizeof(string),
	//		"%5i %4i %4i %s", score->score, score->ping, score->time, ci->name);
		x = SB_SCORELINE_X + (SB_RATING_WIDTH / 2);
		Com_sprintf(cscore, sizeof(cscore), "%5i", score->score);
		Com_sprintf(cnet, sizeof(cnet), "%4i", score->deaths);
		Com_sprintf(cping, sizeof(cping), "%4i", score->ping);
		Com_sprintf(ctime, sizeof(ctime), "%4i", score->time);
	}

	// highlight your position
	if ( score->client == cg.snap->ps.clientNum ) {
		float	hcolor[4];
		int		rank;

		localClient = qtrue;

		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR
			|| cgs.gametype >= GT_TEAM ) {
			rank = -1;
		} else {
			rank = cg.snap->ps.persistant[PERS_RANK] & ~RANK_TIED_FLAG;
		}
		if ( rank == 0 ) {
			hcolor[0] = 0;
			hcolor[1] = 0;
			hcolor[2] = 0.7f;
		} else if ( rank == 1 ) {
			hcolor[0] = 0.7f;
			hcolor[1] = 0;
			hcolor[2] = 0;
		} else if ( rank == 2 ) {
			hcolor[0] = 0.7f;
			hcolor[1] = 0.7f;
			hcolor[2] = 0;
		} else {
			hcolor[0] = 0.7f;
			hcolor[1] = 0.7f;
			hcolor[2] = 0.7f;
		}

		hcolor[3] = fade * 0.16;
		if ( ci->team == TEAM_RED ) {
			CG_FillRect( 8, y,
				304, SMALLCHAR_HEIGHT, hcolor );
		} else if ( ci->team == TEAM_BLUE ) {
			CG_FillRect( 328, y,
				304, SMALLCHAR_HEIGHT, hcolor );
		}
	}

	drawcolor[0] = drawcolor[1] = drawcolor[2] = 1.0;
	drawcolor[3] = 1.0;


	if ( score->ping == -1 ) {
		//CG_DrawStringExt( 40, y, "Connecting", colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH + 4, SMALLCHAR_HEIGHT, 0, 0, 0 );
	}

	if ( ci->team == TEAM_RED ) {
		CG_DrawStringExt( 80 - CG_DrawStrlen(cscore) * (SMALLCHAR_WIDTH + 4) + 2, y, cscore, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH + 4, SMALLCHAR_HEIGHT, 0, 0, 0 );
		CG_DrawStringExt( 112 - CG_DrawStrlen(cnet) * SMALLCHAR_WIDTH, y + 2, cnet, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT - 4, 0, 0, 0 );
	} else if ( ci->team == TEAM_BLUE ) {
		CG_DrawStringExt( 400 - CG_DrawStrlen(cscore) * (SMALLCHAR_WIDTH + 4) + 2, y, cscore, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH + 4, SMALLCHAR_HEIGHT, 0, 0, 0 );
		CG_DrawStringExt( 432 - CG_DrawStrlen(cnet) * SMALLCHAR_WIDTH, y + 2, cnet, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT - 4, 0, 0, 0 );
	} else {
		CG_DrawStringExt( 80 - CG_DrawStrlen(cscore) * (SMALLCHAR_WIDTH + 4) + 2, y + 100, cscore, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH + 4, SMALLCHAR_HEIGHT, 0, 0, 0 );
		CG_DrawStringExt( 432 - CG_DrawStrlen(cnet) * SMALLCHAR_WIDTH, y + 102, cnet, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT - 4, 0, 0, 0 );
	}

	if ( score->ping != -1 ) {
		if ( ci->team == TEAM_RED ) {
			CG_DrawStringExt( 152 - CG_DrawStrlen(cping) * (SMALLCHAR_WIDTH + 4) + 2, y, cping, drawcolor, qfalse, qtrue, SMALLCHAR_WIDTH + 4, SMALLCHAR_HEIGHT, 0, 0, 0 );
			CG_DrawStringExt( 184 - CG_DrawStrlen(ctime) * (SMALLCHAR_WIDTH + 4) + 2, y, ctime, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH + 4, SMALLCHAR_HEIGHT, 0, 0, 0 );
		} else if ( ci->team == TEAM_BLUE ) {
			CG_DrawStringExt( 472 - CG_DrawStrlen(cping) * (SMALLCHAR_WIDTH + 4) + 2, y, cping, drawcolor, qfalse, qtrue, SMALLCHAR_WIDTH + 4, SMALLCHAR_HEIGHT, 0, 0, 0 );
			CG_DrawStringExt( 504 - CG_DrawStrlen(ctime) * (SMALLCHAR_WIDTH + 4) + 2, y, ctime, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH + 4, SMALLCHAR_HEIGHT, 0, 0, 0 );
		} else {
			CG_DrawStringExt( 152 - CG_DrawStrlen(cping) * (SMALLCHAR_WIDTH + 4) + 2, y + 100, cping, drawcolor, qfalse, qtrue, SMALLCHAR_WIDTH + 4, SMALLCHAR_HEIGHT, 0, 0, 0 );
			CG_DrawStringExt( 184 - CG_DrawStrlen(ctime) * (SMALLCHAR_WIDTH + 4) + 2, y + 100, ctime, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH + 4, SMALLCHAR_HEIGHT, 0, 0, 0 );
		}
	}
	if ( ci->team == TEAM_RED ) {
		CG_DrawStringExt( 202 - 2, y + 1, ci->name, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT - 2, 0, 0, 0 );
	} else if ( ci->team == TEAM_BLUE ) {
		CG_DrawStringExt( 522 - 2, y + 1, ci->name, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT - 2, 0, 0, 0 );
	} else {
		CG_DrawStringExt( 202 - 2, y + 101, ci->name, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT - 2, 0, 0, 0 );
	}

	// add the "ready" marker for intermission exiting
	if ( cg.snap->ps.stats[ STAT_CLIENTS_READY ] & ( 1 << score->client ) ) {
//freeze
		if ( !Q_Isfreeze( score->client ) )
//freeze
		//Replace this.
		CG_DrawBigStringColor( iconx + DISTANCE_TO_HEAD, y, "READY", color );
	}
}

/*
=================
CG_TeamScoreboard
=================
*/
static int CG_TeamScoreboard( int y, team_t team, float fade, int maxClients, int lineHeight ) {
	int		i;
	score_t	*score;
	float	color[4];
	int		count;
	clientInfo_t	*ci;

	color[0] = color[1] = color[2] = 1.0;
	color[3] = fade;

	count = 0;
	for ( i = 0 ; i < cg.numScores && count < maxClients ; i++ ) {
		score = &cg.scores[i];
		ci = &cgs.clientinfo[ score->client ];

		if ( team != ci->team ) {
			continue;
		}

		if ( cg_oldScoreboard.integer >= 0 ) {
			CG_DrawClientScore( y + lineHeight * count, score, color, fade, lineHeight == SB_NORMAL_HEIGHT );
		} else {
			CG_NewDrawClientScore( y + lineHeight * count, score, color, fade, lineHeight == SB_NORMAL_HEIGHT );
		}

		count++;
	}

	return count;
}

/*
=================
CG_DrawScoreboard

Draw the normal in-game scoreboard
=================
*/
qboolean CG_DrawOldScoreboard( void ) {
//	char	string[128];
	int		x, y, w, i, n1, n2;
	float	fade;
	float	*fadeColor;
	char	*s;
	int maxClients;
	int lineHeight;
	int topBorderSize, bottomBorderSize;

	// don't draw amuthing if the menu or console is up
	if ( cg_paused.integer ) {
		cg.deferredPlayerLoading = 0;
		return qfalse;
	}

	if ( cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		cg.deferredPlayerLoading = 0;
		return qfalse;
	}

	// don't draw scoreboard during death while warmup up
	if ( cg.warmup && !cg.showScores ) {
		return qfalse;
	}

	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD ||
		 cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		fade = 1.0;
		fadeColor = colorWhite;
	} else {
		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );

		if ( !fadeColor ) {
			// next time scoreboard comes up, don't print killer
			cg.deferredPlayerLoading = 0;
			cg.killerName[0] = 0;
			return qfalse;
		}
		fade = *fadeColor;
	}


	// fragged by ... line
	if ( cg.killerName[0] ) {
		s = va("Fragged by %s", cg.killerName );
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
		x = ( SCREEN_WIDTH - w ) / 2;
		y = 40;
		CG_DrawBigString( x, y, s, fade );
	}

	// current rank
	if ( cgs.gametype < GT_TEAM) {
		if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR ) {
			s = va("%s place with %i",
				CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
				cg.snap->ps.persistant[PERS_SCORE] );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
			x = ( SCREEN_WIDTH - w ) / 2;
			y = 60;
			CG_DrawBigString( x, y, s, fade );
		}
	} else {
		if ( cg.teamScores[0] == cg.teamScores[1] ) {
			s = va("Teams are tied at %i", cg.teamScores[0] );
		} else if ( cg.teamScores[0] >= cg.teamScores[1] ) {
			s = va("Red leads %i to %i",cg.teamScores[0], cg.teamScores[1] );
		} else {
			s = va("Blue leads %i to %i",cg.teamScores[1], cg.teamScores[0] );
		}

		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
		x = ( SCREEN_WIDTH - w ) / 2;
		y = 60;
		CG_DrawBigString( x, y, s, fade );
	}

	// scoreboard
	y = cgs.gametype<GT_TEAM?(SB_HEADER):(SB_HEADER - 10);

	CG_DrawPic( SB_SCORE_X + (SB_RATING_WIDTH / 2) + 27, y, 56, 28, cgs.media.scoreboardScore );
	CG_DrawPic( SB_PING_X - (SB_RATING_WIDTH / 2) , y, 56, 28, cgs.media.scoreboardPing );
	CG_DrawPic( SB_TIME_X - (SB_RATING_WIDTH / 2) - 25, y, 56, 28, cgs.media.scoreboardTime );
	CG_DrawPic( SB_NAME_X - (SB_RATING_WIDTH / 2) - 40, y, 56, 28, cgs.media.scoreboardName );

	y = SB_TOP;

	// If there are more than SB_MAXCLIENTS_NORMAL, use the interleaved scores

	if ( cg.numScores > SB_MAXCLIENTS_NORMAL ) {
		maxClients = SB_MAXCLIENTS_INTER;
		lineHeight = SB_INTER_HEIGHT;
		topBorderSize = 8;
		bottomBorderSize = 16;
	} else {
		maxClients = SB_MAXCLIENTS_NORMAL;
		cg_oldScoreboard.integer&32?(lineHeight = SB_INTER_HEIGHT):(lineHeight = SB_NORMAL_HEIGHT);
		//lineHeight = SB_NORMAL_HEIGHT;
		topBorderSize = 16;
		bottomBorderSize = 16;
	}

	localClient = qfalse;

	if ( cgs.gametype >= GT_TEAM ) {
		//
		// teamplay scoreboard
		//
		//FIXME: OldScoreboard + !largeFormat == gap between description and colors
		if ( cg.teamScores[0] >= cg.teamScores[1] ) {
				n1 = CG_TeamScoreboard( y, TEAM_RED, fade, maxClients, lineHeight );
				CG_DrawTeamBackground( 0, y - topBorderSize, 640, n1 * lineHeight + bottomBorderSize, 0.33f, TEAM_RED );
				y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
				maxClients -= n1;
				n2 = CG_TeamScoreboard( y, TEAM_BLUE, fade, maxClients, lineHeight );
				CG_DrawTeamBackground( 0, y - topBorderSize, 640, n2 * lineHeight + bottomBorderSize, 0.33f, TEAM_BLUE );
				y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
				maxClients -= n2;
		} else {
				n1 = CG_TeamScoreboard( y, TEAM_BLUE, fade, maxClients, lineHeight );
				CG_DrawTeamBackground( 0, y - topBorderSize, 640, n1 * lineHeight + bottomBorderSize, 0.33f, TEAM_BLUE );
				y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
				maxClients -= n1;
				n2 = CG_TeamScoreboard( y, TEAM_RED, fade, maxClients, lineHeight );
				CG_DrawTeamBackground( 0, y - topBorderSize, 640, n2 * lineHeight + bottomBorderSize, 0.33f, TEAM_RED );
				y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
				maxClients -= n2;
		}

		n1 = CG_TeamScoreboard( y, TEAM_SPECTATOR, fade, maxClients, lineHeight );
		y += (n1 * lineHeight) + SMALLCHAR_HEIGHT * 2;

	} else {
		//
		// free for all scoreboard
		//
		n1 = CG_TeamScoreboard( y, TEAM_FREE, fade, maxClients, lineHeight );
		y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
		n2 = CG_TeamScoreboard( y, TEAM_SPECTATOR, fade, maxClients - n1, lineHeight );
		y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
	}

	if (!localClient) {
		// draw local client at the bottom
		for ( i = 0 ; i < cg.numScores ; i++ ) {
			if ( cg.scores[i].client == cg.snap->ps.clientNum ) {
				CG_DrawClientScore( y, &cg.scores[i], fadeColor, fade, lineHeight == SB_NORMAL_HEIGHT );
				break;
			}
		}
	}

	// load any models that have been deferred
	if ( ++cg.deferredPlayerLoading > 10 ) {
		CG_LoadDeferredPlayers();
	}

	return qtrue;

}

/*
=================
CG_NewDrawScoreboard

Draw the normal in-game scoreboard
=================
*/
qboolean CG_DrawNewScoreboard( void ) {
	char	string[128];
	int		x, y, w, i, n1, n2;
	float	fade;
	float	*fadeColor;
	char	*s;
	int maxClients;
	int lineHeight;
	int topBorderSize, bottomBorderSize;
	vec4_t	hred = { 1.0f, 0.25f, 0.25f, 0.2f };
	vec4_t	hblue = { 0.25f, 0.25f, 1.0f, 0.2f };
	int		wred = CG_DrawStrlen( cg_redName.string ) * (SMALLCHAR_WIDTH + 4);
	int		wblue = CG_DrawStrlen( cg_blueName.string ) * (SMALLCHAR_WIDTH + 4);

	// don't draw amuthing if the menu or console is up
	if ( cg_paused.integer ) {
		cg.deferredPlayerLoading = 0;
		return qfalse;
	}

	if ( cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		cg.deferredPlayerLoading = 0;
		return qfalse;
	}

	// don't draw scoreboard during death while warmup up
	if ( cg.warmup && !cg.showScores ) {
		return qfalse;
	}

	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD ||
		 cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		fade = 1.0;
		fadeColor = colorWhite;
	} else {
		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );

		if ( !fadeColor ) {
			// next time scoreboard comes up, don't print killer
			cg.deferredPlayerLoading = 0;
			cg.killerName[0] = 0;
			return qfalse;
		}
		fade = *fadeColor;
	}


	// fragged by ... line
	if ( cg.killerName[0] ) {
		s = va("Fragged by %s", cg.killerName );
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
		x = ( SCREEN_WIDTH - w ) / 2;
		y = 40;
		CG_DrawBigString( x, y, s, fade );
	}

	// current rank
	if ( cgs.gametype < GT_TEAM) {
		if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR ) {
			s = va("%s place with %i",
				CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
				cg.snap->ps.persistant[PERS_SCORE] );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
			x = ( SCREEN_WIDTH - w ) / 2;
			y = 60;
			CG_DrawBigString( x, y, s, fade );
		}
	}

	// scoreboard
	y = SB_HEADER;



	if ( wred > 18 * (SMALLCHAR_WIDTH + 4) )
		wred = 18 * (SMALLCHAR_WIDTH + 4);

	if ( wblue > 18 * (SMALLCHAR_WIDTH + 4) )
		wblue = 18 * (SMALLCHAR_WIDTH + 4);

	if ( CG_DrawStrlen( cg_redName.string ) ) {
		CG_FillRect( 308 - wred, SB_TOP - 48 - SMALLCHAR_HEIGHT, 4 + wred,
					 SMALLCHAR_HEIGHT, hred );
	}
	if ( CG_DrawStrlen( cg_blueName.string ) ) {
		CG_FillRect( 628 - wblue, SB_TOP - 48 - SMALLCHAR_HEIGHT, 4 + wblue,
					 SMALLCHAR_HEIGHT, hblue );
	}

	if ( CG_DrawStrlen( cg_redName.string ) ) {
		CG_DrawPic( 308 - wred - 16, SB_TOP - 48 - SMALLCHAR_HEIGHT,
					16, 16, cgs.media.scoreboardTeamnameRed );
	}
	if ( CG_DrawStrlen( cg_blueName.string ) ) {
		CG_DrawPic( 628 - wblue - 16, SB_TOP - 48 - SMALLCHAR_HEIGHT,
					16, 16, cgs.media.scoreboardTeamnameBlue );
	}

	CG_FillRect( 8, SB_TOP - 48, 304, 48, hred );
	CG_FillRect( 328, SB_TOP - 48, 304, 48, hblue );

	if ( CG_DrawStrlen( cg_redName.string ) ) {
		CG_DrawStringExt( 308 - wred, SB_TOP - 48 - SMALLCHAR_HEIGHT, cg_redName.string,
						  colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH + 4,
						  SMALLCHAR_HEIGHT, 18, 0, 0 );
	}
	if ( CG_DrawStrlen( cg_blueName.string ) ) {
		CG_DrawStringExt( 628 - wblue, SB_TOP - 48 - SMALLCHAR_HEIGHT, cg_blueName.string,
						  colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH + 4,
						  SMALLCHAR_HEIGHT, 18, 0, 0 );
	}

	CG_DrawStringExt( 112, SB_TOP - 48 + 8, "Points  Players  AvgPing", colorRed, qfalse, qtrue, 8, 12, 0, 0, 0 );
	CG_DrawStringExt( 432, SB_TOP - 48 + 8, "Points  Players  AvgPing", colorBlue, qfalse, qtrue, 8, 12, 0, 0, 0 );

	CG_DrawStringExt( 136 - 20 / 2, SB_TOP - 48 + 8 + 12, "0", colorWhite, qfalse, qtrue, 20, 20, 0, 0, 0 );
	CG_DrawStringExt( 204 - 20 / 2, SB_TOP - 48 + 8 + 12, "4", colorWhite, qfalse, qtrue, 20, 20, 0, 0, 0 );
	CG_DrawStringExt( 276 - 20 / 2, SB_TOP - 48 + 8 + 12, "0", colorWhite, qfalse, qtrue, 20, 20, 0, 0, 0 );

	CG_DrawStringExt( 456 - 20 / 2, SB_TOP - 48 + 8 + 12, "0", colorWhite, qfalse, qtrue, 20, 20, 0, 0, 0 );
	CG_DrawStringExt( 524 - 20 / 2, SB_TOP - 48 + 8 + 12, "4", colorWhite, qfalse, qtrue, 20, 20, 0, 0, 0 );
	CG_DrawStringExt( 596 - 20 / 2, SB_TOP - 48 + 8 + 12, "0", colorWhite, qfalse, qtrue, 20, 20, 0, 0, 0 );

	y = SB_TOP;

	// If there are more than SB_MAXCLIENTS_NORMAL, use the interleaved scores

	maxClients = SB_MAXCLIENTS_INTER;
	lineHeight = SB_INTER_HEIGHT;
	topBorderSize = 8;
	bottomBorderSize = 16;

	localClient = qfalse;

	if ( cgs.gametype >= GT_TEAM ) {
		//
		// teamplay scoreboard
		//
		// y += lineHeight/2;


		vec4_t	sred = { 1.0f, 0.12f, 0.12f, 0.2f };
		vec4_t	sblue = { 0.12f, 0.12f, 1.0f, 0.2f };

		Com_sprintf( string, sizeof( string ), "%i", cg.teamScores[0] );
		CG_DrawStringExt( 8, 70, string, colorWhite, qfalse, qfalse, GIANTCHAR_WIDTH, GIANTCHAR_HEIGHT, 0, FONT_BLOCK, 0 );

		Com_sprintf( string, sizeof( string ), "%i", cg.teamScores[1] );
		CG_DrawStringExt( 328, 70, string, colorWhite, qfalse, qfalse, GIANTCHAR_WIDTH, GIANTCHAR_HEIGHT, 0, FONT_BLOCK, 0 );

		y += TINYCHAR_HEIGHT;

		CG_DrawStringExt( 40, y, "Score NET Ping Min  Name", colorRed, qfalse, qtrue, TINYCHAR_WIDTH, TINYCHAR_HEIGHT + 4, 0, 0, 0 );
		CG_DrawStringExt( 360, y, "Score NET Ping Min  Name", colorBlue, qfalse, qtrue, TINYCHAR_WIDTH, TINYCHAR_HEIGHT + 4, 0, 0, 0 );

		y += SMALLCHAR_HEIGHT;

		n1 = CG_TeamScoreboard( y, TEAM_RED, fade, maxClients, lineHeight );
		n2 = CG_TeamScoreboard( y, TEAM_BLUE, fade, maxClients, lineHeight );

		if ( n1 >= n2 )
			CG_FillRect( 8, SB_TOP, 304, n1 * lineHeight + 32, sred );
		else
			CG_FillRect( 8, SB_TOP, 304, n2 * lineHeight + 32, sred );
		maxClients -= n1;

		if ( n1 >= n2 )
			CG_FillRect( 328, SB_TOP, 304, n1 * lineHeight + 32, sblue );
		else
			CG_FillRect( 328, SB_TOP, 304, n2 * lineHeight + 32, sblue );
		maxClients -= n2;

		if ( n1 >= n2 )
			y = SB_TOP + n1 * lineHeight + 32 + 4;
		else
			y = SB_TOP + n2 * lineHeight + 32 + 4;

		CG_DrawStringExt( 320 - 10 * SMALLCHAR_WIDTH / 2, y,
						  "Spectators", colorYellow, qfalse, qtrue, SMALLCHAR_WIDTH,
						  SMALLCHAR_HEIGHT - 4, 0, 0, 0 );

		n1 = CG_TeamScoreboard( y, TEAM_SPECTATOR, fade, maxClients, lineHeight );
		y += (n1 * lineHeight) + SMALLCHAR_HEIGHT * 2;

	} else {
		//
		// free for all scoreboard
		//
		n1 = CG_TeamScoreboard( y, TEAM_FREE, fade, maxClients, lineHeight );
		y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
		n2 = CG_TeamScoreboard( y, TEAM_SPECTATOR, fade, maxClients - n1, lineHeight );
		y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
	}

	if (!localClient) {
		// draw local client at the bottom
		for ( i = 0 ; i < cg.numScores ; i++ ) {
			if ( cg.scores[i].client == cg.snap->ps.clientNum ) {
				CG_NewDrawClientScore( y, &cg.scores[i], fadeColor, fade, lineHeight == SB_NORMAL_HEIGHT );
				break;
			}
		}
	}

	// load any models that have been deferred
	if ( ++cg.deferredPlayerLoading > 10 ) {
		CG_LoadDeferredPlayers();
	}

	return qtrue;
}

//================================================================================

/*
================
CG_CenterGiantLine
================
*/
static void CG_CenterGiantLine( float y, const char *string ) {
	float		x;
	vec4_t		color;

	color[0] = 1;
	color[1] = 1;
	color[2] = 1;
	color[3] = 1;

	x = 0.5 * ( 640 - GIANT_WIDTH * CG_DrawStrlen( string ) );

	CG_DrawStringExt( x, y, string, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0, 0, 0 );
}

/*
=================
CG_DrawTourneyScoreboard

Draw the oversize scoreboard for tournements
=================
*/
void CG_DrawOldTourneyScoreboard( void ) {
	const char		*s;
	vec4_t			color;
	int				min, tens, ones;
	clientInfo_t	*ci;
	int				y;
	int				i;

	// request more scores regularly
	if ( cg.scoresRequestTime + 2000 < cg.time ) {
		cg.scoresRequestTime = cg.time;
		trap_SendClientCommand( "score" );
	}

	color[0] = 1;
	color[1] = 1;
	color[2] = 1;
	color[3] = 1;

	// draw the dialog background
	color[0] = color[1] = color[2] = 0;
	color[3] = 1;
	CG_FillRect( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color );

	// print the mesage of the day
	s = CG_ConfigString( CS_MOTD );
	if ( !s[0] ) {
		s = "Scoreboard";
	}

	// print optional title
	CG_CenterGiantLine( 8, s );

	// print server time
	ones = cg.time / 1000;
	min = ones / 60;
	ones %= 60;
	tens = ones / 10;
	ones %= 10;
	s = va("%i:%i%i", min, tens, ones );

	CG_CenterGiantLine( 64, s );


	// print the two scores

	y = 160;
	if ( cgs.gametype >= GT_TEAM ) {
		//
		// teamplay scoreboard
		//
		CG_DrawStringExt( 8, y, "Red Team", color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0, 0, 0 );
		s = va("%i", cg.teamScores[0] );
		CG_DrawStringExt( 632 - GIANT_WIDTH * strlen(s), y, s, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0, 0, 0 );

		y += 64;

		CG_DrawStringExt( 8, y, "Blue Team", color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0, 0, 0 );
		s = va("%i", cg.teamScores[1] );
		CG_DrawStringExt( 632 - GIANT_WIDTH * strlen(s), y, s, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0, 0, 0 );
	} else {
		//
		// free for all scoreboard
		//
		for ( i = 0 ; i < MAX_CLIENTS ; i++ ) {
			ci = &cgs.clientinfo[i];
			if ( !ci->infoValid ) {
				continue;
			}
			if ( ci->team != TEAM_FREE ) {
				continue;
			}

			CG_DrawStringExt( 8, y, ci->name, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0, 0, 0 );
			s = va("%i", ci->score );
			CG_DrawStringExt( 632 - GIANT_WIDTH * strlen(s), y, s, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0, 0, 0 );
			y += 64;
		}
	}
}

