SWEP.Base = "homigrad_base"
SWEP.PrintName = "ПКМ"
SWEP.Category = "Оружие: Пулемёты"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/tfa_gamebanana/w_mach_pkm.mdl"
SWEP.WorldModelReal = "models/weapons/tfa_gamebanana/c_mach_pkm.mdl"
SWEP.ViewModel =  "models/weapons/tfa_gamebanana/c_mach_pkm.mdl"

SWEP.Bodygroups = {[1] = 5,[2] = 1,[3] = 0,[4] = 0,[5] = 0,[6] = 5,[7] = 4,[8] = 0,[9] = 2}

SWEP.HoldType = "smg"

SWEP.Empty3 = false
SWEP.Empty4 = false

SWEP.holdtypes = {
    ["smg"] = {[1] = 0.3,[2] = 1.25,[3] = 2,[4] = 2.1},
}

SWEP.Primary.ReloadTime = 7
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Damage = 80
SWEP.Primary.Force = 15
SWEP.Primary.Ammo = "7.62x39 mm"
SWEP.Primary.Wait = 0.11
SWEP.Sound = "pwb2/weapons/pkm/pkm-1.wav"
SWEP.RecoilForce = 1.1

SWEP.WorldPos = Vector(-1,-0.5,0)
SWEP.WorldAng = Angle(0,0,0)
SWEP.AttPos = Vector(37,3,-0.2)
SWEP.AttAng = Angle(0.6,-0.1,0)
SWEP.HolsterAng = Angle(0,-10,0)
SWEP.HolsterPos = Vector(-18,1,8)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine4"

SWEP.IconPos = Vector(155,-19,-6)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = true

SWEP.Rarity = 5

SWEP.BoltBone = "bolt"
SWEP.BoltVec = Vector(-2.5,0,0)

SWEP.ZoomPos = Vector(3,-2.80,-0.4)
SWEP.ZoomAng = Angle(0,-0.05,0)

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
        Time = 7
    },
}

SWEP.Reload1 = false
SWEP.Reload2 = false
SWEP.Reload3 = false
