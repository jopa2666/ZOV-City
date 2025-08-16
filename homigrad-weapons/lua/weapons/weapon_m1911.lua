SWEP.Base = "homigrad_base"
SWEP.PrintName = "M1911"
SWEP.Category = "Оружие: Пистолеты"
SWEP.Spawnable = true

SWEP.Bodygroups = {[1] = 0,[2] = 0,[3] = 0,[4] = 0,[5] = 0,[6] = 1,[7] = 0,[8] = 0}
SWEP.Skin = 1

SWEP.WorldModel = "models/weapons/arccw/c_ur_m1911.mdl"
SWEP.ViewModel = "models/weapons/arccw/c_ur_m1911.mdl"

SWEP.HoldType = "revolver"

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.ReloadTime = 3.6
SWEP.Primary.ClipSize = 9
SWEP.Primary.DefaultClip = 9
SWEP.Primary.Damage = 20
SWEP.Primary.Force = 20
SWEP.RecoilForce = 2
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Wait = 0.1
SWEP.Sound = "weapons/m1911/m1911_fp.wav"
SWEP.SubSound = "weapons/m1911/m1911_tp.wav"

SWEP.WorldPos = Vector(-0.5,-0.5,1)
SWEP.WorldAng = Angle(1,0,3)
SWEP.AttPos = Vector(22.5,2.33,-3)
SWEP.AttAng = Angle(-0.5,-0.1,0)
SWEP.HolsterAng = Angle(0,-90,0)
SWEP.HolsterPos = Vector(-16,5,2)

SWEP.BoltBone = "vm_charge"
SWEP.BoltVec = Vector(0,0,-1)

SWEP.IconPos = Vector(80,-15,-0.5)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = false

SWEP.ZoomPos = Vector(4,-2.23,-1.55)
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
        Time = 1.5
    },
    ["reload"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 2.5
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        MinProgress = 0.5,
        Time = 2.5
    }
}

SWEP.Reload1 = "zcitysnd/sound/weapons/makarov/handling/makarov_magout.wav"
SWEP.Reload2 = "zcitysnd/sound/weapons/makarov/handling/makarov_maghit.wav"
SWEP.Reload3 = "zcitysnd/sound/weapons/m9/handling/m9_boltrelease.wav"
SWEP.Reload4 = false

// я выебал беброZа