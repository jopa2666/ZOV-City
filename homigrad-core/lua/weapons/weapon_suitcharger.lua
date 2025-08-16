SWEP.Base = "med_base"
SWEP.Category = "ХЛ2 Медицина"
SWEP.Spawnable = true

SWEP.WorldModel = "models/Items/battery.mdl"

SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true
SWEP.FiresUnderwater = false
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true

SWEP.WorldAng = Angle(0,0,0)
SWEP.WorldPos = Vector(1,-1,-3)
SWEP.CorrectScale = 0.8

SWEP.HealSounds = {
    "items/battery_pickup.wav",
    "items/suitchargeno1.wav",
}
SWEP.HealSound = "items/battery_pickup.wav"
SWEP.HealSoundEnd = "items/suitchargeok1.wav"

function SWEP:Heal(ply)
    if !ply then
        ply = self:GetOwner()
    end
    self.HealSound = table.Random(self.HealSounds)
    if SERVER then
        ply:SetHealth(math.Clamp(ply:Health() + math.random(9,17),0,ply:GetMaxHealth()))
        ply.painlosing = ply.painlosing + 0.9
    end
end

function SWEP:Initialize()
    hg.Weapons[self] = true
    self:SetHoldType(self.HoldType)

    self.Uses = math.random(4,6)
end