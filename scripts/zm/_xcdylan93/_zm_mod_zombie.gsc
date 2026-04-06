#using scripts\shared\array_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#insert scripts\shared\shared.gsh;

REGISTER_SYSTEM_EX( "mod_zombie", &__init__, &__main__, undefined )

function __init__()
{
	init_zombie_model_info();
}

function init_zombie_model_info()
{
	heads = array( "zom_head_fdr02_org1", "zom_head_fdr03_org1", "zom_head_fdr04_org1", "c_t8_zmb_ofc_zombie_male_head1", "c_t8_zmb_ofc_zombie_male_head2", "c_t8_zmb_ofc_zombie_male_head3", "c_t8_zmb_ofc_zombie_male_head4", "c_t8_zmb_ofc_zombie_male_head5", "c_t8_zmb_ofc_zombie_male_head6" );
	hats = array( "zom_m40helmet_net1", "zom_m40helmet_org1", "zom_m40helmet_org2", "zom_m40officercap_org1", "zom_m42cap_org1", "zom_m43cap_org1", "zom_m43cap_org2" );

	register_zombie_model_info( "c_zom_der_zombie_body1", "c_zom_dlchd_pro_honorguard_zombie_body2", heads, hats, "c_zom_dlchd_pro_honorguard_zombie_body1_g_lowclean", "c_zom_dlchd_pro_honorguard_zombie_body1_g_rlegoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_llegoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_blegsoff", "c_zom_dlchd_pro_honorguard_zombie_body2_g_upclean", "c_zom_dlchd_pro_honorguard_zombie_body2_g_rarmoff", "c_zom_dlchd_pro_honorguard_zombie_body2_g_larmoff", "c_zom_dlchd_pro_honorguard_zombie_g_behead" );
	register_zombie_model_info( "c_zom_der_zombie_body2", "c_zom_dlchd_pro_honorguard_zombie_body1", heads, hats, "c_zom_dlchd_pro_honorguard_zombie_body1_g_lowclean", "c_zom_dlchd_pro_honorguard_zombie_body1_g_rlegoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_llegoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_blegsoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_upclean", "c_zom_dlchd_pro_honorguard_zombie_body1_g_rarmoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_larmoff", "c_zom_dlchd_pro_honorguard_zombie_g_behead" );
	register_zombie_model_info( "c_zom_der_zombie_body3", "c_zom_dlchd_pro_honorguard_zombie_body1", heads, hats, "c_zom_dlchd_pro_honorguard_zombie_body1_g_lowclean", "c_zom_dlchd_pro_honorguard_zombie_body1_g_rlegoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_llegoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_blegsoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_upclean", "c_zom_dlchd_pro_honorguard_zombie_body1_g_rarmoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_larmoff", "c_zom_dlchd_pro_honorguard_zombie_g_behead" );

	register_zombie_model_info( "c_zom_dlchd_pro_honorguard_zombie_body1", "c_zom_dlchd_pro_honorguard_zombie_body1", heads, hats, "c_zom_dlchd_pro_honorguard_zombie_body1_g_lowclean", "c_zom_dlchd_pro_honorguard_zombie_body1_g_rlegoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_llegoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_blegsoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_upclean", "c_zom_dlchd_pro_honorguard_zombie_body1_g_rarmoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_larmoff", "c_zom_dlchd_pro_honorguard_zombie_g_behead" );
	register_zombie_model_info( "c_zom_dlchd_pro_honorguard_zombie_body2", "c_zom_dlchd_pro_honorguard_zombie_body2", heads, hats, "c_zom_dlchd_pro_honorguard_zombie_body1_g_lowclean", "c_zom_dlchd_pro_honorguard_zombie_body1_g_rlegoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_llegoff", "c_zom_dlchd_pro_honorguard_zombie_body1_g_blegsoff", "c_zom_dlchd_pro_honorguard_zombie_body2_g_upclean", "c_zom_dlchd_pro_honorguard_zombie_body2_g_rarmoff", "c_zom_dlchd_pro_honorguard_zombie_body2_g_larmoff", "c_zom_dlchd_pro_honorguard_zombie_g_behead" );

	register_zombie_model_info( "c_zom_dlchd_sumpf_zombies_body1", "zom_snipera_body", heads, hats, "zom_snipera_g_lowclean", "zom_snipera_g_rlegoff", "zom_snipera_g_llegoff", "zom_snipera_g_blegsoff", "zom_snipera_g_upclean", "zom_snipera_g_rarmoff", "zom_snipera_g_larmoff", "zom_snipera_g_beheaded" );
	register_zombie_model_info( "c_zom_dlchd_sumpf_zombies_body2", "zom_infantrya_body", heads, hats, "zom_infantrya_g_lowclean", "zom_infantrya_g_rlegoff", "zom_infantrya_g_llegoff", "zom_infantrya_g_blegsoff", "zom_infantrya_g_upclean", "zom_infantrya_g_rarmoff", "zom_infantrya_g_larmoff", "zom_infantrya_g_beheaded" );
	register_zombie_model_info( "c_zom_dlchd_sumpf_zombies_body3", "zom_infantrya_body", heads, hats, "zom_infantrya_g_lowclean", "zom_infantrya_g_rlegoff", "zom_infantrya_g_llegoff", "zom_infantrya_g_blegsoff", "zom_infantrya_g_upclean", "zom_infantrya_g_rarmoff", "zom_infantrya_g_larmoff", "zom_infantrya_g_beheaded" );
	
	register_zombie_model_info( "c_t7_zm_dlchd_cosmo_labcoat_body", "c_t8_zmb_ofc_zombie_male_body1", array( "c_zom_dlchd_cosmo_cosmon_head", "c_zom_dlchd_cosmo_cosmon_head2", "c_zom_dlchd_cosmo_cosmon_head3", "c_zom_dlchd_cosmo_cosmon_head4", "c_zom_dlchd_cosmo_cosmon_head5", "c_zom_dlchd_cosmo_cosmon_head5" ), array(), "c_t8_zmb_ofc_zombie_male_body1_g_lowclean", "c_t8_zmb_ofc_zombie_male_body1_g_rlegoff", "c_t8_zmb_ofc_zombie_male_body1_g_llegoff", "c_t8_zmb_ofc_zombie_male_body1_g_blegsoff", "c_t8_zmb_ofc_zombie_male_body1_g_upclean", "c_t8_zmb_ofc_zombie_male_body1_g_rarmoff", "c_t8_zmb_ofc_zombie_male_body1_g_larmoff", "c_t8_zmb_ofc_zombie_male_body1_g_beheaded" );
	register_zombie_model_info( "c_zm_dlchd_cosmo_spetznaz_zombie_body", "c_t8_zmb_ofc_zombie_male_body2", array( "c_zom_dlchd_cosmo_cosmon_head", "c_zom_dlchd_cosmo_cosmon_head2", "c_zom_dlchd_cosmo_cosmon_head3", "c_zom_dlchd_cosmo_cosmon_head4" ), hats, "c_t8_zmb_ofc_zombie_male_body2_g_lowclean", "c_t8_zmb_ofc_zombie_male_body2_g_rlegoff", "c_t8_zmb_ofc_zombie_male_body2_g_llegoff", "c_t8_zmb_ofc_zombie_male_body2_g_blegsoff", "c_t8_zmb_ofc_zombie_male_body2_g_upclean", "c_t8_zmb_ofc_zombie_male_body2_g_rarmoff", "c_t8_zmb_ofc_zombie_male_body2_g_larmoff", "c_t8_zmb_ofc_zombie_male_body2_g_beheaded" );
	register_zombie_model_info( "c_zom_dlchd_cosmo_cosmon_body", "c_t8_zmb_ofc_zombie_male_body3", array( "c_zom_dlchd_cosmo_cosmon_head", "c_zom_dlchd_cosmo_cosmon_head2", "c_zom_dlchd_cosmo_cosmon_head3", "c_zom_dlchd_cosmo_cosmon_head4", "c_zom_dlchd_cosmo_cosmon_head5" ), array(), "c_t8_zmb_ofc_zombie_male_body3_g_lowclean", "c_t8_zmb_ofc_zombie_male_body3_g_rlegoff", "c_t8_zmb_ofc_zombie_male_body3_g_llegoff", "c_t8_zmb_ofc_zombie_male_body3_g_blegsoff", "c_t8_zmb_ofc_zombie_male_body3_g_upclean", "c_t8_zmb_ofc_zombie_male_body3_g_rarmoff", "c_t8_zmb_ofc_zombie_male_body3_g_larmoff", "c_t8_zmb_ofc_zombie_male_body3_g_beheaded" );
}

