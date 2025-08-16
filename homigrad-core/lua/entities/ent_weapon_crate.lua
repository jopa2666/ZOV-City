AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "ent_small_crate" 
ENT.PrintName = "Легендарный Ящик"
ENT.Author = "Homigrad"
ENT.Category = "Case"
ENT.Purpose = ""
ENT.Spawnable = true

function ENT:Initialize()
	if SERVER then
	    self:SetModel( "models/kali/props/cases/rifle case a.mdl" )
	    self:PhysicsInit( SOLID_VPHYSICS ) 
	    self:SetMoveType( MOVETYPE_VPHYSICS )
	    self:SetSolid( SOLID_VPHYSICS )
        self:SetUseType(SIMPLE_USE)
        self:SetModelScale(1,0)
		self:SetSkin(1)
		self.AmtLoot = math.random(1,2)
		self.Inventory = {}
		for i = 1, math.random(1,self.AmtLoot) do
			local shit = table.Random(hg.loots.weapon_crate)
			table.insert(self.Inventory,shit)
		end
	    local phys = self:GetPhysicsObject()
	    if phys:IsValid() then
	        phys:Wake()
	    end
	end
end