-- Z Я еблан
SWEP.Base = "homigrad_base"
SWEP.PrintName = "Сайга-12"
SWEP.Category = "Оружие: Дробовики"
SWEP.Spawnable = true

SWEP.WorldModel = "models/pwb/weapons/w_saiga_12.mdl"
SWEP.WorldModelReal = "models/pwb/weapons/v_saiga_12.mdl"
SWEP.ViewModel = "models/pwb/weapons/v_saiga_12.mdl"

SWEP.HoldType = "ar2"

SWEP.Primary.ReloadTime = 2
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 7
SWEP.Primary.Damage = 40
SWEP.Primary.Force = 25
SWEP.NumBullet = 7
SWEP.Primary.Ammo = "12/70 gauge"
SWEP.Sound = "weapons/rpkm/fire.wav"
SWEP.SubSound = "weapons/tfa_ins2/m9/fire_3.wav"
SWEP.InsertSound = "weapons/mp153/insert.wav"
SWEP.Primary.ReloadTime = 0.2
SWEP.Primary.Wait = 0.2

SWEP.IsShotgun = true

SWEP.WorldPos = Vector(-1,-0.5,-0.5)
SWEP.WorldAng = Angle(1,0,0)
SWEP.AttPos = Vector(37,3.8,-3)
SWEP.AttAng = Angle(0.2,-0.1,0)
SWEP.HolsterAng = Angle(0,-10,0)
SWEP.HolsterPos = Vector(-25,-0.5,5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine4"

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.BoltBone = "trigger"
SWEP.BoltVec = Vector(0,0,-2)

SWEP.IconPos = Vector(130,-17,-0)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = true

SWEP.ZoomPos = Vector(4,-3.60,-1.1)
SWEP.ZoomAng = Angle(-0.5,0,0)

SWEP.RecoilForce = 3.25

SWEP.Animations = {
    ["draw"] = {
        Source = "draw",
        Time = 1
    },
    ["idle"] = {
        Source = "idle",
        Time = 0.5
    },
    ["reload"] = {
        Source = "reload",
        Time = 0.8
    },
}

SWEP.Reload1 = false
SWEP.Reload2 = false
SWEP.Reload3 = false
SWEP.Reload4 = false