function register_zombie_model_info( body, newbody, &heads, &hats, lowclean, rlegoff, llegoff, blegoff, upclean, rarmoff, larmoff, behead )
{
	DEFAULT( level.zombiemodels, [] );
	level.zombiemodels[body] = SpawnStruct();
	level.zombiemodels[body].newbody = newbody;
	level.zombiemodels[body].heads = heads;
	level.zombiemodels[body].hats = hats;
	level.zombiemodels[body].legdmg1 = lowclean;
	level.zombiemodels[body].legdmg2 = rlegoff;
	level.zombiemodels[body].legdmg3 = llegoff;
	level.zombiemodels[body].legdmg4 = blegoff;
	level.zombiemodels[body].torsodmg1 = upclean;
	level.zombiemodels[body].torsodmg2 = rarmoff;
	level.zombiemodels[body].torsodmg3 = larmoff;
	level.zombiemodels[body].torsodmg4 = upclean;
	level.zombiemodels[body].torsodmg5 = behead;
}

function __main__()
{
	spawner::add_archetype_spawn_function( "zombie", &on_zombie_spawned );
}

function on_zombie_spawned()
{
	self thread swap_models();
}

function swap_models()
{
	self endon( "death" );

	wait 0.05;

	if( !isdefined( level.zombiemodels[self.model] ) )
	{
		return;
	}

	body = level.zombiemodels[self.model];

	self SetModel( body.newbody );
	self.head = array::random( body.heads );
	if( isdefined( body.hats ) && body.hats.size )
	{
		if( RandomInt(10) > 3 )
		{
			self.hatmodel = array::random( body.hats );
		}
	}

	self DetachAll();
	self Attach( self.head, "", 1 );
	if( isdefined( self.hatmodel ) )
	{
		self Attach( self.hatmodel, "", 1 );
	}

	self sync_gib_info( body );
}

function sync_gib_info( body )
{
	if( !isdefined( self.gib_data ) )
	{
		self.gib_data = SpawnStruct();
	}

	self.gib_data.head = self.head;
	self.gib_data.hatmodel = self.hatmodel;
	self.gib_data.legdmg1 = body.legdmg1;
	self.gib_data.legdmg2 = body.legdmg2;
	self.gib_data.legdmg3 = body.legdmg3;
	self.gib_data.legdmg4 = body.legdmg4;
	self.gib_data.torsodmg1 = body.torsodmg1;
	self.gib_data.torsodmg2 = body.torsodmg2;
	self.gib_data.torsodmg3 = body.torsodmg3;
	self.gib_data.torsodmg4 = body.torsodmg4;
	self.gib_data.torsodmg5 = body.torsodmg5;
}