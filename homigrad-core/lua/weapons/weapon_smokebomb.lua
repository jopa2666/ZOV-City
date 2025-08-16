SWEP.Base = "weapon_gren_base"

SWEP.PrintName = "Самодельная дымовая шашка"
SWEP.Author = ""
SWEP.Instructions = ""
SWEP.Category = "Гранаты"
SWEP.SupportTPIK = true

SWEP.Slot = 4
SWEP.SlotPos = 2
SWEP.Spawnable = true

SWEP.ViewModel = "models/props_junk/jlare.mdl"
SWEP.WorldModel = "models/props_junk/jlare.mdl"

SWEP.Granade = "ent_jmod_smokebomb"

SWEP.IconAng = Angle(-20,0,0)
SWEP.IconPos = Vector(40,-1.5,0.5)

SWEP.Offset = {
    Pos = {
        Up = 0.5,
        Right = 2,
        Forward = 2.5
    },
    Ang = {
        Up = 0,
        Right = 195,
        Forward = 0 
    },
    Scale = 1
}

function SWEP:DrawWorldModel()
    local hand, offset, rotate
    
    local pl = self:GetOwner()
    
    if IsValid(pl) then
        local boneIndex = pl:LookupBone("ValveBiped.Bip01_R_Hand")
        
        if boneIndex then
            local pos, ang = pl:GetBonePosition(boneIndex)
            
            pos = pos + ang:Forward() * self.Offset.Pos.Forward
            pos = pos + ang:Right() * self.Offset.Pos.Right
            pos = pos + ang:Up() * self.Offset.Pos.Up
            
            ang:RotateAroundAxis(ang:Up(), self.Offset.Ang.Up)
            ang:RotateAroundAxis(ang:Right(), self.Offset.Ang.Right)
            ang:RotateAroundAxis(ang:Forward(), self.Offset.Ang.Forward)
            
            self:SetRenderOrigin(pos)
            self:SetRenderAngles(ang)
            
            self:SetModelScale(self.Offset.Scale, 0)
        end
    else
        self:SetRenderOrigin(nil)
        self:SetRenderAngles(nil)
    end
    
    self:DrawModel()
end

function SWEP:DrawWorldModelTranslucent()
    self:DrawWorldModel()
end