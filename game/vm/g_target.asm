export Use_Target_Give
code
proc Use_Target_Give 64 12
file "../g_target.c"
line 10
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5://==========================================================
;6:
;7:/*QUAKED target_give (1 0 0) (-8 -8 -8) (8 8 8)
;8:Gives the activator all the items pointed to.
;9:*/
;10:void Use_Target_Give( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 14
;11:	gentity_t	*t;
;12:	trace_t		trace;
;13:
;14:	if ( !activator->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $68
line 15
;15:		return;
ADDRGP4 $67
JUMPV
LABELV $68
line 18
;16:	}
;17:
;18:	if ( !ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $70
line 19
;19:		return;
ADDRGP4 $67
JUMPV
LABELV $70
line 22
;20:	}
;21:
;22:	memset( &trace, 0, sizeof( trace ) );
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 23
;23:	t = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $73
JUMPV
LABELV $72
line 24
;24:	while ( (t = G_Find (t, FOFS(targetname), ent->target)) != NULL ) {
line 25
;25:		if ( !t->item ) {
ADDRLP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $75
line 26
;26:			continue;
ADDRGP4 $73
JUMPV
LABELV $75
line 28
;27:		}
;28:		Touch_Item( t, activator, &trace );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Touch_Item
CALLV
pop
line 31
;29:
;30:		// make sure it isn't going to respawn or show any events
;31:		t->nextthink = 0;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 32
;32:		trap_UnlinkEntity( t );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 33
;33:	}
LABELV $73
line 24
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 652
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $72
line 34
;34:}
LABELV $67
endproc Use_Target_Give 64 12
export SP_target_give
proc SP_target_give 0 0
line 36
;35:
;36:void SP_target_give( gentity_t *ent ) {
line 37
;37:	ent->use = Use_Target_Give;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Target_Give
ASGNP4
line 38
;38:}
LABELV $77
endproc SP_target_give 0 0
export Use_target_remove_powerups
proc Use_target_remove_powerups 8 12
line 47
;39:
;40:
;41://==========================================================
;42:
;43:/*QUAKED target_remove_powerups (1 0 0) (-8 -8 -8) (8 8 8)
;44:takes away all the activators powerups.
;45:Used to drop flight powerups into death puts.
;46:*/
;47:void Use_target_remove_powerups( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 49
;48:	int i;//Monkk
;49:	if( !activator->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $79
line 50
;50:		return;
ADDRGP4 $78
JUMPV
LABELV $79
line 54
;51:	}
;52:
;53:	//monkk- flag sacrifice
;54:	if( g_flagSacrifice.integer == 0 )
ADDRGP4 g_flagSacrifice+12
INDIRI4
CNSTI4 0
NEI4 $81
line 55
;55:	{//plain ole q3
line 56
;56:		if( activator->client->ps.powerups[PW_REDFLAG] ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $84
line 57
;57:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 58
;58:		} else if( activator->client->ps.powerups[PW_BLUEFLAG] ) {
ADDRGP4 $85
JUMPV
LABELV $84
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $86
line 59
;59:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 60
;60:		} else if( activator->client->ps.powerups[PW_NEUTRALFLAG] ) {
ADDRGP4 $87
JUMPV
LABELV $86
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $88
line 61
;61:			Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 62
;62:		}
LABELV $88
LABELV $87
LABELV $85
line 64
;63:		
;64:		memset( activator->client->ps.powerups, 0, sizeof( activator->client->ps.powerups ) );
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 65
;65:	} else {//sacrifice
ADDRGP4 $82
JUMPV
LABELV $81
line 67
;66:		//Monkk
;67:		if(ent->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $90
line 70
;68:			//manually clear the powerups array instead of taking the cheap route of t3h memset
;69:			//we do this because flags needs to get tossed and that happens later in player_die
;70:			for(i=0;i<MAX_POWERUPS;i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $92
line 71
;71:				if (i == PW_REDFLAG || i == PW_BLUEFLAG || i == PW_NEUTRALFLAG) {
ADDRLP4 0
INDIRI4
CNSTI4 7
EQI4 $99
ADDRLP4 0
INDIRI4
CNSTI4 8
EQI4 $99
ADDRLP4 0
INDIRI4
CNSTI4 9
NEI4 $96
LABELV $99
line 73
;72:					//G_Printf("skipping flag powerup removal in Use_target_powerups\n");
;73:					continue;
ADDRGP4 $93
JUMPV
LABELV $96
line 75
;74:				}
;75:				ent->client->ps.powerups[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 76
;76:			}
LABELV $93
line 70
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $92
line 77
;77:		}
LABELV $90
line 78
;78:	}
LABELV $82
line 79
;79:}
LABELV $78
endproc Use_target_remove_powerups 8 12
export SP_target_remove_powerups
proc SP_target_remove_powerups 0 0
line 81
;80:
;81:void SP_target_remove_powerups( gentity_t *ent ) {
line 82
;82:	ent->use = Use_target_remove_powerups;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_target_remove_powerups
ASGNP4
line 83
;83:}
LABELV $100
endproc SP_target_remove_powerups 0 0
export Think_Target_Delay
proc Think_Target_Delay 4 8
line 92
;84:
;85:
;86://==========================================================
;87:
;88:/*QUAKED target_delay (1 0 0) (-8 -8 -8) (8 8 8)
;89:"wait" seconds to pause before firing targets.
;90:"random" delay variance, total delay = delay +/- random seconds
;91:*/
;92:void Think_Target_Delay( gentity_t *ent ) {
line 93
;93:	G_UseTargets( ent, ent->activator );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 94
;94:}
LABELV $101
endproc Think_Target_Delay 4 8
export Use_Target_Delay
proc Use_Target_Delay 8 0
line 96
;95:
;96:void Use_Target_Delay( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 97
;97:	ent->nextthink = level.time + ( ent->wait + ent->random * crandom() ) * 1000;
ADDRLP4 0
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
CNSTF4 1148846080
ADDRLP4 4
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 1073741824
ADDRLP4 0
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
ADDF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 98
;98:	ent->think = Think_Target_Delay;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Think_Target_Delay
ASGNP4
line 99
;99:	ent->activator = activator;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 100
;100:}
LABELV $102
endproc Use_Target_Delay 8 0
export SP_target_delay
proc SP_target_delay 4 12
line 102
;101:
;102:void SP_target_delay( gentity_t *ent ) {
line 104
;103:	// check delay for backwards compatability
;104:	if ( !G_SpawnFloat( "delay", "0", &ent->wait ) ) {
ADDRGP4 $107
ARGP4
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 G_SpawnFloat
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $105
line 105
;105:		G_SpawnFloat( "wait", "1", &ent->wait );
ADDRGP4 $109
ARGP4
ADDRGP4 $110
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 106
;106:	}
LABELV $105
line 108
;107:
;108:	if ( !ent->wait ) {
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
CNSTF4 0
NEF4 $111
line 109
;109:		ent->wait = 1;
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
CNSTF4 1065353216
ASGNF4
line 110
;110:	}
LABELV $111
line 111
;111:	ent->use = Use_Target_Delay;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Target_Delay
ASGNP4
line 112
;112:}
LABELV $104
endproc SP_target_delay 4 12
export Use_Target_Score
proc Use_Target_Score 4 12
line 122
;113:
;114:
;115://==========================================================
;116:
;117:/*QUAKED target_score (1 0 0) (-8 -8 -8) (8 8 8)
;118:"count" number of points to add, default 1
;119:
;120:The activator is given this many points.
;121:*/
;122:void Use_Target_Score (gentity_t *ent, gentity_t *other, gentity_t *activator) {
line 123
;123:	AddScore( activator, ent->r.currentOrigin, ent->count );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 124
;124:}
LABELV $113
endproc Use_Target_Score 4 12
export SP_target_score
proc SP_target_score 0 0
line 126
;125:
;126:void SP_target_score( gentity_t *ent ) {
line 127
;127:	if ( !ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
NEI4 $115
line 128
;128:		ent->count = 1;
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 129
;129:	}
LABELV $115
line 130
;130:	ent->use = Use_Target_Score;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Target_Score
ASGNP4
line 131
;131:}
LABELV $114
endproc SP_target_score 0 0
export Use_Target_Print
proc Use_Target_Print 4 8
line 140
;132:
;133:
;134://==========================================================
;135:
;136:/*QUAKED target_print (1 0 0) (-8 -8 -8) (8 8 8) redteam blueteam private
;137:"message"	text to print
;138:If "private", only the activator gets the message.  If no checks, all clients get the message.
;139:*/
;140:void Use_Target_Print (gentity_t *ent, gentity_t *other, gentity_t *activator) {
line 141
;141:	if ( activator->client && ( ent->spawnflags & 4 ) ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $118
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $118
line 142
;142:		trap_SendServerCommand( activator-g_entities, va("cp \"%s\"", ent->message ));
ADDRGP4 $120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 143
;143:		return;
ADDRGP4 $117
JUMPV
LABELV $118
line 146
;144:	}
;145:
;146:	if ( ent->spawnflags & 3 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $121
line 147
;147:		if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $123
line 148
;148:			G_TeamCommand( TEAM_RED, va("cp \"%s\"", ent->message) );
ADDRGP4 $120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_TeamCommand
CALLV
pop
line 149
;149:		}
LABELV $123
line 150
;150:		if ( ent->spawnflags & 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $117
line 151
;151:			G_TeamCommand( TEAM_BLUE, va("cp \"%s\"", ent->message) );
ADDRGP4 $120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_TeamCommand
CALLV
pop
line 152
;152:		}
line 153
;153:		return;
ADDRGP4 $117
JUMPV
LABELV $121
line 156
;154:	}
;155:
;156:	trap_SendServerCommand( -1, va("cp \"%s\"", ent->message ));
ADDRGP4 $120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 157
;157:}
LABELV $117
endproc Use_Target_Print 4 8
export SP_target_print
proc SP_target_print 0 0
line 159
;158:
;159:void SP_target_print( gentity_t *ent ) {
line 160
;160:	ent->use = Use_Target_Print;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Target_Print
ASGNP4
line 161
;161:}
LABELV $127
endproc SP_target_print 0 0
export Use_Target_Speaker
proc Use_Target_Speaker 4 12
line 179
;162:
;163:
;164://==========================================================
;165:
;166:
;167:/*QUAKED target_speaker (1 0 0) (-8 -8 -8) (8 8 8) looped-on looped-off global activator
;168:"noise"		wav file to play
;169:
;170:A global sound will play full volume throughout the level.
;171:Activator sounds will play on the player that activated the target.
;172:Global and activator sounds can't be combined with looping.
;173:Normal sounds play each time the target is used.
;174:Looped sounds will be toggled by use functions.
;175:Multiple identical looping sounds will just increase volume without any speed cost.
;176:"wait" : Seconds between auto triggerings, 0 = don't auto trigger
;177:"random"	wait variance, default is 0
;178:*/
;179:void Use_Target_Speaker (gentity_t *ent, gentity_t *other, gentity_t *activator) {
line 180
;180:	if (ent->spawnflags & 3) {	// looping sound toggles
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $129
line 181
;181:		if (ent->s.loopSound)
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $131
line 182
;182:			ent->s.loopSound = 0;	// turn it off
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $130
JUMPV
LABELV $131
line 184
;183:		else
;184:			ent->s.loopSound = ent->noise_index;	// start it
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
ASGNI4
line 185
;185:	}else {	// normal sound
ADDRGP4 $130
JUMPV
LABELV $129
line 186
;186:		if ( ent->spawnflags & 8 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $133
line 187
;187:			G_AddEvent( activator, EV_GENERAL_SOUND, ent->noise_index );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 45
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 188
;188:		} else if (ent->spawnflags & 4) {
ADDRGP4 $134
JUMPV
LABELV $133
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $135
line 189
;189:			G_AddEvent( ent, EV_GLOBAL_SOUND, ent->noise_index );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 190
;190:		} else {
ADDRGP4 $136
JUMPV
LABELV $135
line 191
;191:			G_AddEvent( ent, EV_GENERAL_SOUND, ent->noise_index );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 192
;192:		}
LABELV $136
LABELV $134
line 193
;193:	}
LABELV $130
line 194
;194:}
LABELV $128
endproc Use_Target_Speaker 4 12
export SP_target_speaker
proc SP_target_speaker 96 16
line 196
;195:
;196:void SP_target_speaker( gentity_t *ent ) {
line 200
;197:	char	buffer[MAX_QPATH];
;198:	char	*s;
;199:
;200:	G_SpawnFloat( "wait", "0", &ent->wait );
ADDRGP4 $109
ARGP4
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 201
;201:	G_SpawnFloat( "random", "0", &ent->random );
ADDRGP4 $138
ARGP4
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 203
;202:
;203:	if ( !G_SpawnString( "noise", "NOSOUND", &s ) ) {
ADDRGP4 $141
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $139
line 204
;204:		G_Error( "target_speaker without a noise key at %s", vtos( ent->s.origin ) );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 72
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $143
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 205
;205:	}
LABELV $139
line 209
;206:
;207:	// force all client reletive sounds to be "activator" speakers that
;208:	// play on the entity that activates it
;209:	if ( s[0] == '*' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $144
line 210
;210:		ent->spawnflags |= 8;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 211
;211:	}
LABELV $144
line 213
;212:
;213:	if (!strstr( s, ".wav" )) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 72
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $146
line 214
;214:		Com_sprintf (buffer, sizeof(buffer), "%s.wav", s );
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $149
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 215
;215:	} else {
ADDRGP4 $147
JUMPV
LABELV $146
line 216
;216:		Q_strncpyz( buffer, s, sizeof(buffer) );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 217
;217:	}
LABELV $147
line 218
;218:	ent->noise_index = G_SoundIndex(buffer);
ADDRLP4 4
ARGP4
ADDRLP4 76
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
ADDRLP4 76
INDIRI4
ASGNI4
line 221
;219:
;220:	// a repeating speaker can be done completely client side
;221:	ent->s.eType = ET_SPEAKER;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 7
ASGNI4
line 222
;222:	ent->s.eventParm = ent->noise_index;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
ASGNI4
line 223
;223:	ent->s.frame = ent->wait * 10;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 1092616192
ADDRLP4 84
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 224
;224:	ent->s.clientNum = ent->random * 10;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 168
ADDP4
CNSTF4 1092616192
ADDRLP4 88
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 228
;225:
;226:
;227:	// check for prestarted looping sound
;228:	if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $150
line 229
;229:		ent->s.loopSound = ent->noise_index;
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
ASGNI4
line 230
;230:	}
LABELV $150
line 232
;231:
;232:	ent->use = Use_Target_Speaker;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Target_Speaker
ASGNP4
line 234
;233:
;234:	if (ent->spawnflags & 4) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $152
line 235
;235:		ent->r.svFlags |= SVF_BROADCAST;
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 236
;236:	}
LABELV $152
line 238
;237:
;238:	VectorCopy( ent->s.origin, ent->s.pos.trBase );
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 242
;239:
;240:	// must link the entity so we get areas and clusters so
;241:	// the server can determine who to send updates to
;242:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 243
;243:}
LABELV $137
endproc SP_target_speaker 96 16
export target_laser_think
proc target_laser_think 120 32
line 252
;244:
;245:
;246:
;247://==========================================================
;248:
;249:/*QUAKED target_laser (0 .5 .8) (-8 -8 -8) (8 8 8) START_ON
;250:When triggered, fires a laser.  You can either set a target or a direction.
;251:*/
;252:void target_laser_think (gentity_t *self) {
line 258
;253:	vec3_t	end;
;254:	trace_t	tr;
;255:	vec3_t	point;
;256:
;257:	// if pointed at another entity, set movedir to point at it
;258:	if ( self->enemy ) {
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $155
line 259
;259:		VectorMA (self->enemy->s.origin, 0.5, self->enemy->r.mins, point);
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 88
CNSTF4 1056964608
ASGNF4
ADDRLP4 0
ADDRLP4 84
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 92
ADDRLP4 80
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 92
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 96
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 96
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 260
;260:		VectorMA (point, 0.5, self->enemy->r.maxs, point);
ADDRLP4 100
CNSTF4 1056964608
ASGNF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 100
INDIRF4
ADDRLP4 104
INDIRP4
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 100
INDIRF4
ADDRLP4 104
INDIRP4
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1056964608
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 261
;261:		VectorSubtract (point, self->s.origin, self->movedir);
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 676
ADDP4
ADDRLP4 0
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI4 680
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 684
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRLP4 116
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 262
;262:		VectorNormalize (self->movedir);
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 263
;263:	}
LABELV $155
line 266
;264:
;265:	// fire forward and see what we hit
;266:	VectorMA (self->s.origin, 2048, self->movedir, end);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTF4 1157627904
ASGNF4
ADDRLP4 12
ADDRLP4 80
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 88
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
CNSTF4 1157627904
ADDRLP4 88
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 268
;267:
;268:	trap_Trace( &tr, self->s.origin, NULL, NULL, end, self->s.number, CONTENTS_SOLID|CONTENTS_BODY|CONTENTS_CORPSE);
ADDRLP4 24
ARGP4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 96
CNSTP4 0
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 92
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 270
;269:
;270:	if ( tr.entityNum ) {
ADDRLP4 24+52
INDIRI4
CNSTI4 0
EQI4 $167
line 272
;271:		// hurt it if we can
;272:		G_Damage ( &g_entities[tr.entityNum], self, self->activator, self->movedir, 
CNSTI4 896
ADDRLP4 24+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRLP4 24+12
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 21
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 274
;273:			tr.endpos, self->damage, DAMAGE_NO_KNOCKBACK, MOD_TARGET_LASER);
;274:	}
LABELV $167
line 276
;275:
;276:	VectorCopy (tr.endpos, self->s.origin2);
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 24+12
INDIRB
ASGNB 12
line 278
;277:
;278:	trap_LinkEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 279
;279:	self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 280
;280:}
LABELV $154
endproc target_laser_think 120 32
export target_laser_on
proc target_laser_on 4 4
line 283
;281:
;282:void target_laser_on (gentity_t *self)
;283:{
line 284
;284:	if (!self->activator)
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $175
line 285
;285:		self->activator = self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $175
line 286
;286:	target_laser_think (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_think
CALLV
pop
line 287
;287:}
LABELV $174
endproc target_laser_on 4 4
export target_laser_off
proc target_laser_off 0 4
line 290
;288:
;289:void target_laser_off (gentity_t *self)
;290:{
line 291
;291:	trap_UnlinkEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 292
;292:	self->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 293
;293:}
LABELV $177
endproc target_laser_off 0 4
export target_laser_use
proc target_laser_use 0 4
line 296
;294:
;295:void target_laser_use (gentity_t *self, gentity_t *other, gentity_t *activator)
;296:{
line 297
;297:	self->activator = activator;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 298
;298:	if ( self->nextthink > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
CNSTI4 0
LEI4 $179
line 299
;299:		target_laser_off (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_off
CALLV
pop
ADDRGP4 $180
JUMPV
LABELV $179
line 301
;300:	else
;301:		target_laser_on (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_on
CALLV
pop
LABELV $180
line 302
;302:}
LABELV $178
endproc target_laser_use 0 4
export target_laser_start
proc target_laser_start 16 16
line 305
;303:
;304:void target_laser_start (gentity_t *self)
;305:{
line 308
;306:	gentity_t *ent;
;307:
;308:	self->s.eType = ET_BEAM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 5
ASGNI4
line 310
;309:
;310:	if (self->target) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $182
line 311
;311:		ent = G_Find (NULL, FOFS(targetname), self->target);
CNSTP4 0
ARGP4
CNSTI4 652
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 312
;312:		if (!ent) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $184
line 313
;313:			G_Printf ("%s at %s: %s is a bad target\n", self->classname, vtos(self->s.origin), self->target);
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $186
ARGP4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 314
;314:		}
LABELV $184
line 315
;315:		self->enemy = ent;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 316
;316:	} else {
ADDRGP4 $183
JUMPV
LABELV $182
line 317
;317:		G_SetMovedir (self->s.angles, self->movedir);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 318
;318:	}
LABELV $183
line 320
;319:
;320:	self->use = target_laser_use;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 target_laser_use
ASGNP4
line 321
;321:	self->think = target_laser_think;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 target_laser_think
ASGNP4
line 323
;322:
;323:	if ( !self->damage ) {
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $187
line 324
;324:		self->damage = 1;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 1
ASGNI4
line 325
;325:	}
LABELV $187
line 327
;326:
;327:	if (self->spawnflags & 1)
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $189
line 328
;328:		target_laser_on (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_on
CALLV
pop
ADDRGP4 $190
JUMPV
LABELV $189
line 330
;329:	else
;330:		target_laser_off (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_off
CALLV
pop
LABELV $190
line 331
;331:}
LABELV $181
endproc target_laser_start 16 16
export SP_target_laser
proc SP_target_laser 0 0
line 334
;332:
;333:void SP_target_laser (gentity_t *self)
;334:{
line 336
;335:	// let everything else get spawned before we start firing
;336:	self->think = target_laser_start;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 target_laser_start
ASGNP4
line 337
;337:	self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 338
;338:}
LABELV $191
endproc SP_target_laser 0 0
export target_teleporter_use
proc target_teleporter_use 12 16
line 343
;339:
;340:
;341://==========================================================
;342:
;343:void target_teleporter_use( gentity_t *self, gentity_t *other, gentity_t *activator ) {
line 346
;344:	gentity_t	*dest;
;345:
;346:	if (!activator->client)
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $194
line 347
;347:		return;
ADDRGP4 $193
JUMPV
LABELV $194
line 348
;348:	dest = 	G_PickTarget( self->target );
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 349
;349:	if (!dest) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $196
line 350
;350:		G_Printf ("Couldn't find teleporter destination\n");
ADDRGP4 $198
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 351
;351:		return;
ADDRGP4 $193
JUMPV
LABELV $196
line 354
;352:	}
;353:
;354:	TeleportPlayer( activator, dest->s.origin, dest->s.angles, qtrue );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TeleportPlayer
CALLV
pop
line 355
;355:}
LABELV $193
endproc target_teleporter_use 12 16
export SP_target_teleporter
proc SP_target_teleporter 4 12
line 360
;356:
;357:/*QUAKED target_teleporter (1 0 0) (-8 -8 -8) (8 8 8)
;358:The activator will be teleported away.
;359:*/
;360:void SP_target_teleporter( gentity_t *self ) {
line 361
;361:	if (!self->targetname)
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $200
line 362
;362:		G_Printf("untargeted %s at %s\n", self->classname, vtos(self->s.origin));
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $202
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
LABELV $200
line 364
;363:
;364:	self->use = target_teleporter_use;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 target_teleporter_use
ASGNP4
line 365
;365:}
LABELV $199
endproc SP_target_teleporter 4 12
export target_relay_use
proc target_relay_use 36 12
line 375
;366:
;367://==========================================================
;368:
;369:
;370:/*QUAKED target_relay (.5 .5 .5) (-8 -8 -8) (8 8 8) RED_ONLY BLUE_ONLY RANDOM
;371:This doesn't perform any actions except fire its targets.
;372:The activator can be forced to be from a certain team.
;373:if RANDOM is checked, only one of the targets will be fired, not all of them
;374:*/
;375:void target_relay_use (gentity_t *self, gentity_t *other, gentity_t *activator) {
line 376
;376:	if ( ( self->spawnflags & 1 ) && activator->client 
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
BANDI4
CNSTI4 0
EQI4 $204
ADDRLP4 4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $204
ADDRLP4 4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $204
line 377
;377:		&& activator->client->sess.sessionTeam != TEAM_RED ) {
line 378
;378:		return;
ADDRGP4 $203
JUMPV
LABELV $204
line 380
;379:	}
;380:	if ( ( self->spawnflags & 2 ) && activator->client 
ADDRLP4 8
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
BANDI4
CNSTI4 0
EQI4 $206
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $206
ADDRLP4 12
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $206
line 381
;381:		&& activator->client->sess.sessionTeam != TEAM_BLUE ) {
line 382
;382:		return;
ADDRGP4 $203
JUMPV
LABELV $206
line 384
;383:	}
;384:	if ( self->spawnflags & 4 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $208
line 387
;385:		gentity_t	*ent;
;386:
;387:		ent = G_PickTarget( self->target );
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 20
INDIRP4
ASGNP4
line 388
;388:		if ( ent && ent->use ) {
ADDRLP4 24
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 28
CNSTU4 0
ASGNU4
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $203
ADDRLP4 24
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $203
line 389
;389:			ent->use( ent, self, activator );
ADDRLP4 32
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 390
;390:		}
line 391
;391:		return;
ADDRGP4 $203
JUMPV
LABELV $208
line 393
;392:	}
;393:	G_UseTargets (self, activator);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 394
;394:}
LABELV $203
endproc target_relay_use 36 12
export SP_target_relay
proc SP_target_relay 0 0
line 396
;395:
;396:void SP_target_relay (gentity_t *self) {
line 397
;397:	self->use = target_relay_use;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 target_relay_use
ASGNP4
line 398
;398:}
LABELV $212
endproc SP_target_relay 0 0
export target_kill_use
proc target_kill_use 8 32
line 406
;399:
;400:
;401://==========================================================
;402:
;403:/*QUAKED target_kill (.5 .5 .5) (-8 -8 -8) (8 8 8)
;404:Kills the activator.
;405:*/
;406:void target_kill_use( gentity_t *self, gentity_t *other, gentity_t *activator ) {
line 407
;407:	G_Damage ( activator, NULL, NULL, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_TELEFRAG);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
CNSTP4 0
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 8
ARGI4
CNSTI4 18
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 408
;408:}
LABELV $213
endproc target_kill_use 8 32
export SP_target_kill
proc SP_target_kill 0 0
line 410
;409:
;410:void SP_target_kill( gentity_t *self ) {
line 411
;411:	self->use = target_kill_use;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 target_kill_use
ASGNP4
line 412
;412:}
LABELV $214
endproc SP_target_kill 0 0
export SP_target_position
proc SP_target_position 4 8
line 417
;413:
;414:/*QUAKED target_position (0 0.5 0) (-4 -4 -4) (4 4 4)
;415:Used as a positional target for in-game calculation, like jumppad targets.
;416:*/
;417:void SP_target_position( gentity_t *self ){
line 418
;418:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 419
;419:}
LABELV $215
endproc SP_target_position 4 8
proc target_location_linkup 20 8
line 422
;420:
;421:static void target_location_linkup(gentity_t *ent)
;422:{
line 426
;423:	int i;
;424:	int n;
;425://freeze
;426:	qboolean	modified = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 429
;427://freeze
;428:
;429:	if (level.locationLinked) 
ADDRGP4 level+9200
INDIRI4
CNSTI4 0
EQI4 $217
line 430
;430:		return;
ADDRGP4 $216
JUMPV
LABELV $217
line 433
;431:
;432://freeze
;433:	if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $220
line 434
;434:		for ( i = 0, ent = g_entities; i < level.num_entities; i++, ent++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRGP4 g_entities
ASGNP4
ADDRGP4 $226
JUMPV
LABELV $223
line 435
;435:			if ( ent->classname && !Q_stricmp( ent->classname, "target_location" ) ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $228
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $230
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $228
line 436
;436:				if ( ent->count != 255 ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 255
EQI4 $231
line 437
;437:					modified = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 438
;438:					break;
ADDRGP4 $225
JUMPV
LABELV $231
line 440
;439:				}
;440:			}
LABELV $228
line 441
;441:		}
LABELV $224
line 434
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 896
ADDP4
ASGNP4
LABELV $226
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $223
LABELV $225
line 442
;442:	}
LABELV $220
line 444
;443://freeze
;444:	level.locationLinked = qtrue;
ADDRGP4 level+9200
CNSTI4 1
ASGNI4
line 446
;445:
;446:	level.locationHead = NULL;
ADDRGP4 level+9204
CNSTP4 0
ASGNP4
line 448
;447:
;448:	trap_SetConfigstring( CS_LOCATIONS, "unknown" );
CNSTI4 608
ARGI4
ADDRGP4 $235
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 450
;449:
;450:	for (i = 0, ent = g_entities, n = 1;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRGP4 g_entities
ASGNP4
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $239
JUMPV
LABELV $236
line 452
;451:			i < level.num_entities;
;452:			i++, ent++) {
line 453
;453:		if (ent->classname && !Q_stricmp(ent->classname, "target_location")) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $241
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $230
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $241
line 455
;454://freeze
;455:			if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $243
line 456
;456:				if ( ent->count == 255 ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 255
NEI4 $246
line 457
;457:					if ( modified ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $248
line 458
;458:						ent->think = G_FreeEntity;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 459
;459:						ent->nextthink = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 461
;460:
;461:						continue;
ADDRGP4 $237
JUMPV
LABELV $248
line 463
;462:					}
;463:					ent->count = 0;
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 464
;464:				}
LABELV $246
line 465
;465:			}
LABELV $243
line 468
;466://freeze
;467:			// lets overload some variables!
;468:			ent->health = n; // use for location marking
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 469
;469:			trap_SetConfigstring( CS_LOCATIONS + n, ent->message );
ADDRLP4 4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 470
;470:			n++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 471
;471:			ent->nextTrain = level.locationHead;
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 level+9204
INDIRP4
ASGNP4
line 472
;472:			level.locationHead = ent;
ADDRGP4 level+9204
ADDRFP4 0
INDIRP4
ASGNP4
line 473
;473:		}
LABELV $241
line 474
;474:	}
LABELV $237
line 452
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 896
ADDP4
ASGNP4
LABELV $239
line 451
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $236
line 477
;475:
;476:	// All linked together now
;477:}
LABELV $216
endproc target_location_linkup 20 8
export SP_target_location
proc SP_target_location 4 8
line 487
;478:
;479:/*QUAKED target_location (0 0.5 0) (-8 -8 -8) (8 8 8)
;480:Set "message" to the name of this location.
;481:Set "count" to 0-7 for color.
;482:0:white 1:red 2:green 3:yellow 4:blue 5:cyan 6:magenta 7:white
;483:
;484:Closest target_location in sight used for the location, if none
;485:in site, closest in distance
;486:*/
;487:void SP_target_location( gentity_t *self ){
line 488
;488:	self->think = target_location_linkup;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 target_location_linkup
ASGNP4
line 489
;489:	self->nextthink = level.time + 200;  // Let them all spawn first
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 491
;490:
;491:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 492
;492:}
LABELV $253
endproc SP_target_location 4 8
import Cmd_Timein_f
import Cmd_Timeout_f
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_Args
import trap_Milliseconds
import trap_Error
import trap_Printf
import sv_allowUnnamed
import sv_motd8
import sv_motd7
import sv_motd6
import sv_motd5
import sv_motd4
import sv_motd3
import sv_motd2
import sv_motd1
import g_interference
import g_spawnProtection
import g_allowObliterate
import g_freezeAutothawTime
import g_freezeRoundRespawn
import g_DynamicGauntletCycle
import g_gauntletjumpRadius
import g_gauntletJumping
import g_gauntletKnockback
import sv_lock_cg_railHum_to
import g_allowSave
import g_AdminPassword
import g_fixMuzzleBug
import g_readyGrace
import g_allowReady
import g_sacrificeAnnounce
import g_flagSacrifice
import lastmap
import modname
import g_timeInGrace
import g_timeOutLength
import g_timeOutLimit
import g_allowHandicap
import g_pro_mode
import g_muteTourneyspecs
import g_muteSpecs
import g_fastSwitch
import g_fastRespawn
import weap_bfgCycle
import weap_plasmagunCycle
import weap_railgunCycle
import weap_rocketlauncherCycle
import weap_lightninggunCycle
import weap_grenadelauncherCycle
import weap_shotgunCycle
import weap_machinegunCycle
import weap_gauntletCycle
import weap_allowed
import weap_enableHook
import g_wpflags
import sv_fps
import g_delagProjectiles
import g_delagHitscan
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_rankings
import sv_lock_pmove
import pmove_msec
import pmove_fixed
import g_IU_ctf_sounds
import g_returnFlag
import g_DynamicRailgunCycle
import g_RailjumpRadius
import g_RailJumping
import g_teamKnockback
import g_railgunKnockback
import g_StaticKnockback
import g_SelfDamage
import g_FallingDamage
import g_allowLockedTeams
import g_gamemode
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import sv_minRate
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import bans
import g_entities
import gameSettings
import tasks
import level
import InvulnerabilityEffect
import locationSpawn
import CheckDelay
import team_wins
import player_freeze
import is_body_freeze
import is_body
import DamageBody
import Body_free
import Persistant_spectator
import respawnSpectator
import Set_Client
import Set_spectator
import is_spectator
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsgByVec
import Team_GetLocationMsg
import Team_GetLocationByVec
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import getTimeDiff
import G_WriteBans
import G_WriteGameSetings
import G_WriteTaskData
import G_WriteSessionData
import G_InitWorldSession
import G_ReadBans
import G_InitSessionData
import G_ReadGameSetings
import G_ReadTaskData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import ClassnameIsMover
import AnnounceFlagSacrifice
import PlayerHasFlagPowerup
import NoDropAreaBelow
import SpawnFlagAtLastKnownGood
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import ReadyCheck
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import G_TimeShiftClient
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import FireWeaponGrapple
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletJump
import CheckGauntletAttack
import CalcMuzzlePoint
import LogAccuracyHit
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_grapple
import fire_bfg
import fire_railgun
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import CPM_RadiusDamage
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import Registered
import CheckForAutoUnlock
import FindMapNameForNumber
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import Cmd_Stats_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
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
LABELV $235
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $230
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $202
byte 1 117
byte 1 110
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $198
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $186
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $149
byte 1 37
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $148
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $143
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 97
byte 1 107
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $142
byte 1 78
byte 1 79
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 0
align 1
LABELV $141
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $138
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $120
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $110
byte 1 49
byte 1 0
align 1
LABELV $109
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $108
byte 1 48
byte 1 0
align 1
LABELV $107
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
