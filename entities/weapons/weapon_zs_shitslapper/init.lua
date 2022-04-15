INC_SERVER()

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent:IsValid() then
		--[[local vel = ent:GetPos() - self:GetOwner():GetPos()
		vel.z = 0
		vel:Normalize()
		vel = vel * 800
		vel.z = 350

		ent:KnockDown()
		ent:SetGroundEntity(NULL)
		ent:SetVelocity(vel)]]
		local noknockdown = true
		if CurTime() >= (ent.NextKnockdown or 0) then
			noknockdown = false
			ent.NextKnockdown = CurTime() + 4
		end
		ent:ThrowFromPositionSetZ(trace.StartPos, ent:IsPlayer() and 600 or 1600, nil, noknockdown)
	end

end

function SWEP:ApplyMeleeDamage(pl, trace, damage)
	if SERVER and pl:IsPlayer() then
		local cursed = pl:GetStatus("cursed")
		if (cursed) then 
			pl:AddCursed(self:GetOwner(), cursed.DieTime - CurTime() + 5)
		end
		if (not cursed) then 
			pl:AddCursed(pl:GetOwner(), 40)
		end
	end
	self.BaseClass.ApplyMeleeDamage(self, pl, trace, damage)
end
