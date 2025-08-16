SWEP.Base = "wep_food_base"
SWEP.PrintName = "Сок"
SWEP.Category = "Еда"
SWEP.Spawnable = true

SWEP.WorldModel = "models/foodnhouseholditems/juice.mdl"

SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true
SWEP.FiresUnderwater = false
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true

SWEP.Regens = 10
SWEP.BiteSounds = false

function SWEP:Eat()
    local ply = self:GetOwner()
    if SERVER then
        ply.hunger = ply.hunger + self.Regens
    end
end