INVCAT_TRINKETS = 1
INVCAT_COMPONENTS = 2
INVCAT_CONSUMABLES = 3

GM.ZSInventoryItemData = {}
GM.ZSInventoryCategories = {
	[INVCAT_TRINKETS] = "Trinkets",
	[INVCAT_COMPONENTS] = "Components",
	[INVCAT_CONSUMABLES] = "Consumables"
}
GM.ZSInventoryPrefix = {
	[INVCAT_TRINKETS] = "trin",
	[INVCAT_COMPONENTS] = "comp",
	[INVCAT_CONSUMABLES] = "cons"
}

GM.Assemblies = {}
GM.Breakdowns = {}

function GM:GetInventoryItemType(item)
	for typ, aff in pairs(self.ZSInventoryPrefix) do
		if string.sub(item, 1, 4) == aff then
			return typ
		end
	end

	return -1
end

local index = 1
function GM:AddInventoryItemData(intname, name, description, weles, tier, stocks)
	local datatab = {PrintName = name, DroppedEles = weles, Tier = tier, Description = description, Stocks = stocks, Index = index}
	self.ZSInventoryItemData[intname] = datatab
	self.ZSInventoryItemData[index] = datatab

	index = index + 1
end


function GM:AddWeaponBreakdownRecipe(weapon, result)
	local datatab = {Result = result, Index = index}
	self.Breakdowns[weapon] = datatab
	for i = 1, 3 do
		self.Breakdowns[self:GetWeaponClassOfQuality(weapon, i)] = datatab
		self.Breakdowns[self:GetWeaponClassOfQuality(weapon, i, 1)] = datatab
	end

	self.Breakdowns[#self.Breakdowns + 1] = datatab
end

GM:AddWeaponBreakdownRecipe("weapon_zs_stubber",							"comp_modbarrel")
GM:AddWeaponBreakdownRecipe("weapon_zs_z9000",								"comp_basicecore")
GM:AddWeaponBreakdownRecipe("weapon_zs_blaster",							"comp_pumpaction")
GM:AddWeaponBreakdownRecipe("weapon_zs_novablaster",						"comp_contaecore")
GM:AddWeaponBreakdownRecipe("weapon_zs_waraxe", 							"comp_focusbarrel")
GM:AddWeaponBreakdownRecipe("weapon_zs_innervator",							"comp_gaussframe")
GM:AddWeaponBreakdownRecipe("weapon_zs_swissarmyknife",						"comp_shortblade")
GM:AddWeaponBreakdownRecipe("weapon_zs_owens",								"comp_multibarrel")
GM:AddWeaponBreakdownRecipe("weapon_zs_onyx",								"comp_precision")
GM:AddWeaponBreakdownRecipe("weapon_zs_minelayer",							"comp_launcher")
GM:AddWeaponBreakdownRecipe("weapon_zs_fracture",							"comp_linearactuator")
GM:AddWeaponBreakdownRecipe("weapon_zs_harpoon",							"comp_metalpole")
GM:AddWeaponBreakdownRecipe("weapon_zs_cryman",							"comp_mommy")
GM:AddWeaponBreakdownRecipe("weapon_zs_m5",							"comp_sacred_soul")
GM:AddWeaponBreakdownRecipe("trinket_sharpstone",							"comp_sacred_soul")
GM:AddWeaponBreakdownRecipe("weapon_zs_crymam",							"trinket_toysoul")

-- Assemblies (Assembly, Component, Weapon)
GM.Assemblies["weapon_zs_waraxe"] 								= {"comp_modbarrel", 		"weapon_zs_glock3"}
GM.Assemblies["weapon_zs_bust"] 								= {"comp_busthead", 		"weapon_zs_plank"}
GM.Assemblies["weapon_zs_sawhack"] 								= {"comp_sawblade", 		"weapon_zs_axe"}
GM.Assemblies["weapon_zs_bloodhack"] 							= {"comp_sawblade", 		"weapon_zs_manhack"}
GM.Assemblies["weapon_zs_megamasher"] 							= {"comp_propanecan", 		"weapon_zs_sledgehammer"}
GM.Assemblies["weapon_zs_electrohammer"] 						= {"comp_electrobattery",	"weapon_zs_hammer"}
GM.Assemblies["weapon_zs_novablaster"] 							= {"comp_basicecore",		"weapon_zs_magnum"}
GM.Assemblies["weapon_zs_tithonus"] 							= {"comp_contaecore",		"weapon_zs_oberon"}
GM.Assemblies["weapon_zs_fracture"] 							= {"comp_pumpaction",		"weapon_zs_sawedoff"}
GM.Assemblies["weapon_zs_seditionist"] 							= {"comp_focusbarrel",		"weapon_zs_deagle"}
GM.Assemblies["weapon_zs_molotov"] 								= {"comp_propanecan",		"weapon_zs_glassbottle"}
GM.Assemblies["weapon_zs_blareduct"] 							= {"trinket_ammovestii",	"weapon_zs_megamasher"}
GM.Assemblies["weapon_zs_cinderrod"] 							= {"trinket_classixsoul",		"weapon_zs_blareduct"}
GM.Assemblies["weapon_zs_innervator"] 							= {"comp_electrobattery",	"weapon_zs_jackhammer"}
GM.Assemblies["weapon_zs_hephaestus"] 							= {"comp_gaussframe",		"weapon_zs_tithonus"}
GM.Assemblies["weapon_zs_stabber"] 								= {"comp_shortblade",		"weapon_zs_annabelle"}
GM.Assemblies["weapon_zs_galestorm"] 							= {"comp_multibarrel",		"weapon_zs_uzi"}
GM.Assemblies["weapon_zs_eminence"] 							= {"trinket_ammovestiii",	"weapon_zs_barrage"}
GM.Assemblies["weapon_zs_gladiator"] 							= {"trinket_ammovestiii",	"weapon_zs_sweepershotgun"}
GM.Assemblies["weapon_zs_ripper"]								= {"comp_sawblade",			"weapon_zs_zeus"}
GM.Assemblies["weapon_zs_crymam"]								= {"comp_mommy",	"weapon_zs_cry"}
GM.Assemblies["weapon_zs_cry"]								= {"comp_mommy",	"weapon_zs_cryman"}
GM.Assemblies["weapon_zs_asmd"]									= {"comp_precision",		"weapon_zs_quasar"}
GM.Assemblies["weapon_zs_enkindler"]							= {"comp_launcher",			"weapon_zs_cinderrod"}
GM.Assemblies["weapon_zs_proliferator"]							= {"comp_linearactuator",	"weapon_zs_galestorm"}
GM.Assemblies["weapon_zs_graveshovel"]						 	= {"comp_linearactuator",	"weapon_zs_shovel"}
GM.Assemblies["trinket_superstore"]						  	   = {"trinket_store",	     "trinket_store2"}
GM.Assemblies["trinket_electromagnet"]							= {"comp_electrobattery",	"trinket_magnet"}
GM.Assemblies["trinket_projguide"]								= {"comp_cpuparts",			"trinket_targetingvisori"}
GM.Assemblies["trinket_projwei"]								= {"comp_busthead",			"trinket_projguide"}
GM.Assemblies["trinket_controlplat"]							= {"comp_cpuparts",			"trinket_mainsuite"}
GM.Assemblies["weapon_zs_classixx"]				 		    	= {"trinket_classixsoul",			"weapon_zs_classic"}
GM.Assemblies["trinket_classixsoul"]							= {"comp_cpuparts",			"comp_scoper"}
GM.Assemblies["comp_scoper"]						        	= {"trinket_electromagnet",	"trinket_classix"}
GM.Assemblies["weapon_zs_cryman"] 				     			= {"comp_gaussframe",		"weapon_zs_hyena"}
GM.Assemblies["trinket_invalid"]						        	= {"trinket_classil",	"trinket_analgestic"}
GM.Assemblies["weapon_zs_m5"]						        	= {"comp_sacred_soul",	"weapon_zs_m4"}
GM.Assemblies["trinket_aposoul"]				        	= {"trinket_targetingvisori",	"trinket_blanksoul"}
GM.Assemblies["trinket_greedsoul"]						        	= {"trinket_superstore",	"trinket_blanksoul"}
GM.Assemblies["trinket_evesoul"]						        	= {"trinket_bloodpack",	"trinket_blanksoul"}
GM.Assemblies["weapon_zs_singurhammer"] 						= {"trinket_electromagnet",	"weapon_zs_electrohammer"}
GM.Assemblies["weapon_zs_megaray"] 						= {"trinket_soulmedical",	"weapon_zs_healingray"}
GM.Assemblies["weapon_zs_manhack_saw"] 						= {"trinket_aposoul",	"weapon_zs_manhack"}


GM:AddInventoryItemData("comp_modbarrel",		"Modular Barrel",			"A modular barrel suited for pairing up with another gun barrel.",								"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_burstmech",		"Burst Fire Mechanism",		"A mechanism that could be used to make a gun burst fire.",										"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_basicecore",		"Basic Energy Core",		"A small energy core. Needs a weapon with a cylinder mechanism to contain the energy output.",	"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_busthead",		"Bust Head",				"A bust head that could be fitted on to something handle shaped.",								"models/props_combine/breenbust.mdl")
GM:AddInventoryItemData("comp_sawblade",		"Saw Blade",				"A sharp saw blade ready to be fitted onto fast moving objects.",								"models/props_junk/sawblade001a.mdl")
GM:AddInventoryItemData("comp_propanecan",		"Propane Canister",			"A propane canister. With the correct setup, has the potential to ignite things.",				"models/props_junk/propane_tank001a.mdl")
GM:AddInventoryItemData("comp_electrobattery",	"Electrobattery",			"An electrobattery. Could be used to improve repairing motions.",								"models/items/car_battery01.mdl")
--GM:AddInventoryItemData("comp_hungrytether",	"Hungry Tether",			"A hungry tether from a devourer that comes from a devourer rib.",								"models/gibs/HGIBS_rib.mdl")]]
GM:AddInventoryItemData("comp_contaecore",		"Contained Energy Core",	"A contained energy core, that has an internal charging mechanism.",							"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_pumpaction",		"Pump Action Mechanism",	"A standard pump action mechanism from a blaster shotgun.",										"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_focusbarrel",		"Focused Barrel",			"A large focused barrel made from the barrels of the waraxe. Suitable for a handcannon.",		"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_gaussframe",		"Gauss Frame",				"A highly advanced gauss frame. It's almost alien in design, making it hard to use.",			"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_metalpole",		"Metal Pole",				"Long metal pole that could be used to attack things from a distance.",							"models/props_c17/signpole001.mdl")
GM:AddInventoryItemData("comp_salleather",		"Salvaged Leather",			"Pieces of leather that are hard enough to make a nasty impact.",								"models/props_junk/shoe001.mdl")
GM:AddInventoryItemData("comp_gyroscope",		"Gyroscope",				"A metal gyroscope used to calculate orientation.",												"models/maxofs2d/hover_rings.mdl")
GM:AddInventoryItemData("comp_reciever",		"Reciever",					"A radio reciever. Could be used for automation and communication purposes.",					"models/props_lab/reciever01b.mdl")
GM:AddInventoryItemData("comp_cpuparts",		"CPU Parts",				"Parts from a central processor.",																"models/props_lab/harddrive01.mdl")
GM:AddInventoryItemData("comp_launcher",		"Launching Tube",			"A metal tube made to launch objects.",															"models/weapons/w_rocket_launcher.mdl")
GM:AddInventoryItemData("comp_launcherh",		"Heavy Launching Tube",		"A heavy metal tube made to launch large objects.",												"models/weapons/w_rocket_launcher.mdl")
GM:AddInventoryItemData("comp_shortblade",		"Short Blade",				"A short metal blade for cutting and stabbing.",												"models/weapons/w_knife_t.mdl")
GM:AddInventoryItemData("comp_multibarrel",		"Multi-Bored Barrel",		"An unusual gun barrel which allows multiple bullets to pass through.",							"models/props_lab/pipesystem03a.mdl")
GM:AddInventoryItemData("comp_holoscope",		"Holographic Scope",		"A holographic weapon sight with magnification.",												{
	["base"] = { type = "Model", model = "models/props_c17/utilityconnecter005.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.273, 1.728, -0.843), angle = Angle(74.583, 180, 0), size = Vector(2.207, 0.105, 0.316), color = Color(50, 50, 66, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.492, -1.03, 0), angle = Angle(0, -78.715, 90), size = Vector(0.03, 0.02, 0.032), color = Color(50, 50, 66, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} }
})
GM:AddInventoryItemData("comp_scoper",		"Scopy",		"Heh for classix.",												{
	["base"] = { type = "Model", model = "models/props_c17/utilityconnecter005.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.273, 1.728, -0.843), angle = Angle(74.583, 180, 0), size = Vector(2.207, 0.105, 0.316), color = Color(50, 50, 66, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.492, -1.03, 0), angle = Angle(0, -78.715, 90), size = Vector(0.03, 0.02, 0.032), color = Color(50, 50, 66, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} }
})
GM:AddInventoryItemData("comp_linearactuator",	"Linear Actuator",			"A linear actuator from a shell holder. Requires a heavy base to mount properly.",				"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_pulsespool",		"Pulse Spool",				"Used to inject more pulse power to a system. Could be used to stabilise something.",			"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_flak",			"Flak Chamber",				"An internal chamber for projecting heated scrap.",												"models/weapons/w_rocket_launcher.mdl")
GM:AddInventoryItemData("comp_precision",		"Precision Chassis",		"A suite setup for rewarding precise shots on moving targets.",									"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_mommy",		"Mommy",		"Mom from Cryman.",									"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_sacred_soul",		"Sacred Soul",		"This sacred cartridge...",									"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_bloodhack",		"Bloody Hadck",		"djasnndwhadjajs||daw...",									"models/Items/combine_rifle_cartridge01.mdl")


-- Trinkets
local trinket, description, trinketwep
local hpveles = {
	["ammo"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 3.5, 3), angle = Angle(15.194, 80.649, 180), size = Vector(0.6, 0.6, 1.2), color = Color(145, 132, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local hpweles = {
	["ammo"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 2.5, 3), angle = Angle(15.194, 80.649, 180), size = Vector(0.6, 0.6, 1.2), color = Color(145, 132, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local ammoveles = {
	["ammo"] = { type = "Model", model = "models/props/de_prodigy/ammo_can_02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 3, -0.519), angle = Angle(0, 85.324, 101.688), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local ammoweles = {
	["ammo"] = { type = "Model", model = "models/props/de_prodigy/ammo_can_02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 2, -1.558), angle = Angle(5.843, 82.986, 111.039), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local mveles = {
	["band++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(2.599, 1, 1), angle = Angle(0, -25, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 3, -1), angle = Angle(97.013, 29.221, 0), size = Vector(0.045, 0.045, 0.025), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(-2.401, -1, 0.5), angle = Angle(0, 155.455, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} }
}
local mweles = {
	["band++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(2.599, 1, 1), angle = Angle(0, -25, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(-2.401, -1, 0.5), angle = Angle(0, 155.455, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 2, -0.5), angle = Angle(111.039, -92.338, 97.013), size = Vector(0.045, 0.045, 0.025), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} }
}
local pveles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, -2.597), angle = Angle(5.843, 90, 0), size = Vector(0.25, 0.15, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local pweles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 0.5, -2), angle = Angle(5, 90, 0), size = Vector(0.25, 0.15, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local oveles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.799, 2, -1.5), angle = Angle(5, 180, 0), size = Vector(0.05, 0.039, 0.07), color = Color(196, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local oweles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.799, 2, -1.5), angle = Angle(5, 180, 0), size = Vector(0.05, 0.039, 0.07), color = Color(196, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local develes = {
	["perf"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.799, 2.5, -5.715), angle = Angle(5, 180, 0), size = Vector(0.1, 0.039, 0.09), color = Color(168, 155, 0, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal", skin = 0, bodygroup = {} }
}
local deweles = {
	["perf"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 2, -5.715), angle = Angle(0, 180, 0), size = Vector(0.1, 0.039, 0.09), color = Color(168, 155, 0, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal", skin = 0, bodygroup = {} }
}
local supveles = {
	["perf"] = { type = "Model", model = "models/props_lab/reciever01c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.299, 2.5, -2), angle = Angle(5, 180, 92.337), size = Vector(0.2, 0.699, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local supweles = {
	["perf"] = { type = "Model", model = "models/props_lab/reciever01c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.5, -2), angle = Angle(5, 180, 92.337), size = Vector(0.2, 0.699, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local book = {
	["perf"] = { type = "Model", model = "models/props_lab/binderblue.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.5, -2), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local bookw = {
	["perf"] = { type = "Model", model = "models/props_lab/binderblue.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.5, -2), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
-- some text
-- Health Trinkets
trinket, trinketwep = GM:AddTrinket(""..translate.Get("t_healthpack"), "vitpackagei", false, hpveles, hpweles, 2, ""..translate.Get("t_d_healthpack"))
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 10)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 0.09)
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket(""..translate.Get("t_vbank"), "vitpackageii", false, hpveles, hpweles, 4, ""..translate.Get("t_d_vbank"))
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 20)
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR_DMG_REDUCTION, -0.03)

trinket = GM:AddTrinket(""..translate.Get("t_truepill"), "pills", false, hpveles, hpweles, 4, ""..translate.Get("t_d_truepill"))
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 10)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 0.11)
--trinket = GM:AddTrinket("Damage", "damage222", false, hpveles, hpweles, 4, "+10% damage melee ")
--GM:AddWeaponModifier(trinket, WEAPON_MODIFIER_DAMAGE, 3)


trinket = GM:AddTrinket(""..translate.Get("t_richeye"), "greedeye", false, hpveles, hpweles, 4, ""..translate.Get("t_d_richeye"))
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS, 20)
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, 0.05)

trinket = GM:AddTrinket(""..translate.Get("t_bara"), "classil", false, hpveles, hpweles, 4, ""..translate.Get("t_d_bara"))
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 60)
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR_DMG_REDUCTION, 0.09)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, -5)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, -0.35)

trinket, trinketwep = GM:AddTrinket(""..translate.Get("t_bloodpack"), "bloodpack", false, hpveles, hpweles, 2, ""..translate.Get("t_d_bloodpack"), nil, 15)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket(""..translate.Get("t_bloodpacki"), "cardpackagei", false, hpveles, hpweles, 2, ""..translate.Get("t_d_bloodpacki"))
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 20)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.07)
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket(""..translate.Get("t_bloodpackii"), "cardpackageii", false, hpveles, hpweles, 4, ""..translate.Get("t_d_bloodpackii"))
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 20)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.12)

GM:AddTrinket(""..translate.Get("t_regimp"), "regenimplant", false, hpveles, hpweles, 3, ""..translate.Get("t_d_regimp"))

trinket, trinketwep = GM:AddTrinket(""..translate.Get("t_bioclean"), "biocleanser", false, hpveles, hpweles, 2, ""..translate.Get("t_d_bioclean"))
trinketwep.PermitDismantle = true

GM:AddSkillModifier(GM:AddTrinket(""..translate.Get("t_cutset"), "cutlery", false, hpveles, hpweles, nil, ""..translate.Get("t_d_cutset")), SKILLMOD_FOODEATTIME_MUL, -0.8)
trinket, trinketwep = GM:AddTrinket(""..translate.Get("t_killer"), "killer", false, hpveles, hpweles, 2, ""..translate.Get("t_d_killer"))
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 110)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, -50)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.37)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.50)
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR_DMG_REDUCTION, 0.21)
trinketwep.PermitDismantle = true
trinket, trinketwep = GM:AddTrinket("Status", "via", false, hpveles, hpweles, 2, "Vera Via,bloodoarmoro +50")
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 50)
trinket, trinketwep = GM:AddTrinket("Status", "via1", false, hpveles, hpweles, 2, "Vera Via,bloodoarmoro +30")
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 30)
trinket, trinketwep = GM:AddTrinket("Status", "via2", false, hpveles, hpweles, 2, "Vera Via,bloodoarmoro +40")
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 40)
trinket, trinketwep = GM:AddTrinket("Status", "via3", false, hpveles, hpweles, 2, "Vera Via,bloodoarmoro +10")
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 10)

