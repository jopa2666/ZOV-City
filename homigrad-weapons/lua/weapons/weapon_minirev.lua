SWEP.Base = "homigrad_base"
SWEP.PrintName = "410 Jury"
SWEP.Category = "Оружие: Пистолеты"
SWEP.Spawnable = true

SWEP.Bodygroups = {[1] = 0,[2] = 0,[3] = 0}

SWEP.WorldModel = "models/weapons/w_pist_410jury.mdl"
SWEP.WorldModelReal = "models/weapons/c_pist_410jury.mdl"
SWEP.ViewModel = "models/weapons/c_pist_410jury.mdl"

SWEP.HoldType = "revolver"

SWEP.ViewModelFlip = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.ReloadTime = 3
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 5
SWEP.Primary.Damage = 25
SWEP.Primary.Force = 25
SWEP.RecoilForce = 3
SWEP.NumBullet = 3
SWEP.Primary.Ammo = "12/70 Gauge"
SWEP.Primary.Wait = 0.2
SWEP.Sound = "weapons/410jury/fire.wav"

SWEP.IsRevolver = true

SWEP.WorldPos = Vector(2,-0.5,0)
SWEP.WorldAng = Angle(1,0,0)
SWEP.AttPos = Vector(24,3.5,-1)
SWEP.AttAng = Angle(0,0,0)
SWEP.HolsterAng = Angle(0,-90,0)
SWEP.HolsterPos = Vector(-10,5,2)

SWEP.BoltBone = "glock_slide"
SWEP.BoltVec = Vector(0,0,-1)

SWEP.IconPos = Vector(40,-9.75,-7.5)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = false

SWEP.ZoomPos = Vector(2,-2.3,-1)
SWEP.ZoomAng = Angle(-0.5,0,0)

SWEP.holdtypes = {
    ["revolver"] = {[1] = 0.3,[2] = 0.9,[3] = 1.3,[4] = 0},
}

SWEP.Animations = {
	["idle"] = {
        Source = "idle",
    },
	["draw"] = {
        Source = "draw",
        MinProgress = 0.5,
        Time = 0.5
    },
    ["reload"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 3
    },
}

