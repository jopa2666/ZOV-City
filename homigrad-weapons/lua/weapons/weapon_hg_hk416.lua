SWEP.Base = "homigrad_base"
SWEP.PrintName = "HK416"
SWEP.Category = "Оружие: Винтовки"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/arccw/dm1973/w_hk416_a7_battle.mdl"
SWEP.WorldModelReal = "models/weapons/arccw/dm1973/c_hk416_a7_battle.mdl"
SWEP.ViewModel = "models/weapons/arccw/dm1973/c_hk416_a7_battle.mdl"

SWEP.HoldType = "ar2"

SWEP.Primary.ReloadTime = 1.9
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Damage = 35
SWEP.Primary.Force = 1
SWEP.Primary.Ammo = "5.56x45 mm"
SWEP.Primary.Wait = 0.085
SWEP.Sound = "weapons/arccw_dmi/hk416_a7/ar15exp-1.wav"
SWEP.RecoilForce = 0.8

SWEP.WorldPos = Vector(-1,1,1)
SWEP.WorldAng = Angle(1,0,0)
SWEP.AttPos = Vector(32,5.15,-3.45)
SWEP.AttAng = Angle(0,0.2,0)
SWEP.HolsterAng = Angle(-145,0,0)
SWEP.HolsterPos = Vector(-10,-12,3)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine2"

SWEP.IconPos = Vector(110,-13,-2.5)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = true

SWEP.Rarity = 5

SWEP.BoltBone = nil
SWEP.BoltVec = nil

SWEP.ZoomPos = Vector(2,-2.43,0.5)
SWEP.ZoomAng = Angle(-0.8,-0.05,0)

SWEP.Animations = {
	["idle"] = {
        Source = "idle",
    },
	["draw"] = {
        Source = "draw",
        MinProgress = 0.5,
        Time = 1
    },
    ["reload"] = {
        Source = "soh_wet",
        MinProgress = 0.5,
        Time = 2
    },
    ["reload_empty"] = {
        Source = "soh_dry",
        MinProgress = 0.5,
        Time = 2
    }
}

SWEP.Reload1 = false
SWEP.Reload2 = false
SWEP.Reload3 = false
SWEP.Reload4 = false