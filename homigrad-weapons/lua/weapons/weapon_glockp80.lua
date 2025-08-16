SWEP.Base = "homigrad_base"
SWEP.PrintName = "Glock P80"
SWEP.Category = "Оружие: Пистолеты"
SWEP.Spawnable = true

SWEP.Bodygroups = {[1] = 0,[2] = 0,[3] = 0}

SWEP.WorldModel = "models/weapons/arccw/c_ud_glock.mdl"
SWEP.ViewModel = "models/weapons/arccw/c_ud_glock.mdl"

SWEP.HoldType = "revolver"

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.ReloadTime = 2
SWEP.Primary.ClipSize = 17
SWEP.Primary.DefaultClip = 17
SWEP.Primary.Damage = 35
SWEP.Primary.Force = 25
SWEP.RecoilForce = 1.55
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Wait = 0.1
SWEP.Sound = "sounds_zcity/glock17/close.wav"
SWEP.SubSound = "hmcd/hndg_beretta92fs/beretta92_fire1.wav"
SWEP.SuppressedSound = "sounds_zcity/hk_usp/supressor.wav"
SWEP.ShellEjectPos = Vector(0, 2, -4)
SWEP.ShellEjectAng = Angle(0, -90, 0)
SWEP.ShellEjectVelocity = 200

SWEP.WorldPos = Vector(-4,-0.5,2)
SWEP.WorldAng = Angle(1,0,0)
SWEP.AttPos = Vector(22.5,2.33,-3)
SWEP.AttAng = Angle(-0.5,-0.1,0)
SWEP.HolsterAng = Angle(0,-90,0)
SWEP.HolsterPos = Vector(-16,4,2)

SWEP.BoltBone = "glock_slide"
SWEP.BoltVec = Vector(0,0,-1)

SWEP.IconPos = Vector(40,-9.75,-7.5)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = false

SWEP.AttBone = "glock_parent"

SWEP.MountType = "picatinny"

SWEP.AvaibleAtt = {
    ["sight"] = false,
    ["barrel"] = true,
    ["grip"] = false
}

SWEP.AttachmentPos = {
    ['sight'] = Vector(2,0,1.55),
    ['barrel'] = Vector(6.8,0.1,2.3),
    ['grip'] = Vector(-9,0,-1)
}
SWEP.AttachmentAng = {
    ['sight'] = Angle(-90,0,-90),
    ['barrel'] = Angle(90,180,90),
    ['grip'] = Angle(-90,0,90)
}

SWEP.ZoomPos = Vector(8,-2.31,-2.45)
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
        Time = 2
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        MinProgress = 0.5,
        Time = 2
    }
}

SWEP.Reload1 = "zcitysnd/sound/weapons/makarov/handling/makarov_magout.wav"
SWEP.Reload2 = "zcitysnd/sound/weapons/makarov/handling/makarov_maghit.wav"
SWEP.Reload3 = "zcitysnd/sound/weapons/m9/handling/m9_boltrelease.wav"
SWEP.Reload4 = false