-- Hohol
trinket, trinketwep = GM:AddTrinket("Сало", "salo", false, mveles, mweles, 2, "Доигрались хохлы?")

trinketwep.PermitDismantle = true
-- Melee Trinkets

description = ""..translate.Get("t_d_box")
trinket = GM:AddTrinket(""..translate.Get("t_box"), "boxingtraining", false, mveles, mweles, nil, description)
GM:AddSkillModifier(trinket, SKILLMOD_UNARMED_SWING_DELAY_MUL, -0.25)
GM:AddSkillFunction(trinket, function(pl, active) pl.BoxingTraining = active end)

trinket, trinketwep = GM:AddTrinket(""..translate.Get("t_momentsup"), "momentumsupsysii", false, mveles, mweles, 2, ""..translate.Get("t_d_momentsup"))
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.09)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.10)
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket(""..translate.Get("t_momentsupi"), "momentumsupsysiii", false, mveles, mweles, 3, ""..translate.Get("t_d_momentsupi"))
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.13)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.12)

GM:AddSkillModifier(GM:AddTrinket(""..translate.Get("t_hemoad"), "hemoadrenali", false, mveles, mweles, nil, ""..translate.Get("t_d_hemoad")), SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.06)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.02)

trinket = GM:AddTrinket(""..translate.Get("t_hemoadi"), "hemoadrenalii", false, mveles, mweles, 3, ""..translate.Get("t_d_hemoadi"))
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.13)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, 44)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.05)
trinket = GM:AddTrinket(""..translate.Get("t_damager"), "damage222", false, mveles, mweles, 3, ""..translate.Get("t_d_damager"))
GM:AddSkillModifier(trinket, SKILLMOD_DAMAGE, 0.90)

