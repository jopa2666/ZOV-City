SWEP.Base = "med_base"
SWEP.PrintName = "Героин"
SWEP.Category = "Медицина"
SWEP.Spawnable = true
SWEP.SupportTPIK = true

SWEP.WorldModel = "models/jellik/krokodil.mdl"
SWEP.WorldModelReal = "models/jellik/krokodil.mdl"

SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true
SWEP.FiresUnderwater = false
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true

SWEP.WorldAng = Angle(0,-90,0)
SWEP.WorldPos = Vector(0,0,-2)
SWEP.CorrectScale = 1.1

SWEP.IconPos = Vector(30,1.35,0)
SWEP.IconAng = Angle(0,90,0)

SWEP.HealSound = "zcity/healing/bloodbag_loop_2.wav"
SWEP.HealSoundEnd = "zcity/healing/morphine_out_0.wav"

function SWEP:Heal(ply)
    if not ply then
        ply = self:GetOwner()
    end
    if SERVER then
        ply.adrenaline = ply.adrenaline + 2.5
        ply:SetHealth(math.Clamp(ply:Health() + math.random(-35,-40),0,ply:GetMaxHealth()))
        ply.painlosing = ply.painlosing + 1.5
    end
end

function SWEP:Initialize()
    hg.Weapons[self] = true
    self:SetHoldType(self.HoldType)

    self.Uses = 2
end

function SWEP:Step_Anim()
    local ply = self:GetOwner()

    if self:IsAttacking(ply) then
        hg.bone.Set(ply,"r_upperarm",Vector(0,0,0),Angle(0,-45,0),1,0.125)
        hg.bone.Set(ply,"r_forearm",Vector(0,0,0),Angle(-10,-5,0),1,0.125)
        hg.bone.Set(ply,"r_hand",Vector(0,0,0),Angle(-25,0,0),1,0.125)
        hg.bone.Set(ply,"l_upperarm",Vector(0,0,0),Angle(0,-35,0),1,0.125)
        hg.bone.Set(ply,"l_forearm",Vector(0,0,0),Angle(20,-25,0),1,0.125)
        hg.bone.Set(ply,"l_hand",Vector(0,0,0),Angle(0,0,-90),1,0.125)
    elseif self:IsSAttacking(ply) then
        hg.bone.Set(ply,"r_upperarm",Vector(0,0,0),Angle(0,-90,0),1,0.075)
        hg.bone.Set(ply,"r_forearm",Vector(0,0,0),Angle(20,55,0),1,0.125)
        hg.bone.Set(ply,"r_hand",Vector(0,0,0),Angle(90,0,20),1,0.275)   
    else
        hg.bone.Set(ply,"r_upperarm",Vector(0,0,0),Angle(0,-40,0),1,0.075)
        hg.bone.Set(ply,"r_forearm",Vector(0,0,0),Angle(20,-10,0),1,0.075)
        hg.bone.Set(ply,"r_hand",Vector(0,0,0),Angle(0,0,10),1,0.075)
        self.LastUse = CurTime() + 0.3
    end
end