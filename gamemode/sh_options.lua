GM.ZombieEscapeWeaponsPrimary = {
	"weapon_zs_zeakbar",
	"weapon_zs_zesweeper",
	"weapon_zs_zesmg",
	"weapon_zs_zeinferno",
	"weapon_zs_zestubber",
	"weapon_zs_zebulletstorm",
	"weapon_zs_zesilencer",
	"weapon_zs_zequicksilver",
	"weapon_zs_zeamigo",
	"weapon_zs_zem4",
	"weapon_zs_zeboomstick"
}

GM.ZombieEscapeWeaponsSecondary = {
	"weapon_zs_zedeagle",
	"weapon_zs_zebattleaxe",
	"weapon_zs_zeeraser",
	"weapon_zs_zeglock",
	"weapon_zs_zetempest"
}

-- Change this if you plan to alter the cost of items or you severely change how Worth works.
-- Having separate cart files allows people to have separate loadouts for different servers.
GM.CartFile = "zscarts.txt"
GM.SkillLoadoutsFile = "zsskloadouts.txt"

ITEMCAT_GUNS = 1
ITEMCAT_AMMO = 2
ITEMCAT_MELEE = 3
ITEMCAT_TOOLS = 4
ITEMCAT_DEPLOYABLES = 5
ITEMCAT_TRINKETS = 6
ITEMCAT_OTHER = 7
ITEMCAT_SPECIAL = 8


ITEMSUBCAT_TRINKETS_DEFENSIVE = 1
ITEMSUBCAT_TRINKETS_OFFENSIVE = 2
ITEMSUBCAT_TRINKETS_MELEE = 3
ITEMSUBCAT_TRINKETS_PERFOMANCE = 4
ITEMSUBCAT_TRINKETS_SUPPORT = 5
ITEMSUBCAT_TRINKETS_SPECIAL = 6
ITEMSUBCAT_TRINKETS_SUPER = 7


GM.ItemCategories = {
	[ITEMCAT_GUNS] = "Guns",
	[ITEMCAT_AMMO] = "Ammunition",
	[ITEMCAT_MELEE] = "Melee",
	[ITEMCAT_TOOLS] = "Tools",
	[ITEMCAT_DEPLOYABLES] = "Deployables",
	[ITEMCAT_TRINKETS] = "Trinkets",
	[ITEMCAT_OTHER] = "Other",
	[ITEMCAT_SPECIAL] = "Skill"
}

GM.ItemSubCategories = {
	[ITEMSUBCAT_TRINKETS_DEFENSIVE] = "Defensive",
	[ITEMSUBCAT_TRINKETS_OFFENSIVE] = "Offensive",
	[ITEMSUBCAT_TRINKETS_MELEE] = "Melee",
	[ITEMSUBCAT_TRINKETS_PERFOMANCE] = "Performance",
	[ITEMSUBCAT_TRINKETS_SUPPORT] = "Support",
	[ITEMSUBCAT_TRINKETS_SPECIAL] = "Special",
	[ITEMSUBCAT_TRINKETS_SUPER] = "Super"

}