trinket = GM:AddTrinket("Thermia", "flashlo", false, mveles, mweles, 3, "+8% blood armor convert and you take by 7% more damage,+55 speed\n+8% Конвертации кровавой брони от удара\n Вы получаете на 16% Больше урона,+55 к скорости")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.08)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.07)
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, 55)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, 55)

GM:AddSkillModifier(GM:AddTrinket("Hemo-Adrenal Converter II", "hemoadrenaliii", false, mveles, mweles, 4, "+22% blood armor convert.\n +22% К Конвертации кровавой брони"), SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.22)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.04)
GM:AddSkillModifier(GM:AddTrinket("AntiThermia", "sharpkt", false, mveles, mweles, 4, "-8% blood armor convert, -999% speed when you kill zombie on time, and you take by 5% less damage.\n -8% К конвертации кровавой брони,-999% К скорости при убийстве зомби,на 5% меньше получаемый урон"), SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, -0.09)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, -0.08)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, -280)

GM:AddSkillModifier(GM:AddTrinket("Power Gauntlet", "powergauntlet", false, mveles, mweles, 3, "Charges your melee damage up to +45% with each hit\nMissing resets damage\n Заряжает каждый удар на 45% за каждое попадание,сбрасывает счетчик при пропуске"), SKILLMOD_MELEE_POWERATTACK_MUL, 0.45)

GM:AddTrinket("Finesse Kit", "sharpkit", false, mveles, mweles, 2, "Deal up to +32% melee damage to slowed zombies\n +32% мили урона замедленным зомби")


GM:AddTrinket("Sharp Stone", "sharpstone", false, mveles, mweles, 3, "+5% melee damage\n +5% К мили урону")
--perfomance
GM:AddSkillModifier(GM:AddTrinket("Adrenaline", "adrenaline", false, pveles, pweles, nil, "Each hit on you gives 15 seconds of buffs.\nКаждый удар по вам будет давать 15 сек баффов"), SKILLMOD_JUMPPOWER_MUL, 0.01)
GM:AddSkillModifier(GM:AddTrinket("Forgotten Ascorbic Acid", "ass", false, pveles, pweles, nil, "+6 health,-2% Accuracy.\n+6 хп,-2% К аккуратности"), SKILLMOD_HEALTH, 6)
trinket = GM:AddTrinket("Sports armband", "sarmband", true, pveles, pweles, 2, "+4% Jump Power\n+4% К прыжку")
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.04)
trinket = GM:AddTrinket("Engineer Gaming", "engineer", true, pveles, pweles, 2, "+12% Deployable convert speed\n+12% К складыванию деплояблов")
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYABLE_PACKTIME_MUL, 0.12)
trinket = GM:AddTrinket("Scout Gaming", "scout", true, pveles, pweles, 2, "+10 speed\n+10 к скорости")
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, 10)
trinket = GM:AddTrinket("Broken hammer", "scour", true, pveles, pweles, 2, "+30% repair hammer,-15% Point multiplier\n+30% к силе починке,-15% К поинтам")
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, -0.15)
GM:AddSkillModifier(trinket, SKILLMOD_REPAIRRATE_MUL,  0.30)

