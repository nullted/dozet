SWEP.PrintName = "'Cinderrod' Zip Gun"

SWEP.Base = "weapon_zs_blareduct"

SWEP.Primary.Damage = 173
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 1.5

SWEP.ConeMax = 7.5
SWEP.ConeMin = 6.5

SWEP.ReloadSpeed = 0.44
SWEP.ReloadDelay = 0.45

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.15, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RECOIL, -32.5)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -1)

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEADSHOT_MULTI, 0.3)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Arobus' Minibush", "MORE DAMAGE", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 2.5
	wept.ConeMin = wept.ConeMin * 0.3
	wept.ConeMax = wept.ConeMax * 0.1
	wept.Primary.Delay = wept.Primary.Delay * 1.1
	wept.Recoil = 4

end)

