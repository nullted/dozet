INC_CLIENT()

SWEP.Slot = 3
SWEP.SlotPos = 0

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 58



}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -3), angle = Angle(0, 0, 0) },
	["Base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 3), angle = Angle(0, 0, 0) }
}

local colBG = Color(16, 16, 16, 90)
local colRed = Color(220, 0, 0, 230)
local colWhite = Color(220, 220, 220, 230)

local function DrawHeatBar(self, x, y, wid, hei, is3d)
	local heatcolor = (1 - (self:GetShortHeat() + self:GetLongHeat())) * 220
	colWhite.g = heatcolor
	colWhite.b = heatcolor
	colWhite.a = 230

	local barrelcol = self.VElements["egon_base+"].color
	barrelcol.g = heatcolor
	barrelcol.b = heatcolor

	local shortdiv = self:GetShortHeat()
	local longdiv = self:GetLongHeat()
	local barheight = 20
	local bary = y + hei * 0.6
	local barshortwid = math.max(wid * shortdiv - 8, 0)
	local barlongwid = math.max(wid * longdiv - 8, 0)

	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawRect(x, bary, wid - 8, barheight)
	surface.SetDrawColor(255, 30, 10, 220)
	surface.DrawRect(x + 4, bary + 4, barlongwid, barheight - 8)
	surface.SetDrawColor(255, 190, 0, 220)
	surface.DrawRect(x + 4 + barlongwid, bary + 4, barshortwid, barheight - 8)
	surface.SetDrawColor(100, 0, 0, 255)
	surface.DrawRect(x - 12 + wid, bary - 4, 4, barheight + 8)

	if self:GetGunState() == 2 then
		colWhite.b = 0
		colWhite.g = 0
		if ((CurTime() * 4) % 2) > 1 then
			colWhite.a = 0
		else
			draw.SimpleTextBlurry("VENTING", is3d and "ZS3D2DFontSmaller" or "ZSHUDFontSmaller", x + wid/2, bary + hei * 0.15, colRed, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

function SWEP:Draw2DHUD()
	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72
	local spare = self:GetPrimaryAmmoCount()

	local yy = ScrH() - hei * 2 - screenscale * 84

	DrawHeatBar(self, x + wid * 0.25 - wid/4, yy + hei * 0.2, wid, hei)

	draw.RoundedBox(16, x, y, wid, hei, colBG)
	draw.SimpleTextBlurry(spare, spare >= 1000 and "ZSHUDFont" or "ZSHUDFontBig", x + wid * 0.5, y + hei * 0.5, spare == 0 and colRed or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleTextBlurry("Бомбежка", "ZSHUDFont", x + wid * 0.5, yy + hei * 0.45, colRed, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function SWEP:Draw3DHUD(vm, pos, ang)
	local wid, hei = 180, 64
	local x, y = wid * -0.6, hei * -0.5
	local spare = self:GetPrimaryAmmoCount()

	cam.Start3D2D(pos, ang, self.HUD3DScale / 2)
		DrawHeatBar(self, x + wid * 0.25 - wid/4, y - hei * 1, wid, hei, true)

		draw.RoundedBoxEx(32, x, y, wid, hei, colBG, true, false, true, false)
		draw.SimpleTextBlurry(spare, spare >= 1000 and "ZS3D2DFontSmall" or "ZS3D2DFont", x + wid * 0.5, y + hei * 0.5, spare == 0 and colRed or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleTextBlurry("Бомбежка", "ZS3D2DFontSmall", x + wid * 0.5, y - hei * 1, colRed, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end