-- Performance Trinkets
GM:AddTrinket("Oxygen Tank", "oxygentank", true, nil, {
	["base"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 3, -1), angle = Angle(180, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, nil, "10x breathing time underwater.\n 10x к времени под водой", "oxygentank")

GM:AddSkillModifier(GM:AddTrinket("Acrobat Frame", "acrobatframe", false, pveles, pweles, nil, "+8% jump power.\n +8% К силе прыжка"), SKILLMOD_JUMPPOWER_MUL, 0.08)

trinket = GM:AddTrinket("Night Vision Goggles", "nightvision", true, pveles, pweles, 2, "-20% effect of dim vision and ability to see in the dark\n-20% effect of vision affecting effects\n-45% fright duration\n -20% К эффективности ослепления,дает способность видеть во тьме\n -20% К другим эффектам влияющим на зрение\n -45% К длительности испуга")
GM:AddSkillModifier(trinket, SKILLMOD_DIMVISION_EFF_MUL, -0.20)
GM:AddSkillModifier(trinket, SKILLMOD_FRIGHT_DURATION_MUL, -0.20)
GM:AddSkillModifier(trinket, SKILLMOD_VISION_ALTER_DURATION_MUL, -0.2)
GM:AddSkillFunction(trinket, function(pl, active)
	if CLIENT and pl == MySelf and GAMEMODE.m_NightVision and not active then
		surface.PlaySound("items/nvg_off.wav")
		GAMEMODE.m_NightVision = false
	end
end)
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket("Portable Weapons Satchel", "portablehole", false, pveles, pweles, nil, "+15% deployable speed convert, reload speed 3% and sale by 1%\n -15% К времени подбиранию деплоябла,перезарядка увеличена на 3%")
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYSPEED_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.03)
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.01)

trinket = GM:AddTrinket("Agility Magnifier", "pathfinder", false, pveles, pweles, 2, "+55% Phase Speed multipier\n-45% by the time of teleportation\n+20% jump power\n+55% скорости в фазе перехода между баррикадами\n-45% к скорости телепортирования сигила \n+20% силе прыжка")
GM:AddSkillModifier(trinket, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.55)
GM:AddSkillModifier(trinket, SKILLMOD_SIGIL_TELEPORT_MUL, -0.45)
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.2)

trinket = GM:AddTrinket("Store", "store", false, pveles, pweles, 2, "Sale by 4%\n Скидка в 4%")
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.04)
trinket = GM:AddTrinket("Upgraded Store", "superstore", false, pveles, pweles, 2, "Sale by 5%\n Скидка в 5%")
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.05)
trinket = GM:AddTrinket("Credit Card", "store2", false, pveles, pweles, 2, "Sale by 3%\n Скидка в 3%")
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.03)

trinket = GM:AddTrinket("Galvanizer Implant", "analgestic", false, pveles, pweles, 3, "-50% Slow effect multiplier\n-50% Low hp slow multiplier\n-70% кулдаун падения\n-66% duration of pulling attacks\n+25% weapon switch speed\n -70% To time for ragdoll debuff\n-50% замедления от неполного хп\n-70% кулдаун падения")
GM:AddSkillModifier(trinket, SKILLMOD_SLOW_EFF_TAKEN_MUL, -0.50)
GM:AddSkillModifier(trinket, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.50)
GM:AddSkillModifier(trinket, SKILLMOD_KNOCKDOWN_RECOVERY_MUL, -0.7)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYSPEED_MUL, 0.25)
trinket = GM:AddTrinket("INVALID", "invalid", false, pveles, pweles, 3, "baracat  sucks dicks,you have immune to knockdown\n Ебанный баракот сосет,иммунитет к дебаффу падения")
GM:AddSkillModifier(trinket, SKILLMOD_KNOCKDOWN_RECOVERY_MUL, -0.6)

trinket = GM:AddTrinket("Credit", "kre", false, pveles, pweles, 3, "Sale by 4%\n Скидка в 4%")
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.04)

GM:AddSkillModifier(GM:AddTrinket("Ammo Vest", "ammovestii", false, ammoveles, ammoweles, 2, "+7% reload speed\n +7% К скорости перезарядки"), SKILLMOD_RELOADSPEED_MUL, 0.07)
GM:AddSkillModifier(GM:AddTrinket("Ammo Bandolier", "ammovestiii", false, ammoveles, ammoweles, 4, "+11% Reload speed\n+11% К скорости перезарядки"), SKILLMOD_RELOADSPEED_MUL, 0.11)
GM:AddSkillModifier(GM:AddTrinket("Side Sadle", "sammovest", false, ammoveles, ammoweles, 4, "+16% Reload speed\n+16% К скорости перезарядки"), SKILLMOD_RELOADSPEED_MUL, 0.16)
GM:AddSkillModifier(GM:AddTrinket("Classic Tutorial on reload", "classix", false, book, bookw, 4, "+16% Reload speed\n+16% К скорости перезарядки "), SKILLMOD_RELOADSPEED_MUL, 0.16)

GM:AddTrinket("Automated Reloader", "autoreload", false, ammoveles, ammoweles, 2, "Reload weapon every 4 seconds\n Перезаряжает оружие каждые 4 секунды")

-- Offensive Implants
GM:AddSkillModifier(GM:AddTrinket("Targeting Visor", "targetingvisori", false, oveles, oweles, nil, "+6% accuracy\n +6% к аккуратности."), SKILLMOD_AIMSPREAD_MUL, -0.06)

GM:AddSkillModifier(GM:AddTrinket("Targeting Unifier", "targetingvisoriii", false, oveles, oweles, 4, "+11% accuracy.\n +11% к аккуратности"), SKILLMOD_AIMSPREAD_MUL, -0.11)

GM:AddTrinket("Refined Subscope", "refinedsub", false, oveles, oweles, 4, "+27% Accuracy if weapon tier 3 or lower\n+27% к точности если тир оружия 3 или меньше")

trinket = GM:AddTrinket("Aim Compensator", "aimcomp", false, oveles, oweles, 3, "-52% to strenght aim shake\n+11% accuracy\n You can see hp zombie\n-52% к силе тряски\n+11% к точности \nВы видите здоровье зомби")
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, -0.11)
GM:AddSkillModifier(trinket, SKILLMOD_AIM_SHAKE_MUL, -0.52)
GM:AddSkillFunction(trinket, function(pl, active) pl.TargetLocus = active end)

GM:AddSkillModifier(GM:AddTrinket("Pulse Booster", "pulseampi", false, oveles, oweles, nil, "+14% to pulse slowdown\n+14% к замедлению от пульс оружия"), SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.14)

trinket = GM:AddTrinket("Pulse Infuser", "pulseampii", false, oveles, oweles, 3, "+14% to pulse slowdown\n+22% to explosive radius\n+20% к замедлению от пульс оружия\n+22% радиус взрыва")
GM:AddSkillModifier(trinket, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.2)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_RADIUS, 0.22)

trinket = GM:AddTrinket("Resonance Cascade Device", "resonance", false, oveles, oweles, 4, "When you deal enough damage to the pulse there is a chance of an explosion\n -11% pulse slowdown\nКогда вы наносите достачный урон то есть шанс взрыва\n-11% к замедлению пульс оружия")
GM:AddSkillModifier(trinket, SKILLMOD_PULSE_WEAPON_SLOW_MUL, -0.11)

trinket = GM:AddTrinket("Cryogenic Inductor", "cryoindu", false, oveles, oweles, 4, "Ice weapon can blow up zombie\nThe explosion is based on zombie hp\nЛедянное оружие может взорвать зомби,взрыв основан на хп зомби ")

trinket = GM:AddTrinket("Extended Magazine", "extendedmag", false, oveles, oweles, 3, "Increases the maximum clip if it has 8 or more rounds by +15%\nУвеличивает максимальный боезапас если в нем 8 или больше патрон на +15%")

trinket = GM:AddTrinket("Pulse Impedance Module", "pulseimpedance", false, oveles, oweles, 5, "Slowing down the pulse with a weapon slows down the zombie attack speed\n+24% to pulse slowdown\nЗамедление пульс оружием замедляет скорость атаки зомби\n+24% к замедлению пульс оружием")
GM:AddSkillFunction(trinket, function(pl, active) pl.PulseImpedance = active end)
GM:AddSkillModifier(trinket, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.24)

trinket = GM:AddTrinket("Curb Stompers", "curbstompers", false, oveles, oweles, 2, "Instantly kills headcrabs deals 50 damage to the thor class you jumped on \ndeals 300% damage from falling on the zombie you fell on\nyou will not be able to receive damage from falling when you fall on a zombie\t-25% Deceleration after falling\nМоментально убивает хедкрабов наносит 50 урона к торс классу на которого вы прыгнули \nНаносит 300% Урона от падения на зомби на которого вы упали\nВы не сможете получить урон от падения когда упадете на зомби\n-25% Замедлению после падения")
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, -0.25)

GM:AddTrinket("Superior Assembly", "supasm", false, oveles, oweles, 5, "Increase weapon damage if weapon tier 2 or lower\nУвеличивает урон оружия если тир 2 или выше")

