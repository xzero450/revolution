#include "g_local.h"
#include "botlib.h"
#include "be_aas.h"
#include "be_ai_goal.h"
#include "be_ai_move.h"

#include "ai_main.h"
#include "ai_dmq3.h"

#include "chars.h"

int BotTeamCarrierVisible( bot_state_t *bs ) {
	int	i;
	float	vis;
	aas_entityinfo_t	entinfo;
	gentity_t	*ent;
	float	f, alertness;
	float	squaredist;
	vec3_t	dir;
	int	areanum;

	alertness = trap_Characteristic_BFloat( bs->character, CHARACTERISTIC_ALERTNESS, 0, 1 );

	for ( i = 0; i < maxclients && i < MAX_CLIENTS; i++ ) {
		if ( i == bs->client ) continue;
		ent = &g_entities[ i ];
		if ( !ent->inuse || !ent->target_ent ) continue;
		BotEntityInfo( ent->target_ent->s.number, &entinfo );
		if ( !entinfo.valid || !( entinfo.powerups & ( 1 << PW_BATTLESUIT ) ) ) continue;
		if ( !BotSameTeam( bs, i ) ) continue;
		VectorSubtract( entinfo.origin, bs->origin, dir );
		squaredist = VectorLengthSquared( dir );
		if ( squaredist > Square( 900.0 + alertness * 4000.0 ) ) continue;
		f = 90 + 90 - ( 90 - ( squaredist > Square( 810 ) ? Square( 810 ) : squaredist ) / ( 810 * 9 ) );
		vis = BotEntityVisible( bs->entitynum, bs->eye, bs->viewangles, f, entinfo.number );
		if ( vis <= 0 ) continue;
		areanum = BotPointAreaNum( entinfo.origin );
		if ( trap_AAS_AreaTravelTimeToGoalArea( bs->areanum, bs->origin, areanum, bs->tfl ) ) {
			return entinfo.number;
		}
	}
	return -1;
}

void BotRefuseOrder( bot_state_t *bs );

void BotTeamSeekGoals( bot_state_t *bs ) {
	aas_entityinfo_t	entinfo;
	int	c;
	int	areanum;

	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
		BotEntityInfo( bs->teammate, &entinfo );
		if ( !entinfo.valid || !( entinfo.powerups & ( 1 << PW_BATTLESUIT ) ) ) {
			bs->ltgtype = 0;
			return;
		}
		areanum = BotPointAreaNum( entinfo.origin );
		if ( !trap_AAS_AreaTravelTimeToGoalArea( bs->areanum, bs->origin, areanum, bs->tfl ) ) {
			bs->ltgtype = 0;
		}
		return;
	}
	if ( bs->owndecision_time < FloatTime() ) {
		c = BotTeamCarrierVisible( bs );
		if ( c >= 0 && ( bs->ltgtype != LTG_TEAMACCOMPANY || bs->teammate != c ) ) {
			BotRefuseOrder( bs );
			bs->decisionmaker = bs->client;
			bs->ordered = qfalse;
			bs->teammate = c;
			bs->teammatevisible_time = FloatTime();
			bs->teammessage_time = 0;
			bs->arrive_time = 1;

			bs->teamgoal_time = FloatTime() + 120;
			bs->ltgtype = LTG_TEAMACCOMPANY;
			bs->formation_dist = 70;
			BotSetTeamStatus( bs );
			bs->owndecision_time = FloatTime() + 5;
			return;
		}
	}
#if 0
	if ( BotTeamLeader( bs ) ) {
		return;
	}
	if ( bs->lastgoal_ltgtype ) {
		bs->teamgoal_time += 60;
	}
	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
		bs->ltgtype = 0;
	}
	if ( bs->ltgtype == LTG_TEAMHELP ||
		bs->ltgtype == LTG_TEAMACCOMPANY ||
		bs->ltgtype == LTG_DEFENDKEYAREA ||
		bs->ltgtype == LTG_CAMPORDER ||
		bs->ltgtype == LTG_PATROL ||
		bs->ltgtype == LTG_GETITEM ) {
		return;
	}
	if ( BotSetLastOrderedTask( bs ) ) {
		return;
	}
	if ( bs->owndecision_time > FloatTime() ) {
		return;
	}
	if ( bs->ctfroam_time > FloatTime() ) {
		return;
	}
	if ( BotAggression( bs ) < 50 ) {
		return;
	}
	bs->teammessage_time = FloatTime() + 2 * random();

	bs->ltgtype = 0;
	bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
	BotSetTeamStatus( bs );
	bs->owndecision_time = FloatTime() + 5;
#endif
}
