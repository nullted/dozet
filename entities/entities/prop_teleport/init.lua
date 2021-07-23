INC_SERVER()

local function RefreshDetpackOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_teleport")) do
		if ent:IsValid() and ent:GetOwner() == pl then
			ent:SetOwner(NULL)
		end
	end
end
hook.Add("PlayerDisconnected", "Detpack.PlayerDisconnected", RefreshDetpackOwners)
hook.Add("OnPlayerChangedTeam", "Detpack.OnPlayerChangedTeam", RefreshDetpackOwners)

ENT.NextBlip = 0

function ENT:Initialize()
	self.CreateTime = CurTime()

	self:SetModel("models/weapons/w_c4_planted.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
end






function ENT:OnPackedUp(pl)
	pl:GiveEmptyWeapon("weapon_zs_teleporter")
	pl:GiveAmmo(1, "sniperpenetratedround")

	self:Remove()
end

