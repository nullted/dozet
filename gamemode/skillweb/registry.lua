GM.Skills = {}
GM.SkillModifiers = {}
GM.SkillFunctions = {}
GM.SkillModifierFunctions = {}

function GM:AddSkill(id, name, description, x, y, connections, tree)
	local skill = {Connections = table.ToAssoc(connections or {})}

	if CLIENT then
		skill.x = x
		skill.y = y

		-- TODO: Dynamic skill descriptions based on modifiers on the skill.

		skill.Description = description
	end

	if #name == 0 then
		name = "Skill "..id
		skill.Disabled = true
	end

	skill.Name = name
	skill.Tree = tree

	self.Skills[id] = skill

	return skill
end

-- Use this after all skills have been added. It assigns dynamic IDs!
function GM:AddTrinket(name, swepaffix, pairedweapon, veles, weles, tier, description, status, stocks)
	local skill = {Connections = {}}

	skill.Name = name
	skill.Trinket = swepaffix
	skill.Status = status

	local datatab = {PrintName = name, DroppedEles = weles, Tier = tier, Description = description, Status = status, Stocks = stocks}

	if pairedweapon then
		skill.PairedWeapon = "weapon_zs_t_" .. swepaffix
	end

	self.ZSInventoryItemData["trinket_" .. swepaffix] = datatab
	self.Skills[#self.Skills + 1] = skill

	return #self.Skills, self.ZSInventoryItemData["trinket_" .. swepaffix]
end

-- I'll leave this here, but I don't think it's needed.
function GM:GetTrinketSkillID(trinketname)
	for skillid, skill in pairs(GM.Skills) do
		if skill.Trinket and skill.Trinket == trinketname then
			return skillid
		end
	end
end

function GM:AddSkillModifier(skillid, modifier, amount)
	self.SkillModifiers[skillid] = self.SkillModifiers[skillid] or {}
	self.SkillModifiers[skillid][modifier] = (self.SkillModifiers[skillid][modifier] or 0) + amount
end

function GM:AddSkillFunction(skillid, func)
	self.SkillFunctions[skillid] = self.SkillFunctions[skillid] or {}
	table.insert(self.SkillFunctions[skillid], func)
end

function GM:SetSkillModifierFunction(modid, func)
	self.SkillModifierFunctions[modid] = func
end

function GM:MkGenericMod(modifiername)
	return function(pl, amount) pl[modifiername] = math.Clamp(amount + 1.0, 0.0, 1000.0) end
end

-- These are used for position on the screen
TREE_HEALTHTREE = 1
TREE_SPEEDTREE = 2
TREE_SUPPORTTREE = 3
TREE_BUILDINGTREE = 4
TREE_MELEETREE = 5
TREE_GUNTREE = 6
TREE_POINTTREE = 7
TREE_ANCIENTTREE = 8
TREE_DEFENSETREE = 9
TREE_DONATETREE = 10

-- Dummy skill used for "connecting" to their trees.
SKILL_NONE = 0

--[[
SKILL_U_AMMOCRATE = 0 -- Unlock alternate arsenal crate that only sells cheap ammo (remove from regular?)
SKILL_U_DECOY = 0 -- "Unlock: Decoy", "Unlocks purchasing the Decoy\nZombies believe it is a human\nCan be destroyed\nExplodes when destroyed"

SKILL_OVERCHARGEFLASHLIGHT = 0 -- Your flashlight now produces a blinding flash that stuns zombies\nYour flashlight now breaks after one use

Unlock: Explosive body armor - Allows you to purchase explosive body armor, which knocks back both you and nearby zombies when you fall below 25 hp.
Olympian - +50% throw power\nsomething bad
Unlock: Antidote Medic Gun - Unlocks purchasing the Antidote Medic Gun\nTarget poison damage resistance +100%\nTarget immediately cleansed of all debuffs\nTarget is no longer healed or hastened
]]

-- unimplemented

SKILL_SPEED1 = 1
SKILL_SPEED2 = 2
SKILL_SPEED3 = 3
SKILL_SPEED4 = 4
SKILL_SPEED5 = 5
SKILL_BACKPEDDLER = 18
SKILL_LOADEDHULL = 20
SKILL_REINFORCEDHULL = 21
SKILL_REINFORCEDBLADES = 22
SKILL_AVIATOR = 23
SKILL_U_BLASTTURRET = 24
SKILL_TWINVOLLEY = 26
SKILL_TURRETOVERLOAD = 27
SKILL_LIGHTCONSTRUCT = 34
SKILL_QUICKDRAW = 39
SKILL_QUICKRELOAD = 41
SKILL_VITALITY2 = 45
SKILL_BARRICADEEXPERT = 77
SKILL_BATTLER1 = 48
SKILL_BATTLER2 = 49
SKILL_BATTLER3 = 50
SKILL_BATTLER4 = 51
SKILL_BATTLER5 = 52
SKILL_HEAVYSTRIKES = 53
SKILL_COMBOKNUCKLE = 62
SKILL_U_CRAFTINGPACK = 64
SKILL_JOUSTER = 65
SKILL_SCAVENGER = 67
SKILL_U_ZAPPER_ARC = 68
SKILL_ULTRANIMBLE = 70
SKILL_D_FRAIL = 71
SKILL_U_MEDICCLOUD = 72
SKILL_SMARTTARGETING = 73
SKILL_GOURMET = 76
SKILL_BLOODARMOR = 79
SKILL_REGENERATOR = 80
SKILL_SAFEFALL = 83
SKILL_VITALITY3 = 84
SKILL_TANKER = 86
SKILL_U_CORRUPTEDFRAGMENT = 87
SKILL_WORTHINESS3 = 78
SKILL_WORTHINESS4 = 88
SKILL_FOCUS = 40
SKILL_WORTHINESS1 = 42
SKILL_WORTHINESS2 = 43
SKILL_WOOISM = 46
SKILL_U_DRONE = 28
SKILL_U_NANITECLOUD = 29
SKILL_STOIC1 = 6
SKILL_STOIC2 = 7
SKILL_STOIC3 = 8
SKILL_STOIC4 = 9
SKILL_STOIC5 = 10
SKILL_SURGEON1 = 11
SKILL_SURGEON2 = 12
SKILL_SURGEON3 = 13
SKILL_HANDY1 = 14
SKILL_HANDY2 = 15
SKILL_HANDY3 = 16
SKILL_MOTIONI = 17
SKILL_PHASER = 19
SKILL_TURRETLOCK = 25
SKILL_HAMMERDISCIPLINE = 30
SKILL_FIELDAMP = 31
SKILL_U_ROLLERMINE = 32
SKILL_HAULMODULE = 33
SKILL_TRIGGER_DISCIPLINE1 = 35
SKILL_TRIGGER_DISCIPLINE2 = 36
SKILL_TRIGGER_DISCIPLINE3 = 37
SKILL_D_PALSY = 38
SKILL_EGOCENTRIC = 44
SKILL_D_HEMOPHILIA = 47
SKILL_LASTSTAND = 54
SKILL_D_NOODLEARMS = 55
SKILL_GLASSWEAPONS = 56
SKILL_CANNONBALL = 57
SKILL_D_CLUMSY = 58
SKILL_CHEAPKNUCKLE = 59
SKILL_CRITICALKNUCKLE = 60
SKILL_KNUCKLEMASTER = 61
SKILL_D_LATEBUYER = 63
SKILL_VITALITY1 = 66
SKILL_TAUT = 69
SKILL_INSIGHT = 74
SKILL_GLUTTON = 75
SKILL_D_WEAKNESS = 81
SKILL_PREPAREDNESS = 82
SKILL_D_WIDELOAD = 85
SKILL_FORAGER = 89
SKILL_LANKY = 90
SKILL_PITCHER = 91
SKILL_BLASTPROOF = 92
SKILL_MASTERCHEF = 93
SKILL_SUGARRUSH = 94
SKILL_U_STRENGTHSHOT = 95
SKILL_STABLEHULL = 96
SKILL_LIGHTWEIGHT = 97
SKILL_AGILEI = 98
SKILL_U_CRYGASGREN = 99
SKILL_SOFTDET = 100
SKILL_STOCKPILE = 101
SKILL_ACUITY = 102
SKILL_VISION = 103
SKILL_U_ROCKETTURRET = 104
SKILL_RECLAIMSOL = 105
SKILL_ORPHICFOCUS = 106
SKILL_IRONBLOOD = 107
SKILL_BLOODLETTER = 108
SKILL_HAEMOSTASIS = 109
SKILL_SLEIGHTOFHAND = 110
SKILL_AGILEII = 111
SKILL_AGILEIII = 112
SKILL_BIOLOGYI = 113
SKILL_BIOLOGYII = 114
SKILL_BIOLOGYIII = 115
SKILL_FOCUSII = 116
SKILL_FOCUSIII = 117
SKILL_EQUIPPED = 118
SKILL_SURESTEP = 119
SKILL_INTREPID = 120
SKILL_CARDIOTONIC = 121
SKILL_BLOODLUST = 122
SKILL_SCOURER = 123
SKILL_LANKYII = 124
SKILL_U_ANTITODESHOT = 125
SKILL_DISPERSION = 126
SKILL_MOTIONII = 127
SKILL_MOTIONIII = 128
SKILL_D_SLOW = 129
SKILL_BRASH = 130
SKILL_CONEFFECT = 131
SKILL_CIRCULATION = 132
SKILL_SANGUINE = 133
SKILL_ANTIGEN = 134
SKILL_INSTRUMENTS = 135
SKILL_HANDY4 = 136
SKILL_HANDY5 = 137
SKILL_TECHNICIAN = 138
SKILL_BIOLOGYIV = 139
SKILL_SURGEONIV = 140
SKILL_DELIBRATION = 141
SKILL_DRIFT = 142
SKILL_WARP = 143
SKILL_LEVELHEADED = 144
SKILL_ROBUST = 145
SKILL_STOWAGE = 146
SKILL_TRUEWOOISM = 147
SKILL_UNBOUND = 148
SKILL_FOUR_IN_ONE = 149
SKILL_CHEESE = 150
SKILL_CARRIER = 151
SKILL_NULLED = 152
SKILL_OVERHAND = 153
SKILL_SIGILOL = 154
SKILL_UNSIGIL = 155
SKILL_SOULNET = 156
SKILL_GLASSMAN = 165
SKILL_THREE_IN_ONE = 188
SKILL_BANDOLIER = 200
SKILL_CURSEDTRINKETS = 201
SKILL_DONATE1 = 203
SKILL_BLOODLOST = 210
SKILL_ABUSE = 218


SKILLMOD_HEALTH = 1
SKILLMOD_SPEED = 2
SKILLMOD_WORTH = 3
SKILLMOD_FALLDAMAGE_THRESHOLD_MUL = 4
SKILLMOD_FALLDAMAGE_RECOVERY_MUL = 5
SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL = 6
SKILLMOD_FOODRECOVERY_MUL = 7
SKILLMOD_FOODEATTIME_MUL = 8
SKILLMOD_JUMPPOWER_MUL = 9
SKILLMOD_RELOADSPEED_MUL = 11
SKILLMOD_DEPLOYSPEED_MUL = 12
SKILLMOD_UNARMED_DAMAGE_MUL = 13
SKILLMOD_UNARMED_SWING_DELAY_MUL = 14
SKILLMOD_MELEE_DAMAGE_MUL = 15
SKILLMOD_HAMMER_SWING_DELAY_MUL = 16
SKILLMOD_CONTROLLABLE_SPEED_MUL = 17
SKILLMOD_CONTROLLABLE_HANDLING_MUL = 18
SKILLMOD_CONTROLLABLE_HEALTH_MUL = 19
SKILLMOD_MANHACK_DAMAGE_MUL = 20
SKILLMOD_BARRICADE_PHASE_SPEED_MUL = 21
SKILLMOD_MEDKIT_COOLDOWN_MUL = 22
SKILLMOD_MEDKIT_EFFECTIVENESS_MUL = 23
SKILLMOD_REPAIRRATE_MUL = 24
SKILLMOD_TURRET_HEALTH_MUL = 25
SKILLMOD_TURRET_SCANSPEED_MUL = 26
SKILLMOD_TURRET_SCANANGLE_MUL = 27
SKILLMOD_BLOODARMOR = 28
SKILLMOD_MELEE_KNOCKBACK_MUL = 29
SKILLMOD_SELF_DAMAGE_MUL = 30
SKILLMOD_AIMSPREAD_MUL = 31
SKILLMOD_POINTS = 32
SKILLMOD_POINT_MULTIPLIER = 33
SKILLMOD_FALLDAMAGE_DAMAGE_MUL = 34
SKILLMOD_MANHACK_HEALTH_MUL = 35
SKILLMOD_DEPLOYABLE_HEALTH_MUL = 36
SKILLMOD_DEPLOYABLE_PACKTIME_MUL = 37
SKILLMOD_DRONE_SPEED_MUL = 38
SKILLMOD_DRONE_CARRYMASS_MUL = 39
SKILLMOD_MEDGUN_FIRE_DELAY_MUL = 40
SKILLMOD_RESUPPLY_DELAY_MUL = 41
SKILLMOD_FIELD_RANGE_MUL = 42
SKILLMOD_FIELD_DELAY_MUL = 43
SKILLMOD_DRONE_GUN_RANGE_MUL = 44
SKILLMOD_HEALING_RECEIVED = 45
SKILLMOD_RELOADSPEED_PISTOL_MUL = 46
SKILLMOD_RELOADSPEED_SMG_MUL = 47
SKILLMOD_RELOADSPEED_ASSAULT_MUL = 48
SKILLMOD_RELOADSPEED_SHELL_MUL = 49
SKILLMOD_RELOADSPEED_RIFLE_MUL = 50
SKILLMOD_RELOADSPEED_XBOW_MUL = 51
SKILLMOD_RELOADSPEED_PULSE_MUL = 52
SKILLMOD_RELOADSPEED_EXP_MUL = 53
SKILLMOD_MELEE_ATTACKER_DMG_REFLECT = 54
SKILLMOD_PULSE_WEAPON_SLOW_MUL = 55
SKILLMOD_MELEE_DAMAGE_TAKEN_MUL = 56
SKILLMOD_POISON_DAMAGE_TAKEN_MUL = 57
SKILLMOD_BLEED_DAMAGE_TAKEN_MUL = 58
SKILLMOD_MELEE_SWING_DELAY_MUL = 59
SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL = 60
SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL = 61
SKILLMOD_MELEE_POWERATTACK_MUL = 62
SKILLMOD_KNOCKDOWN_RECOVERY_MUL = 63
SKILLMOD_MELEE_RANGE_MUL = 64
SKILLMOD_SLOW_EFF_TAKEN_MUL = 65
SKILLMOD_EXP_DAMAGE_TAKEN_MUL = 66
SKILLMOD_FIRE_DAMAGE_TAKEN_MUL = 67
SKILLMOD_PROP_CARRY_CAPACITY_MUL = 68
SKILLMOD_PROP_THROW_STRENGTH_MUL = 69
SKILLMOD_PHYSICS_DAMAGE_TAKEN_MUL = 70
SKILLMOD_VISION_ALTER_DURATION_MUL = 71
SKILLMOD_DIMVISION_EFF_MUL = 72
SKILLMOD_PROP_CARRY_SLOW_MUL = 73
SKILLMOD_BLEED_SPEED_MUL = 74
SKILLMOD_MELEE_LEG_DAMAGE_ADD = 75
SKILLMOD_SIGIL_TELEPORT_MUL = 76
SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT = 77
SKILLMOD_POISON_SPEED_MUL = 78
SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL = 79
SKILLMOD_EXP_DAMAGE_RADIUS = 80
SKILLMOD_MEDGUN_RELOAD_SPEED_MUL = 81
SKILLMOD_WEAPON_WEIGHT_SLOW_MUL = 82
SKILLMOD_FRIGHT_DURATION_MUL = 83
SKILLMOD_IRONSIGHT_EFF_MUL = 84
SKILLMOD_BLOODARMOR_DMG_REDUCTION = 85
SKILLMOD_BLOODARMOR_MUL = 86
SKILLMOD_BLOODARMOR_GAIN_MUL = 87
SKILLMOD_LOW_HEALTH_SLOW_MUL = 88
SKILLMOD_PROJ_SPEED = 89
SKILLMOD_SCRAP_START = 90
SKILLMOD_ENDWAVE_POINTS = 91
SKILLMOD_ARSENAL_DISCOUNT = 92
SKILLMOD_CLOUD_RADIUS = 93
SKILLMOD_CLOUD_TIME = 94
SKILLMOD_PROJECTILE_DAMAGE_MUL = 95
SKILLMOD_EXP_DAMAGE_MUL = 96
SKILLMOD_TURRET_RANGE_MUL = 97
SKILLMOD_AIM_SHAKE_MUL = 98
SKILLMOD_MEDDART_EFFECTIVENESS_MUL = 99
SKILLMOD_DAMAGE = 100
SKILLMOD_HEADSHOT_MUL = 101
SKILLMOD_XP = 102

local GOOD = "^"..COLORID_GREEN
local BAD = "^"..COLORID_RED
local NEUTRAL = "^"..COLORID_GRAY
--

-- Health Tree
GM:AddSkill(SKILL_STOIC1, "Stoic I", GOOD.."+4 maximum health\n"..BAD.."-5 movement speed",
																-4,			-6,					{SKILL_NONE, SKILL_STOIC2}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_STOIC2, "Stoic II", GOOD.."+5 maximum health\n"..BAD.."-7 movement speed",
																-4,			-4,					{SKILL_STOIC3, SKILL_VITALITY1, SKILL_REGENERATOR}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_STOIC3, "Stoic III", GOOD.."+6 maximum health\n"..BAD.."-9 movement speed",
																-3,			-2,					{SKILL_STOIC4}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_STOIC4, "Stoic IV", GOOD.."+8 maximum health\n"..BAD.."-11 movement speed",
																-3,			0,					{SKILL_STOIC5}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_STOIC5, "Stoic V", GOOD.."+11 maximum health\n"..BAD.."-10 movement speed",
																-3,			2,					{SKILL_BLOODARMOR, SKILL_TANKER}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_D_HEMOPHILIA, "Debuff: Hemophilia", GOOD.."+10 starting Worth\n"..GOOD.."+3 starting scrap\n"..BAD.."Bleed for 25% extra damage when hit",
																4,			2,					{}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_GLUTTON, "Glutton", GOOD.."Gain up to 30 blood armor when you eat food\n"..GOOD.."Blood armor gained can exceed the cap by 40\n"..BAD.."+7 maximum health\n"..BAD.."No longer receive health from eating food",
																3,			-2,					{SKILL_GOURMET, SKILL_BLOODARMOR}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_PREPAREDNESS, "Preparedness", GOOD.."Your starting item can be a random food item",
																4,			-6,					{SKILL_NONE}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_GOURMET, "Gourmet", GOOD.."+400% recovery from food\n"..BAD.."+200% time to eat food",
																4,			-4,					{SKILL_PREPAREDNESS, SKILL_VITALITY1}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_HAEMOSTASIS, "Haemostasis", GOOD.."Resist status effects while you have at least 2 blood armor\n"..BAD.."Lose 2 blood armor on resist\n"..BAD.."-25% blood armor damage absorption",
																4,			6,					{}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_BLOODLETTER, "Bloodletter", GOOD.."+100% blood armor generated\n"..BAD.."Losing all blood armor inflicts 5 bleed damage",
																0,			4,					{SKILL_ANTIGEN}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_REGENERATOR, "Regenerator", GOOD.."Regenerate 1 health every 6s when below 60% health\n"..BAD.."-6 maximum health",
																-5,			-2,					{}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_NULLED, "The Immortal", GOOD.."Regenerate 3 health every 5 sec",
			                                                   	-5,			0,					{SKILL_REGENERATOR}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_BLOODARMOR, "Blood Armor", GOOD.."Regenerate 1 blood armor every 8 seconds upto your blood armor max\nBase blood armor maximum is 20\nBase blood armor damage absorption is 50%\n"..BAD.."-13 maximum health",
																2,			2,					{SKILL_IRONBLOOD, SKILL_BLOODLETTER, SKILL_D_HEMOPHILIA}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_IRONBLOOD, "Iron Blood", GOOD.."+25% damage reduction from blood armor\n"..GOOD.."Bonus doubled when health is 50% or less\n"..BAD.."-50% maximum blood armor",
																2,			4,					{SKILL_HAEMOSTASIS, SKILL_CIRCULATION}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_D_WEAKNESS, "Debuff: Weakness", GOOD.."+60 starting Worth\n"..GOOD.."+15 end of wave points\n"..BAD.."-60 maximum health\n"..BAD.."-30 Melee Damage\n",
																1,			-1,					{}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_VITALITY1, "Vitality I", GOOD.."+3 maximum health",
																0,			-4,					{SKILL_VITALITY2}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_VITALITY2, "Vitality II", GOOD.."+3 maximum health",
																0,			-2,					{SKILL_VITALITY3}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_VITALITY3, "Vitality III", GOOD.."+3 maximum health",
																0,			-0,					{SKILL_D_WEAKNESS}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_CHEESE, "Cheese", GOOD.."+10 maximum health and +10 speed",
																1,			1,					{SKILL_GOURMET}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_TANKER, "Tanker", GOOD.."+60 maximum health\n"..BAD.."-40 movement speed",
																-5,			4,					{}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_FORAGER, "Forager", GOOD.."25% chance to collect food from resupply boxes\n"..BAD.."+20% resupply box delay",
																5,			-2,					{SKILL_GOURMET}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_SUGARRUSH, "Sugar Rush", GOOD.."+35 speed boost from food for 14 seconds\n"..BAD.."-35% recovery from food\n",
																4,			0,					{SKILL_GOURMET}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_CIRCULATION, "Circulation", GOOD.."+1 maximum blood armor",
																4,			4,					{SKILL_SANGUINE}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_SANGUINE, "Sanguine", GOOD.."+11 maximum blood armor\n"..BAD.."-9 maximum health",
																6,			2,					{}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_ANTIGEN, "Antigen", GOOD.."+5% blood armor damage absorption\n"..BAD.."-3 maximum health",
																-2,			4,					{}, TREE_HEALTHTREE)
-- Speed Tree
GM:AddSkill(SKILL_SPEED1, "Speed I", GOOD.."+2 movement speed\n"..BAD.."-1 maximum health",
																-4,			6,					{SKILL_NONE, SKILL_SPEED2}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SPEED2, "Speed II", GOOD.."3 movement speed\n"..BAD.."-2 maximum health",
																-4,			4,					{SKILL_SPEED3, SKILL_PHASER, SKILL_SPEED2, SKILL_U_CORRUPTEDFRAGMENT}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SPEED3, "Speed III", GOOD.."+5 movement speed\n"..BAD.."-4 maximum health",
																-4,			2,					{SKILL_SPEED4}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SPEED4, "Speed IV", GOOD.."+7 movement speed\n"..BAD.."-6 maximum health",
																-4,			0,					{SKILL_SPEED5, SKILL_SAFEFALL}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SPEED5, "Speed V", GOOD.."+13 movement speed\n"..BAD.."-10 maximum health",
																-4,			-2,					{SKILL_ULTRANIMBLE, SKILL_BACKPEDDLER, SKILL_MOTIONI, SKILL_CARDIOTONIC, SKILL_UNBOUND}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_AGILEI, "Agile I", GOOD.."+4% jumping power\n"..BAD.."-2 movement speed",
																4,			6,					{SKILL_NONE, SKILL_AGILEII}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_AGILEII, "Agile II", GOOD.."+5% jumping power\n"..BAD.."-3 movement speed",
																4,			2,					{SKILL_AGILEIII, SKILL_WORTHINESS3}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_AGILEIII, "Agile III", GOOD.."+6% jumping power\n"..BAD.."-4 movement speed",
																4,			-2,					{SKILL_SAFEFALL, SKILL_ULTRANIMBLE, SKILL_SURESTEP, SKILL_INTREPID}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_D_SLOW, "Slow", GOOD.."+30 starting Worth\n"..GOOD.."+20 end of wave points\n"..BAD.."-68.75 movement speed",
																0,			-4,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_MOTIONI, "Motion I", GOOD.."+5 movement speed",
																-2,			-2,					{SKILL_MOTIONII}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_MOTIONII, "Motion II", GOOD.."+9 movement speed",
																-1,			-1,					{SKILL_MOTIONIII}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_MOTIONIII, "Motion III", GOOD.."+12 movement speed",
																0,			-2,					{SKILL_D_SLOW}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_BACKPEDDLER, "Backpeddler", GOOD.."Move the same speed in all directions\n"..BAD.."-7 movement speed\n"..BAD.."Receive leg damage on any melee hit",
																-6,			0,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_PHASER, "Phaser", GOOD.."+15% barricade phasing movement speed\n"..BAD.."+15% sigil teleportation time",
																-1,			4,					{SKILL_D_WIDELOAD, SKILL_DRIFT}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_DRIFT, "Drift", GOOD.."+5% barricade phasing movement speed",
																1,			3,					{SKILL_WARP}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_WARP, "Warp", GOOD.."-5% sigil teleportation time",
																2,			2,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SIGILOL, "Sigil Infection", GOOD.."+300% Speed in phasing phase\n"..BAD.."+100% sigil teleportation time",
																2,			4,					{SKILL_WARP}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_CURSEDTRINKETS, "Worth Trinkets", GOOD.."Cursed?\n"..BAD.."Cursed?\n"..GOOD.."Cursed?\n"..BAD.."Cursed?\n"..GOOD.."Cursed?\n"..BAD.."Cursed?\n"..GOOD.."Cursed?",
																2,		    5,					{SKILL_SIGILOL}, TREE_SPEEDTREE)

GM:AddSkill(SKILL_UNSIGIL, "Uncorrupter", GOOD.."+24% Reload speed\n"..BAD.."-80% Melee damage",
																0,			2,					{SKILL_LEVELHEADED}, TREE_GUNTREE)



GM:AddSkill(SKILL_SAFEFALL, "Safe Fall", GOOD.."-40% fall damage taken\n"..GOOD.."+20% faster fall damage knockdown recovery\n"..BAD.."+10% slow down from landing or fall damage",
																0,			0,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_D_WIDELOAD, "Debuff: Wide Load", GOOD.."+20 starting Worth\n"..GOOD.."-5% resupply delay\n"..BAD.."Phasing speed limited to 1 for the first 6 seconds of phasing",
																1,			1,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_U_CORRUPTEDFRAGMENT, "Unlock: Corrupted Fragment", GOOD.."Unlocks purchasing the Corrupted Fragment\nGoes to corrupted sigils instead",
																-2,			2,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_ULTRANIMBLE, "Ultra Nimble", GOOD.."+30 movement speed\n"..BAD.."-10 maximum health",
																0,			-6,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_WORTHINESS3, "Worthiness III", GOOD.."+10 starting worth\n"..BAD.."-3 starting points",
																6,			2,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SURESTEP, "Sure Step", GOOD.."-30% effectiveness of slows\n"..BAD.."-4 movement speed",
																6,			0,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_INTREPID, "Intrepid", GOOD.."-35% low health slow intensity\n"..BAD.."-4 movement speed",
																6,			-4,					{SKILL_ROBUST}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_ROBUST, "Robust", GOOD.."-6% movement speed reduction with heavy weapons",
																5,			-5,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_CARDIOTONIC, "Cardiotonic", GOOD.."Hold shift to run whilst draining blood armor\n"..BAD.."-12 movement speed\n"..BAD.."-20% blood armor damage absorption\nSprinting grants +40 move speed",
																-6,			-4,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_UNBOUND, "Unbound", GOOD.."-60% reduced delay from switching weapons affecting movement speed\n"..BAD.."-4 movement speed",
																-4,			-4,					{}, TREE_SPEEDTREE)
-- Medic Tree
GM:AddSkill(SKILL_SURGEON1, "Surgeon I", GOOD.."-6% medical kit cooldown",
																-4,			6,					{SKILL_NONE, SKILL_SURGEON2}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_SURGEON2, "Surgeon II", GOOD.."-9% medical kit cooldown",
																-3,			3,					{SKILL_WORTHINESS4, SKILL_SURGEON3}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_SURGEON3, "Surgeon III", GOOD.."-11% medical kit cooldown",
																-2,			0,					{SKILL_U_MEDICCLOUD, SKILL_D_FRAIL, SKILL_SURGEONIV}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_SURGEONIV, "Surgeon IV", GOOD.."-21% medical kit cooldown",
																-2,			-3,					{}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_BIOLOGYI, "Biology I", GOOD.."+8% medic tool effectiveness",
																4,			6,					{SKILL_NONE, SKILL_BIOLOGYII}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_BIOLOGYII, "Biology II", GOOD.."+13% medic tool effectiveness",
																3,			3,					{SKILL_BIOLOGYIII, SKILL_SMARTTARGETING}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_BIOLOGYIII, "Biology III", GOOD.."+18% medic tool effectiveness",
																2,			0,					{SKILL_U_MEDICCLOUD, SKILL_U_ANTITODESHOT, SKILL_BIOLOGYIV}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_BIOLOGYIV, "Biology IV", GOOD.."+21% medic tool effectiveness",
																2,			-3,					{}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_D_FRAIL, "Debuff: Frail", GOOD.."-33% medical kit cooldown\n"..GOOD.."+33% medic tool effectiveness\n"..BAD.."Cannot be healed above 44% health",
																-4,			-2,					{}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_U_MEDICCLOUD, "Unlock: Medic Cloud Bomb", GOOD.."Unlocks purchasing the Medic Cloud Bomb\nSlowly heals all humans inside the cloud",
																0,			-2,					{SKILL_DISPERSION}, TREE_SUPPORTTREE)
.AlwaysActive = true
GM:AddSkill(SKILL_SMARTTARGETING, "Smart Targeting", GOOD.."Medical weapon darts lock onto targets with right click\n"..BAD.."+75% medic tool fire delay\n"..BAD.."-30% healing effectiveness on medical darts",
																0,			2,					{}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_RECLAIMSOL, "Recoverable Solution", GOOD.."60% of wasted medical dart ammo is returned to you\n"..BAD.."+150% medic tool fire delay\n"..BAD.."-40% medic tool reload speed\n"..BAD.."Cannot speed boost full health players",
																0,			4,					{SKILL_SMARTTARGETING}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_U_STRENGTHSHOT, "Unlock: Strength Shot Gun", GOOD.."Unlocks purchasing the Strength Shot Gun\nTarget damage +25% for 10 seconds\nExtra damage is given to you as points\nTarget is not healed",
																0,			0,					{SKILL_SMARTTARGETING}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_WORTHINESS4, "Worthiness IV", GOOD.."+10 starting worth\n"..BAD.."-3 starting points",
																-5,			2,					{}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_U_ANTITODESHOT, "Unlock: Antidote Handgun", GOOD.."Unlocks purchasing the Antidote Handgun\nFires piercing blasts that heal poison greatly\nCleanses statuses from targets with a small point gain\nDoes not heal health",
																4,			-2,					{}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_DISPERSION, "Dispersion", GOOD.."+15% cloud bomb radius\n"..BAD.."-10% cloud bomb time",
																0,			-4,					{}, TREE_SUPPORTTREE)

-- Defence Tree
GM:AddSkill(SKILL_HANDY1, "Handy I", GOOD.."+5% repair rate",
																-5,			-6,					{SKILL_NONE, SKILL_HANDY2}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HANDY2, "Handy II", GOOD.."+6% repair rate",
																-5,			-4,					{SKILL_HANDY3, SKILL_U_BLASTTURRET, SKILL_LOADEDHULL}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HANDY3, "Handy III", GOOD.."+8% repair rate",
																-5,			-1,					{SKILL_TAUT, SKILL_HAMMERDISCIPLINE, SKILL_D_NOODLEARMS, SKILL_HANDY4}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HANDY4, "Handy IV", GOOD.."+11% repair rate",
																-3,			1,					{SKILL_HANDY5}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HANDY5, "Handy V", GOOD.."+13% repair rate",
																-3,			3,					{SKILL_OVERHAND}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_OVERHAND, "OverHandy", GOOD.."+25% repair rate\n"..BAD.."+15% swing delay",
																-3,			4,					{SKILL_HANDY5}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HAMMERDISCIPLINE, "Hammer Discipline", GOOD.."-40% swing delay with the Carpenter Hammer",
																0,			1,					{SKILL_BARRICADEEXPERT}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_BARRICADEEXPERT, "Reinforcer", GOOD.."Props hit with a hammer in the last 7 seconds take 8% less damage\n"..GOOD.."Gain points from protected props\n"..BAD.."+20% swing delay with the Carpenter Hammer",
																0,			3,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_LOADEDHULL, "Loaded Hull", GOOD.."Controllables explode when destroyed, dealing explosive damage\n"..BAD.."-10% Controllable health",
																-2,			-4,					{SKILL_REINFORCEDHULL, SKILL_REINFORCEDBLADES, SKILL_AVIATOR}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_REINFORCEDHULL, "Reinforced Hull", GOOD.."+25% Controllable health\n"..BAD.."-20% Controllable handling\n"..BAD.."-20% Controllable speed",
																-2,			-2,					{SKILL_STABLEHULL}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_STABLEHULL, "Stable Hull", GOOD.."Controllables are immune to high speed impacts\n"..BAD.."-20% Controllable speed",
																0,			-3,					{SKILL_U_DRONE}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_REINFORCEDBLADES, "Reinforced Blades", GOOD.."+25% Manhack damage\n"..BAD.."-15% Manhack health",
																0,			-5,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_AVIATOR, "Aviator", GOOD.."+40% Controllable speed and handling\n"..BAD.."-25% Controllable health",
																-4,			-2,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_U_BLASTTURRET, "Unlock: Blast Turret", GOOD.."Unlocks purchasing the Blast Turret\nFires buckshot instead of SMG ammo\nDamage is higher close up\nCannot scan for targets far away",
																-8,			-4,					{SKILL_TURRETLOCK, SKILL_TWINVOLLEY, SKILL_TURRETOVERLOAD}, TREE_BUILDINGTREE)
.AlwaysActive = true
GM:AddSkill(SKILL_TURRETLOCK, "Turret Lock", "-90% turret scan angle\n"..BAD.."-90% turret target lock angle",
																-6,			-2,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_TWINVOLLEY, "Twin Volley", GOOD.."Fire twice as many bullets in manual turret mode\n"..BAD.."+100% turret ammo usage in manual turret mode\n"..BAD.."+50% turret fire delay in manual turret mode",
																-10,		-5,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_TURRETOVERLOAD, "Turret Overload", GOOD.." +100% Turret scan speed\n"..BAD.."-30% Turret range",
																-8,			-2,					{SKILL_INSTRUMENTS}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_U_DRONE, "Unlock: Pulse Drone", GOOD.."Unlocks the Pulse Drone Variant\nFires short range pulse projectiles instead of bullets",
																2,			-3,					{SKILL_HAULMODULE, SKILL_U_ROLLERMINE}, TREE_BUILDINGTREE)
.AlwaysActive = true
GM:AddSkill(SKILL_U_NANITECLOUD, "Unlock: Nanite Cloud Bomb", GOOD.."Unlocks purchasing the Nanite Cloud Bomb\nSlowly repairs all props and deployables inside the cloud",
																3,			1,					{SKILL_HAMMERDISCIPLINE}, TREE_BUILDINGTREE)
.AlwaysActive = true
GM:AddSkill(SKILL_FIELDAMP, "Field Amplifier", GOOD.."-20% zapper and repair field delay\n"..BAD.."-40% zapper and repair field range",
																6,			4,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_TECHNICIAN, "Field Technician", GOOD.." +3% zapper and repair field range\n"..GOOD.."-3% zapper and repair field delay",
																4,			3,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_U_ROLLERMINE, "Unlock: Rollermine", GOOD.."Unlocks purchasing Rollermines\nRolls along the ground, shocking zombies and dealing damage",
																3,			-5,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HAULMODULE, "Unlock: Hauling Drone", GOOD.."Unlocks the Hauling Drone\nRapidly transports props and items but cannot attack",
																2,			-1,					{SKILL_U_NANITECLOUD}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_LIGHTCONSTRUCT, "Light Construction", GOOD.."-25% deployable pack time\n"..BAD.."-25% deployable health",
																8,			-1,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_STOCKPILE, "Stockpiling", GOOD.."Collect twice as much from resupplies\n"..BAD.."2x resupply box delay",
																8,			-3,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_ACUITY, "Supplier's Acuity", GOOD.."Locate nearby resupply boxes if behind walls\n"..GOOD.."Locate nearby unplaced resupply boxes on players through walls\n"..GOOD.."Locate nearby resupply packs through walls",
																6,			-3,					{SKILL_INSIGHT, SKILL_STOCKPILE, SKILL_U_CRAFTINGPACK, SKILL_STOWAGE}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_VISION, "Refiner's Vision", GOOD.."Locate nearby remantlers if behind walls\n"..GOOD.."Locate nearby unplaced remantlers on players through walls",
																6,			-6,					{SKILL_NONE, SKILL_ACUITY}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_U_ROCKETTURRET, "Unlock: Rocket Turret", GOOD.."Unlocks purchasing the Rocket Turret\nFires explosives instead of SMG ammo\nDeals damage in a radius\nHigh tier deployable",
																-8,			-0,					{SKILL_TURRETOVERLOAD}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_INSIGHT, "Buyer's Insight", GOOD.."Locate nearby arsenal crates if behind walls\n"..GOOD.."Locate nearby unplaced arsenal crates on players through walls\n"..GOOD.."Locate nearby arsenal packs through walls",
																6,			-0,					{SKILL_U_NANITECLOUD, SKILL_U_ZAPPER_ARC, SKILL_LIGHTCONSTRUCT, SKILL_D_LATEBUYER}, TREE_BUILDINGTREE)
.AlwaysActive = true
GM:AddSkill(SKILL_U_ZAPPER_ARC, "Unlock: Arc Zapper", GOOD.."Unlocks purchasing the Arc Zapper\nZaps zombies that get nearby, and jumps in an arc\nMid tier deployable and long cooldown\nRequires a steady upkeep of pulse ammo",
																6,			2,					{SKILL_FIELDAMP, SKILL_TECHNICIAN}, TREE_BUILDINGTREE)
.AlwaysActive = true
GM:AddSkill(SKILL_D_LATEBUYER, "Debuff: Late Buyer", GOOD.."+20 starting Worth\n"..GOOD.."33% arsenal discount\n"..BAD.."Unable to use points at arsenal crates until the second half of the round",
																8,			1,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_CARRIER, "Carrier", GOOD.."+100% Speed when you take prop\n"..BAD.."-50% Deployable health\n"..BAD.."-50% Deployable packtime",
																9,			2,					{SKILL_D_LATEBUYER}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_U_CRAFTINGPACK, "Unlock: Crafting Pack", GOOD.."Unlocks purchasing the Sawblade component\n"..GOOD.."Unlocks purchasing the Electrobattery component\n"..GOOD.."Unlocks purchasing the CPU Parts component",
																4,			-1,					{}, TREE_BUILDINGTREE)
.AlwaysActive = true
GM:AddSkill(SKILL_TAUT, "Taut", GOOD.."Damage does not make you drop props\n"..BAD.."+40% prop carrying slow down",
																-5,			3,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_D_NOODLEARMS, "Debuff: Noodle Arms", GOOD.."+5 starting Worth\n"..GOOD.."+1 starting scrap\n"..BAD.."Unable to pick up objects",
																-7,			2,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_INSTRUMENTS, "Instruments", GOOD.."+5% turret range",
																-10,		-3,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_STOWAGE, 	"Stowage", GOOD.."Resupply usages build up when you're not there\n"..BAD.."-15% resupply delay",
																4,			-3,					{}, TREE_BUILDINGTREE)

-- Gunnery Tree
GM:AddSkill(SKILL_TRIGGER_DISCIPLINE1, "Trigger Discipline I", GOOD.."+2% weapon reload speed\n"..GOOD.."+2% weapon draw speed\n"..BAD.."-9% Melee damage",
																-5,			6,					{SKILL_TRIGGER_DISCIPLINE2, SKILL_NONE}, TREE_GUNTREE)
GM:AddSkill(SKILL_TRIGGER_DISCIPLINE2, "Trigger Discipline II", GOOD.."+3% weapon reload speed\n"..GOOD.."+3% weapon draw speed\n"..BAD.."-13% Melee Damage",
																-4,			3,					{SKILL_TRIGGER_DISCIPLINE3, SKILL_D_PALSY, SKILL_EQUIPPED}, TREE_GUNTREE)
GM:AddSkill(SKILL_TRIGGER_DISCIPLINE3, "Trigger Discipline III", GOOD.."+4% weapon reload speed\n"..GOOD.."+4% weapon draw speed\n"..BAD.."-18% Melee damage",
																-3,			0,					{SKILL_QUICKRELOAD, SKILL_QUICKDRAW, SKILL_WORTHINESS1, SKILL_EGOCENTRIC}, TREE_GUNTREE)
GM:AddSkill(SKILL_D_PALSY, "Debuff: Palsy", GOOD.."+10 starting Worth\n"..GOOD.."-3% resupply delay\n"..BAD.."Aiming ability reduced when health is low",
																0,			4,					{SKILL_LEVELHEADED}, TREE_GUNTREE)
GM:AddSkill(SKILL_LEVELHEADED, "Level Headed", GOOD.."-5% reduced effect of aim shake effects",
																-2,			2,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_QUICKDRAW, "Quick Draw", GOOD.."+65% weapon draw speed\n"..BAD.."-15% weapon reload speed",
																0,			1,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_FOCUS, "Focus I", GOOD.."+11% tighter aiming reticule\n"..BAD.."-3% weapon reload speed",
																5,			6,					{SKILL_NONE, SKILL_FOCUSII}, TREE_GUNTREE)
GM:AddSkill(SKILL_FOCUSII, "Focus II", GOOD.."+9% tighter aiming reticule\n"..BAD.."-7% weapon reload speed",
																4,			3,					{SKILL_FOCUSIII, SKILL_SCAVENGER, SKILL_D_PALSY, SKILL_PITCHER}, TREE_GUNTREE)
GM:AddSkill(SKILL_FOCUSIII, "Focus III", GOOD.."+12% tighter aiming reticule\n"..BAD.."-6% weapon reload speed",
																3,			0,					{SKILL_EGOCENTRIC, SKILL_WOOISM, SKILL_ORPHICFOCUS, SKILL_SCOURER}, TREE_GUNTREE)
GM:AddSkill(SKILL_QUICKRELOAD, "Quick Reload", GOOD.."+10% weapon reload speed\n"..BAD.."-25% weapon draw speed",
																-5,			1,					{SKILL_SLEIGHTOFHAND}, TREE_GUNTREE)
GM:AddSkill(SKILL_SLEIGHTOFHAND, "Sleight of Hand", GOOD.."+10% weapon reload speed\n"..BAD.."-5% tighter aiming reticule",
																-5,			-2,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_BANDOLIER, "Bandolier", GOOD.."Give specific buff for reload speed for every weapon and passive +5%\n+13% For Assault;+9% To Explosive\n+21% To Pistol;+11% to Pulse\n+20% To Rifle;+44% For Shotgun\n+12% To SMG;+9% To crossbow",
																-6,			-1,					{SKILL_SLEIGHTOFHAND}, TREE_GUNTREE)
GM:AddSkill(SKILL_U_CRYGASGREN, "Unlock: Cryo Gas Grenade", GOOD.."Unlocks purchasing the Cryo Gas Grenade\nVariant of the Corrosive Gas Grenade\nCryo gas deals a bit of damage over time\nZombies are slowed in the effect",
																2,			-3,					{SKILL_EGOCENTRIC}, TREE_GUNTREE)
GM:AddSkill(SKILL_SOFTDET, "Soft Detonation", GOOD.."-40% explosive damage taken\n"..BAD.."-10% explosive damage radius",
																0,			-5,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_ORPHICFOCUS, "Orphic Focus", GOOD.."90% spread while ironsighting\n"..GOOD.."+2% tighter aiming reticule\n"..BAD.."110% spread at any other time\n"..BAD.."-6% reload speed",
																5,			-1,					{SKILL_DELIBRATION}, TREE_GUNTREE)
GM:AddSkill(SKILL_DELIBRATION, "Delibration", GOOD.."+3% tighter aiming reticule",
																6,			-3,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_EGOCENTRIC, "Egocentric", GOOD.."-40% damage vs. yourself\n"..BAD.."-10 health",
																0,			-1,					{SKILL_BLASTPROOF}, TREE_GUNTREE)
GM:AddSkill(SKILL_BLASTPROOF, "Blast Proof", GOOD.."-40% damage vs. yourself\n"..BAD.."-10% reload speed\n"..BAD.."-12% weapon draw speed",
																0,			-3,					{SKILL_SOFTDET, SKILL_CANNONBALL, SKILL_CONEFFECT}, TREE_GUNTREE)
GM:AddSkill(SKILL_WOOISM, "Zeal", GOOD.."-50% speed reduction from being ironsighted\n"..BAD.."-25% accuracy bonus from ironsighting",
																5,			1,					{SKILL_TRUEWOOISM}, TREE_GUNTREE)
GM:AddSkill(SKILL_SCAVENGER, "Scavenger's Eyes", GOOD.."See nearby weapons, ammo, and items through walls",
																7,			4,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_PITCHER, "Pitcher", GOOD.."+10% object throw and thrown weapon velocity",
																6,			2,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_EQUIPPED, "Alacrity", GOOD.."Your starting item can be a random special trinket",
																-6,			2,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_WORTHINESS1, "Worthiness I", GOOD.."+10 starting worth\n"..BAD.."-3 starting points",
																-4,			-3,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_CANNONBALL, "Cannonball", "-25% projectile speed\n"..GOOD.."+3% projectile damage",
																-2,			-3,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_SCOURER, "Scourer", GOOD.."Earn end of wave points as scrap\n"..BAD.."Earn no end of wave points",
																4,			-3,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_CONEFFECT, "Concentrated Effect", GOOD.."+5% explosive damage\n"..BAD.."-20% explosive damage radius",
																2,			-5,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_TRUEWOOISM, "Wooism", GOOD.."No accuracy penalty from moving or jumping\n"..BAD.."No accuracy bonus from crouching or ironsighting",
																7,			0,					{}, TREE_GUNTREE)

-- Melee Tree
GM:AddSkill(SKILL_WORTHINESS2, "Worthiness II", GOOD.."+10 starting worth\n"..BAD.."-3 starting points",
																4,			0,					{}, TREE_MELEETREE)
GM:AddSkill(SKILL_BATTLER1, "Battler I", GOOD.."+3% melee damage\n"..BAD.."-2% weapon reload speed",
																-6,			-6,					{SKILL_BATTLER2, SKILL_NONE}, TREE_MELEETREE)
GM:AddSkill(SKILL_BATTLER2, "Battler II", GOOD.."+6% melee damage\n"..BAD.."-4% weapon reload speed",
																-6,			-4,					{SKILL_BATTLER3, SKILL_LIGHTWEIGHT}, TREE_MELEETREE)
GM:AddSkill(SKILL_BATTLER3, "Battler III", GOOD.."+8% melee damage\n"..BAD.."-9% weapon reload speed",
																-4,			-2,					{SKILL_BATTLER4, SKILL_LANKY, SKILL_FOUR_IN_ONE}, TREE_MELEETREE)
GM:AddSkill(SKILL_BATTLER4, "Battler IV", GOOD.."+9% melee damage\n"..BAD.."-13% weapon reload speed",
																-2,			0,					{SKILL_BATTLER5, SKILL_MASTERCHEF, SKILL_D_CLUMSY}, TREE_MELEETREE)
GM:AddSkill(SKILL_BATTLER5, "Battler V", GOOD.."+10% melee damage\n"..BAD.."-16% weapon reload speed",
																0,			2,					{SKILL_GLASSWEAPONS, SKILL_BLOODLUST}, TREE_MELEETREE)
GM:AddSkill(SKILL_LASTSTAND, "Last Stand", GOOD.."Double melee damage when below 25% health\n"..BAD.."0.85x melee weapon damage at any other time",
																0,			6,					{SKILL_ABUSE}, TREE_MELEETREE)
GM:AddSkill(SKILL_ABUSE, "Last abuse", GOOD.."+10% Melee damage\n"..BAD.."25% Max health for heal",
																0,			7,					{}, TREE_MELEETREE)
GM:AddSkill(SKILL_SOULNET, "Soul Eater", GOOD.."In Start Gave random soul\n"..GOOD.."Gave +6% Damage for scythe,can randomly give food from ressuply\n"..BAD.."-10% melee damage",
																0,			4,					{SKILL_LASTSTAND}, TREE_MELEETREE)
GM:AddSkill(SKILL_GLASSWEAPONS, "Glass Weapons", GOOD.."3.5x melee weapon damage vs. zombies\n"..BAD.."Your melee weapons have a 50% chance to break when hitting a zombie",
																2,			4,					{}, TREE_MELEETREE)
GM:AddSkill(SKILL_GLASSMAN, "Glass Touch", GOOD.."You Deal x2.3 Damage\n"..BAD.."You Take x3 Damage",
																3,			5,					{SKILL_GLASSWEAPONS}, TREE_MELEETREE)
GM:AddSkill(SKILL_D_CLUMSY, "Debuff: Clumsy", GOOD.."+20 starting Worth\n"..GOOD.."+5 starting points\n"..BAD.."Very easy to be knocked down",
																-2,			2,					{}, TREE_MELEETREE)
GM:AddSkill(SKILL_CHEAPKNUCKLE, "Cheap Tactics", GOOD.."Slow targets when striking with a melee weapon from behind\n"..BAD.."-10% melee range",
																4,			-2,					{SKILL_HEAVYSTRIKES, SKILL_WORTHINESS2}, TREE_MELEETREE)
GM:AddSkill(SKILL_CRITICALKNUCKLE, "Critical Knuckle", GOOD.."Knockback when using unarmed strikes\n"..BAD.."-25% unarmed strike damage\n"..BAD.."+25% time before next unarmed strike",
																6,			-2,					{SKILL_BRASH}, TREE_MELEETREE)
GM:AddSkill(SKILL_KNUCKLEMASTER, "Knuckle Master", GOOD.."+75% unarmed strike damage\n"..GOOD.."Movement speed is no longer slower when using unarmed strikes\n"..BAD.."+35% time before next unarmed strike",
																6,			-6,					{SKILL_NONE, SKILL_COMBOKNUCKLE}, TREE_MELEETREE)
GM:AddSkill(SKILL_COMBOKNUCKLE, "Combo Knuckle", GOOD.."Next unarmed strike is 2x faster if hitting something\n"..BAD.."Next unarmed attack is 2x slower if not hitting something",
																6,			-4,					{SKILL_CHEAPKNUCKLE, SKILL_CRITICALKNUCKLE}, TREE_MELEETREE)
GM:AddSkill(SKILL_HEAVYSTRIKES, "Heavy Strikes", GOOD.."+100% melee knockback\n"..BAD.."8% of melee damage dealt is reflected back to you\n"..BAD.."100% reflected if using unarmed strikes",
																2,			0,					{SKILL_BATTLER5, SKILL_JOUSTER}, TREE_MELEETREE)
GM:AddSkill(SKILL_JOUSTER, "Jouster", GOOD.."+20% melee damage\n"..BAD.."-90% melee knockback",
																2,			2,					{SKILL_BLOODLOST}, TREE_MELEETREE)
GM:AddSkill(SKILL_BLOODLOST, "Bloodlust", GOOD.."+25% Damage Multiplier for  6 secs if take damage\n"..BAD.."-30 health",
																3,			2,					{}, TREE_MELEETREE)
GM:AddSkill(SKILL_LANKY, "Lanky I", GOOD.."+10% melee range\n"..BAD.."-15% melee damage",
																-4,			0,					{SKILL_LANKYII}, TREE_MELEETREE)
GM:AddSkill(SKILL_LANKYII, "Lanky II", GOOD.."+10% melee range\n"..BAD.."-15% melee damage",
																-4,			2,					{}, TREE_MELEETREE)
GM:AddSkill(SKILL_MASTERCHEF, "Master Chef", GOOD.."Zombies hit by culinary weapons in the past second have a chance to drop food items on death\n"..BAD.."-10% melee damage",
																0,			-3,					{SKILL_BATTLER4}, TREE_MELEETREE)
GM:AddSkill(SKILL_LIGHTWEIGHT, "Lightweight", GOOD.."+6 movement speed with a melee weapon equipped\n"..BAD.."-20% melee damage",
																-6,			-2,					{}, TREE_MELEETREE)
GM:AddSkill(SKILL_BLOODLUST, "Phantom Rage", "Gain phantom health equal to half the damage taken from zombies\nLose phantom health equal to any healing received\nPhantom health decreases by 5 per second\n"..GOOD.."Heal 25% of damage done with melee from remaining phantom health\n"..BAD.."-50% healing received",
																-2,			4,					{SKILL_LASTSTAND}, TREE_MELEETREE)
GM:AddSkill(SKILL_BRASH, "Brash", GOOD.."-16% melee swing impact delay\n"..BAD.."-15 speed on melee kill for 10 seconds",
																6,			0,					{}, TREE_MELEETREE)
GM:AddSkill(SKILL_FOUR_IN_ONE, "2 in 1", GOOD.."-9% melee swing impact delay\n"..BAD.."-7 health",
																-2,			-2,					{}, TREE_MELEETREE)
GM:AddSkill(SKILL_THREE_IN_ONE, "3 in 1", GOOD.."-16% melee swing impact delay\n"..BAD.."-10 health",
																-3,			-3,					{SKILL_FOUR_IN_ONE}, TREE_MELEETREE)

SKILL_POINTI = 157
GM:AddSkillModifier(SKILL_POINTI, SKILLMOD_POINT_MULTIPLIER, 0.02)
GM:AddSkill(SKILL_POINTI, "Point I", GOOD.."+0.04 Luck,+2% Point MUL\n The quality system increases the chances of getting a better soul",
																0,			0,					{SKILL_NONE}, TREE_POINTTREE)
SKILL_POINTII = 158
GM:AddSkillModifier(SKILL_POINTII, SKILLMOD_POINT_MULTIPLIER, 0.03)
GM:AddSkill(SKILL_POINTII, "Point II", GOOD.."+0.06 Luck,+3% Point MUL",
																-0.5,			-1,					{SKILL_POINTI}, TREE_POINTTREE)
SKILL_POINTIII = 159
GM:AddSkillModifier(SKILL_POINTIII, SKILLMOD_POINT_MULTIPLIER, 0.05)
GM:AddSkill(SKILL_POINTIII, "Point III", NEUTRAL.."+0.15 Luck\n"..GOOD.."+5% Point MUL",
																-1,			-2,					{SKILL_POINTII}, TREE_POINTTREE)
SKILL_POINTIIII = 160
	GM:AddSkillModifier(SKILL_POINTIIII, SKILLMOD_POINT_MULTIPLIER, 0.07)
	GM:AddSkillModifier(SKILL_POINTIIII, SKILLMOD_POINTS, 5)
GM:AddSkill(SKILL_POINTIIII, "Pointer", NEUTRAL.."+0.40 Luck\n"..GOOD.."+7% Point MUL\n" ..GOOD.. "+5 Start Points",
																-2,			-3,					{SKILL_POINTIII}, TREE_POINTTREE)
	SKILL_LUCK = 161
	GM:AddSkillModifier(SKILL_LUCK, SKILLMOD_POINT_MULTIPLIER, 0.01)
GM:AddSkill(SKILL_LUCK, "Luck", NEUTRAL.."+1 luck",
																-3,			-3,					{SKILL_POINTIIII}, TREE_POINTTREE)
SKILL_LUCKE = 162
GM:AddSkillModifier(SKILL_LUCKE, SKILLMOD_POINT_MULTIPLIER, 0.1)
GM:AddSkill(SKILL_LUCKE, "Luckiest", NEUTRAL.."+2 luck\n" ..BAD.. "-10% Points MUL",
	1,			-2,					{SKILL_POINTIIII}, TREE_POINTTREE)
	SKILL_BLUCK = 163
	GM:AddSkillModifier(SKILL_BLUCK, SKILLMOD_POINT_MULTIPLIER, 0.01)
GM:AddSkill(SKILL_BLUCK, "Quad", GOOD.."Better quality system\n" ..BAD.. "-3% Points Multiplier",
	2,			-2.75,					{SKILL_LUCKE}, TREE_POINTTREE)
	SKILL_PILLUCK = 164
	GM:AddSkillModifier(SKILL_PILLUCK, SKILLMOD_POINT_MULTIPLIER, 0.03)
GM:AddSkill(SKILL_PILLUCK, "Lucky Pill", GOOD.."Luck up if you eat good pill\n" ..BAD.. "Luck Down if you eat bad pill",
	-1,			-4,					{SKILL_POINTIIII}, TREE_POINTTREE)
	SKILL_DUDEE = 166
	GM:AddSkillModifier(SKILL_DUDEE, SKILLMOD_POINT_MULTIPLIER, 0.20)
GM:AddSkill(SKILL_DUDEE, "Lucky man", GOOD.."+2 Luck\n",
	2,			-5,					{SKILL_LUCKE,SKILL_WORTHINESS4}, TREE_POINTTREE)
	SKILL_BADTRIP = 167
	GM:AddSkillModifier(SKILL_BADTRIP, SKILLMOD_POINT_MULTIPLIER, 0.10)
	GM:AddSkill(SKILL_BADTRIP, "Bad Trip", GOOD.."+10% Points multiplier\n" ..BAD.. "System of Quality does not work",
		2,			-6,					{SKILL_DUDEE}, TREE_POINTTREE)
		SKILL_SCAM = 168
		GM:AddSkillModifier(SKILL_SCAM, SKILLMOD_POINT_MULTIPLIER, 0.10)
		GM:AddSkill(SKILL_SCAM, "Scam", GOOD.."+10% Points Multiplier \n" ..BAD.. "Quality is worse",
			3,			-8,					{SKILL_BADTRIP}, TREE_POINTTREE)
			SKILL_SOLARUZ = 169
			GM:AddSkillModifier(SKILL_SOLARUZ, SKILLMOD_POINT_MULTIPLIER, 0.30)
			GM:AddSkillModifier(SKILL_SOLARUZ, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.40)
			GM:AddSkill(SKILL_SOLARUZ, "Debuff:Deadly Fortuna", GOOD.."+30% Points Multiplicator \n" ..BAD.. "+40% damage taken melee",
				3,			-9,					{SKILL_SCAM}, TREE_POINTTREE)
SKILL_ANCK = 170
GM:AddSkill(SKILL_ANCK, "Ancient knowledge", GOOD.."Learn The Ancient knowledge \n" ..BAD.. "The cost of knowledge",
					0,			0,					{SKILL_SOLARUZ}, TREE_ANCIENTTREE)
SKILL_ANCK1 = 171
GM:AddSkill(SKILL_ANCK1, "Ancient Volume 1", GOOD.."Learn The Ancient knowledge\n You know only 50%",
					0,			-1,					{SKILL_ANCK}, TREE_ANCIENTTREE)
SKILL_ANCK2 = 172
GM:AddSkill(SKILL_ANCK2, "Ancient Volume 2", GOOD.."You Know 100%!",
					0,			-2,					{SKILL_ANCK1}, TREE_ANCIENTTREE)

SKILL_STRICTE = 173
GM:AddSkillModifier(SKILL_STRICTE, SKILLMOD_MELEE_DAMAGE_MUL, 0.05)
GM:AddSkill(SKILL_STRICTE, "Stricte praecepta", GOOD.."+ 5% Melee damage!",
					1,			-4,					{SKILL_ANCK2}, TREE_ANCIENTTREE)
SKILL_VERUS = 174
GM:AddSkillModifier(SKILL_VERUS, SKILLMOD_MANHACK_DAMAGE_MUL, 0.33)
GM:AddSkillModifier(SKILL_VERUS, SKILLMOD_MANHACK_HEALTH_MUL, 0.33)
GM:AddSkill(SKILL_VERUS, "Verus", GOOD.."Better  +33% manhack!",
					-1,			-4,					{SKILL_ANCK2}, TREE_ANCIENTTREE)
SKILL_PIGNUS = 175
GM:AddSkillModifier(SKILL_PIGNUS, SKILLMOD_TURRET_SCANSPEED_MUL, 0.33)
GM:AddSkillModifier(SKILL_PIGNUS, SKILLMOD_TURRET_HEALTH_MUL, 0.33)
GM:AddSkillModifier(SKILL_PIGNUS, SKILLMOD_TURRET_RANGE_MUL, 0.33)
GM:AddSkill(SKILL_PIGNUS, "Pignus", GOOD.."Better turrets!",
					-1,			-5,					{SKILL_VERUS}, TREE_ANCIENTTREE)
SKILL_STRENGHT = 176
GM:AddSkillModifier(SKILL_STRENGHT, SKILLMOD_MELEE_DAMAGE_MUL, 0.1)
GM:AddSkill(SKILL_STRENGHT, "Strongman", GOOD.."+10% Melee damage!",
					1,			-5,					{SKILL_STRICTE}, TREE_ANCIENTTREE)
SKILL_EX = 177
GM:AddSkill(SKILL_EX, "Exsecrandus", GOOD.."USELESS!",
					0,			-6,					{SKILL_PIGNUS,SKILL_STRENGHT}, TREE_ANCIENTTREE)
SKILL_EX2 = 178					
GM:AddSkill(SKILL_EX2, "Scientia", GOOD.."Science!",
					0,			-7,					{SKILL_EX}, TREE_ANCIENTTREE)
					SKILL_ANIMA = 179		
GM:AddSkillModifier(SKILL_ANIMA, SKILLMOD_MELEE_DAMAGE_MUL, 0.15)
GM:AddSkillModifier(SKILL_ANIMA, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.10)			
GM:AddSkill(SKILL_ANIMA, "Fines de anima", GOOD.."+15% melee damage\n" ..BAD.."+10% Melee damage taken!",
					-3,			-7,					{SKILL_EX2}, TREE_ANCIENTTREE)
	SKILL_MERCUS = 184
					GM:AddSkillModifier(SKILL_MERCUS, SKILLMOD_RESUPPLY_DELAY_MUL, -0.10)			
					GM:AddSkill(SKILL_MERCUS, "Mortiferum Pompam", GOOD.."-10% Ressuply Delay",
										-4,			-7,					{SKILL_ANIMA}, TREE_ANCIENTTREE)
SKILL_SIGILIBERATOR = 180	
GM:AddSkillModifier(SKILL_SIGILIBERATOR, SKILLMOD_MELEE_DAMAGE_MUL, 2)
	GM:AddSkillModifier(SKILL_SIGILIBERATOR, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 2)			
GM:AddSkill(SKILL_SIGILIBERATOR, "Liberator", GOOD.."x2 damage\n" ..BAD.."x2 damage taken",
										-3,			-9,					{SKILL_EX2}, TREE_ANCIENTTREE)
										SKILL_DEATH = 181	
GM:AddSkillModifier(SKILL_DEATH, SKILLMOD_MEDKIT_COOLDOWN_MUL, 0.2)
GM:AddSkillModifier(SKILL_DEATH, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.2)		
GM:AddSkill(SKILL_DEATH, "Morieris", GOOD.."Better medicine\n" ..BAD.."+20% Medkit Cooldown\n"..GOOD.."+20% Medkit effectiveness",
										-3,			-8,					{SKILL_EX2}, TREE_ANCIENTTREE)
										SKILL_ALLPOWER = 182
GM:AddSkillModifier(SKILL_ALLPOWER, SKILLMOD_REPAIRRATE_MUL, 0.10)		
GM:AddSkill(SKILL_ALLPOWER, "Cunctipotens", GOOD.."Better cades\n" ..GOOD.."+10% Repair Mul",
					-4,			-8,					{SKILL_DEATH}, TREE_ANCIENTTREE)
SKILL_ANCIENT = 183
GM:AddSkillModifier(SKILL_ANCIENT, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.47)
GM:AddSkillModifier(SKILL_ANCIENT, SKILLMOD_MELEE_DAMAGE_MUL, 0.2)		
GM:AddSkill(SKILL_ANCIENT, "Adventum Antiqua", GOOD.."+20% Damage melee\n" ..BAD.."+47% Damage taken mul",
					-4,			-9,					{SKILL_SIGILIBERATOR}, TREE_ANCIENTTREE)
					SKILL_CLASSIX1 = 185	
GM:AddSkill(SKILL_CLASSIX1, "Classical scientia mundi", GOOD.."Random bloodarmor",
					-5,			-8,					{SKILL_ALLPOWER}, TREE_ANCIENTTREE)
SKILL_BLOODMARY = 186
GM:AddSkill(SKILL_BLOODMARY, "Sanguinum Messis", GOOD.."useless",
										-5,			-9,					{SKILL_ANCIENT}, TREE_ANCIENTTREE)
										SKILL_TRUEPOWER = 187
GM:AddSkill(SKILL_TRUEPOWER, "Future Knowledge Vol.3", GOOD.."Cost Of Knowledge",
																				-5,			-10,					{SKILL_BLOODMARY}, TREE_ANCIENTTREE)
																														SKILL_HEARTS = 202
GM:AddSkill(SKILL_HEARTS, "Ancient Hearts", GOOD.."Unlock Heart Trinkets",
																				-5,			-11,					{SKILL_TRUEPOWER}, TREE_ANCIENTTREE)

SKILL_DEFEND = 190
GM:AddSkill(SKILL_DEFEND, "Defender of the Sigil I", GOOD.."You get 2% less damage\n"..BAD.."Speed -1",
				                                                            	-0.25,			-0.5,					{SKILL_NONE}, TREE_DEFENSETREE)

GM:AddSkillModifier(SKILL_DEFEND, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.02)
GM:AddSkillModifier(SKILL_DEFEND, SKILLMOD_SPEED, -1)

SKILL_DEFEND1 = 191
GM:AddSkill(SKILL_DEFEND1, "Defender of the Sigil II", GOOD.."You get 2% less damage\n"..BAD.."Speed -2",
				                                                            	0.75,			0,					{SKILL_DEFEND}, TREE_DEFENSETREE)

GM:AddSkillModifier(SKILL_DEFEND1, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.02)
GM:AddSkillModifier(SKILL_DEFEND1, SKILLMOD_SPEED, -2)
SKILL_DEFEND2 = 192
GM:AddSkill(SKILL_DEFEND2, "Defender of the Sigil III", GOOD.."You get 3% less damage\n"..BAD.."Speed -4",
				                                                            	1.5,			1,					{SKILL_DEFEND1}, TREE_DEFENSETREE)

GM:AddSkillModifier(SKILL_DEFEND2, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.03)
GM:AddSkillModifier(SKILL_DEFEND2, SKILLMOD_SPEED, -4)
SKILL_DEFEND3 = 193
GM:AddSkill(SKILL_DEFEND3, "Defender of the Sigil IV", GOOD.."You get 4% less damage\n"..BAD.."Speed -6",
				                                                            	1.5,			2,					{SKILL_DEFEND2}, TREE_DEFENSETREE)

GM:AddSkillModifier(SKILL_DEFEND3, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.04)
GM:AddSkillModifier(SKILL_DEFEND3, SKILLMOD_SPEED, -6)
SKILL_DEFEND4 = 194
GM:AddSkill(SKILL_DEFEND4, "Defender of the Sigil V", GOOD.."You get 6% less damage\n"..BAD.."Speed -12",
				                                                            	0.75,			3,					{SKILL_DEFEND3}, TREE_DEFENSETREE)

GM:AddSkillModifier(SKILL_DEFEND4, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.06)
GM:AddSkillModifier(SKILL_DEFEND4, SKILLMOD_SPEED, -12)
SKILL_DEFEND5 = 195
GM:AddSkill(SKILL_DEFEND5, "Defender of the Sigil VI", GOOD.."You get 9% less damage\n"..BAD.."Speed -16",
				                                                            	0,			3.5,					{SKILL_DEFEND4}, TREE_DEFENSETREE)

GM:AddSkillModifier(SKILL_DEFEND5, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.09)
GM:AddSkillModifier(SKILL_DEFEND5, SKILLMOD_SPEED, -16)
SKILL_DEFENDER = 196
GM:AddSkill(SKILL_DEFENDER, "Defender of Humans", GOOD.."You get 4% less damage\n"..BAD.."Melee damage multiplier 0.96x",
				                                                            	-1.5,			0,					{SKILL_DEFEND}, TREE_DEFENSETREE)

GM:AddSkillModifier(SKILL_DEFENDER, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.04)
GM:AddSkillModifier(SKILL_DEFENDER, SKILLMOD_MELEE_DAMAGE_MUL, -0.04)
SKILL_DEFENDEROFM = 197
GM:AddSkill(SKILL_DEFENDEROFM, "Defender of Monsters", BAD.."You get 5% more damage\n"..GOOD.."Melee damage multiplier 1.05x",
				                                                            	-2,			1,					{SKILL_DEFENDER}, TREE_DEFENSETREE)

GM:AddSkillModifier(SKILL_DEFENDEROFM, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.05)
GM:AddSkillModifier(SKILL_DEFENDEROFM, SKILLMOD_MELEE_DAMAGE_MUL, 0.05)
SKILL_TRIP = 198
GM:AddSkill(SKILL_TRIP, "Wall curse", GOOD.."-20% Damage taken\n"..BAD.."Melee damage multiplier 0.73x\n"..BAD.."-60 Speed\nYou have power of the wall!",
				                                                            	-2,			2,					{SKILL_DEFENDEROFM}, TREE_DEFENSETREE)

GM:AddSkillModifier(SKILL_TRIP, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.20)
GM:AddSkillModifier(SKILL_TRIP, SKILLMOD_MELEE_DAMAGE_MUL, -0.27)
GM:AddSkillModifier(SKILL_TRIP, SKILLMOD_SPEED, -60)
SKILL_MERIS = 199
GM:AddSkill(SKILL_MERIS, "Meris", GOOD.."-10% Damage taken\n"..BAD.."-20% Melee damage!",
				                                                            	-1,			3.5,					{SKILL_TRIP}, TREE_DEFENSETREE)

GM:AddSkillModifier(SKILL_MERIS, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.10)
GM:AddSkillModifier(SKILL_MERIS, SKILLMOD_MELEE_DAMAGE_MUL, -0.2)
GM:AddSkill(SKILL_DONATE1, "Donate I", GOOD.."-3% Damage taken\n"..GOOD.."+2% Melee damage! Thank Null",
				                                                            	21,			20,					{SKILL_NONE}, TREE_DONATETREE)

GM:AddSkillModifier(SKILL_DONATE1, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.03)
GM:AddSkillModifier(SKILL_DONATE1, SKILLMOD_MELEE_DAMAGE_MUL, 0.02)
SKILL_DONATE2 = 204
GM:AddSkill(SKILL_DONATE2, "Donate II", GOOD.."+5 Blood armor\n"..GOOD.."-5% Poison Speed!Thank Null",
				                                                            	20,			21,					{SKILL_DONATE1}, TREE_DONATETREE)

GM:AddSkillModifier(SKILL_DONATE2, SKILLMOD_BLOODARMOR, 5)
GM:AddSkillModifier(SKILL_DONATE2, SKILLMOD_POISON_SPEED_MUL, -0.05)
SKILL_HELPFORPROJECT = 205
GM:AddSkill(SKILL_HELPFORPROJECT, "Donate", GOOD.."Donate if you want to get new skills\n"..BAD.."+1 skill for every donate",
				                                                            	20,			20,					{}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_HELPFORPROJECT, SKILLMOD_BLOODARMOR, 1)
SKILL_DONATE3 = 206
GM:AddSkill(SKILL_DONATE3, "Donate III", GOOD.."+50% For XP\n"..BAD.."THX Chayok",
				                                                            	20,			22,					{SKILL_DONATE2}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_DONATE3, SKILLMOD_XP, 0.50)
SKILL_DONATE4 = 207
GM:AddSkill(SKILL_DONATE4, "Donate IV", GOOD.."+10% Reload Speed\n"..BAD.."THX cheetus and null",
				                                                            	21,			23,					{SKILL_DONATE3}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_DONATE4, SKILLMOD_RELOADSPEED_MUL, 0.10)
SKILL_DONATE5 = 208
GM:AddSkill(SKILL_DONATE5, "Donate V", GOOD.."Sale by 6%\n"..BAD.."Thx ivan36099",
				                                                            	22,			23,					{SKILL_DONATE4}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_DONATE5, SKILLMOD_ARSENAL_DISCOUNT, -0.03)
SKILL_DONATE6 = 209
GM:AddSkill(SKILL_DONATE6, "Donate VI", GOOD.."+15% To blood armor convert\n"..BAD.."THX Null",
				                                                            	22,			24,					{SKILL_DONATE5}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_DONATE6, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.15)
SKILL_DONATE7 = 211
GM:AddSkill(SKILL_DONATE7, "Donate VII", GOOD.."+20% Hammer repair mul\n"..BAD.."THX chayok01 and null",
				                                                            	21,			24,					{SKILL_DONATE6}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_DONATE7, SKILLMOD_REPAIRRATE_MUL, 0.20)
SKILL_DONATE8 = 212
GM:AddSkill(SKILL_DONATE8, "Donate VIII", GOOD.."+% Reload speed\n"..BAD.."Donate if you want to unlock this skill",
				                                                            	21,			25,					{SKILL_DONATE9}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_DONATE8, SKILLMOD_RELOADSPEED_MUL, 0.10)
SKILL_DONATE9 = 213
GM:AddSkill(SKILL_DONATE9, "Donate IX", GOOD.."+ Health\n"..BAD.."Donate if you want to unlock this skill",
				                                                            	20,			25,					{SKILL_DONATE8}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_DONATE9, SKILLMOD_HEALTH, 5)
SKILL_DONATE10 = 214
GM:AddSkill(SKILL_DONATE10, "Donate X", GOOD.."+ Worth\n"..BAD.."Donate if you want to unlock this skill",
				                                                            	21,			26,					{SKILL_DONATE9}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_DONATE10, SKILLMOD_WORTH, 10)
SKILL_CHALLENGER1 = 215
GM:AddSkill(SKILL_CHALLENGER1, "Challenger I", GOOD.."+20 Health,+5% Sale, help for challenges!\n"..GOOD.."Can use in any challenge",
				                                                            	25,			26,					{SKILL_NONE, SKILL_CHALLENGER2}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_CHALLENGER1, SKILLMOD_HEALTH, 20)
GM:AddSkillModifier(SKILL_CHALLENGER1, SKILLMOD_ARSENAL_DISCOUNT, -0.05)
SKILL_CHALLENGER2 = 216
GM:AddSkill(SKILL_CHALLENGER2, "Challenger II", GOOD.."+20% Reload speed\n"..GOOD.."Can use in any challenge",
				                                                            	25,			24,					{SKILL_CHALLENGER1}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_CHALLENGER2, SKILLMOD_RELOADSPEED_MUL, 0.2)
SKILL_CHALLENGER3 = 217
GM:AddSkill(SKILL_CHALLENGER3, "Challenger III", GOOD.."+100% XP Multiplier\n"..GOOD.."Can use in any challenge",
				                                                            	25,			20,					{}, TREE_DONATETREE)
GM:AddSkillModifier(SKILL_CHALLENGER3, SKILLMOD_XP, 1)






GM:AddSkillModifier(SKILL_BLOODLOST, SKILLMOD_HEALTH, -30)
GM:AddSkillModifier(SKILL_ABUSE, SKILLMOD_MELEE_DAMAGE_MUL, 0.1)




GM:SetSkillModifierFunction(SKILLMOD_SPEED, function(pl, amount)
	pl.SkillSpeedAdd = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, function(pl, amount)
	pl.MedicHealMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MEDKIT_COOLDOWN_MUL, function(pl, amount)
	pl.MedicCooldownMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)
GM:SetSkillModifierFunction(SKILLMOD_HEADSHOT_MUL, function(pl, amount)
	pl.HeadshotMulti = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_WORTH, function(pl, amount)
	pl.ExtraStartingWorth = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_FALLDAMAGE_THRESHOLD_MUL, function(pl, amount)
	pl.FallDamageThresholdMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, function(pl, amount)
	pl.FallDamageSlowDownMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_FOODEATTIME_MUL, function(pl, amount)
	pl.FoodEatTimeMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_JUMPPOWER_MUL, function(pl, amount)
	pl.JumpPowerMul = math.Clamp(amount + 1.0, 0.0, 10.0)

	if SERVER then
		pl:ResetJumpPower()
	end
end)

GM:SetSkillModifierFunction(SKILLMOD_DEPLOYSPEED_MUL, function(pl, amount)
	pl.DeploySpeedMultiplier = math.Clamp(amount + 1.0, 0.05, 100.0)

	for _, wep in pairs(pl:GetWeapons()) do
		GAMEMODE:DoChangeDeploySpeed(wep)
	end
end)

GM:SetSkillModifierFunction(SKILLMOD_BLOODARMOR, function(pl, amount)
	local oldarmor = pl:GetBloodArmor()
	local oldcap = pl.MaxBloodArmor or 20
	local new = 20 + math.Clamp(amount, -20, 1000)

	pl.MaxBloodArmor = new

	if SERVER then
		if oldarmor > oldcap then
			local overcap = oldarmor - oldcap
			pl:SetBloodArmor(pl.MaxBloodArmor + overcap)
		else
			pl:SetBloodArmor(pl:GetBloodArmor() / oldcap * new)
		end
	end
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplier = math.Clamp(amount + 1.0, 0.05, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_DAMAGE_MUL, function(pl, amount)
	pl.MeleeDamageMultiplier = math.Clamp(amount + 1.0, 0.0, 100.0)
end)
GM:SetSkillModifierFunction(SKILLMOD_DAMAGE, function(pl, amount)
	pl.DamageMultiplier = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_SELF_DAMAGE_MUL, function(pl, amount)
	pl.SelfDamageMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_KNOCKBACK_MUL, function(pl, amount)
	pl.MeleeKnockbackMultiplier = math.Clamp(amount + 1.0, 0.0, 10000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_UNARMED_DAMAGE_MUL, function(pl, amount)
	pl.UnarmedDamageMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_UNARMED_SWING_DELAY_MUL, function(pl, amount)
	pl.UnarmedDelayMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_BARRICADE_PHASE_SPEED_MUL, function(pl, amount)
	pl.BarricadePhaseSpeedMul = math.Clamp(amount + 1.0, 0.05, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_HAMMER_SWING_DELAY_MUL, function(pl, amount)
	pl.HammerSwingDelayMul = math.Clamp(amount + 1.0, 0.01, 1.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_REPAIRRATE_MUL, function(pl, amount)
	pl.RepairRateMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_AIMSPREAD_MUL, function(pl, amount)
	pl.AimSpreadMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MEDGUN_FIRE_DELAY_MUL, function(pl, amount)
	pl.MedgunFireDelayMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MEDGUN_RELOAD_SPEED_MUL, function(pl, amount)
	pl.MedgunReloadSpeedMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_DRONE_GUN_RANGE_MUL, function(pl, amount)
	pl.DroneGunRangeMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_HEALING_RECEIVED, function(pl, amount)
	pl.HealingReceived = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_PISTOL_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierPISTOL = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_SMG_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierSMG1 = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_ASSAULT_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierAR2 = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_SHELL_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierBUCKSHOT = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_RIFLE_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplier357 = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_XBOW_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierXBOWBOLT = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_PULSE_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierPULSE = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_EXP_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierIMPACTMINE = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_ATTACKER_DMG_REFLECT, function(pl, amount)
	pl.BarbedArmor = math.Clamp(amount, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_PULSE_WEAPON_SLOW_MUL, function(pl, amount)
	pl.PulseWeaponSlowMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.MeleeDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_POISON_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.PoisonDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.BleedDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_SWING_DELAY_MUL, function(pl, amount)
	pl.MeleeSwingDelayMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, function(pl, amount)
	pl.MeleeDamageToBloodArmorMul = math.Clamp(amount, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, function(pl, amount)
	pl.MeleeMovementSpeedOnKill = math.Clamp(amount, -15, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_POWERATTACK_MUL, function(pl, amount)
	pl.MeleePowerAttackMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_KNOCKDOWN_RECOVERY_MUL, function(pl, amount)
	pl.KnockdownRecoveryMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_RANGE_MUL, function(pl, amount)
	pl.MeleeRangeMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_SLOW_EFF_TAKEN_MUL, function(pl, amount)
	pl.SlowEffTakenMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_EXP_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.ExplosiveDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_FIRE_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.FireDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_PROP_CARRY_CAPACITY_MUL, function(pl, amount)
	pl.PropCarryCapacityMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_PROP_THROW_STRENGTH_MUL, function(pl, amount)
	pl.ObjectThrowStrengthMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_PHYSICS_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.PhysicsDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_VISION_ALTER_DURATION_MUL, function(pl, amount)
	pl.VisionAlterDurationMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_DIMVISION_EFF_MUL, function(pl, amount)
	pl.DimVisionEffMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_XP, function(pl, amount)
	GAMEMODE.HumanXPMulti = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)
GM:SetSkillModifierFunction(SKILLMOD_PROP_CARRY_SLOW_MUL, function(pl, amount)
	pl.PropCarrySlowMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_BLEED_SPEED_MUL, function(pl, amount)
	pl.BleedSpeedMul = math.Clamp(amount + 1.0, 0.1, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_LEG_DAMAGE_ADD, function(pl, amount)
	pl.MeleeLegDamageAdd = math.Clamp(amount, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_SIGIL_TELEPORT_MUL, function(pl, amount)
	pl.SigilTeleportTimeMul = math.Clamp(amount + 1.0, 0.1, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT, function(pl, amount)
	pl.BarbedArmorPercent = math.Clamp(amount, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_POISON_SPEED_MUL, function(pl, amount)
	pl.PoisonSpeedMul = math.Clamp(amount + 1.0, 0.1, 1000.0)
end)


GM:SetSkillModifierFunction(SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL, GM:MkGenericMod("ProjDamageTakenMul"))
GM:SetSkillModifierFunction(SKILLMOD_EXP_DAMAGE_RADIUS, GM:MkGenericMod("ExpDamageRadiusMul"))
GM:SetSkillModifierFunction(SKILLMOD_WEAPON_WEIGHT_SLOW_MUL, GM:MkGenericMod("WeaponWeightSlowMul"))
GM:SetSkillModifierFunction(SKILLMOD_FRIGHT_DURATION_MUL, GM:MkGenericMod("FrightDurationMul"))
GM:SetSkillModifierFunction(SKILLMOD_IRONSIGHT_EFF_MUL, GM:MkGenericMod("IronsightEffMul"))
GM:SetSkillModifierFunction(SKILLMOD_MEDDART_EFFECTIVENESS_MUL, GM:MkGenericMod("MedDartEffMul"))

GM:SetSkillModifierFunction(SKILLMOD_BLOODARMOR_DMG_REDUCTION, function(pl, amount)
	pl.BloodArmorDamageReductionAdd = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_BLOODARMOR_MUL, function(pl, amount)
	local mul = math.Clamp(amount + 1.0, 0.0, 1000.0)

	pl.MaxBloodArmorMul = mul

	local oldarmor = pl:GetBloodArmor()
	local oldcap = pl.MaxBloodArmor or 20
	local new = pl.MaxBloodArmor * mul

	pl.MaxBloodArmor = new

	if SERVER then
		if oldarmor > oldcap then
			local overcap = oldarmor - oldcap
			pl:SetBloodArmor(pl.MaxBloodArmor + overcap)
		else
			pl:SetBloodArmor(pl:GetBloodArmor() / oldcap * new)
		end
	end
end)

GM:SetSkillModifierFunction(SKILLMOD_BLOODARMOR_GAIN_MUL, GM:MkGenericMod("BloodarmorGainMul"))
GM:SetSkillModifierFunction(SKILLMOD_LOW_HEALTH_SLOW_MUL, GM:MkGenericMod("LowHealthSlowMul"))
GM:SetSkillModifierFunction(SKILLMOD_PROJ_SPEED, GM:MkGenericMod("ProjectileSpeedMul"))

GM:SetSkillModifierFunction(SKILLMOD_ENDWAVE_POINTS, function(pl,amount)
	pl.EndWavePointsExtra = math.Clamp(amount, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_ARSENAL_DISCOUNT, GM:MkGenericMod("ArsenalDiscount"))
GM:SetSkillModifierFunction(SKILLMOD_CLOUD_RADIUS, GM:MkGenericMod("CloudRadius"))
GM:SetSkillModifierFunction(SKILLMOD_CLOUD_TIME, GM:MkGenericMod("CloudTime"))
GM:SetSkillModifierFunction(SKILLMOD_EXP_DAMAGE_MUL, GM:MkGenericMod("ExplosiveDamageMul"))
GM:SetSkillModifierFunction(SKILLMOD_PROJECTILE_DAMAGE_MUL, GM:MkGenericMod("ProjectileDamageMul"))
GM:SetSkillModifierFunction(SKILLMOD_TURRET_RANGE_MUL, GM:MkGenericMod("TurretRangeMul"))
GM:SetSkillModifierFunction(SKILLMOD_AIM_SHAKE_MUL, GM:MkGenericMod("AimShakeMul"))


GM:AddSkillModifier(SKILL_BANDOLIER, SKILLMOD_RELOADSPEED_ASSAULT_MUL, 0.13)
GM:AddSkillModifier(SKILL_BANDOLIER, SKILLMOD_RELOADSPEED_EXP_MUL, 0.09)
GM:AddSkillModifier(SKILL_BANDOLIER, SKILLMOD_RELOADSPEED_PISTOL_MUL, 0.21)
GM:AddSkillModifier(SKILL_BANDOLIER, SKILLMOD_RELOADSPEED_PULSE_MUL, 0.11)
GM:AddSkillModifier(SKILL_BANDOLIER, SKILLMOD_RELOADSPEED_RIFLE_MUL, 0.20)
GM:AddSkillModifier(SKILL_BANDOLIER, SKILLMOD_RELOADSPEED_SHELL_MUL, 0.44)
GM:AddSkillModifier(SKILL_BANDOLIER, SKILLMOD_RELOADSPEED_SMG_MUL, 0.12)
GM:AddSkillModifier(SKILL_BANDOLIER, SKILLMOD_RELOADSPEED_XBOW_MUL, 0.09)
GM:AddSkillModifier(SKILL_BANDOLIER, SKILLMOD_RELOADSPEED_MUL, 0.05)

GM:AddSkillModifier(SKILL_SPEED1, SKILLMOD_SPEED, 2)
GM:AddSkillModifier(SKILL_SPEED1, SKILLMOD_HEALTH, -1)

GM:AddSkillModifier(SKILL_SPEED2, SKILLMOD_SPEED, 3)
GM:AddSkillModifier(SKILL_SPEED2, SKILLMOD_HEALTH, -2)

GM:AddSkillModifier(SKILL_SPEED3, SKILLMOD_SPEED, 5)
GM:AddSkillModifier(SKILL_SPEED3, SKILLMOD_HEALTH, -4)

GM:AddSkillModifier(SKILL_SPEED4, SKILLMOD_SPEED, 7)
GM:AddSkillModifier(SKILL_SPEED4, SKILLMOD_HEALTH, -6)

GM:AddSkillModifier(SKILL_SPEED5, SKILLMOD_SPEED, 13)
GM:AddSkillModifier(SKILL_SPEED5, SKILLMOD_HEALTH, -10)

GM:AddSkillModifier(SKILL_STOIC1, SKILLMOD_HEALTH, 4)
GM:AddSkillModifier(SKILL_STOIC1, SKILLMOD_SPEED, -5)

GM:AddSkillModifier(SKILL_STOIC2, SKILLMOD_HEALTH, 5)
GM:AddSkillModifier(SKILL_STOIC2, SKILLMOD_SPEED, -7)

GM:AddSkillModifier(SKILL_STOIC3, SKILLMOD_HEALTH, 6)
GM:AddSkillModifier(SKILL_STOIC3, SKILLMOD_SPEED, -9)

GM:AddSkillModifier(SKILL_STOIC4, SKILLMOD_HEALTH, 8)
GM:AddSkillModifier(SKILL_STOIC4, SKILLMOD_SPEED, -11)

GM:AddSkillModifier(SKILL_STOIC5, SKILLMOD_HEALTH, 11)
GM:AddSkillModifier(SKILL_STOIC5, SKILLMOD_SPEED, -10)

GM:AddSkillModifier(SKILL_VITALITY1, SKILLMOD_HEALTH, 3)
GM:AddSkillModifier(SKILL_VITALITY2, SKILLMOD_HEALTH, 3)
GM:AddSkillModifier(SKILL_VITALITY3, SKILLMOD_HEALTH, 3)
GM:AddSkillModifier(SKILL_CHEESE, SKILLMOD_HEALTH, 10)
GM:AddSkillModifier(SKILL_CHEESE, SKILLMOD_SPEED, 10)

GM:AddSkillModifier(SKILL_MOTIONI, SKILLMOD_SPEED, 5)
GM:AddSkillModifier(SKILL_MOTIONII, SKILLMOD_SPEED, 9)
GM:AddSkillModifier(SKILL_MOTIONIII, SKILLMOD_SPEED, 12)

GM:AddSkillModifier(SKILL_FOCUS, SKILLMOD_AIMSPREAD_MUL, -0.11)
GM:AddSkillModifier(SKILL_FOCUS, SKILLMOD_RELOADSPEED_MUL, -0.03)

GM:AddSkillModifier(SKILL_FOCUSII, SKILLMOD_AIMSPREAD_MUL, -0.09)
GM:AddSkillModifier(SKILL_FOCUSII, SKILLMOD_RELOADSPEED_MUL, -0.07)

GM:AddSkillModifier(SKILL_FOCUSIII, SKILLMOD_AIMSPREAD_MUL, -0.12)
GM:AddSkillModifier(SKILL_FOCUSIII, SKILLMOD_RELOADSPEED_MUL, -0.06)

GM:AddSkillModifier(SKILL_ORPHICFOCUS, SKILLMOD_RELOADSPEED_MUL, -0.06)
GM:AddSkillModifier(SKILL_ORPHICFOCUS, SKILLMOD_AIMSPREAD_MUL, -0.02)

GM:AddSkillModifier(SKILL_DELIBRATION, SKILLMOD_AIMSPREAD_MUL, -0.03)

GM:AddSkillModifier(SKILL_WOOISM, SKILLMOD_IRONSIGHT_EFF_MUL, -0.25)

GM:AddSkillModifier(SKILL_GLUTTON, SKILLMOD_HEALTH, 7)

GM:AddSkillModifier(SKILL_TANKER, SKILLMOD_HEALTH, 60)
GM:AddSkillModifier(SKILL_TANKER, SKILLMOD_SPEED, -40)

GM:AddSkillModifier(SKILL_ULTRANIMBLE, SKILLMOD_HEALTH, -10)
GM:AddSkillModifier(SKILL_ULTRANIMBLE, SKILLMOD_SPEED, 30)

GM:AddSkillModifier(SKILL_EGOCENTRIC, SKILLMOD_SELF_DAMAGE_MUL, -0.4)
GM:AddSkillModifier(SKILL_EGOCENTRIC, SKILLMOD_HEALTH, -10)

GM:AddSkillModifier(SKILL_BLASTPROOF, SKILLMOD_SELF_DAMAGE_MUL, -0.40)
GM:AddSkillModifier(SKILL_BLASTPROOF, SKILLMOD_RELOADSPEED_MUL, -0.10)
GM:AddSkillModifier(SKILL_BLASTPROOF, SKILLMOD_DEPLOYSPEED_MUL, -0.12)

GM:AddSkillModifier(SKILL_SURGEON1, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.06)
GM:AddSkillModifier(SKILL_SURGEON2, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.09)
GM:AddSkillModifier(SKILL_SURGEON3, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.11)
GM:AddSkillModifier(SKILL_SURGEONIV, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.21)

GM:AddSkillModifier(SKILL_BIOLOGYI, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.08)
GM:AddSkillModifier(SKILL_BIOLOGYII, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.13)
GM:AddSkillModifier(SKILL_BIOLOGYIII, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.18)
GM:AddSkillModifier(SKILL_BIOLOGYIV, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.21)

GM:AddSkillModifier(SKILL_HANDY1, SKILLMOD_REPAIRRATE_MUL, 0.05)
GM:AddSkillModifier(SKILL_HANDY2, SKILLMOD_REPAIRRATE_MUL, 0.06)
GM:AddSkillModifier(SKILL_HANDY3, SKILLMOD_REPAIRRATE_MUL, 0.08)
GM:AddSkillModifier(SKILL_HANDY4, SKILLMOD_REPAIRRATE_MUL, 0.11)
GM:AddSkillModifier(SKILL_HANDY5, SKILLMOD_REPAIRRATE_MUL, 0.13)

GM:AddSkillModifier(SKILL_OVERHAND, SKILLMOD_REPAIRRATE_MUL, 0.25)
GM:AddSkillModifier(SKILL_OVERHAND, SKILLMOD_HAMMER_SWING_DELAY_MUL, 0.10)

GM:AddSkillModifier(SKILL_D_SLOW, SKILLMOD_WORTH, 30)
GM:AddSkillModifier(SKILL_D_SLOW, SKILLMOD_ENDWAVE_POINTS, 20)
GM:AddSkillModifier(SKILL_D_SLOW, SKILLMOD_SPEED, -68.75)

GM:AddSkillModifier(SKILL_GOURMET, SKILLMOD_FOODEATTIME_MUL, 2.0)
GM:AddSkillModifier(SKILL_GOURMET, SKILLMOD_FOODRECOVERY_MUL, 4.0)

GM:AddSkillModifier(SKILL_SUGARRUSH, SKILLMOD_FOODRECOVERY_MUL, -0.35)

GM:AddSkillModifier(SKILL_BATTLER1, SKILLMOD_MELEE_DAMAGE_MUL, 0.01)
GM:AddSkillModifier(SKILL_BATTLER2, SKILLMOD_MELEE_DAMAGE_MUL, 0.03)
GM:AddSkillModifier(SKILL_BATTLER3, SKILLMOD_MELEE_DAMAGE_MUL, 0.03)
GM:AddSkillModifier(SKILL_BATTLER4, SKILLMOD_MELEE_DAMAGE_MUL, 0.07)
GM:AddSkillModifier(SKILL_BATTLER5, SKILLMOD_MELEE_DAMAGE_MUL, 0.09)
GM:AddSkillModifier(SKILL_SOULNET, SKILLMOD_MELEE_DAMAGE_MUL,-0.10)

GM:AddSkillModifier(SKILL_BATTLER1, SKILLMOD_RELOADSPEED_MUL, -0.02)
GM:AddSkillModifier(SKILL_BATTLER2, SKILLMOD_RELOADSPEED_MUL, -0.04)
GM:AddSkillModifier(SKILL_BATTLER3, SKILLMOD_RELOADSPEED_MUL, -0.09)
GM:AddSkillModifier(SKILL_BATTLER4, SKILLMOD_RELOADSPEED_MUL, -0.13)
GM:AddSkillModifier(SKILL_BATTLER5, SKILLMOD_RELOADSPEED_MUL, -0.16)

GM:AddSkillModifier(SKILL_GLASSMAN, SKILLMOD_MELEE_DAMAGE_MUL, 2.3)
GM:AddSkillModifier(SKILL_GLASSMAN, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 3)

GM:AddSkillModifier(SKILL_JOUSTER, SKILLMOD_MELEE_DAMAGE_MUL, 0.2)
GM:AddSkillModifier(SKILL_JOUSTER, SKILLMOD_MELEE_KNOCKBACK_MUL, -0.9)

GM:AddSkillModifier(SKILL_QUICKDRAW, SKILLMOD_DEPLOYSPEED_MUL, 0.65)
GM:AddSkillModifier(SKILL_QUICKDRAW, SKILLMOD_RELOADSPEED_MUL, -0.01)

GM:AddSkillModifier(SKILL_QUICKRELOAD, SKILLMOD_RELOADSPEED_MUL, 0.10)
GM:AddSkillModifier(SKILL_QUICKRELOAD, SKILLMOD_DEPLOYSPEED_MUL, -0.15)

GM:AddSkillModifier(SKILL_SLEIGHTOFHAND, SKILLMOD_RELOADSPEED_MUL, 0.30)
GM:AddSkillModifier(SKILL_SLEIGHTOFHAND, SKILLMOD_AIMSPREAD_MUL, 0.5)

GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE1, SKILLMOD_RELOADSPEED_MUL, 0.02)
GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE1, SKILLMOD_DEPLOYSPEED_MUL, 0.02)

GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE2, SKILLMOD_RELOADSPEED_MUL, 0.03)
GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE2, SKILLMOD_DEPLOYSPEED_MUL, 0.03)

GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE3, SKILLMOD_RELOADSPEED_MUL, 0.04)
GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE3, SKILLMOD_DEPLOYSPEED_MUL, 0.04)

GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE1, SKILLMOD_MELEE_DAMAGE_MUL, -0.09)

GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE2, SKILLMOD_MELEE_DAMAGE_MUL, -0.13)

GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE3, SKILLMOD_MELEE_DAMAGE_MUL, -0.18)

GM:AddSkillModifier(SKILL_UNSIGIL, SKILLMOD_RELOADSPEED_MUL, 0.26)
GM:AddSkillModifier(SKILL_UNSIGIL, SKILLMOD_MELEE_DAMAGE_MUL, -0.8)

GM:AddSkillModifier(SKILL_PHASER, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.15)
GM:AddSkillModifier(SKILL_PHASER, SKILLMOD_SIGIL_TELEPORT_MUL, 0.15)

GM:AddSkillModifier(SKILL_DRIFT, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.05)

GM:AddSkillModifier(SKILL_WARP, SKILLMOD_SIGIL_TELEPORT_MUL, -0.05)

GM:AddSkillModifier(SKILL_SIGILOL, SKILLMOD_SIGIL_TELEPORT_MUL, 1)
GM:AddSkillModifier(SKILL_SIGILOL, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 3)

GM:AddSkillModifier(SKILL_HAMMERDISCIPLINE, SKILLMOD_HAMMER_SWING_DELAY_MUL, -0.4)
GM:AddSkillModifier(SKILL_BARRICADEEXPERT, SKILLMOD_HAMMER_SWING_DELAY_MUL, 0.2)

GM:AddSkillModifier(SKILL_SAFEFALL, SKILLMOD_FALLDAMAGE_DAMAGE_MUL, -0.4)
GM:AddSkillModifier(SKILL_SAFEFALL, SKILLMOD_FALLDAMAGE_RECOVERY_MUL, -0.2)
GM:AddSkillModifier(SKILL_SAFEFALL, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, 0.1)

GM:AddSkillModifier(SKILL_BACKPEDDLER, SKILLMOD_SPEED, -3)
GM:AddSkillFunction(SKILL_BACKPEDDLER, function(pl, active)
	pl.NoBWSpeedPenalty = active
end)

GM:AddSkillModifier(SKILL_D_CLUMSY, SKILLMOD_WORTH, 50)
GM:AddSkillModifier(SKILL_D_CLUMSY, SKILLMOD_POINTS, 10)
GM:AddSkillFunction(SKILL_D_CLUMSY, function(pl, active)
	pl.IsClumsy = active
end)

GM:AddSkillModifier(SKILL_D_NOODLEARMS, SKILLMOD_WORTH, 10)
GM:AddSkillModifier(SKILL_D_NOODLEARMS, SKILLMOD_SCRAP_START, 10)
GM:AddSkillFunction(SKILL_D_NOODLEARMS, function(pl, active)
	pl.NoObjectPickup = active
end)

GM:AddSkillModifier(SKILL_D_PALSY, SKILLMOD_WORTH, 10)
GM:AddSkillModifier(SKILL_D_PALSY, SKILLMOD_RESUPPLY_DELAY_MUL, -0.03)
GM:AddSkillFunction(SKILL_D_PALSY, function(pl, active)
	pl.HasPalsy = active
end)

GM:AddSkillModifier(SKILL_D_HEMOPHILIA, SKILLMOD_WORTH, 30)
GM:AddSkillModifier(SKILL_D_HEMOPHILIA, SKILLMOD_SCRAP_START, 16)
GM:AddSkillFunction(SKILL_D_HEMOPHILIA, function(pl, active)
	pl.HasHemophilia = active
end)

GM:AddSkillModifier(SKILL_D_LATEBUYER, SKILLMOD_WORTH, 30)
GM:AddSkillModifier(SKILL_D_LATEBUYER, SKILLMOD_ARSENAL_DISCOUNT, -0.33)

GM:AddSkillFunction(SKILL_TAUT, function(pl, active)
	pl.BuffTaut = active
end)
GM:AddSkillModifier(SKILL_CARRIER, SKILLMOD_DEPLOYABLE_PACKTIME_MUL, 0.50)
GM:AddSkillModifier(SKILL_CARRIER, SKILLMOD_DEPLOYABLE_HEALTH_MUL, -0.50)
GM:AddSkillModifier(SKILL_CARRIER, SKILLMOD_PROP_CARRY_SLOW_MUL, -1)

GM:AddSkillModifier(SKILL_BLOODARMOR, SKILLMOD_HEALTH, -5)

GM:AddSkillModifier(SKILL_HAEMOSTASIS, SKILLMOD_BLOODARMOR_DMG_REDUCTION, 0.16)

GM:AddSkillModifier(SKILL_REGENERATOR, SKILLMOD_HEALTH, -6)

GM:AddSkillModifier(SKILL_D_WEAKNESS, SKILLMOD_WORTH, 60)
GM:AddSkillModifier(SKILL_D_WEAKNESS, SKILLMOD_ENDWAVE_POINTS, 15)
GM:AddSkillModifier(SKILL_D_WEAKNESS, SKILLMOD_HEALTH, -60)
GM:AddSkillModifier(SKILL_D_WEAKNESS, SKILLMOD_MELEE_DAMAGE_MUL, -0.3)

GM:AddSkillModifier(SKILL_D_WIDELOAD, SKILLMOD_WORTH, -10)
GM:AddSkillModifier(SKILL_D_WIDELOAD, SKILLMOD_RESUPPLY_DELAY_MUL, -0.05)
GM:AddSkillFunction(SKILL_D_WIDELOAD, function(pl, active)
	pl.NoGhosting = active
end)

GM:AddSkillFunction(SKILL_WOOISM, function(pl, active)
	pl.Wooism = active
end)

GM:AddSkillFunction(SKILL_ORPHICFOCUS, function(pl, active)
	pl.Orphic = active
end)

GM:AddSkillModifier(SKILL_WORTHINESS1, SKILLMOD_WORTH, 10)
GM:AddSkillModifier(SKILL_WORTHINESS2, SKILLMOD_WORTH, 10)
GM:AddSkillModifier(SKILL_WORTHINESS3, SKILLMOD_WORTH, 10)
GM:AddSkillModifier(SKILL_WORTHINESS4, SKILLMOD_WORTH, 10)

GM:AddSkillModifier(SKILL_KNUCKLEMASTER, SKILLMOD_UNARMED_SWING_DELAY_MUL, 0.35)
GM:AddSkillModifier(SKILL_KNUCKLEMASTER, SKILLMOD_UNARMED_DAMAGE_MUL, 0.75)

GM:AddSkillModifier(SKILL_CRITICALKNUCKLE, SKILLMOD_UNARMED_DAMAGE_MUL, -0.25)
GM:AddSkillModifier(SKILL_CRITICALKNUCKLE, SKILLMOD_UNARMED_SWING_DELAY_MUL, 0.25)

GM:AddSkillModifier(SKILL_SMARTTARGETING, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, 0.75)
GM:AddSkillModifier(SKILL_SMARTTARGETING, SKILLMOD_MEDDART_EFFECTIVENESS_MUL, -0.3)

GM:AddSkillModifier(SKILL_RECLAIMSOL, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, 1.5)
GM:AddSkillModifier(SKILL_RECLAIMSOL, SKILLMOD_MEDGUN_RELOAD_SPEED_MUL, -0.4)

GM:AddSkillModifier(SKILL_LANKY, SKILLMOD_MELEE_DAMAGE_MUL, -0.15)
GM:AddSkillModifier(SKILL_LANKY, SKILLMOD_MELEE_RANGE_MUL, 0.15)

GM:AddSkillModifier(SKILL_LANKYII, SKILLMOD_MELEE_DAMAGE_MUL, -0.25)
GM:AddSkillModifier(SKILL_LANKYII, SKILLMOD_MELEE_RANGE_MUL, 0.2)

GM:AddSkillModifier(SKILL_D_FRAIL, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.33)
GM:AddSkillModifier(SKILL_D_FRAIL, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.33)
GM:AddSkillFunction(SKILL_D_FRAIL, function(pl, active)
	pl:SetDTBool(DT_PLAYER_BOOL_FRAIL, active)
end)

GM:AddSkillModifier(SKILL_MASTERCHEF, SKILLMOD_MELEE_DAMAGE_MUL, -0.10)

GM:AddSkillModifier(SKILL_LIGHTWEIGHT, SKILLMOD_MELEE_DAMAGE_MUL, -0.2)

GM:AddSkillModifier(SKILL_AGILEI, SKILLMOD_JUMPPOWER_MUL, 0.04)
GM:AddSkillModifier(SKILL_AGILEI, SKILLMOD_SPEED, -2)

GM:AddSkillModifier(SKILL_AGILEII, SKILLMOD_JUMPPOWER_MUL, 0.05)
GM:AddSkillModifier(SKILL_AGILEII, SKILLMOD_SPEED, -3)

GM:AddSkillModifier(SKILL_AGILEIII, SKILLMOD_JUMPPOWER_MUL, 0.06)
GM:AddSkillModifier(SKILL_AGILEIII, SKILLMOD_SPEED, -4)

GM:AddSkillModifier(SKILL_SOFTDET, SKILLMOD_EXP_DAMAGE_RADIUS, 0.10)
GM:AddSkillModifier(SKILL_SOFTDET, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, -0.6)

GM:AddSkillModifier(SKILL_IRONBLOOD, SKILLMOD_BLOODARMOR_DMG_REDUCTION, 0.65)
GM:AddSkillModifier(SKILL_IRONBLOOD, SKILLMOD_BLOODARMOR_MUL, -0.3)

GM:AddSkillModifier(SKILL_BLOODLETTER, SKILLMOD_BLOODARMOR_GAIN_MUL, 1)

GM:AddSkillModifier(SKILL_SURESTEP, SKILLMOD_SPEED, -4)
GM:AddSkillModifier(SKILL_SURESTEP, SKILLMOD_SLOW_EFF_TAKEN_MUL, -0.35)

GM:AddSkillModifier(SKILL_INTREPID, SKILLMOD_SPEED, -4)
GM:AddSkillModifier(SKILL_INTREPID, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.35)

GM:AddSkillModifier(SKILL_UNBOUND, SKILLMOD_SPEED, -4)

GM:AddSkillModifier(SKILL_CHEAPKNUCKLE, SKILLMOD_MELEE_RANGE_MUL, -0.1)

GM:AddSkillModifier(SKILL_HEAVYSTRIKES, SKILLMOD_MELEE_KNOCKBACK_MUL, 1)

GM:AddSkillModifier(SKILL_CANNONBALL, SKILLMOD_PROJ_SPEED, -0.25)
GM:AddSkillModifier(SKILL_CANNONBALL, SKILLMOD_PROJECTILE_DAMAGE_MUL, 0.03)

GM:AddSkillModifier(SKILL_CONEFFECT, SKILLMOD_EXP_DAMAGE_RADIUS, -0.2)
GM:AddSkillModifier(SKILL_CONEFFECT, SKILLMOD_EXP_DAMAGE_MUL, 0.05)

GM:AddSkillModifier(SKILL_CARDIOTONIC, SKILLMOD_SPEED, -12)
GM:AddSkillModifier(SKILL_CARDIOTONIC, SKILLMOD_BLOODARMOR_DMG_REDUCTION, -0.2)

GM:AddSkillFunction(SKILL_SCOURER, function(pl, active)
	pl.Scourer = active
end)

GM:AddSkillModifier(SKILL_DISPERSION, SKILLMOD_CLOUD_RADIUS, 0.15)
GM:AddSkillModifier(SKILL_DISPERSION, SKILLMOD_CLOUD_TIME, -0.1)

GM:AddSkillModifier(SKILL_BRASH, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.16)
GM:AddSkillModifier(SKILL_BRASH, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, -15)

GM:AddSkillModifier(SKILL_FOUR_IN_ONE, SKILLMOD_HEALTH, -7)
GM:AddSkillModifier(SKILL_FOUR_IN_ONE, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.09)

GM:AddSkillModifier(SKILL_THREE_IN_ONE, SKILLMOD_HEALTH, -14)
GM:AddSkillModifier(SKILL_THREE_IN_ONE, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.16)

GM:AddSkillModifier(SKILL_CIRCULATION, SKILLMOD_BLOODARMOR, 1)

GM:AddSkillModifier(SKILL_SANGUINE, SKILLMOD_BLOODARMOR, 11)
GM:AddSkillModifier(SKILL_SANGUINE, SKILLMOD_HEALTH, -9)

GM:AddSkillModifier(SKILL_ANTIGEN, SKILLMOD_BLOODARMOR_DMG_REDUCTION, 0.05)
GM:AddSkillModifier(SKILL_ANTIGEN, SKILLMOD_HEALTH, -3)

GM:AddSkillModifier(SKILL_INSTRUMENTS, SKILLMOD_TURRET_RANGE_MUL, 0.05)

GM:AddSkillModifier(SKILL_LEVELHEADED, SKILLMOD_AIM_SHAKE_MUL, -0.05)

GM:AddSkillModifier(SKILL_ROBUST, SKILLMOD_WEAPON_WEIGHT_SLOW_MUL, -0.06)

GM:AddSkillModifier(SKILL_TAUT, SKILLMOD_PROP_CARRY_SLOW_MUL, 0.4)

GM:AddSkillModifier(SKILL_TURRETOVERLOAD, SKILLMOD_TURRET_RANGE_MUL, -0.3)

GM:AddSkillModifier(SKILL_STOWAGE, SKILLMOD_RESUPPLY_DELAY_MUL, 0.05)
GM:AddSkillFunction(SKILL_STOWAGE, function(pl, active)
	pl.Stowage = active
end)

GM:AddSkillFunction(SKILL_TRUEWOOISM, function(pl, active)
	pl.TrueWooism = active
end)