trinket = GM:AddTrinket("Olympian Frame", "olympianframe", false, oveles, oweles, 2, "+100% object throwing strength\n-25% prop carrying slow down\n-35% movement speed reduction with heavy weapons +3 points to end wave\n +100% К силе броска,-25% К замедлению от несения пропа,-35% К замедлению от тяжолово оружия\n+3 к поинтам под конец волны")
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS, 3)
GM:AddSkillModifier(trinket, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.25)
GM:AddSkillModifier(trinket, SKILLMOD_WEAPON_WEIGHT_SLOW_MUL, -0.35)


-- Defensive Trinkets
trinket, trinketwep = GM:AddTrinket("Kevlar underbody", "kevlar", false, develes, deweles, 2, "-6% melee damage taken\n-11% projectile damage taken\n-6% полученного урона в ближнем бою\n-11% полученного урона от снаряда")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.06)
GM:AddSkillModifier(trinket, SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL, -0.11)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, -0.01)
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket("Barbed Armor", "barbedarmor", false, develes, deweles, 3, "50% of melee damage taken reflected back to melee attackers\nAdditional 10 damage reflected back to melee attackers\nMelee attackers take 30 arm damage\n-4% melee damage taken and you take +3point to end wave\50% полученного урона в ближнем бою отражается атакующим в ближнем бою\nДополнительно 20 урона отражается атакующим в ближнем бою\nАтакующие в ближнем бою получают 30 урона от руки\n-4% полученного урона в ближнем бою, и вы получаете на 3 поинта больше под конец волны")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT, 11)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT, 0.5)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.04)
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS, 3)

trinket = GM:AddTrinket("Antitoxin Package", "antitoxinpack", false, develes, deweles, 2, "-17% poison damage taken\n-40% poison damage over time speed\n-17% полученного урона от яда\n-40% урона от яда с течением времени скорость")
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.17)
GM:AddSkillModifier(trinket, SKILLMOD_POISON_SPEED_MUL, -0.4)

trinket = GM:AddTrinket("Hemostasis Implant", "hemostasis", false, develes, deweles, 2, "-30% bleed damage taken\n-60% bleeding speed.\n-30% нанесенного урона от кровотечения\n-60% скорости кровотечения.")
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, -0.3)
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_SPEED_MUL, -0.6)

trinket = GM:AddTrinket("EOD Vest", "eodvest", false, develes, deweles, 4, "-35% explosive damage taken\n-50% fire damage taken\n-13% self damage taken\n-35% нанесенного урона от взрыва по себе \n-50% нанесенного урона от огня по себе\n-13% нанесенного себе вреда")
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, -0.35)
GM:AddSkillModifier(trinket, SKILLMOD_FIRE_DAMAGE_TAKEN_MUL, -0.50)
GM:AddSkillModifier(trinket, SKILLMOD_SELF_DAMAGE_MUL, -0.13)

trinket = GM:AddTrinket("Feather Fall Frame", "featherfallframe", false, develes, deweles, 3, "-65% fall damage taken\n+30% fall damage threshold\n-75% slow down from landing or fall damage\n--65% полученного урона при падении\n+30% порога урона при падении\n75% замедление от приземления или урона при падении")
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_DAMAGE_MUL, -0.65)
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_THRESHOLD_MUL, 0.30)
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, -0.75)

trinket = GM:AddTrinket("Супер-Скидка", "stopit", false, develes, deweles, 3, "Sale by 9%\nдает скидку в 9%")
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.09)

trinketwep.PermitDismantle = true

local eicev = {
	["base"] = { type = "Model", model = "models/gibs/glass_shard04.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.339, 2.697, -2.309), angle = Angle(4.558, -34.502, -72.395), size = Vector(0.5, 0.5, 0.5), color = Color(0, 137, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

local eicew = {
	["base"] = { type = "Model", model = "models/gibs/glass_shard04.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.556, 2.519, -1.468), angle = Angle(0, -5.844, -75.974), size = Vector(0.5, 0.5, 0.5), color = Color(0, 137, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

GM:AddTrinket("Iceburst Shield", "iceburst", false, eicev, eicew, nil, "Releases an ice burst when taking a melee hit, slowing zombies down\nRecharges every 40 seconds\nВыпускает ледянной всплеск при получения урона, замедляя зомби\nперезаряжается каждые 40 секунд")

GM:AddSkillModifier(GM:AddTrinket("Force Dampening Field Emitter", "forcedamp", false, develes, deweles, 2, "-33% physics impact damage taken\nImmune to knockdowns from props\nTake normal physics damage from shades.\n -33% урона от урона физическим оружием по себе\nневосприимчив к нокдаунам от пропа\nВы получаете обычный урон от шейда."), SKILLMOD_PHYSICS_DAMAGE_TAKEN_MUL, -0.33)

GM:AddSkillFunction(GM:AddTrinket("Necrotic Senses Distorter", "necrosense", false, develes, deweles, 2, "Hides aura from zombies in close proximity\n Вы скрываеет свою ауру от зомби когда они рядом"), function(pl, active) pl:SetDTBool(DT_PLAYER_BOOL_NECRO, active) end)

trinket, trinketwep = GM:AddTrinket("Reactive Flasher", "reactiveflasher", false, develes, deweles, 2, "Blinds and disorients melee attacker for 2 seconds\nRecharges every 75 seconds\nОслепляет и дезориентирует атакующего в ближнем бою на 2 секунды\nперезаряжается каждые 75 секунд")
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket("Composite Underlay", "composite", false, develes, deweles, 4, "-11% melee damage taken\n-16% projectile damage taken and you take -7% blood armor convert\n-11% полученного урона в ближнем бою\n-16% полученного урона от снаряда, и вы получаете -7% преобразования кровавой брони")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.11)
GM:AddSkillModifier(trinket, SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL, -0.16)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, -0.07)

trinket = GM:AddTrinket("Diamond armor", "toysite", false, develes, deweles, 4, "You get 9% less damage, but the blood armor is ineffective, it is produced in 10%,you can stump headcrabs\nВы получаете на 9% меньше урона но кровавая броня неэффективна вырабатываеться в 10%,вы можете давить крабов")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.09)
GM:AddSkillModifier(trinket, SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL, -0.21)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.10)

-- Support Trinkets
trinket, trinketwep = GM:AddTrinket("Arsenal Pack", "arsenalpack", false, {
	["base"] = { type = "Model", model = "models/Items/item_item_crate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -1), angle = Angle(0, -90, 180), size = Vector(0.35, 0.35, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, {
	["base"] = { type = "Model", model = "models/Items/item_item_crate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -1), angle = Angle(0, -90, 180), size = Vector(0.35, 0.35, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, 4, "Allows nearby humans to purchase from the arsenal menu.\n Компактный Арсенал,вы можете закупаться везде!", "arsenalpack", 3)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Resupply Pack", "resupplypack", true, nil, {
	["base"] = { type = "Model", model = "models/Items/ammocrate_ar2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -1), angle = Angle(0, -90, 180), size = Vector(0.35, 0.35, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, 4, "Allows humans to resupply from you\nPress LMB with the pack in your hand to resupply yourself.\n Компактный ресапл", "resupplypack", 3)
trinketwep.PermitDismantle = true

GM:AddTrinket("Magnet", "magnet", true, supveles, supweles, nil, "Slowly pulls ammo and weapons towards you\nMust be equipped to take effect\n Быстро притягивает луты к вам!(работает только когда вы держите магнит)", "magnet")
GM:AddTrinket("Electromagnet", "electromagnet", true, supveles, supweles, nil, "Pulls ammo and weapons towards you quickly\nMust be equipped to take effect\nБыстро притягивает луты к вам!", "magnet_electro")

trinket, trinketwep = GM:AddTrinket("Loading Exoskeleton", "loadingex", false, supveles, supweles, 2, "-55% prop carrying slow down\n-20% deployable pack time and you take +2 to end wave")
GM:AddSkillModifier(trinket, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.55)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYABLE_PACKTIME_MUL, -0.2)
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS, 2)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Blueprints", "blueprintsi", false, supveles, supweles, 2, "+10% repair rate\n +10% К силе починке")
GM:AddSkillModifier(trinket, SKILLMOD_REPAIRRATE_MUL, 0.10)
trinketwep.PermitDismantle = true

GM:AddSkillModifier(GM:AddTrinket("Advanced Blueprints", "blueprintsii", false, supveles, supweles, 4, "+20% repair rate\n +10% К силе починке"), SKILLMOD_REPAIRRATE_MUL, 0.20)

trinket, trinketwep = GM:AddTrinket("Medical Processor", "processor", false, supveles, supweles, 2, "-10% medic kit cooldown\n-60% medic tool fire delay\nReprocess food into medical ammo with right click")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.10)
GM:AddSkillModifier(trinket, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.6)

trinket = GM:AddTrinket("Curative Kit", "curativeii", false, supveles, supweles, 3, "-20% medic kit cooldown\n-15% medic tool fire delay")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.20)
GM:AddSkillModifier(trinket, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.15)

trinket = GM:AddTrinket("Remedial Booster", "remedy", false, supveles, supweles, 3, "+30% medic tool effectiveness\n +30% К эффективности мед инструментов")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.3)

trinket = GM:AddTrinket("Maintenance Suite", "mainsuite", false, supveles, supweles, 2, "+10% zapper and repair field range\n-7% zapper and repair field delay\n+10% turret range")
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_RANGE_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_DELAY_MUL, -0.07)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_RANGE_MUL, 0.1)

