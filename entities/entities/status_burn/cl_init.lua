INC_CLIENT()

local function GetRandomBonePos(pl)
	if pl ~= MySelf or pl:ShouldDrawLocalPlayer() then
		local bone = pl:GetBoneMatrix(math.random(0,25))
		if bone then
			return bone:GetTranslation()
		end
	end

	return pl:GetShootPos()
end

function ENT:Draw()
	local ent = self:GetOwner()
	if not ent:IsValid() then return end
	
	local pos
	if ent == MySelf and not ent:ShouldDrawLocalPlayer() then
		local aa, bb = ent:WorldSpaceAABB()
		pos = Vector(math.Rand(aa.x, bb.x), math.Rand(aa.y, bb.y), math.Rand(aa.z, bb.z))
	else
		pos = GetRandomBonePos(ent)
	end

	local emitter = ParticleEmitter(self:GetPos())
	emitter:SetNearClip(24, 32)
	
	for i = 1, 2 do
		particle = emitter:Add("sprites/light_glow02_add", pos + VectorRand() * 12)
		particle:SetDieTime(math.Rand(1.3, 5))
		particle:SetStartAlpha(220)
		particle:SetEndAlpha(20)
		particle:SetStartSize(4)
		particle:SetEndSize(0)
		particle:SetGravity(Vector(0, 0, 75))
		particle:SetAirResistance(300)
		particle:SetStartLength(3)
		particle:SetEndLength(55)
		particle:SetColor(255, 236, 102)
	end
	
	emitter:Finish()
end
