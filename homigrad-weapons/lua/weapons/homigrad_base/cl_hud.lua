function SWEP:DrawHUDAdd()
end

function SWEP:DrawHUD()
	local ply = self:GetOwner()
	self:DrawHUDAdd()
	show = math.Clamp(self.AmmoChek or 0,0,1)
	self.AmmoChek = Lerp(2*FrameTime(),self.AmmoChek or 0,0)
	color_gray = Color(225,0,0,255*show)
	color_gray1 = Color(225,0,0,255*show)
	if show > 0 then
	local ply = LocalPlayer()
	local ammo,ammobag = self:GetMaxClip1(), self:Clip1()
	if ammobag > ammo - 1 then
		text = hg.GetPhrase("gun_full")
	elseif ammobag > ammo - ammo/3 then
		text = hg.GetPhrase("gun_nearfull")
	elseif ammobag > ammo/3 then
		text = hg.GetPhrase("gun_halfempty")
	elseif ammobag >= 1 then
		text = hg.GetPhrase("gun_nearempty")
	elseif ammobag < 1 then
		text = hg.GetPhrase("gun_empty")
	end

	local ammomags = ply:GetAmmoCount( self:GetPrimaryAmmoType() )

	if oldclip != ammobag then
		randomx = math.random(0, 5)
		randomy = math.random(0, 5)
		timer.Simple(0.15, function()
			oldclip = ammobag
		end)
	else
		randomx = 0
		randomy = 0
	end

	if oldmag != ammomags then
		randomxmag = math.random(0, 5)
		randomymag = math.random(0, 5)
		timer.Simple(0.35, function()
			oldmag = ammomags
		end)
	else
		randomxmag = 0
		randomymag = 0
	end

	local ent = hg.GetCurrentCharacter(ply)

	if !IsValid(ent) then
		ent = ply
	end

	local mat = ent:GetBoneMatrix(self.reload and ent:LookupBone("ValveBiped.Bip01_L_Hand") or ent:LookupBone("ValveBiped.Bip01_R_Hand"))

	local pos,ang = mat:GetTranslation(),ply:EyeAngles()

	local textpos = (pos + ang:Forward() * 10 + ang:Right() * -2 + ang:Up() * 4):ToScreen()
	if self.IsRevolver then
		draw.DrawText( string.format(hg.GetPhrase("gun_revolver"),ammobag), "HS.18", textpos.x+randomx, textpos.y+randomy, color_gray1, TEXT_ALIGN_RIGHT )
		draw.DrawText( string.format(hg.GetPhrase("gun_revolvermags"),ammomags), "HS.18", textpos.x+randomxmag, textpos.y+25+randomymag, color_gray, TEXT_ALIGN_RIGHT )
	elseif self.IsShotgun then
		draw.DrawText( string.format(hg.GetPhrase("gun_shotgun"),text), "HS.18", textpos.x+randomx, textpos.y+randomy, color_gray1, TEXT_ALIGN_RIGHT )
		draw.DrawText( string.format(hg.GetPhrase("gun_shotgunmags"),ammomags), "HS.18", textpos.x+randomxmag, textpos.y+25+randomymag, color_gray, TEXT_ALIGN_RIGHT )
	else
		draw.DrawText( string.format(hg.GetPhrase("gun_default"),text), "HS.18", textpos.x+randomx, textpos.y+randomy, color_gray1, TEXT_ALIGN_RIGHT )
		draw.DrawText( string.format(hg.GetPhrase("gun_defaultmags"),math.Round(ammomags/ammo)), "HS.18", textpos.x+5+randomxmag, textpos.y+25+randomymag, color_gray, TEXT_ALIGN_RIGHT )
	end
	end
end