trinket = GM:AddTrinket("Control Platform", "controlplat", false, supveles, supweles, 2, "+15% controllable health\n+15% controllable speed\n+50% manhack damage")
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_HEALTH_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_SPEED_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_DAMAGE_MUL, 0.50)

trinket = GM:AddTrinket("Projectile Guidance", "projguide", false, supveles, supweles, 2, "+400% projectile speed")
GM:AddSkillModifier(trinket, SKILLMOD_PROJ_SPEED, 4)

trinket = GM:AddTrinket("Projectile Weight", "projwei", false, supveles, supweles, 2, "-100% projectile speed\n+60% projectile damage")
GM:AddSkillModifier(trinket, SKILLMOD_PROJ_SPEED, -1)
GM:AddSkillModifier(trinket, SKILLMOD_PROJECTILE_DAMAGE_MUL, 0.6)

local ectov = {
	["base"] = { type = "Model", model = "models/props_junk/glassjug01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.381, 2.617, 2.062), angle = Angle(180, 12.243, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 4.07), angle = Angle(180, 12.243, 0), size = Vector(0.123, 0.123, 0.085), color = Color(0, 0, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

local ectow = {
	["base"] = { type = "Model", model = "models/props_junk/glassjug01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.506, 1.82, 1.758), angle = Angle(-164.991, 19.691, 8.255), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 4.07), angle = Angle(180, 12.243, 0), size = Vector(0.123, 0.123, 0.085), color = Color(0, 0, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

trinket = GM:AddTrinket("Reactive Chemicals", "reachem", false, ectov, ectow, 3, "+40% explosive damage taken\n+30% explosive damage radius")
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, 0.4)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_RADIUS, 0.3)

trinket = GM:AddTrinket("Operations Matrix", "opsmatrix", false, supveles, supweles, 4, "+15% zapper and repair field range\n-13% zapper and repair field delay\n+85% turret range")
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_RANGE_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_DELAY_MUL, -0.13)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_RANGE_MUL, 0.85)
trinket = GM:AddTrinket("Hate O me", "hateome", false, supveles, supweles, 4, "Fucking boomS x1.9 radius of explosive and -0.4 taken damage by explosive.")
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, -0.4)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_RADIUS, 1.8)
-- Super Trinkets
trinket = GM:AddTrinket("Super Manifest", "sman", false, supveles, supweles, 4, "-19% Ressuply Delay.")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.19)
trinket = GM:AddTrinket("Tutorial for Pro", "stutor", false, book, bookw, 4, "+11% Points Multiplier.")
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.11)
trinket = GM:AddTrinket("Gaben Store", "gstore", false, supveles, supweles, 4, "+18% Arsenal Discount\n  +18% Скидка.")
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.18)
trinket = GM:AddTrinket("FutureBluePrints", "futureblu", false, supveles, supweles, 4, "BluePrint From future!.+30% repair rate\n +30% К силе починке")
GM:AddSkillModifier(trinket, SKILLMOD_REPAIRRATE_MUL, 0.30)
trinket = GM:AddTrinket("Book Of Knowledge", "knowbook", false, book, bookw, 4, "+7% Points Multiplier,+5% Reload Speed.+1% Melee damage.\n+7% К поинтам,+5% К перезарядке,+1% К мили урону")
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.07)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.05)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.01)
trinket = GM:AddTrinket("Bloodlust", "bloodlust", false, book, bookw, 4, "-10 HP,+20% Damage per attack(Reset if miss).\n-10 хп,+20% к мили урону за каждый удар(Сбрасывается при промахе)")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_POWERATTACK_MUL, 0.20)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, -10)
trinket = GM:AddTrinket("Additional Battery", "adbat", false, supveles, supweles, 4, "+50% Reload Speed For Pulse Weapon\n+50% К скорости перезарядки для пульс оружия")
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_PULSE_MUL, 0.50)
trinket = GM:AddTrinket("Mech Arm", "marm", false, supveles, supweles, 4, "+22% Reload Speed\n+22% К скорости перезарядки")
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.22)
trinket = GM:AddTrinket("Steel Shield", "sshield", false, supveles, supweles, 4, "-10% Taken Damage,-6% Reload Speed\n-6% К скорости перезарядки,-10% получаемого урона")
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, -0.06)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.10)

--Special Trinkets
trinket = GM:AddTrinket("Null heart", "nulledher", false, supveles, supweles, 4, "+10% Melee Damage,+20 health,slowly dying after taking damage\n+10% мили урона,+20 хп,медленно умираешь после получения урона")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 20)
trinket = GM:AddTrinket("Heart of the void", "voidheart", false, supveles, supweles, 4, "+25% К мили урону,-30хп\n+25% Melee damage,-30 health")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.25)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, -30)
trinket = GM:AddTrinket("King Heart", "kheart", false, supveles, supweles, 4, "+15% К полученым поинтам,-15хп\n+15% Point Multiplier,-15 health")
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, -15)
trinket = GM:AddTrinket("Cursed Trinket", "cursedtrinket", false, supveles, supweles, 4, "Всегда меняется(+2% К сопротивляемости урону)-2% К множителю,после получения урона получаешь 80 проклятья\nEver Change(-2% damage taken)-2% Points MUL,curse you for 80 secs ")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.02)
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, -0.02)




-- ???
GM:AddSkillModifier(GM:AddTrinket("Acquisitions Manifest", "acqmanifest", false, supveles, supweles, 2, "-6% resupply delay time\n-6% к времени амуниции"), SKILLMOD_RESUPPLY_DELAY_MUL, -0.06)
GM:AddSkillModifier(GM:AddTrinket("Procurement Manifest", "promanifest", false, supveles, supweles, 4, "-15% resupply delay time\n-15% к времени амуниции"), SKILLMOD_RESUPPLY_DELAY_MUL, -0.15)

-- Boss Trinkets

local blcorev = {
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_Spine4", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = true},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0, 0.5, -1.701), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(20, 20, 20, 255), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} },
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_Spine4", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = true}
}

local blcorew = {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(20, 20, 20, 255), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} }
}
local blcorea = {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 9.697, y = 2.3097 }, color = Color(0, 35, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.949, 0.349, 0.349), color = Color(20, 20, 20, 255), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} }
}

GM:AddTrinket("Soul of Judas", "bleaksoul", false, blcorev, blcorew, nil, "Blinds and knocks zombies away when attacked\nRecharges every 15 seconds\nОслепляет и откидывает назад зомби(Которые атаковали вас)\n Перезарядка каждые 15 сек\n Q:2")

trinket = GM:AddTrinket("Soul of ???", "spiritess", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "+22% jump height\n+22% К силе прыжка.")
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.22)

trinket = GM:AddTrinket("Soul of Erwa", "soulmedical", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 9.697, y = 2.3097 }, color = Color(0, 35, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.949, 0.349, 0.349), color = Color(20, 20, 20, 255), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "+15% к силе аптечки,-15% отката аптечки\n+15% Med Effectiveness,-15% Cooldown medkit.\n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.15)
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.15)

trinket = GM:AddTrinket("Samson Soul", "samsonsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(255, 5, 11, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Вы наносите на 10% больше урона мили оружием и получаете в 30% раз больше урона от яда и кровотока.\nYou deal to 10% more melee damage and take by 30% more poison and blood damage\n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, 0.30)
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, 0.30)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.10)

trinket = GM:AddTrinket("Soul of Eve", "evesoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(0, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(0, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Вы наносите на 22% меньше урона мили оружием но яд и кровотечение наносит на 88% меньше урона.\n-22% melee damage but you take by -88% damage from effects\n Q:2")
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.88)
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, -0.88)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, -0.22)

