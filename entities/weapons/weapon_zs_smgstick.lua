AddCSLuaFile()

SWEP.Base = "weapon_zs_base"

SWEP.PrintName = "Smgstick"
SWEP.Description = "Stop what?."

if CLIENT then
	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(1.65, 0, -8)
	SWEP.HUD3DScale = 0.025

	SWEP.ViewModelFlip = false
end

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadDelay = 0.2

SWEP.Primary.Sound = Sound("weapons/shotgun/shotgun_dbl_fire.wav")
SWEP.Primary.Damage = 11
SWEP.Primary.NumShots = 6
SWEP.Primary.Delay = 0.5

SWEP.Recoil = 7.5

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.DefaultClip = 200

SWEP.ConeMax = 11.5
SWEP.ConeMin = 10

SWEP.Tier = 3

SWEP.WalkSpeed = SPEED_SLOWER
SWEP.FireAnimSpeed = 0.07
SWEP.Knockback = 198

SWEP.PumpActivity = ACT_SHOTGUN_PUMP
SWEP.PumpSound = Sound("Weapon_Shotgun.Special1")
SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.04)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "Lithe Stick", "Decreased damage but faster reload, more knockback and more move speed", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 0.30
	wept.ReloadSpeed = wept.ReloadSpeed * 3
	wept.Primary.Delay = wept.Primary.Delay * 0.5
	wept.Knockback = 181
	wept.WalkSpeed = SPEED_SLOW
end)


function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self:GetOwner()

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitSound(self.Primary.Sound)

	local clip = self:Clip1()

	self:ShootBullets(self.Primary.Damage, self.Primary.NumShots * clip, self:GetCone())

	self:TakePrimaryAmmo(clip)
	owner:ViewPunch(clip * 0.5 * self.Recoil * Angle(math.Rand(-0.1, -0.1), math.Rand(-0.1, 0.1), 0))

	owner:SetGroundEntity(NULL)
	owner:SetVelocity(-self.Knockback * clip * owner:GetAimVector())

	self.IdleAnimation = CurTime() + self:SequenceDuration()
end
