AddCSLuaFile()

SWEP.Base = "weapon_zs_shitslapper"

SWEP.PrintName = "haha funny"

SWEP.MeleeDelay = 0.25
SWEP.MeleeReach = 40
SWEP.MeleeDamage = 50
SWEP.SwingAnimSpeed = 2.96

SWEP.DelayWhenDeployed = true

function SWEP:Reload()
	self:SecondaryAttack()
end

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end