trinket = GM:AddTrinket("Soul of Jacob&Jesau", "jacobjesausoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 5, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 0, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Вы не сможете получать поинты после волны но теперь вы получаете на 20% больше поинтов.\nYou now don't take point's per wave,+20% point multiplier \n Q:5")
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS , -9999)
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.20)

trinket = GM:AddTrinket("Soul of Isaac", "isaacsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(34, 120, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 5, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(115, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Дает всего по немногу,дает 10 хп,перезарядка быстрее на 8%,вы получаете на 4% больше поинтов\n+10 hp,Reload speed by 8%,+10% point multiplier \n Q:2")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 10)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.08)
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.1)

trinket = GM:AddTrinket("Soul of Magdalene", "magdalenesoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 60, 90, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 5, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Дает  10 здоровья и 40 кровавой брони,но вы на 40 единицы медленее\n +30 hp,+40 blood armor,-40 speed \n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 10)
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, -40)
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 40)

trinket = GM:AddTrinket("Soul of Lilith", "lilithsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(0, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Дает большой бафф к туррелям и дронам с амуницией,аммуниция идет быстрее на 10%,на 30% больше хп у всех деплояблов,туррели имеют в 50% больше хп и скорость сканирования на 40% больше\n Give huge buff for turrets and drones\n Q:4")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.1)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYABLE_HEALTH_MUL, 0.3)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_HEALTH_MUL, 0.5)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_SCANSPEED_MUL, 0.4)
trinket = GM:AddTrinket("Soul of Eden", "whysoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 255, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 20, y = 20 }, color = Color(0, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(11, 20, 110, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil," Дает баффы всех нормальным душ(души досетовцев не считаються) но в меньшем маштабе и дает еще их дебаффы,не копирует душу лоста,лазаря и форготена\ngives a buff of normal souls but worse, debuffs too!(does not include Doset-souls and soul Of lazarus,forgotten and lost) \nQ:Ultimate ")
GM:AddSkillModifier(trinket, SKILLMOD_DRONE_CARRYMASS_MUL, 0.03)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_RANGE_MUL, 0.05)
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.07)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYABLE_HEALTH_MUL, 0.02)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_HEALTH_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_SCANSPEED_MUL, 0.09)
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, -10)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 17)
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 30)
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS , -25)
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.11)
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, -0.11)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, -0.03)
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, -0.02)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.13)
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.07)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.09)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.07)
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_HEALTH_MUL, 0.06) 
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_DAMAGE_MUL, 0.07) 
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.05)
trinket = GM:AddTrinket("Blank Soul", "blanksoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 255, 211, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 210, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Пустая душа поглощает 5% урона по вам\nblank soul absorb 5% damage to you \n Q:0 ")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.05)

trinket = GM:AddTrinket(" Soul of Classix", "classixsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(5, 25, 211, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(5, 0, 25, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(155, 110, 15, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Классикс одарил вас силой бомбежки! Перезарядка винтовок на быстрее 56% и лучше точность на 20%\n+56% reload speed for snipers and +20% accuracy\n Q:0")
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_RIFLE_MUL, 0.56)
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, -0.20)

trinket = GM:AddTrinket("Soul of Darkness", "darksoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(0, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 255, 00, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(21, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "+20% К радиусу взрыву,+20% К урону от взрыва,-20% урона по себе\n -20% Self-damage,+20% Explosive radius,+20% Explosive Damage\n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_RADIUS, 0.20)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, 0.2)
GM:AddSkillModifier(trinket, SKILLMOD_SELF_DAMAGE_MUL, -0.2)
trinket = GM:AddTrinket("Soul of Azazel", "eriosoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 255, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(255, 165, 00, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "На 10% больше урон от мили!-20 хп и -10 кровавой брони.\n Melee damage multiplier 1.10x! -20 hp -10 blood armor\n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.10)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, -20) 
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, -10) 
trinket = GM:AddTrinket("Soul of Appolyon", "aposoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(30, 111, 51, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 105, 20, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 30, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Манхаки стали еще лучше! На 30% больше хп и на 20% больше урон.\n Manhack is better,+30% Hp and +20% damage for manhacks\n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_HEALTH_MUL, 0.3) 
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_DAMAGE_MUL, 0.2) 
trinket = GM:AddTrinket("Soul of Bethany", "betsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(33, 33, 31, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(120, 200, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 0, 5, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Больше никакой кровавой брони(навсегда)...Только обычное хп и хороший хил по ней!Хил по вам в 300% лучше и дает 50 хп\n+50 hp,-200 blood armor(PERMA EFFECT)\n+100% Heal received\n Q:4")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 50) 
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, -200) 
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 2) 
trinket = GM:AddTrinket("Soul of Lost", "lostsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 255, 255, 125), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 255, 20, 125), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 30, 255, 95), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Быстрее двигаешься через пропы,но ты получаешь в 90% раза больше урона!Вы быстрее на 100 единиц\nYou move faster through prop,+210 speed\n122% Damage taken mul \nQ:1")
GM:AddSkillModifier(trinket, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 2) 
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.90) 
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, 100)
trinket = GM:AddTrinket("Soul of Greed", "greedsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(21, 255, 1, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(120, 0, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 0, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Ваша жадность дает 5% скидку и +15% к поинтам\n Sale by 5%,+15% Point Multiplier\n Q:5")
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.15)
trinket = GM:AddTrinket("Soul of Cain", "cainsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(9, 155, 9, 55), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(125, 0, 255, 100), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 0, 255, 155), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Ускоряет амуницию на 19%,скидка в 5%\n-19% Ressuply Delay,Sale by 5%\n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.19)
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.05)
trinket = GM:AddTrinket("Soul of Lazarus", "lazarussoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(9, 0, 0, 195), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(125, 0, 255, 0), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 0, 5, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Лазарь защищает вас всей своей душой\nsave you if you have 20% health,gave 100% blood(Heal only with hemostasis)")
trinket = GM:AddTrinket("Soul of Forgotten", "forsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(9, 0, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 55, 5, 100), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Вы лучше бьете  мили оружием!,но вы не сможете нормально атаковать другим оружием\nBetter melee but you can't use other weapon exlude melee weapon \n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 12)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.20)
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, 40)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, -0.44)

trinket = GM:AddTrinket("Soul of Sussy Stragus", "starsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(9, 0, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 55, 5, 100), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Дает 55 скорости отнимая 10% дамага\n +55 speed,-10% Melee damage\n Q:lmao")
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, 55)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, -0.10)

trinket = GM:AddTrinket("Soul of Toy", "toysoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(0, 0, 0, 125), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 125), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(0, 0, 0, 100), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Душа Тоя???Невозможно.Большая уязвимость к баракотам,дает 100 скорости,чинильная станция лучше на 100%,вы не взорветесь!Хотя смысл все объяснять?\n+400% Knockdown time but you very STRONG\n Q:One For All ")
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, 100)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_RANGE_MUL, 1)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_DELAY_MUL, -1)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, 2)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_RADIUS, 0.3)
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_HEALTH_MUL, 0.6)
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_SPEED_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_DAMAGE_MUL, 10)
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_COOLDOWN_MUL, -1)
GM:AddSkillModifier(trinket, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.3)
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS, 55)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT, 60)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT, 3)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.04)
GM:AddSkillModifier(trinket, SKILLMOD_KNOCKDOWN_RECOVERY_MUL, 4)
trinket = GM:AddTrinket("Soul of Tea", "teasoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 0, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(10, 23, 35, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 55, 5, 100), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Дает 40 скорости\n +40 speed\n Q:1")
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, 40)
trinket = GM:AddTrinket("Soul of Sugger", "sugersoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(255, 255, 255, 25), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 55, 5, 100), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "+10% К мили урону,-2% получаемого урона\n +10% for melee damage,-2% Damage taken mul\n Q:1")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.10)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.02)
trinket = GM:AddTrinket("Soul of N3ll", "nulledsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(255, 255, 255, 25), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 55, 5, 100), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "+20% К мuли урону,+12% п0лучаемого ур0на,+12% к п0луч1ем0му хиллу,ск3дк1 в 6%\n +20% f0r meleE damAge,+12% Damag3 tak3n mul,+12% Heal rec3ived,s1l3 by 6%\n Q:Ultimate")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.20)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.12)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 0.12)
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.06)








--Alt Souls 









GM:AddTrinket("Soul of Alter Judas", "altjudassoul", false, blcorev, blcorew, nil, "Blinds and knocks zombies away when attacked\nRecharges every 15 seconds\nОслепляет и откидывает назад зомби(Которые атаковали вас)\n Перезарядка каждые 15 сек\n Q:2")

trinket = GM:AddTrinket("Soul of Alt ???", "altsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "+22% jump height\n+22% К силе прыжка.")
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.22)


trinket = GM:AddTrinket("Alt Samson Soul", "altsamsonsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(255, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(255, 5, 11, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Вы наносите на 10% больше урона мили оружием и получаете в 30% раз больше урона от яда и кровотока.\nYou deal to 10% more melee damage and take by 30% more poison and blood damage\n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, 0.30)
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, 0.30)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.10)