--[[
Humans select what weapons (or other things) they want to start with and can even save favorites. Each object has a number of 'Worth' points.
Signature is a unique signature to give in case the item is renamed or reordered. Don't use a number or a string number!
A human can only use 100 points (default) when they join. Redeeming or joining late starts you out with a random loadout from above.
SWEP is a swep given when the player spawns with that perk chosen.
Callback is a function called. Model is a display model. If model isn't defined then the SWEP model will try to be used.
swep, callback, and model can all be nil or empty
]]
GM.Items = {}
function GM:AddItem(signature, category, price, swep, name, desc, model, callback)
	local tab = {Signature = signature, Name = name or "?", Description = desc, Category = category, Price = price or 0, SWEP = swep, Callback = callback, Model = model}

	tab.Worth = tab.Price -- compat

	self.Items[#self.Items + 1] = tab
	self.Items[signature] = tab

	return tab
end

function GM:AddStartingItem(signature, category, price, swep, name, desc, model, callback)
	local item = self:AddItem(signature, category, price, swep, name, desc, model, callback)
	item.WorthShop = true

	return item
end

function GM:AddPointShopItem(signature, category, price, swep, name, desc, model, callback)
	local item = self:AddItem("ps_"..signature, category, price, swep, name, desc, model, callback)
	item.PointShop = true

	return item
end

-- How much ammo is considered one 'clip' of ammo? For use with setting up weapon defaults. Works directly with zs_survivalclips
GM.AmmoCache = {}
GM.AmmoCache["ar2"]							= 46		-- Assault rifles.
GM.AmmoCache["alyxgun"]						= 24		-- Not used.
GM.AmmoCache["pistol"]						= 24		-- Pistols.
GM.AmmoCache["smg1"]						= 55		-- SMG's and some rifles.
GM.AmmoCache["357"]							= 12		-- Rifles, especially of the sniper variety.
GM.AmmoCache["xbowbolt"]					= 8		-- Crossbows
GM.AmmoCache["buckshot"]					= 14		-- Shotguns
GM.AmmoCache["ar2altfire"]					= 1			-- Not used.
GM.AmmoCache["slam"]						= 1			-- Force Field Emitters.
GM.AmmoCache["rpg_round"]					= 1			-- Not used. Rockets?
GM.AmmoCache["smg1_grenade"]				= 1			-- Not used.
GM.AmmoCache["sniperround"]					= 1			-- Barricade Kit
GM.AmmoCache["sniperpenetratedround"]		= 1			-- Remote Det pack.
GM.AmmoCache["grenade"]						= 1			-- Grenades.
GM.AmmoCache["thumper"]						= 1			-- Gun turret.
GM.AmmoCache["gravity"]						= 1			-- Unused.
GM.AmmoCache["battery"]						= 40		-- Used with the Medical Kit.
GM.AmmoCache["gaussenergy"]					= 4		-- Nails used with the Carpenter's Hammer.
GM.AmmoCache["combinecannon"]				= 1			-- Not used.
GM.AmmoCache["airboatgun"]					= 1			-- Arsenal crates.
GM.AmmoCache["striderminigun"]				= 1			-- Message beacons.
GM.AmmoCache["helicoptergun"]				= 1			-- Resupply boxes.
GM.AmmoCache["spotlamp"]					= 1
GM.AmmoCache["manhack"]						= 1
GM.AmmoCache["repairfield"]					= 1
GM.AmmoCache["zapper"]						= 1
GM.AmmoCache["pulse"]						= 35
GM.AmmoCache["impactmine"]					= 5
GM.AmmoCache["chemical"]					= 35
GM.AmmoCache["flashbomb"]					= 1
GM.AmmoCache["turret_buckshot"]				= 1
GM.AmmoCache["turret_assault"]				= 1
GM.AmmoCache["turret_super"]				= 1
GM.AmmoCache["scrap"]						= 4

GM.AmmoResupply = table.ToAssoc({"ar2", "pistol", "smg1", "357", "xbowbolt", "buckshot", "battery", "pulse", "impactmine", "chemical", "gaussenergy", "scrap", "grenade"})

-----------
-- Worth --
-----------

GM:AddStartingItem("pshtr",				ITEMCAT_GUNS,			30,				"weapon_zs_peashooter")
GM:AddStartingItem("btlax",				ITEMCAT_GUNS,			30,				"weapon_zs_battleaxe")
GM:AddStartingItem("owens",				ITEMCAT_GUNS,			30,				"weapon_zs_owens")
GM:AddStartingItem("blstr",				ITEMCAT_GUNS,			30,				"weapon_zs_blaster")
GM:AddStartingItem("tossr",				ITEMCAT_GUNS,			30,				"weapon_zs_tosser")
GM:AddStartingItem("stbbr",				ITEMCAT_GUNS,			30,				"weapon_zs_stubber")
GM:AddStartingItem("crklr",				ITEMCAT_GUNS,			30,				"weapon_zs_crackler")
GM:AddStartingItem("sling",				ITEMCAT_GUNS,			30,				"weapon_zs_slinger")
GM:AddStartingItem("z9000",				ITEMCAT_GUNS,			30,				"weapon_zs_z9000")
GM:AddStartingItem("minelayer",			ITEMCAT_GUNS,			30,				"weapon_zs_minelayer")

GM:AddStartingItem("2pcp",				ITEMCAT_AMMO,			15,				nil,			"28 pistol ammo",				nil,		"ammo_pistol",			function(pl) pl:GiveAmmo(28, "pistol", true) end)
GM:AddStartingItem("3pcp",				ITEMCAT_AMMO,			20,				nil,			"42 pistol ammo",				nil,		"ammo_pistol",			function(pl) pl:GiveAmmo(42, "pistol", true) end)
GM:AddStartingItem("2sgcp",				ITEMCAT_AMMO,			15,				nil,			"24 shotgun ammo",				nil,		"ammo_shotgun",			function(pl) pl:GiveAmmo(24, "buckshot", true) end)
GM:AddStartingItem("3sgcp",				ITEMCAT_AMMO,			20,				nil,			"36 shotgun ammo",				nil,		"ammo_shotgun",			function(pl) pl:GiveAmmo(36, "buckshot", true) end)
GM:AddStartingItem("2smgcp",			ITEMCAT_AMMO,			15,				nil,			"72 SMG ammo",					nil,		"ammo_smg",				function(pl) pl:GiveAmmo(72, "smg1", true) end)
GM:AddStartingItem("3smgcp",			ITEMCAT_AMMO,			20,				nil,			"108 SMG ammo",					nil,		"ammo_smg",				function(pl) pl:GiveAmmo(108, "smg1", true) end)
GM:AddStartingItem("2arcp",				ITEMCAT_AMMO,			15,				nil,			"64 assault rifle ammo",		nil,		"ammo_assault",			function(pl) pl:GiveAmmo(64, "ar2", true) end)
GM:AddStartingItem("3arcp",				ITEMCAT_AMMO,			20,				nil,			"96 assault rifle ammo",		nil,		"ammo_assault",			function(pl) pl:GiveAmmo(96, "ar2", true) end)
GM:AddStartingItem("2rcp",				ITEMCAT_AMMO,			15,				nil,			"16 rifle ammo",				nil,		"ammo_rifle",			function(pl) pl:GiveAmmo(16, "357", true) end)
GM:AddStartingItem("3rcp",				ITEMCAT_AMMO,			20,				nil,			"24 rifle ammo",				nil,		"ammo_rifle",			function(pl) pl:GiveAmmo(24, "357", true) end)
GM:AddStartingItem("2pls",				ITEMCAT_AMMO,			15,				nil,			"60 pulse ammo",				nil,		"ammo_pulse",			function(pl) pl:GiveAmmo(60, "pulse", true) end)
GM:AddStartingItem("3pls",				ITEMCAT_AMMO,			20,				nil,			"90 pulse ammo",				nil,		"ammo_pulse",			function(pl) pl:GiveAmmo(90, "pulse", true) end)
GM:AddStartingItem("xbow1",				ITEMCAT_AMMO,			15,				nil,			"16 crossbow bolts",			nil,		"ammo_bolts",			function(pl) pl:GiveAmmo(16, "XBowBolt", true) end)
GM:AddStartingItem("xbow2",				ITEMCAT_AMMO,			20,				nil,			"24 crossbow bolts",			nil,		"ammo_bolts",			function(pl) pl:GiveAmmo(24, "XBowBolt", true) end)
GM:AddStartingItem("4mines",			ITEMCAT_AMMO,			15,				nil,			"6 explosives",					nil,		"ammo_explosive",		function(pl) pl:GiveAmmo(6, "impactmine", true) end)
GM:AddStartingItem("6mines",			ITEMCAT_AMMO,			20,				nil,			"9 explosives",					nil,		"ammo_explosive",		function(pl) pl:GiveAmmo(9, "impactmine", true) end)
GM:AddStartingItem("8nails",			ITEMCAT_AMMO,			15,				nil,			"8 nails",						nil, 		"ammo_nail", 			function(pl) pl:GiveAmmo(8, "GaussEnergy", true) end)
GM:AddStartingItem("12nails",			ITEMCAT_AMMO,			20,				nil,			"12 nails",						nil, 		"ammo_nail", 			function(pl) pl:GiveAmmo(12, "GaussEnergy", true) end)
GM:AddStartingItem("60mkit",			ITEMCAT_AMMO,			20,				nil,			"100 medical power",				nil,		"ammo_medpower",		function(pl) pl:GiveAmmo(100, "Battery", true) end)
GM:AddStartingItem("90mkit",			ITEMCAT_AMMO,			25,				nil,			"120 medical power",				nil,		"ammo_medpower",		function(pl) pl:GiveAmmo(120, "Battery", true) end)
GM:AddStartingItem("scrap",		    	ITEMCAT_AMMO,			20,				nil,			"Scrap 15",				nil,		"ammo_scrap",		function(pl) pl:GiveAmmo(15, "Scrap", true) end)
GM:AddStartingItem("scraper",			ITEMCAT_AMMO,			30,				nil,			"Scrap 25",				nil,		"ammo_scrap",		function(pl) pl:GiveAmmo(25, "Scrap", true) end)



GM:AddStartingItem("brassknuckles",		ITEMCAT_MELEE,			25,				"weapon_zs_brassknuckles").Model = "models/props_c17/utilityconnecter005.mdl"
GM:AddStartingItem("zpaxe",				ITEMCAT_MELEE,			25,				"weapon_zs_axe")
GM:AddStartingItem("stnbtn",			ITEMCAT_MELEE,			25,				"weapon_zs_stunbaton")
GM:AddStartingItem("csknf",				ITEMCAT_MELEE,			10,				"weapon_zs_swissarmyknife")
GM:AddStartingItem("zpplnk",			ITEMCAT_MELEE,			25,				"weapon_zs_plank")
GM:AddStartingItem("zpfryp",			ITEMCAT_MELEE,			25,				"weapon_zs_fryingpan")
GM:AddStartingItem("zpcpot",			ITEMCAT_MELEE,			25,				"weapon_zs_pot")
GM:AddStartingItem("ladel",				ITEMCAT_MELEE,			25,				"weapon_zs_ladel")
GM:AddStartingItem("pipe",				ITEMCAT_MELEE,			25,				"weapon_zs_pipe")
GM:AddStartingItem("hook",				ITEMCAT_MELEE,			25,				"weapon_zs_hook")
GM:AddStartingItem("lamp",				ITEMCAT_MELEE,			25,				"weapon_zs_lamp")

local item
GM:AddStartingItem("medkit",			ITEMCAT_TOOLS,			30,				"weapon_zs_medicalkit")
GM:AddStartingItem("medgun",			ITEMCAT_TOOLS,			55,				"weapon_zs_medicgun")
item =
GM:AddStartingItem("strengthshot",		ITEMCAT_TOOLS,			40,				"weapon_zs_strengthshot")
item.SkillRequirement = SKILL_U_STRENGTHSHOT
item =
GM:AddStartingItem("antidoteshot",		ITEMCAT_TOOLS,			40,				"weapon_zs_antidoteshot")
item.SkillRequirement = SKILL_U_ANTITODESHOT
GM:AddStartingItem("arscrate",			ITEMCAT_DEPLOYABLES,			10,				"weapon_zs_arsenalcrate")
.Countables = "prop_arsenalcrate"
GM:AddStartingItem("resupplybox",		ITEMCAT_DEPLOYABLES,			25,				"weapon_zs_resupplybox")
.Countables = "prop_resupplybox"
GM:AddStartingItem("remantler",			ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_remantler")
.Countables = "prop_remantler"
item =
GM:AddStartingItem("infturret",			ITEMCAT_DEPLOYABLES,			45,				"weapon_zs_gunturret",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret") pl:GiveAmmo(1, "thumper") pl:GiveAmmo(125, "smg1") end)
item.Countables = "prop_gunturret"
item.NoClassicMode = true
item =
GM:AddStartingItem("blastturret",		ITEMCAT_DEPLOYABLES,			55,				"weapon_zs_gunturret_buckshot",	nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_buckshot") pl:GiveAmmo(1, "turret_buckshot") pl:GiveAmmo(30, "buckshot") end)
item.Countables = "prop_gunturret_buckshot"
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_BLASTTURRET
item =
GM:AddStartingItem("repairfield",		ITEMCAT_DEPLOYABLES,			30,				"weapon_zs_repairfield",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_repairfield") pl:GiveAmmo(1, "repairfield") pl:GiveAmmo(50, "pulse") end)
item.Countables = "prop_repairfield"
item.NoClassicMode = true
item =
GM:AddStartingItem("zapper",			ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_zapper",				nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_zapper") pl:GiveAmmo(1, "zapper") pl:GiveAmmo(50, "pulse") end)
item.Countables = "prop_zapper"
item.NoClassicMode = true

GM:AddStartingItem("manhack",			ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_manhack").Countables = "prop_manhack"
item =
GM:AddStartingItem("drone",				ITEMCAT_DEPLOYABLES,			30,				"weapon_zs_drone",				nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_drone") pl:GiveAmmo(1, "drone") pl:GiveAmmo(60, "smg1") end)
item.Countables = "prop_drone"
item =
GM:AddStartingItem("pulsedrone",		ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_drone_pulse",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_drone_pulse") pl:GiveAmmo(1, "pulse_cutter") pl:GiveAmmo(60, "pulse") end)
item.Countables = "prop_drone_pulse"
item.SkillRequirement = SKILL_U_DRONE
item =
GM:AddStartingItem("hauldrone",			ITEMCAT_DEPLOYABLES,			25,				"weapon_zs_drone_hauler",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_drone_hauler") pl:GiveAmmo(1, "drone_hauler") end)
item.Countables = "prop_drone_hauler"
item.SkillRequirement = SKILL_HAULMODULE
item =
GM:AddStartingItem("rollermine",		ITEMCAT_DEPLOYABLES,			35,				"weapon_zs_rollermine",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_rollermine") pl:GiveAmmo(1, "rollermine") end)
item.Countables = "prop_rollermine"
item.SkillRequirement = SKILL_U_ROLLERMINE

GM:AddStartingItem("wrench",			ITEMCAT_TOOLS,			20,				"weapon_zs_wrench").NoClassicMode = true
GM:AddStartingItem("crphmr",			ITEMCAT_TOOLS,			40,				"weapon_zs_hammer").NoClassicMode = true
GM:AddStartingItem("electoh",			ITEMCAT_TOOLS,			60,				"weapon_zs_electrohammer").NoClassicMode = true
GM:AddStartingItem("junkpack",			ITEMCAT_DEPLOYABLES,	30,				"weapon_zs_boardpack")
GM:AddStartingItem("normpack",			ITEMCAT_DEPLOYABLES,	30,				"weapon_zs_normalpack")
GM:AddStartingItem("propanetank",		ITEMCAT_TOOLS,			30,				"comp_propanecan")
GM:AddStartingItem("busthead",			ITEMCAT_TOOLS,			35,				"comp_busthead")
GM:AddStartingItem("sawblade",			ITEMCAT_TOOLS,			35,				"comp_sawblade")
GM:AddStartingItem("cpuparts",			ITEMCAT_TOOLS,			35,				"comp_cpuparts")
GM:AddStartingItem("electrobattery",	ITEMCAT_TOOLS,			45,				"comp_electrobattery")
GM:AddStartingItem("singurhamemer",	        ITEMCAT_TOOLS,			120,				"weapon_zs_singurhammer").NoClassicMode = true
GM:AddStartingItem("msgbeacon",			ITEMCAT_DEPLOYABLES,			10,				"weapon_zs_messagebeacon").Countables = "prop_messagebeacon"
item =
GM:AddStartingItem("ffemitter",			ITEMCAT_DEPLOYABLES,			45,				"weapon_zs_ffemitter",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_ffemitter") pl:GiveAmmo(1, "slam") pl:GiveAmmo(50, "pulse") end)
item.Countables = "prop_ffemitter"
GM:AddStartingItem("barricadekit",		ITEMCAT_DEPLOYABLES,			30,				"weapon_zs_barricadekit")
GM:AddStartingItem("camera",			ITEMCAT_DEPLOYABLES,			15,				"weapon_zs_camera").Countables = "prop_camera"
GM:AddStartingItem("tv",				ITEMCAT_DEPLOYABLES,			35,				"weapon_zs_tv").Countables = "prop_tv"

GM:AddStartingItem("oxtank",			ITEMCAT_TRINKETS,		5,				"trinket_oxygentank").SubCategory =				ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("boxingtraining",	ITEMCAT_TRINKETS,		10,				"trinket_boxingtraining").SubCategory =			ITEMSUBCAT_TRINKETS_MELEE
GM:AddStartingItem("cutlery",			ITEMCAT_TRINKETS,		10,				"trinket_cutlery").SubCategory =				ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("portablehole",		ITEMCAT_TRINKETS,		10,				"trinket_portablehole").SubCategory =			ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("acrobatframe",		ITEMCAT_TRINKETS,		15,				"trinket_acrobatframe").SubCategory=			ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("nightvision",		ITEMCAT_TRINKETS,		15,				"trinket_nightvision").SubCategory =			ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("targetingvisi",		ITEMCAT_TRINKETS,		15,				"trinket_targetingvisori").SubCategory =		ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddStartingItem("pulseampi",			ITEMCAT_TRINKETS,		15,				"trinket_pulseampi").SubCategory =				ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddStartingItem("blueprintsi",		ITEMCAT_TRINKETS,		15,				"trinket_blueprintsi").SubCategory =			ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddStartingItem("loadingframe",		ITEMCAT_TRINKETS,		15,				"trinket_loadingex").SubCategory =				ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("kevlar",			ITEMCAT_TRINKETS,		15,				"trinket_kevlar").SubCategory =					ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("momentumsupsysii",	ITEMCAT_TRINKETS,		15,				"trinket_momentumsupsysii").SubCategory =		ITEMSUBCAT_TRINKETS_MELEE
GM:AddStartingItem("hemoadrenali",		ITEMCAT_TRINKETS,		15,				"trinket_hemoadrenali").SubCategory =			ITEMSUBCAT_TRINKETS_MELEE
GM:AddStartingItem("vitpackagei",		ITEMCAT_TRINKETS,		20,				"trinket_vitpackagei").SubCategory =			ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("processor",			ITEMCAT_TRINKETS,		20,				"trinket_processor").SubCategory =				ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddStartingItem("cardpackagei",		ITEMCAT_TRINKETS,		20,				"trinket_cardpackagei").SubCategory =			ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("bloodpack",			ITEMCAT_TRINKETS,		20,				"trinket_bloodpack").SubCategory =				ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("biocleanser",		ITEMCAT_TRINKETS,		20,				"trinket_biocleanser").SubCategory =			ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("reactiveflasher",	ITEMCAT_TRINKETS,		5,				"trinket_reactiveflasher").SubCategory =		ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("magnet",			ITEMCAT_TRINKETS,		10,				"trinket_magnet").SubCategory =					ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("arsenalpack",		ITEMCAT_TRINKETS,		15,				"trinket_arsenalpack").SubCategory =			ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddStartingItem("resupplypack",		ITEMCAT_TRINKETS,		25,				"trinket_resupplypack").SubCategory =			ITEMSUBCAT_TRINKETS_SUPPORT

GM:AddStartingItem("stone",				ITEMCAT_OTHER,			5,				"weapon_zs_stone")
GM:AddStartingItem("grenade",			ITEMCAT_OTHER,			20,				"weapon_zs_grenade")
GM:AddStartingItem("flashbomb",			ITEMCAT_OTHER,			15,				"weapon_zs_flashbomb")
GM:AddStartingItem("molotov",			ITEMCAT_OTHER,			20,				"weapon_zs_molotov")
GM:AddStartingItem("betty",				ITEMCAT_OTHER,			10,				"weapon_zs_proxymine")
GM:AddStartingItem("corgasgrenade",		ITEMCAT_OTHER,			40,				"weapon_zs_corgasgrenade")
GM:AddStartingItem("crygasgrenade",		ITEMCAT_OTHER,			35,				"weapon_zs_crygasgrenade").SkillRequirement = SKILL_U_CRYGASGREN
GM:AddStartingItem("detpck",			ITEMCAT_OTHER,			55,				"weapon_zs_detpack").Countables = "prop_detpack"
item =
GM:AddStartingItem("sigfragment",		ITEMCAT_OTHER,			25,				"weapon_zs_sigilfragment")
item.NoClassicMode = true
item =
GM:AddStartingItem("corfragment",		ITEMCAT_OTHER,			35,				"weapon_zs_corruptedfragment")
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_CORRUPTEDFRAGMENT
item =
GM:AddStartingItem("medcloud",			ITEMCAT_OTHER,			25,				"weapon_zs_mediccloudbomb")
item.SkillRequirement = SKILL_U_MEDICCLOUD
item =
GM:AddStartingItem("nanitecloud",		ITEMCAT_OTHER,			25,				"weapon_zs_nanitecloudbomb")
item.SkillRequirement = SKILL_U_NANITECLOUD
GM:AddStartingItem("bloodshot",			ITEMCAT_OTHER,			35,				"weapon_zs_bloodshotbomb")

------------
-- Points --
------------

-- Tier 1
GM:AddPointShopItem("pshtr",			ITEMCAT_GUNS,			20,				"weapon_zs_peashooter", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_peashooter") end)
GM:AddPointShopItem("btlax",			ITEMCAT_GUNS,			20,				"weapon_zs_battleaxe", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_battleaxe") end)
GM:AddPointShopItem("owens",			ITEMCAT_GUNS,			20,				"weapon_zs_owens", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_owens") end)
GM:AddPointShopItem("blstr",			ITEMCAT_GUNS,			20,				"weapon_zs_blaster", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_blaster") end)
GM:AddPointShopItem("tossr",			ITEMCAT_GUNS,			20,				"weapon_zs_tosser", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_tosser") end)
GM:AddPointShopItem("stbbr",			ITEMCAT_GUNS,			20,				"weapon_zs_stubber", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_stubber") end)
GM:AddPointShopItem("crklr",			ITEMCAT_GUNS,			20,				"weapon_zs_crackler", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_crackler") end)
GM:AddPointShopItem("sling",			ITEMCAT_GUNS,			20,				"weapon_zs_slinger", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_slinger") end)
GM:AddPointShopItem("z9000",			ITEMCAT_GUNS,			20,				"weapon_zs_z9000", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_z9000") end)
GM:AddPointShopItem("minelayer",		ITEMCAT_GUNS,			20,				"weapon_zs_minelayer", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_minelayer") end)
-- Tier 2
GM:AddPointShopItem("glock3",			ITEMCAT_GUNS,			55,				"weapon_zs_glock3")
GM:AddPointShopItem("magnum",			ITEMCAT_GUNS,			55,				"weapon_zs_magnum")
GM:AddPointShopItem("eraser",			ITEMCAT_GUNS,			55,				"weapon_zs_eraser")
GM:AddPointShopItem("sawedoff",			ITEMCAT_GUNS,			55,				"weapon_zs_sawedoff")
GM:AddPointShopItem("uzi",				ITEMCAT_GUNS,			55,				"weapon_zs_uzi")
GM:AddPointShopItem("annabelle",		ITEMCAT_GUNS,			55,				"weapon_zs_annabelle")
GM:AddPointShopItem("inquisitor",		ITEMCAT_GUNS,			55,				"weapon_zs_inquisitor")
GM:AddPointShopItem("amigo",			ITEMCAT_GUNS,			55,				"weapon_zs_amigo")
GM:AddPointShopItem("hurricane",		ITEMCAT_GUNS,			55,				"weapon_zs_hurricane")
GM:AddPointShopItem("nome",		        ITEMCAT_GUNS,			55,				"weapon_zs_nome")
GM:AddPointShopItem("popl",		        ITEMCAT_GUNS,			55,				"weapon_zs_popluttar")
GM:AddPointShopItem("relsogun",		        ITEMCAT_GUNS,			55,				"weapon_zs_relsous")
GM:AddPointShopItem("fracture",		        ITEMCAT_GUNS,			55,				"weapon_zs_fracture")
-- Tier 3
GM:AddPointShopItem("deagle",			ITEMCAT_GUNS,			100,				"weapon_zs_deagle")
GM:AddPointShopItem("tempest",			ITEMCAT_GUNS,			100,				"weapon_zs_tempest")
GM:AddPointShopItem("ender",			ITEMCAT_GUNS,			100,				"weapon_zs_ender")
GM:AddPointShopItem("shredder",			ITEMCAT_GUNS,			100,				"weapon_zs_smg")
GM:AddPointShopItem("silencer",			ITEMCAT_GUNS,			100,				"weapon_zs_silencer")
GM:AddPointShopItem("hunter",			ITEMCAT_GUNS,			100,				"weapon_zs_hunter")
GM:AddPointShopItem("onyx",				ITEMCAT_GUNS,			100,				"weapon_zs_onyx")
GM:AddPointShopItem("charon",			ITEMCAT_GUNS,			100,				"weapon_zs_charon")
GM:AddPointShopItem("akbar",			ITEMCAT_GUNS,			100,				"weapon_zs_akbar")
GM:AddPointShopItem("oberon",			ITEMCAT_GUNS,			100,				"weapon_zs_oberon")
GM:AddPointShopItem("pollutor",			ITEMCAT_GUNS,			100,				"weapon_zs_pollutor")
GM:AddPointShopItem("smgstick",			ITEMCAT_GUNS,			100,				"weapon_zs_smgstick")
GM:AddPointShopItem("stalker",			ITEMCAT_GUNS,			100,			"weapon_zs_m4")
GM:AddPointShopItem("binocle",			ITEMCAT_GUNS,			100,			"weapon_zs_binocle")
-- Tier 4
GM:AddPointShopItem("longarm",			ITEMCAT_GUNS,			180,			"weapon_zs_longarm")
GM:AddPointShopItem("sweeper",			ITEMCAT_GUNS,			180,			"weapon_zs_sweepershotgun")
GM:AddPointShopItem("jackhammer",		ITEMCAT_GUNS,			180,			"weapon_zs_jackhammer")
GM:AddPointShopItem("bulletstorm",		ITEMCAT_GUNS,			180,			"weapon_zs_bulletstorm")
GM:AddPointShopItem("reaper",			ITEMCAT_GUNS,			180,			"weapon_zs_reaper")
GM:AddPointShopItem("quicksilver",		ITEMCAT_GUNS,			180,			"weapon_zs_quicksilver")
GM:AddPointShopItem("artemis",			ITEMCAT_GUNS,			180,			"weapon_zs_artemis")
GM:AddPointShopItem("zeus",				ITEMCAT_GUNS,			180,			"weapon_zs_zeus")
GM:AddPointShopItem("inferno",			ITEMCAT_GUNS,			180,			"weapon_zs_inferno")
GM:AddPointShopItem("quasar",			ITEMCAT_GUNS,			180,			"weapon_zs_quasar")
GM:AddPointShopItem("barrage",			ITEMCAT_GUNS,			180,			"weapon_zs_barrage")
GM:AddPointShopItem("toxico",			ITEMCAT_GUNS,			180,			"weapon_zs_toxicshooter")
-- Tier 5
GM:AddPointShopItem("slugrifle",		ITEMCAT_GUNS,			260,			"weapon_zs_slugrifle")
GM:AddPointShopItem("gluon",			ITEMCAT_GUNS,			260,			"weapon_zs_gluon")
GM:AddPointShopItem("novacolt",			ITEMCAT_GUNS,			260,			"weapon_zs_novacolt")
GM:AddPointShopItem("bulwark",			ITEMCAT_GUNS,		    260,			"weapon_zs_bulwark")
GM:AddPointShopItem("juggernaut",		ITEMCAT_GUNS,		    260,			"weapon_zs_juggernaut")
GM:AddPointShopItem("scar",				ITEMCAT_GUNS,			260,			"weapon_zs_scar")
GM:AddPointShopItem("colossus",			ITEMCAT_GUNS,			260,			"weapon_zs_colossus")
GM:AddPointShopItem("renegade",			ITEMCAT_GUNS,			260,			"weapon_zs_renegade")
GM:AddPointShopItem("crossbow",			ITEMCAT_GUNS,			260,			"weapon_zs_crossbow")
GM:AddPointShopItem("pulserifle",		ITEMCAT_GUNS,			260,			"weapon_zs_pulserifle")
GM:AddPointShopItem("spinfusor",		ITEMCAT_GUNS,			260,			"weapon_zs_spinfusor")
GM:AddPointShopItem("broadside",		ITEMCAT_GUNS,			260,			"weapon_zs_broadside")
GM:AddPointShopItem("smelter",			ITEMCAT_GUNS,			260,			"weapon_zs_smelter")
GM:AddPointShopItem("hyena",			ITEMCAT_GUNS,			260,				"weapon_zs_hyena")
-- Tier 6 beta
GM:AddPointShopItem("classixg",			ITEMCAT_GUNS,			500,			"weapon_zs_classic")
GM:AddPointShopItem("plasmk",			ITEMCAT_GUNS,			500,			"weapon_zs_plasmatik")
GM:AddPointShopItem("deathdlrs",		ITEMCAT_GUNS,			500,			"weapon_zs_deathdealers")
GM:AddPointShopItem("boomstick",		ITEMCAT_GUNS,			500,			"weapon_zs_boomstick")
GM:AddPointShopItem("hephaa",		ITEMCAT_GUNS,			500,			"weapon_zs_hephaestus")
-- Tier 7
GM:AddPointShopItem("sacredhh",			ITEMCAT_GUNS,			1000,			"weapon_zs_m6")
GM:AddPointShopItem("gaysseagle",   	ITEMCAT_GUNS,			1000,			"weapon_zs_gaeagle")
GM:AddPointShopItem("doomstick",   	ITEMCAT_GUNS,			1000,			"weapon_zs_doomstick")


GM:AddPointShopItem("pistolammo",		ITEMCAT_AMMO,			9,				nil,							"24 pistol ammo",				nil,									"ammo_pistol",						function(pl) pl:GiveAmmo(25, "pistol", true) end)
GM:AddPointShopItem("shotgunammo",		ITEMCAT_AMMO,			9,				nil,							"14 shotgun ammo",				nil,									"ammo_shotgun",						function(pl) pl:GiveAmmo(14, "buckshot", true) end)
GM:AddPointShopItem("smgammo",			ITEMCAT_AMMO,			9,				nil,							"55 SMG ammo",					nil,									"ammo_smg",							function(pl) pl:GiveAmmo(55, "smg1", true) end)
GM:AddPointShopItem("rifleammo",		ITEMCAT_AMMO,			9,				nil,							"12 rifle ammo",					nil,									"ammo_rifle",						function(pl) pl:GiveAmmo(12, "357", true) end)
GM:AddPointShopItem("crossbowammo",		ITEMCAT_AMMO,			9,				nil,							"8 crossbow bolts",				nil,									"ammo_bolts",						function(pl) pl:GiveAmmo(8,	"XBowBolt",	true) end)
GM:AddPointShopItem("assaultrifleammo",	ITEMCAT_AMMO,			9,				nil,							"46 assault rifle ammo",		nil,									"ammo_assault",						function(pl) pl:GiveAmmo(46, "ar2", true) end)
GM:AddPointShopItem("pulseammo",		ITEMCAT_AMMO,			9,				nil,							"35 pulse ammo",				nil,									"ammo_pulse",						function(pl) pl:GiveAmmo(35, "pulse", true) end)
GM:AddPointShopItem("impactmine",		ITEMCAT_AMMO,			9,				nil,							"5 explosives",					nil,									"ammo_explosive",					function(pl) pl:GiveAmmo(5, "impactmine", true) end)
GM:AddPointShopItem("chemical",			ITEMCAT_AMMO,			9,				nil,							"35 chemical vials",			nil,									"ammo_chemical",					function(pl) pl:GiveAmmo(35, "chemical", true) end)
item =
GM:AddPointShopItem("100mkit",			ITEMCAT_AMMO,			10,				nil,							"50 Medical Kit power",			"50 extra power for the Medical Kit.",	"ammo_medpower",					function(pl) pl:GiveAmmo(50, "Battery", true) end)
item.CanMakeFromScrap = true
GM:AddPointShopItem("nailsz",			ITEMCAT_AMMO,			7,				nil,			"8 nails",						nil, 		"ammo_nail", 			function(pl) pl:GiveAmmo(8, "GaussEnergy", true) end)

item.NoClassicMode = true
-- Tier 1
GM:AddPointShopItem("brassknuckles",	ITEMCAT_MELEE,			15,				"weapon_zs_brassknuckles").Model = "models/props_c17/utilityconnecter005.mdl"
GM:AddPointShopItem("knife",			ITEMCAT_MELEE,			15,				"weapon_zs_swissarmyknife")
GM:AddPointShopItem("zpplnk",			ITEMCAT_MELEE,			15,				"weapon_zs_plank")
GM:AddPointShopItem("axe",				ITEMCAT_MELEE,			15,				"weapon_zs_axe")
GM:AddPointShopItem("zpfryp",			ITEMCAT_MELEE,			15,				"weapon_zs_fryingpan")
GM:AddPointShopItem("zpcpot",			ITEMCAT_MELEE,			15,				"weapon_zs_pot")
GM:AddPointShopItem("ladel",			ITEMCAT_MELEE,			15,				"weapon_zs_ladel")
GM:AddPointShopItem("pipe",				ITEMCAT_MELEE,			15,				"weapon_zs_pipe")
GM:AddPointShopItem("stunbaton",		ITEMCAT_MELEE,			15,				"weapon_zs_stunbaton")
GM:AddPointShopItem("hook",				ITEMCAT_MELEE,			15,				"weapon_zs_hook")
GM:AddPointShopItem("syx",				ITEMCAT_MELEE,			15,				"weapon_zs_syx")
-- Tier 2
GM:AddPointShopItem("broom",			ITEMCAT_MELEE,			35,				"weapon_zs_pushbroom")
GM:AddPointShopItem("shovel",			ITEMCAT_MELEE,			35,				"weapon_zs_shovel")
GM:AddPointShopItem("sledgehammer",		ITEMCAT_MELEE,			35,				"weapon_zs_sledgehammer")
GM:AddPointShopItem("harpoon",			ITEMCAT_MELEE,			35,				"weapon_zs_harpoon")
GM:AddPointShopItem("butcherknf",		ITEMCAT_MELEE,			35,				"weapon_zs_butcherknife")
GM:AddPointShopItem("keyboard",		    ITEMCAT_MELEE,			15,				"weapon_zs_keyboard")
GM:AddPointShopItem("dash",		    ITEMCAT_MELEE,			35,				"weapon_zs_f_dash")
-- Tier 3
GM:AddPointShopItem("longsword",		ITEMCAT_MELEE,			60,				"weapon_zs_longsword")
GM:AddPointShopItem("executioner",		ITEMCAT_MELEE,			60,				"weapon_zs_executioner")
GM:AddPointShopItem("rebarmace",		ITEMCAT_MELEE,			60,				"weapon_zs_rebarmace")
GM:AddPointShopItem("meattenderizer",	ITEMCAT_MELEE,			60,				"weapon_zs_meattenderizer")
GM:AddPointShopItem("iceeluxx",	ITEMCAT_MELEE,			60,				"weapon_zs_icelux")
-- Tier 4
GM:AddPointShopItem("graveshvl",		ITEMCAT_MELEE,			95,			"weapon_zs_graveshovel")
GM:AddPointShopItem("kongol",			ITEMCAT_MELEE,			95,			"weapon_zs_kongolaxe")
GM:AddPointShopItem("scythe",			ITEMCAT_MELEE,			95,			"weapon_zs_scythe")
GM:AddPointShopItem("powerfists",		ITEMCAT_MELEE,			95,			"weapon_zs_powerfists")
-- Tier 5
GM:AddPointShopItem("frotchet",			ITEMCAT_MELEE,			190,			"weapon_zs_frotchet")
GM:AddPointShopItem("luxrockj",			ITEMCAT_MELEE,			95,			"weapon_zs_luxshade")
GM:AddPointShopItem("xouryc",			ITEMCAT_MELEE,			190,			"weapon_zs_loy")
GM:AddPointShopItem("luxoid",			ITEMCAT_MELEE,			190,			"weapon_zs_luxoid")
-- Tier 6
GM:AddPointShopItem("megahook",			ITEMCAT_MELEE,			400,			"weapon_zs_harpoon_mega")
GM:AddPointShopItem("teslar",			ITEMCAT_MELEE,			400,			"weapon_zs_teslorer")
-- Tier 7
GM:AddPointShopItem("speed",			ITEMCAT_MELEE,			10600,			"weapon_zs_speed")
-- Super Trinkets ------------------------------------------------------------------------------------------------------------------------------------------------

--
GM:AddPointShopItem("futureblu",			ITEMCAT_TRINKETS,		200,				"trinket_futureblu").SubCategory =								ITEMSUBCAT_TRINKETS_SUPER
GM:AddPointShopItem("sman",			ITEMCAT_TRINKETS,		200,				"trinket_sman").SubCategory =								ITEMSUBCAT_TRINKETS_SUPER
GM:AddPointShopItem("stutor",			ITEMCAT_TRINKETS,		200,				"trinket_stutor").SubCategory =								ITEMSUBCAT_TRINKETS_SUPER
GM:AddPointShopItem("gstore",			ITEMCAT_TRINKETS,		200,				"trinket_gstore").SubCategory =								ITEMSUBCAT_TRINKETS_SUPER
GM:AddPointShopItem("bloodlu",			ITEMCAT_TRINKETS,		200,				"trinket_bloodlust").SubCategory =								ITEMSUBCAT_TRINKETS_SUPER
GM:AddPointShopItem("knowev",			ITEMCAT_TRINKETS,		200,				"trinket_knowbook").SubCategory =								ITEMSUBCAT_TRINKETS_SUPER
GM:AddPointShopItem("adbat",			ITEMCAT_TRINKETS,		200,				"trinket_adbat").SubCategory =								ITEMSUBCAT_TRINKETS_SUPER
GM:AddPointShopItem("marm",			ITEMCAT_TRINKETS,		200,				"trinket_marm").SubCategory =								ITEMSUBCAT_TRINKETS_SUPER
GM:AddPointShopItem("sshield",			ITEMCAT_TRINKETS,		200,				"trinket_sshield").SubCategory =								ITEMSUBCAT_TRINKETS_SUPER


GM:AddPointShopItem("crphmr",			ITEMCAT_TOOLS,			25,				"weapon_zs_hammer",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_hammer") pl:GiveAmmo(5, "GaussEnergy") end)
GM:AddPointShopItem("wrench",			ITEMCAT_TOOLS,			20,				"weapon_zs_wrench").NoClassicMode = true
GM:AddPointShopItem("arsenalcrate",		ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_arsenalcrate").Countables = "prop_arsenalcrate"
GM:AddPointShopItem("resupplybox",		ITEMCAT_DEPLOYABLES,			30,				"weapon_zs_resupplybox").Countables = "prop_resupplybox"
GM:AddPointShopItem("remantler",		ITEMCAT_DEPLOYABLES,			30,				"weapon_zs_remantler").Countables = "prop_remantler"
GM:AddPointShopItem("msgbeacon",		ITEMCAT_DEPLOYABLES,			0,				"weapon_zs_messagebeacon").Countables = "prop_messagebeacon"
GM:AddPointShopItem("camera",			ITEMCAT_DEPLOYABLES,			15,				"weapon_zs_camera").Countables = "prop_camera"
GM:AddPointShopItem("tv",				ITEMCAT_DEPLOYABLES,			25,				"weapon_zs_tv").Countables = "prop_tv"
item =
GM:AddPointShopItem("infturret",		ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_gunturret",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret") pl:GiveAmmo(1, "thumper") end)
item.NoClassicMode = true
item.Countables = "prop_gunturret"
item =
GM:AddPointShopItem("blastturret",		ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_gunturret_buckshot",	nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_buckshot") pl:GiveAmmo(1, "turret_buckshot") end)
item.Countables = "prop_gunturret_buckshot"
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_BLASTTURRET
item =
GM:AddPointShopItem("assaultturret",	ITEMCAT_DEPLOYABLES,			125,			"weapon_zs_gunturret_assault",	nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_assault") pl:GiveAmmo(1, "turret_assault") end)
item.NoClassicMode = true
item.Countables = "prop_gunturret_assault"
item =
GM:AddPointShopItem("rocketturret",		ITEMCAT_DEPLOYABLES,			125,			"weapon_zs_gunturret_rocket",	nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_rocket") pl:GiveAmmo(1, "turret_rocket") end)
item.Countables = "prop_gunturret_rocket"
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_ROCKETTURRET
GM:AddPointShopItem("weapon_zs_gunturret_super",		ITEMCAT_DEPLOYABLES,			290,			"weapon_zs_gunturret_super",	nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_super") pl:GiveAmmo(1, "turret_super") end)
item.Countables = "prop_gunturret_super"
item.NoClassicMode = true
--GM:AddStartingItem("infturret",			ITEMCAT_DEPLOYABLES,			45,				"weapon_zs_gunturret",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret") pl:GiveAmmo(1, "thumper") pl:GiveAmmo(125, "smg1") end)
GM:AddPointShopItem("manhack",			ITEMCAT_DEPLOYABLES,			30,				"weapon_zs_manhack").Countables = "prop_manhack"
item =
GM:AddPointShopItem("drone",			ITEMCAT_DEPLOYABLES,			40,				"weapon_zs_drone")
item.Countables = "prop_drone"
item =
GM:AddPointShopItem("pulsedrone",		ITEMCAT_DEPLOYABLES,			40,				"weapon_zs_drone_pulse")
item.Countables = "prop_drone_pulse"
item.SkillRequirement = SKILL_U_DRONE
item =
GM:AddPointShopItem("hauldrone",		ITEMCAT_DEPLOYABLES,			15,				"weapon_zs_drone_hauler")
item.Countables = "prop_drone_hauler"
item.SkillRequirement = SKILL_HAULMODULE
item =
GM:AddPointShopItem("rollermine",		ITEMCAT_DEPLOYABLES,			35,				"weapon_zs_rollermine")
item.Countables = "prop_rollermine"
item.SkillRequirement = SKILL_U_ROLLERMINE

item =
GM:AddPointShopItem("repairfield",		ITEMCAT_DEPLOYABLES,			55,				"weapon_zs_repairfield",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_repairfield") pl:GiveAmmo(1, "repairfield") pl:GiveAmmo(30, "pulse") end)
item.Countables = "prop_repairfield"
item.NoClassicMode = true
item =
GM:AddPointShopItem("zapper",			ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_zapper",				nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_zapper") pl:GiveAmmo(1, "zapper") pl:GiveAmmo(30, "pulse") end)
item.Countables = "prop_zapper"
item.NoClassicMode = true
item =
GM:AddPointShopItem("zapper_arc",		ITEMCAT_DEPLOYABLES,			100,			"weapon_zs_zapper_arc",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_zapper_arc") pl:GiveAmmo(1, "zapper_arc") pl:GiveAmmo(30, "pulse") end)
item.Countables = "prop_zapper_arc"
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_ZAPPER_ARC
item =
GM:AddPointShopItem("ffemitter",		ITEMCAT_DEPLOYABLES,			40,				"weapon_zs_ffemitter",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_ffemitter") pl:GiveAmmo(1, "slam") pl:GiveAmmo(30, "pulse") end)
item.Countables = "prop_ffemitter"
GM:AddPointShopItem("propanetank",		ITEMCAT_TOOLS,			15,				"comp_propanecan")
GM:AddPointShopItem("busthead",			ITEMCAT_TOOLS,			25,				"comp_busthead")
GM:AddPointShopItem("sawblade",			ITEMCAT_TOOLS,			30,				"comp_sawblade").SkillRequirement = SKILL_U_CRAFTINGPACK
GM:AddPointShopItem("cpuparts",			ITEMCAT_TOOLS,			30,				"comp_cpuparts").SkillRequirement = SKILL_U_CRAFTINGPACK
GM:AddPointShopItem("electrobattery",	ITEMCAT_TOOLS,			40,				"comp_electrobattery").SkillRequirement = SKILL_U_CRAFTINGPACK
GM:AddPointShopItem("barricadekit",		ITEMCAT_DEPLOYABLES,	20,				"weapon_zs_barricadekit")
GM:AddPointShopItem("medkit",			ITEMCAT_TOOLS,			30,				"weapon_zs_medicalkit")
GM:AddPointShopItem("medgun",			ITEMCAT_TOOLS,			30,				"weapon_zs_medicgun")
item =
GM:AddPointShopItem("strengthshot",		ITEMCAT_TOOLS,			30,				"weapon_zs_strengthshot")
item.SkillRequirement = SKILL_U_STRENGTHSHOT
item =
GM:AddPointShopItem("antidote",			ITEMCAT_TOOLS,			30,				"weapon_zs_antidoteshot")
item.SkillRequirement = SKILL_U_ANTITODESHOT
GM:AddPointShopItem("medrifle",			ITEMCAT_TOOLS,			55,				"weapon_zs_medicrifle")
GM:AddPointShopItem("healray",			ITEMCAT_TOOLS,			100,			"weapon_zs_healingray")
GM:AddPointShopItem("stone",			ITEMCAT_TOOLS,			15,			"weapon_zs_stone")
GM:AddPointShopItem("scrap",				ITEMCAT_TOOLS,			30,				nil,							"Scrap x20",							"Scrap but is have x15.",					"ammo_scrap",						function(pl) pl:GiveAmmo(20, "Scrap", true) end)
-- Tier 1
GM:AddPointShopItem("cutlery",			ITEMCAT_TRINKETS,		10,				"trinket_cutlery").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("boxingtraining",	ITEMCAT_TRINKETS,		10,				"trinket_boxingtraining").SubCategory =							ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("hemoadrenali",		ITEMCAT_TRINKETS,		10,				"trinket_hemoadrenali").SubCategory =							ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("oxtank",			ITEMCAT_TRINKETS,		10,				"trinket_oxygentank").SubCategory =								ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("acrobatframe",		ITEMCAT_TRINKETS,		10,				"trinket_acrobatframe").SubCategory =							ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("portablehole",		ITEMCAT_TRINKETS,		10,				"trinket_portablehole").SubCategory =							ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("magnet",			ITEMCAT_TRINKETS,		10,				"trinket_magnet").SubCategory =									ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("targetingvisi",	ITEMCAT_TRINKETS,		10,				"trinket_targetingvisori").SubCategory =						ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("pulseampi",		ITEMCAT_TRINKETS,		10,				"trinket_pulseampi").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
-- Tier 2
GM:AddPointShopItem("momentumsupsysii",	ITEMCAT_TRINKETS,		15,				"trinket_momentumsupsysii").SubCategory =						ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("sharpkit",			ITEMCAT_TRINKETS,		15,				"trinket_sharpkit").SubCategory =								ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("sharpkt",			ITEMCAT_TRINKETS,		50,				"trinket_sharpkt").SubCategory =								ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("nightvision",		ITEMCAT_TRINKETS,		15,				"trinket_nightvision").SubCategory =							ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("loadingframe",		ITEMCAT_TRINKETS,		15,				"trinket_loadingex").SubCategory =								ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("pathfinder",		ITEMCAT_TRINKETS,		15,				"trinket_pathfinder").SubCategory =								ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("ammovestii",		ITEMCAT_TRINKETS,		15,				"trinket_ammovestii").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("olympianframe",	ITEMCAT_TRINKETS,		15,				"trinket_olympianframe").SubCategory =							ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("autoreload",		ITEMCAT_TRINKETS,		15,				"trinket_autoreload").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("curbstompers",		ITEMCAT_TRINKETS,		15,				"trinket_curbstompers").SubCategory =							ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("vitpackagei",		ITEMCAT_TRINKETS,		15,				"trinket_vitpackagei").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("cardpackagei",		ITEMCAT_TRINKETS,		15,				"trinket_cardpackagei").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("forcedamp",		ITEMCAT_TRINKETS,		15,				"trinket_forcedamp").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("sarmband",		ITEMCAT_TRINKETS,		15,				"trinket_sarmband").SubCategory =								ITEMSUBCAT_TRINKETS_PERFOMANCE
GM:AddPointShopItem("engineer",		ITEMCAT_TRINKETS,		15,				"trinket_engineer").SubCategory =								ITEMSUBCAT_TRINKETS_PERFOMANCE
GM:AddPointShopItem("kevlar",			ITEMCAT_TRINKETS,		15,				"trinket_kevlar").SubCategory =									ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("antitoxinpack",	ITEMCAT_TRINKETS,		15,				"trinket_antitoxinpack").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("hemostasis",		ITEMCAT_TRINKETS,		15,				"trinket_hemostasis").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("bloodpack",		ITEMCAT_TRINKETS,		15,				"trinket_bloodpack").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("reactiveflasher",	ITEMCAT_TRINKETS,		15,				"trinket_reactiveflasher").SubCategory =						ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("iceburst",			ITEMCAT_TRINKETS,		15,				"trinket_iceburst").SubCategory =								ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("biocleanser",		ITEMCAT_TRINKETS,		15,				"trinket_biocleanser").SubCategory =							ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("necrosense",		ITEMCAT_TRINKETS,		15,				"trinket_necrosense").SubCategory =								ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("blueprintsi",		ITEMCAT_TRINKETS,		15,				"trinket_blueprintsi").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("processor",		ITEMCAT_TRINKETS,		15,				"trinket_processor").SubCategory =								ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("acqmanifest",		ITEMCAT_TRINKETS,		15,				"trinket_acqmanifest").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("mainsuite",		ITEMCAT_TRINKETS,		15,				"trinket_mainsuite").SubCategory =								ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("hateome",		ITEMCAT_TRINKETS,		100,				"trinket_hateome").SubCategory =					    		ITEMSUBCAT_TRINKETS_SUPPORT
-- Tier 3
--GM:AddPointShopItem("climbinggear",  	ITEMCAT_TRINKETS,		30,				"trinket_climbinggear").SubCategory =							ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("reachem",			ITEMCAT_TRINKETS,		30,				"trinket_reachem").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("momentumsupsysiii",ITEMCAT_TRINKETS,		30,				"trinket_momentumsupsysiii").SubCategory =						ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("adrenaline",ITEMCAT_TRINKETS,		30,				"trinket_adrenaline").SubCategory =						ITEMSUBCAT_TRINKETS_PERFOMANCE
GM:AddPointShopItem("brokenhammer",ITEMCAT_TRINKETS,		30,				"trinket_scour").SubCategory =						ITEMSUBCAT_TRINKETS_PERFOMANCE
GM:AddPointShopItem("scout",ITEMCAT_TRINKETS,		30,				"trinket_scout").SubCategory =						ITEMSUBCAT_TRINKETS_PERFOMANCE
GM:AddPointShopItem("powergauntlet",	ITEMCAT_TRINKETS,		30,				"trinket_powergauntlet").SubCategory =							ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("hemoadrenalii",	ITEMCAT_TRINKETS,		30,				"trinket_hemoadrenalii").SubCategory =							ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("sharpstone",		ITEMCAT_TRINKETS,		30,				"trinket_sharpstone").SubCategory =								ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("store",	      	ITEMCAT_TRINKETS,		30,				"trinket_store").SubCategory =					     			ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("analgestic",		ITEMCAT_TRINKETS,		30,				"trinket_analgestic").SubCategory =								ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("feathfallframe",	ITEMCAT_TRINKETS,		30,				"trinket_featherfallframe").SubCategory =						ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("aimcomp",			ITEMCAT_TRINKETS,		30,				"trinket_aimcomp").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("pulseampii",		ITEMCAT_TRINKETS,		30,				"trinket_pulseampii").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("extendedmag",		ITEMCAT_TRINKETS,		30,				"trinket_extendedmag").SubCategory =							ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("vitpackageii",		ITEMCAT_TRINKETS,		30,				"trinket_vitpackageii").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("cardpackageii",	ITEMCAT_TRINKETS,		30,				"trinket_cardpackageii").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("regenimplant",		ITEMCAT_TRINKETS,		30,				"trinket_regenimplant").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("barbedarmor",		ITEMCAT_TRINKETS,		30,				"trinket_barbedarmor").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("blueprintsii",		ITEMCAT_TRINKETS,		30,				"trinket_blueprintsii").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("curativeii",		ITEMCAT_TRINKETS,		30,				"trinket_curativeii").SubCategory =								ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("remedy",			ITEMCAT_TRINKETS,		30,				"trinket_remedy").SubCategory =									ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("flashlo",	      	ITEMCAT_TRINKETS,		30,				"trinket_flashlo").SubCategory =								ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("pills",	      	ITEMCAT_TRINKETS,		30,				"trinket_pills").SubCategory =								ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("damage222",	      	ITEMCAT_TRINKETS,		30,				"trinket_damage222").SubCategory =								ITEMSUBCAT_TRINKETS_MELEE
-- Tier 4
GM:AddPointShopItem("hemoadrenaliii",	ITEMCAT_TRINKETS,		50,				"trinket_hemoadrenaliii").SubCategory =							ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("ammoband",			ITEMCAT_TRINKETS,		50,				"trinket_ammovestiii").SubCategory =							ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("resonance",		ITEMCAT_TRINKETS,		50,				"trinket_resonance").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("cryoindu",			ITEMCAT_TRINKETS,		50,				"trinket_cryoindu").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("refinedsub",		ITEMCAT_TRINKETS,		50,				"trinket_refinedsub").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("targetingvisiii",	ITEMCAT_TRINKETS,		50,				"trinket_targetingvisoriii").SubCategory =						ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("sammovest",	   ITEMCAT_TRINKETS,		50,				"trinket_sammovest").SubCategory =						ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("eodvest",			ITEMCAT_TRINKETS,		50,				"trinket_eodvest").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("composite",		ITEMCAT_TRINKETS,		50,				"trinket_composite").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("toysite  ",		ITEMCAT_TRINKETS,		150,				"trinket_toysite").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("arsenalpack",		ITEMCAT_TRINKETS,		50,				"trinket_arsenalpack").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("resupplypack",		ITEMCAT_TRINKETS,		50,				"trinket_resupplypack").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("promanifest",		ITEMCAT_TRINKETS,		50,				"trinket_promanifest").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("opsmatrix",		ITEMCAT_TRINKETS,		50,				"trinket_opsmatrix").SubCategory =								ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("store2",	        ITEMCAT_TRINKETS,		50,				"trinket_store2").SubCategory =						ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("kre",	            ITEMCAT_TRINKETS,		50,				"trinket_kre").SubCategory =						ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("greedeye",	            ITEMCAT_TRINKETS,		50,				"trinket_greedeye").SubCategory =						ITEMSUBCAT_TRINKETS_SPECIAL
-- Tier 5
GM:AddPointShopItem("supasm",			ITEMCAT_TRINKETS,		70,				"trinket_supasm").SubCategory =									ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("pulseimpedance",	ITEMCAT_TRINKETS,		70,				"trinket_pulseimpedance").SubCategory =							ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("classix",	        ITEMCAT_TRINKETS,		70,				"trinket_classix").SubCategory =							  ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("killer",	        ITEMCAT_TRINKETS,		70,				"trinket_killer").SubCategory =						     	 ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("stopit",        	ITEMCAT_TRINKETS,		70,				"trinket_stopit").SubCategory =						ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("classil",	        ITEMCAT_TRINKETS,		70,				"trinket_classil").SubCategory =							  ITEMSUBCAT_TRINKETS_OFFENSIVE 
-- GM:AddPointShopItem("void",	        ITEMCAT_TRINKETS,		70,				"trinket_void").SubCategory =							  ITEMSUBCAT_TRINKETS_OFFENSIVE


  
GM:AddPointShopItem("flashbomb",		ITEMCAT_OTHER,			25,				"weapon_zs_flashbomb")
GM:AddPointShopItem("molotov",			ITEMCAT_OTHER,			30,				"weapon_zs_molotov")
GM:AddPointShopItem("grenade",			ITEMCAT_OTHER,			35,				"weapon_zs_grenade")
GM:AddPointShopItem("betty",			ITEMCAT_OTHER,			35,				"weapon_zs_proxymine")
GM:AddPointShopItem("detpck",			ITEMCAT_OTHER,			40,				"weapon_zs_detpack")
item =
GM:AddPointShopItem("crygasgrenade",	ITEMCAT_OTHER,			20,				"weapon_zs_crygasgrenade")
item.SkillRequirement = SKILL_U_CRYGASGREN
GM:AddPointShopItem("corgasgrenade",	ITEMCAT_OTHER,			45,				"weapon_zs_corgasgrenade")
GM:AddPointShopItem("sigfragment",		ITEMCAT_OTHER,			30,				"weapon_zs_sigilfragment")
GM:AddPointShopItem("bloodshot",		ITEMCAT_OTHER,			45,				"weapon_zs_bloodshotbomb")
item =
GM:AddPointShopItem("corruptedfragment",ITEMCAT_OTHER,			55,				"weapon_zs_corruptedfragment")
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_CORRUPTEDFRAGMENT
item =
GM:AddPointShopItem("nanitecloud",		ITEMCAT_OTHER,			40,				"weapon_zs_nanitecloudbomb")
item.SkillRequirement = SKILL_U_NANITECLOUD
item =
GM:AddPointShopItem("nulledher",		ITEMCAT_SPECIAL,			80,				"trinket_nulledher")
item.SkillRequirement = SKILL_HEARTS
item =
GM:AddPointShopItem("voidheart",		ITEMCAT_SPECIAL,			80,				"trinket_voidheart")
item.SkillRequirement = SKILL_HEARTS
item =
GM:AddPointShopItem("kheart",		ITEMCAT_SPECIAL,			120,				"trinket_kheart")
item.SkillRequirement = SKILL_HEARTS
item =
GM:AddPointShopItem("cursedtrinket",		ITEMCAT_SPECIAL,			120,				"trinket_cursedtrinket")
item.SkillRequirement = SKILL_CURSEDTRINKETS

-- These are the honorable mentions that come at the end of the round.

local function genericcallback(pl, magnitude) return pl:Name(), magnitude end
GM.HonorableMentions = {}
GM.HonorableMentions[HM_MOSTZOMBIESKILLED] = {Name = "Crymommy", String = "by %s, with %d killed zombies.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTDAMAGETOUNDEAD] = {Name = "GEnius", String = "goes to %s, with a total of %d damage dealt to the undead.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTHEADSHOTS] = {Name = "AIMer", String = "goes to %s, with a total of %s headshot kills.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_PACIFIST] = {Name = "Fucking Pacifist", String = "goes to %s for not killing a single zombie and still surviving!", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTHELPFUL] = {Name = "У того у кого стилили", String = "goes to %s for assisting in the disposal of %d zombies.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_LASTHUMAN] = {Name = "Last Doset man", String = "goes to %s for being the last person alive.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_OUTLANDER] = {Name = "Adventurer", String = "goes to %s for getting killed %d feet away from a zombie spawn.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_GOODDOCTOR] = {Name = "Good Man 2", String = "goes to %s for healing their team for %d points of health.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_HANDYMAN] = {Name = "Best Cader", String = "goes to %s for getting %d barricade assistance points.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_SCARECROW] = {Name = "Super Autist", String = "goes to %s for killing %d poor crows.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_MOSTBRAINSEATEN] = {Name = "Killer 1001", String = "by %s, with %d brains eaten.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_MOSTDAMAGETOHUMANS] = {Name = "I wanna to be a BOSS!", String = "goes to %s, with a total of %d damage given to living players.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_LASTBITE] = {Name = "Bite the nigger", String = "goes to %s for ending the round.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_USEFULTOOPPOSITE] = {Name = "Helpful", String = "goes to %s for giving up a whopping %d kills!", Callback = genericcallback, Color = COLOR_RED}
GM.HonorableMentions[HM_STUPID] = {Name = "Childhouse", String = "is what %s is for getting killed %d feet away from a zombie spawn.", Callback = genericcallback, Color = COLOR_RED}
GM.HonorableMentions[HM_SALESMAN] = {Name = "Buy this!Sale is 0%!", String = "is what %s is for having %d points worth of items taken from their arsenal crate.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_WAREHOUSE] = {Name = "Strane man?", String = "describes %s well since they had their resupply boxes used %d times.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_DEFENCEDMG] = {Name = "Defender", String = "goes to %s for protecting humans from %d damage with defence boosts.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_STRENGTHDMG] = {Name = "Alchemic", String = "is what %s is for boosting players with an additional %d damage.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_BARRICADEDESTROYER] = {Name = "Zmainer", String = "goes to %s for doing %d damage to barricades.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_NESTDESTROYER] = {Name = "FUCKING NIGGER", String = "goes to %s for destroying %d nests.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_NESTMASTER] = {Name = "Good man", String = "goes to %s for having %d zombies spawn through their nest.", Callback = genericcallback, Color = COLOR_LIMEGREEN}

-- Don't let humans use these models because they look like undead models. Must be lower case.
GM.RestrictedModels = {
	"models/player/zombie_classic.mdl",
	"models/player/zombie_classic_hbfix.mdl",
	"models/player/zombine.mdl",
	"models/player/zombie_soldier.mdl",
	"models/player/zombie_fast.mdl",
	"models/player/corpse1.mdl",
	"models/player/charple.mdl",
	"models/player/skeleton.mdl",
	"models/player/combine_soldier_prisonguard.mdl",
	"models/player/soldier_stripped.mdl",
	"models/player/zelpa/stalker.mdl",
	"models/player/fatty/fatty.mdl",
	"models/player/zombie_lacerator2.mdl"
}

-- If a person has no player model then use one of these (auto-generated).
GM.RandomPlayerModels = {}
for name, mdl in pairs(player_manager.AllValidModels()) do
	if not table.HasValue(GM.RestrictedModels, string.lower(mdl)) then
		table.insert(GM.RandomPlayerModels, name)
	end
end

GM.DeployableInfo = {}
function GM:AddDeployableInfo(class, name, wepclass)
	local tab = {Class = class, Name = name or "?", WepClass = wepclass}

	self.DeployableInfo[#self.DeployableInfo + 1] = tab
	self.DeployableInfo[class] = tab

	return tab
end
GM:AddDeployableInfo("prop_arsenalcrate", 		"Arsenal Crate", 		"weapon_zs_arsenalcrate")
GM:AddDeployableInfo("prop_resupplybox", 		"Resupply Box", 		"weapon_zs_resupplybox")
GM:AddDeployableInfo("prop_remantler", 			"Weapon Remantler", 	"weapon_zs_remantler")
GM:AddDeployableInfo("prop_messagebeacon", 		"Message Beacon", 		"weapon_zs_messagebeacon")
GM:AddDeployableInfo("prop_camera", 			"Camera",	 			"weapon_zs_camera")
GM:AddDeployableInfo("prop_gunturret", 			"Gun Turret",	 		"weapon_zs_gunturret")
GM:AddDeployableInfo("prop_gunturret_assault", 	"Assault Turret",	 	"weapon_zs_gunturret_assault")
GM:AddDeployableInfo("prop_gunturret_buckshot",	"Blast Turret",	 		"weapon_zs_gunturret_buckshot")
GM:AddDeployableInfo("prop_gunturret_rocket",	"Rocket Turret",	 	"weapon_zs_gunturret_rocket")
GM:AddDeployableInfo("prop_gunturret_super",	"Super Turret",	 	"weapon_zs_gunturret_super")
GM:AddDeployableInfo("prop_repairfield",		"Repair Field Emitter",	"weapon_zs_repairfield")
GM:AddDeployableInfo("prop_zapper",				"Zapper",				"weapon_zs_zapper")
GM:AddDeployableInfo("prop_zapper_arc",			"Arc Zapper",			"weapon_zs_zapper_arc")
GM:AddDeployableInfo("prop_ffemitter",			"Force Field Emitter",	"weapon_zs_ffemitter")
GM:AddDeployableInfo("prop_manhack",			"Manhack",				"weapon_zs_manhack")
GM:AddDeployableInfo("prop_manhack_saw",		"Sawblade Manhack",		"weapon_zs_manhack_saw")
GM:AddDeployableInfo("prop_drone",				"Drone",				"weapon_zs_drone")
GM:AddDeployableInfo("prop_drone_pulse",		"Pulse Drone",			"weapon_zs_drone_pulse")
GM:AddDeployableInfo("prop_drone_hauler",		"Hauler Drone",			"weapon_zs_drone_hauler")
GM:AddDeployableInfo("prop_rollermine",			"Rollermine",			"weapon_zs_rollermine")
GM:AddDeployableInfo("prop_tv",                   	 "TV",                    	"weapon_zs_tv")

GM.MaxSigils = 2

GM.DefaultRedeem = CreateConVar("zs_redeem", "3", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "The amount of kills a zombie needs to do in order to redeem. Set to 0 to disable."):GetInt()
cvars.AddChangeCallback("zs_redeem", function(cvar, oldvalue, newvalue)
	GAMEMODE.DefaultRedeem = math.max(0, tonumber(newvalue) or 0)
end)

GM.WaveOneZombies = 0.12--math.Round(CreateConVar("zs_waveonezombies", "0.1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "The percentage of players that will start as zombies when the game begins."):GetFloat(), 2)
-- cvars.AddChangeCallback("zs_waveonezombies", function(cvar, oldvalue, newvalue)
-- 	GAMEMODE.WaveOneZombies = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
-- end)

-- Game feeling too easy? Just change these values!
GM.ZombieSpeedMultiplier = math.Round(CreateConVar("zs_zombiespeedmultiplier", "1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Zombie running speed will be scaled by this value."):GetFloat(), 2)
cvars.AddChangeCallback("zs_zombiespeedmultiplier", function(cvar, oldvalue, newvalue)
	GAMEMODE.ZombieSpeedMultiplier = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
end)

-- This is a resistance, not for claw damage. 0.5 will make zombies take half damage, 0.25 makes them take 1/4, etc.
GM.ZombieDamageMultiplier = math.Round(CreateConVar("zs_zombiedamagemultiplier", "0.90", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Scales the amount of damage that zombies take. Use higher values for easy zombies, lower for harder."):GetFloat(), 2)
cvars.AddChangeCallback("zs_zombiedamagemultiplier", function(cvar, oldvalue, newvalue)
	GAMEMODE.ZombieDamageMultiplier = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
end)

GM.TimeLimit = CreateConVar("zs_timelimit", "25", FCVAR_ARCHIVE + FCVAR_NOTIFY, "Time in minutes before the game will change maps. It will not change maps if a round is currently in progress but after the current round ends. -1 means never switch maps. 0 means always switch maps."):GetInt() * 60
cvars.AddChangeCallback("zs_timelimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.TimeLimit = tonumber(newvalue) or 2500
	if GAMEMODE.TimeLimit ~= -1 then
		GAMEMODE.TimeLimit = GAMEMODE.TimeLimit * 2500
	end
end)

GM.RoundLimit = CreateConVar("zs_roundlimit", "3", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many times the game can be played on the same map. -1 means infinite or only use time limit. 0 means once."):GetInt()
cvars.AddChangeCallback("zs_roundlimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.RoundLimit = tonumber(newvalue) or 3
end)

-- Static values that don't need convars...

-- Initial length for wave 1.
GM.WaveOneLength = 100

-- Add this many seconds for each additional wave.
GM.TimeAddedPerWave = 10

-- New players are put on the zombie team if the current wave is this or higher. Do not put it lower than 1 or you'll break the game.
GM.NoNewHumansWave = 4

-- Humans can not commit suicide if the current wave is this or lower.
GM.NoSuicideWave = 0

-- How long 'wave 0' should last in seconds. This is the time you should give for new players to join and get ready.
GM.WaveZeroLength = 300

-- Time humans have between waves to do stuff without NEW zombies spawning. Any dead zombies will be in spectator (crow) view and any living ones will still be living.
GM.WaveIntermissionLength = 90

-- Time in seconds between end round and next map.
GM.EndGameTime = 30

-- How many clips of ammo guns from the Worth menu start with. Some guns such as shotguns and sniper rifles have multipliers on this.
GM.SurvivalClips = 4 --2

-- How long do humans have to wait before being able to get more ammo from a resupply box?
GM.ResupplyBoxCooldown = 45

-- Put your unoriginal, 5MB Rob Zombie and Metallica music here.
GM.LastHumanSound = Sound("zombiesurvival/lasthuman.ogg")

-- Sound played when humans all die.
GM.AllLoseSound = Sound("zombiesurvival/music_lose.ogg")

-- Sound played when humans survive.
GM.HumanWinSound = Sound("zombiesurvival/music_win.ogg")

-- Sound played to a person when they die as a human.
GM.DeathSound = Sound("zombiesurvival/human_death_stinger.ogg")

-- Fetch map profiles and node profiles from noxiousnet database?
GM.UseOnlineProfiles = true

-- This multiplier of points will save over to the next round. 1 is full saving. 0 is disabled.
-- Setting this to 0 will not delete saved points and saved points do not "decay" if this is less than 1.
GM.PointSaving = 0

-- Lock item purchases to waves. Tier 2 items can only be purchased on wave 2, tier 3 on wave 3, etc.
-- HIGHLY suggested that this is on if you enable point saving. Always false if objective map, zombie escape, classic mode, or wave number is changed by the map.
GM.LockItemTiers = false

-- Don't save more than this amount of points. 0 for infinite.
GM.PointSavingLimit = 25

-- For Classic Mode
GM.WaveIntermissionLengthClassic = 10
GM.WaveOneLengthClassic = 30
GM.TimeAddedPerWaveClassic = 15

-- Max amount of damage left to tick on these. Any more pending damage is ignored.
GM.MaxRotDamage = 2000
GM.MaxBleedDamage = 230

-- Give humans this many points when the wave ends.
GM.EndWavePointsBonus = 7

-- Also give humans this many points when the wave ends, multiplied by (wave - 1)
GM.EndWavePointsBonusPerWave = 3
