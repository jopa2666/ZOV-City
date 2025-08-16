SWEP.Base = "homigrad_base"
SWEP.PrintName = "SCAR"
SWEP.Category = "Оружие: Винтовки"
SWEP.Spawnable = true

SWEP.WorldModelReal = "models/weapons/tfa_gamebanana/c_rif_scarh.mdl"
SWEP.WorldModel = "models/weapons/tfa_gamebanana/w_rif_scarh.mdl"
SWEP.ViewModel = "models/weapons/tfa_gamebanana/c_rif_scarh.mdl"

SWEP.HoldType = "ar2"

SWEP.Primary.ReloadTime = 6.25
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Damage = 40
SWEP.Primary.Force = 1
SWEP.Primary.Ammo = "5.56x45 mm"
SWEP.Primary.Wait = 0.085
SWEP.Sound = "pwb/weapons/hk416/shoot.wav"
SWEP.RecoilForce = 1

SWEP.WorldPos = Vector(1,-1.5,0)
SWEP.WorldAng = Angle(0,0,0)
SWEP.AttPos = Vector(26,4,-3)
SWEP.AttAng = Angle(0,0,0)
SWEP.HolsterAng = Angle(0,-10,0)
SWEP.HolsterPos = Vector(-28,-3.5,3.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine4"

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.IconPos = Vector(120,-23,-2.5)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = true

SWEP.Rarity = 5

SWEP.BoltBone = nil
SWEP.BoltVec = nil

SWEP.ZoomPos = Vector(0,-3.32,0)
SWEP.ZoomAng = Angle(0.2,0,0)

SWEP.Animations = {
	["idle"] = {
        Source = "idle",
    },
	["draw"] = {
        Source = "draw",
        MinProgress = 0.5,
        Time = 1.5
    },
    ["reload"] = {
        Source = "reload_cham",
        MinProgress = 0.5,
        Time = 6
    },
    ["reload_empty"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 6
    }
}

SWEP.Reload1 = "pwb2/weapons/m4a1/ru-556 clip out 1.wav"
SWEP.Reload2 = "pwb2/weapons/m4a1/ru-556 clip in 2.wav"
SWEP.Reload3 = "pwb2/weapons/m4a1/ru-556 bolt forward.wav"
SWEP.Reload4 = false