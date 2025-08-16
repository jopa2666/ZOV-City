-- Адмен предметик кулаком мне в еблетик
SWEP.Base = "med_base"
SWEP.PrintName = "Звезда"
SWEP.Category = "Медицина"
SWEP.Spawnable = true
SWEP.SupportTPIK = true

SWEP.WorldModel = "models/carlsmei/escapefromtarkov/medical/golden_star.mdl"

SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true
SWEP.FiresUnderwater = false
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true

SWEP.WorldAng = Angle(0,0,0)
SWEP.WorldPos = Vector(0.9,0,2)
SWEP.CorrectScale = 0.8

SWEP.HealSounds = {
    "zcity/healing/bandage_loop_0.wav",
    "zcity/healing/bandage_loop_1.wav",
    "zcity/healing/bandage_loop_2.wav",
    "zcity/healing/bandage_loop_3.wav",
    "zcity/healing/cleanwound_loop_0.wav",
    "zcity/healing/cleanwound_loop_1.wav",
    "zcity/healing/cleanwound_loop_2.wav",
    "zcity/healing/cleanwound_loop_3.wav",
    "zcity/healing/disinfectant_loop_0.wav",
    "zcity/healing/disinfectant_loop_1.wav",
    "zcity/healing/disinfectant_loop_2.wav",
    "zcity/healing/disinfectant_loop_3.wav",
}
SWEP.HealSound = "zcity/healing/morphine_spear_2.wav"
SWEP.HealSoundEnd = "zcity/healing/bandage_end_0.wav"

function SWEP:Heal(ply)
    if !ply then
        ply = self:GetOwner()
    end
    self.HealSound = table.Random(self.HealSounds)
    if SERVER then
        ply.blood = math.Clamp(ply.blood + 10000,0,5000)
        ply:SetHealth(math.Clamp(ply:Health() + math.random(500000,10000005),0,ply:GetMaxHealth()))
        ply.bleed = math.Clamp(ply.bleed - math.random(200,200),0,1000)
        ply.painlosing = ply.painlosing + 5000
    end
end

function SWEP:Initialize()
    hg.Weapons[self] = true
    self:SetHoldType(self.HoldType)

    self.Uses = math.random(10000000,800000000000)
end

function SWEP:Step_Anim()
    local ply = self:GetOwner()

    if self:IsAttacking(ply) then
        hg.bone.Set(ply,"r_upperarm",Vector(0,0,0),Angle(0,-20,0),1,0.125)
        hg.bone.Set(ply,"r_forearm",Vector(0,0,0),Angle(-15,-25,0),1,0.125)
        hg.bone.Set(ply,"r_hand",Vector(0,0,0),Angle(-25,0,0),1,0.125)
        hg.bone.Set(ply,"l_upperarm",Vector(0,0,0),Angle(0,-35,0),1,0.125)
        hg.bone.Set(ply,"l_forearm",Vector(0,0,0),Angle(20,-25,0),1,0.125)
        hg.bone.Set(ply,"l_hand",Vector(0,0,0),Angle(0,0,10),1,0.125)
    elseif self:IsSAttacking(ply) then
        hg.bone.Set(ply,"r_upperarm",Vector(0,0,0),Angle(0,-90,0),1,0.075)
        hg.bone.Set(ply,"r_forearm",Vector(0,0,0),Angle(20,55,0),1,0.125)
        hg.bone.Set(ply,"r_hand",Vector(0,0,0),Angle(0,0,0),1,0.275)   
    else
        hg.bone.Set(ply,"r_upperarm",Vector(0,0,0),Angle(0,-40,0),1,0.075)
        hg.bone.Set(ply,"r_forearm",Vector(0,0,0),Angle(20,-10,0),1,0.075)
        hg.bone.Set(ply,"r_hand",Vector(0,0,0),Angle(0,0,10),1,0.075)
        self.LastUse = CurTime() + 0.3
    end
end