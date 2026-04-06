#using scripts\shared\array_shared;
#using scripts\shared\system_shared;
#insert scripts\shared\shared.gsh;

#define X_ALIGN 	5
#define Y_ALIGN		212
#define Y_OFFSET 	15
#define FADETIME 	1
#define COLOR_RED	( 0.96, 0.16, 0.16 )
#define COLOR_WHITE	( 1, 1, 1 )

REGISTER_SYSTEM( "zm_trap_timer", &__init__, undefined )

function __init__()
{
	DEFAULT( level.trap_timers, [] );

	thread init_trap_timer();
	thread prison_trap_timer();
	thread flogger_trap();
}

function init_trap_timer()
{
	for(;;)
	{
		level waittill( "trap_activate", trap );

		if( !isdefined( trap ) )
		{
			continue;
		}

		duration = trap._trap_duration;
		cooldown = trap._trap_cooldown_time;

		if( isdefined( duration ) && isdefined( cooldown ) )
		{
			total = duration + cooldown;

			timer = create_trap_timer_elem( X_ALIGN, Y_ALIGN + ( level.trap_timers.size * Y_OFFSET ) );
			level.trap_timers[level.trap_timers.size] = timer;

			timer thread cleanup_after_time( duration, cooldown );
			timer thread cleanup_endgame();
		}
	}
}

function prison_trap_timer()
{
	if( level.script != "zm_prison" )
	{
		return;
	}

	for(;;)
	{
		level waittill( "trap_activated" );

		duration = 24;
		cooldown = 25;
		total = duration + cooldown;

		timer = create_trap_timer_elem( X_ALIGN, Y_ALIGN + ( level.trap_timers.size * Y_OFFSET ) );
		level.trap_timers[level.trap_timers.size] = timer;

		timer thread cleanup_after_time( duration, cooldown );
		timer thread cleanup_endgame();
	}
}

function flogger_trap()
{
	if( level.script != "zm_sumpf" )
	{
		return;
	}

	array::thread_all( GetEntArray( "pendulum_buy_trigger", "targetname" ), &monitor_flogger_buy );
}

function monitor_flogger_buy()
{
	self._trap_duration = 30.25;
	self._trap_cooldown_time = 45.55;

	for(;;)
	{
		self waittill( "trigger" );
		wait 0.05;
		if( !IS_TRUE( level.var_99432870 ) || IS_TRUE( level.flogger_timer ) )
		{
			continue;
		}
		level notify( "trap_activate", self );
		level.flogger_timer = 1;
		self waittill( "leverup" );
		wait 45;
		level.flogger_timer = 0;
	}
}

function create_trap_timer_elem( x, y )
{
	timer = NewHudElem();
	timer.horzalign = "left";
	timer.vertalign = "top";
	timer.alignx = "left";
	timer.aligny = "top";
	timer.x = x;
	timer.y = y;
	timer.fontscale = 1.5;
	timer.alpha = 0;
	timer.color = COLOR_WHITE;
	timer.hidewheninmenu = 0;
	timer.foreground = 0;
	return timer;
}

function cleanup_after_time( duration = 40, cooldown = 60 )
{
	level endon( "end_game" );

	self SetTenthsTimer( duration + FADETIME );
	self FadeOverTime( 0.3 );
	self.alpha = 1;

	wait duration + FADETIME;

	self SetTenthsTimer( cooldown );

	self.color = COLOR_RED;
	wait cooldown - FADETIME;
	self FadeOverTime( FADETIME );
	self.alpha = 0;
	wait FADETIME;
	ArrayRemoveValue( level.trap_timers, self );
	self Destroy();
	array::thread_all( level.trap_timers, &move_timer_up );
}

function cleanup_endgame()
{
	self endon( "death" );

	level waittill( "end_game" );
	self Destroy();
}

function move_timer_up()
{
	self MoveOverTime( FADETIME );
	self.y -= Y_OFFSET;
}