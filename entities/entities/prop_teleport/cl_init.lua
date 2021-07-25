INC_CLIENT()

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Initialize()
	self.CreateTime = CurTime()
end

function ENT:Draw()
	self:DrawModel()
end

local matGlow = Material("sprites/glow04_noz")
local colBlue = Color(100, 100, 255)
