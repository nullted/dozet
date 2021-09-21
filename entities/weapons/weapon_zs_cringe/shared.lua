SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "CRINGE"

SWEP.Secondary.Delay = 3.5
SWEP.Primary.Delay = 1.2


SWEP.NextPuke = 3
SWEP.PukeLeft = 10

SWEP.MeleeDamage = 56
SWEP.MeleeDamageVsProps = 84
SWEP.MeleeReach = 111
SWEP.MeleeSize = 3


function SWEP:SecondaryAttack()
	if CurTime() < self:GetNextSecondaryFire() then return end
	local owner = self:GetOwner()
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

	self.PukeLeft = 35

	owner:EmitSound("npc/barnacle/barnacle_die2.wav")
	owner:EmitSound("npc/barnacle/barnacle_digesting1.wav")
	owner:EmitSound("npc/barnacle/barnacle_digesting2.wav")
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end





function SWEP:MeleeHit(ent, trace, damage, forcescale)
	if not ent:IsPlayer() then
		damage = self.MeleeDamageVsProps
	end

	self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/barnacle/barnacle_tongue_pull"..math.random(3)..".wav")
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self:EmitSound("npc/barnacle/barnacle_bark"..math.random(2)..".wav")
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local matSheet = Material("Models/Charple/Charple1_sheet")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
end