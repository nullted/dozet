SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeReach = 52
SWEP.MeleeDelay = 0.3
SWEP.MeleeSize = 4.5 --1.5
SWEP.MeleeDamage = 7
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeAnimationDelay = 0.05

SWEP.Primary.Delay = 0.41

SWEP.ViewModel = Model("models/weapons/v_pza.mdl")
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

function SWEP:CheckMoaning()
end

function SWEP:StopMoaningSound()
end

function SWEP:StartMoaningSound()
end


function SWEP:PlayHitSound()
	self:GetOwner():EmitSound("npc/fast_zombie/fz_scream1.wav", 75, math.random(60,70), 0.5)
	self:GetOwner():EmitSound("npc/fast_zombie/fz_scream1.wav", 75, math.random(70,80), 0.5)
end

function SWEP:PlayAttackSound()
	self:GetOwner():EmitSound("npc/combine_soldier/die"..math.random(1,3)..".wav", 75, math.random(70,75), 0.5)
	self:GetOwner():EmitSound("npc/combine_soldier/die"..math.random(1,3)..".wav", 75, math.random(78,90), 0.5)
end


function SWEP:PlayAlertSound()
	self:EmitSound("npc/zombie/claw_strike"..math.random(3)..".wav", 75, 80, nil, CHAN_AUTO)
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:SetSwingAnimTime(time)
	self:SetDTFloat(3, time)
end

function SWEP:GetSwingAnimTime()
	return self:GetDTFloat(3)
end

function SWEP:StartSwinging()
	self.BaseClass.StartSwinging(self)
	self:SetSwingAnimTime(CurTime() + 1)
end
