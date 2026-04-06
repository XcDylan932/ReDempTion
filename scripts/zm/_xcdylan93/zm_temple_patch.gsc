#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#insert scripts\shared\shared.gsh;

REGISTER_SYSTEM_EX( "zm_temple_patch", undefined, &__main__, undefined )

function __main__()
{
	if( level.script != "zm_temple" )
	{
		return;
	}

	thread pap_pressure_plate_override();
}

function pap_pressure_plate_override()
{
	level flag::wait_till( "power_on" );
	waittillframeend;

	for( i = 0; i < 4; i++ )
	{
		trigger = GetEnt( sprintf( "pap_blocker_trigger{0}", i + 1 ), "targetname" );
		trigger.requiredplayers = array( 1, 3, 2, 4 )[i];
	}
}