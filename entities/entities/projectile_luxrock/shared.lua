ENT.Type = "anim"

ENT.IgnoreBullets = false
ENT.IgnoreMelee = false
ENT.IgnoreTraces = false

function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and ent:Team() == TEAM_HUMAN or ent:IsProjectile()
end

util.PrecacheModel("models/props_wasteland/rockgranite03b.mdl")
