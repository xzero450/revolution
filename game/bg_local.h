// Copyright (C) 1999-2000 Id Software, Inc.
//
// bg_local.h -- local definitions for the bg (both games) files

#define	MIN_WALK_NORMAL	0.7f		// can't walk on very steep slopes

#define	STEPSIZE		18

#define	JUMP_VELOCITY	270

#define	TIMER_LAND		130
#define	TIMER_GESTURE	(34*66+50)

#define	OVERCLIP		1.001f

// all of the locals will be zeroed before each
// pmove, just to make damn sure we don't have
// any differences when running on client or server
typedef struct {
	vec3_t		forward, right, up;
	float		frametime;

	int			msec;

	qboolean	walking;
	qboolean	groundPlane;
	trace_t		groundTrace;

	float		impactSpeed;

	vec3_t		previous_origin;
	vec3_t		previous_velocity;
	int			previous_waterlevel;
} pml_t;

extern	pmove_t		*pm;
extern	pml_t		pml;

// movement parameters
extern	float	pm_stopspeed;
extern	float	pm_duckScale;
extern	float	pm_swimScale;
extern	float	pm_wadeScale;

extern	float	pm_accelerate;
extern	float	pm_airaccelerate;
extern	float	pm_wateraccelerate;
extern	float	pm_flyaccelerate;

extern	float	pm_friction;
extern	float	pm_waterfriction;
extern	float	pm_flightfriction;

extern	int		c_pmove;

void PM_ClipVelocity( vec3_t in, vec3_t normal, vec3_t out, float overbounce );
void PM_AddTouchEnt( int entityNum );
void PM_AddEvent( int newEvent );

qboolean	PM_SlideMove( qboolean gravity );
void		PM_StepSlideMove( qboolean gravity );

/* Weapon Cycles */
extern	vmCvar_t	weap_enableHook;
extern	vmCvar_t	weap_gauntletCycle;
extern	vmCvar_t	weap_machinegunCycle;
extern	vmCvar_t	weap_shotgunCycle;
extern	vmCvar_t	weap_grenadelauncherCycle;
extern	vmCvar_t	weap_lightninggunCycle;
extern	vmCvar_t	weap_rocketlauncherCycle;
extern	vmCvar_t	weap_railgunCycle;
extern	vmCvar_t	weap_plasmagunCycle;
extern	vmCvar_t	weap_bfgCycle;
extern	vmCvar_t	g_DynamicGauntletCycle;
extern	vmCvar_t	g_gamemode;
extern	vmCvar_t	g_delagHitscan;
extern	vmCvar_t	g_pro_mode;
extern	vmCvar_t	g_interference;
extern	vmCvar_t	g_pro_mode;
extern	vmCvar_t	g_fastSwitch;
extern	vmCvar_t	g_allowReady;

