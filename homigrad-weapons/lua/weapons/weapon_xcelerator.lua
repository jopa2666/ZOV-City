SWEP.Base = "homigrad_base"
SWEP.PrintName = "XCelerator"
SWEP.Category = "Оружие: Пистолеты"
SWEP.Spawnable = true

SWEP.Bodygroups = {[1] = 0,[2] = 0,[3] = 0}

SWEP.WorldModel = "models/weapons/tfa_gamebanana/w_pist_xcelerator.mdl"
SWEP.WorldModelReal = "models/weapons/tfa_gamebanana/c_pist_xcelerator.mdl"
SWEP.ViewModel = "models/weapons/tfa_gamebanana/c_pist_xcelerator.mdl"

SWEP.HoldType = "revolver"

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.ReloadTime = 2.3
SWEP.Primary.ClipSize = 13
SWEP.Primary.DefaultClip = 13
SWEP.Primary.Damage = 30
SWEP.Primary.Force = 25
SWEP.RecoilForce = 1.3
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Wait = 0.1
SWEP.Sound = "weapons/arccw_uc_usp/fire-01.ogg"
SWEP.SubSound = "weapons/tfa_ins2/mk23/m45_fp.wav"

SWEP.WorldPos = Vector(-6,-0.5,0)
SWEP.WorldAng = Angle(1,0,0)
SWEP.AttPos = Vector(22.5,4,-3)
SWEP.AttAng = Angle(-0.5,-2,0)
SWEP.HolsterAng = Angle(0,-90,0)
SWEP.HolsterPos = Vector(-0.5,7,0.2)

SWEP.BoltBone = "sig_slide"
SWEP.BoltVec = Vector(0,1,0)

SWEP.IconPos = Vector(55,-17,-3)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = false

SWEP.ZoomPos = Vector(9,-3.1,-1.2)
SWEP.ZoomAng = Angle(-0.5,0,0)

SWEP.holdtypes = {
    ["revolver_empty"] = {[1] = 0.3,[2] = 0.9,[3] = 1.3,[4] = 0},
}

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
        Source = "reload",
        MinProgress = 0.5,
        Time = 2.5
    },
}

SWEP.Reload1 = false
SWEP.Reload2 = false
SWEP.Reload3 = false
SWEP.Reload4 = false