trinket = GM:AddTrinket("Soul of Alt Eve", "altevesoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(0, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(0, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(0, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Вы наносите на 22% меньше урона мили оружием но яд и кровотечение наносит на 88% меньше урона.\n-22% melee damage but you take by -88% damage from effects\n Q:2")
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.88)
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, -0.88)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, -0.22)

trinket = GM:AddTrinket("Soul of Jacob", "jacobsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(255, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(0, 5, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 0, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Вы не сможете получать поинты после волны но теперь вы получаете на 20% больше поинтов.\nYou now don't take point's per wave,+20% point multiplier \n Q:5")
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS , -9999)
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.20)

trinket = GM:AddTrinket("Soul of Alt Isaac", "altisaacsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(34, 120, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(0, 5, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(115, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Дает всего по немногу,дает 10 хп,перезарядка быстрее на 8%,вы получаете на 4% больше поинтов\n+10 hp,Reload speed by 8%,+10% point multiplier \n Q:2")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 10)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.08)
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.1)

trinket = GM:AddTrinket("Soul of Alt Magdalene", "altmagdalenesoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(255, 60, 90, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(0, 5, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Дает  10 здоровья и 40 кровавой брони,но вы на 40 единицы медленее\n +30 hp,+40 blood armor,-40 speed \n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 10)
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, -40)
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 40)

trinket = GM:AddTrinket("Soul of Alt Lilith", "altlilithsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(255, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(0, 0, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(0, 0, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil,"Дает большой бафф к туррелям и дронам с амуницией,аммуниция идет быстрее на 10%,на 30% больше хп у всех деплояблов,туррели имеют в 50% больше хп и скорость сканирования на 40% больше\n Give huge buff for turrets and drones\n Q:4")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.1)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYABLE_HEALTH_MUL, 0.3)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_HEALTH_MUL, 0.5)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_SCANSPEED_MUL, 0.4)
trinket = GM:AddTrinket("Soul of Alt Eden", "altwhysoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(255, 255, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(0, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(11, 20, 110, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil," Дает баффы всех нормальным душ(души досетовцев не считаються) но в меньшем маштабе и дает еще их дебаффы,не копирует душу лоста,лазаря и форготена\ngives a buff of normal souls but worse, debuffs too!(does not include Doset-souls and soul Of lazarus,forgotten and lost) \nQ:Ultimate ")
GM:AddSkillModifier(trinket, SKILLMOD_DRONE_CARRYMASS_MUL, 0.03)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_RANGE_MUL, 0.05)
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.07)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYABLE_HEALTH_MUL, 0.02)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_HEALTH_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_SCANSPEED_MUL, 0.09)
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, -10)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 17)
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 30)
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS , -25)
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.11)
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, -0.11)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, -0.03)
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, -0.02)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.13)
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.07)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.09)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.07)
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_HEALTH_MUL, 0.06) 
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_DAMAGE_MUL, 0.07) 
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.05)


trinket = GM:AddTrinket("Soul of Alt Azazel", "alteriosoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(255, 255, 0, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(255, 165, 00, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "На 10% больше урон от мили!-20 хп и -10 кровавой брони.\n Melee damage multiplier 1.10x! -20 hp -10 blood armor\n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.10)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, -20) 
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, -10) 
trinket = GM:AddTrinket("Soul of Alt Appolyon", "altaposoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(30, 111, 51, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(0, 105, 20, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 30, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Манхаки стали еще лучше! На 30% больше хп и на 20% больше урон.\n Manhack is better,+30% Hp and +20% damage for manhacks\n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_HEALTH_MUL, 0.3) 
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_DAMAGE_MUL, 0.2) 
trinket = GM:AddTrinket("Soul of Alt Bethany", "altbetsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(33, 33, 31, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(120, 200, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 0, 5, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Больше никакой кровавой брони(навсегда)...Только обычное хп и хороший хил по ней!Хил по вам в 300% лучше и дает 50 хп\n+50 hp,-200 blood armor(PERMA EFFECT)\n+100% Heal received\n Q:4")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 50) 
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, -200) 
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 2) 
trinket = GM:AddTrinket("Soul of Alt Lost", "altlostsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(255, 255, 255, 125), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(0, 255, 20, 125), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 30, 255, 95), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Быстрее двигаешься через пропы,но ты получаешь в 90% раза больше урона!Вы быстрее на 100 единиц\nYou move faster through prop,+210 speed\n122% Damage taken mul \nQ:1")
GM:AddSkillModifier(trinket, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 2) 
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.90) 
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, 100)
trinket = GM:AddTrinket("Soul of Alt Greed", "altgreedsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(21, 255, 1, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(120, 0, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 0, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Ваша жадность дает 10% скидку и +25% к поинтам\n Sale by 10%,+25% Point Multiplier\n Q:5")
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.10)
GM:AddSkillModifier(trinket, SKILLMOD_POINT_MULTIPLIER, 0.25)
trinket = GM:AddTrinket("Soul of Alt Cain", "altcainsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(9, 155, 9, 55), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(125, 0, 255, 100), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 0, 255, 155), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Ускоряет амуницию на 19%,скидка в 5%\n-19% Ressuply Delay,Sale by 5%\n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.19)
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.05)
trinket = GM:AddTrinket("Soul of Alt Lazarus", "altlazarussoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(9, 0, 0, 195), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(125, 0, 255, 0), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 0, 5, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Лазарь защищает вас всей своей душой\nsave you if you have 20% health,gave 100% blood(Heal only with hemostasis)")
trinket = GM:AddTrinket("Soul of Alt Forgotten", "altforsoul", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10.697, y = 10.697 }, color = Color(9, 0, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 30, y = 30 }, color = Color(0, 0, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(55, 55, 5, 100), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "Вы лучше бьете  мили оружием!,но вы не сможете нормально атаковать другим оружием\nBetter melee but you can't use other weapon exlude melee weapon \n Q:3")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 12)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_MUL, 0.20)
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, 40)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, -0.44)



-- Starter Trinkets

trinket, trinketwep = GM:AddTrinket("Armband", "armband", false, mveles, mweles, nil, "-20% melee swing impact delay\n-16% melee damage taken\n-20% Скорости атаки\n-16% Получаемого мили урона")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.2)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.16)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Condiments", "condiments", false, supveles, supweles, nil, "+90% recovery from food\n-20% time to eat food\n -20% К времени поедания\n +90% к лечению от еды")
GM:AddSkillModifier(trinket, SKILLMOD_FOODRECOVERY_MUL, 0.90)
GM:AddSkillModifier(trinket, SKILLMOD_FOODEATTIME_MUL, -0.20)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Escape Manual", "emanual", false, develes, deweles, nil, "+200% phasing speed\n-12% low health slow intensity\n +90% К скорости передвижения в фазе\n -12% к эффективности замедления от лоу хп")
GM:AddSkillModifier(trinket, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.90)
GM:AddSkillModifier(trinket, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.12)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Aiming Aid", "aimaid", false, develes, deweles, nil, "+5% tighter aiming reticule\n-7% reduced effect of aim shake effects\n+5% К аккуратности стрельбы\n-6% К силе трясения экрана")
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_AIM_SHAKE_MUL, -0.06)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Vitamin Capsules", "vitamins", false, hpveles, hpweles, nil, "+8 maximum health\n-32% poison damage taken\n +8 к макс хп\n-32% Получаемого урона от яда")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 8)
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.32)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Welfare Shield", "welfare", false, hpveles, hpweles, nil, "-12% resupply delay\n-20% self damage taken\n-12% К времени амуниции\n-20% Получаемого урона по себе")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.12)
GM:AddSkillModifier(trinket, SKILLMOD_SELF_DAMAGE_MUL, -0.20)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Chemistry Set", "chemistry", false, hpveles, hpweles, nil, "+13% medic tool effectiveness\n+100% cloud bomb time\n +13% К эффективности мед иснтрументам\n+100% К времени действия облачных бомб")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.13)
GM:AddSkillModifier(trinket, SKILLMOD_CLOUD_TIME, 1)
trinketwep.PermitDismantle = true
