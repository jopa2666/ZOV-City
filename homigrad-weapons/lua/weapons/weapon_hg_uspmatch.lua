SWEP.Base = "homigrad_base"
SWEP.PrintName = "HK USP Match"
SWEP.Category = "ХЛ2 Оружие: Пистолеты"
SWEP.Spawnable = true

SWEP.Bodygroups = {[1] = 0,[2] = 0,[3] = 0}

SWEP.WorldModel = "models/weapons/pistol/w_pistol.mdl"
SWEP.WorldModelReal = "models/weapons/tfa_mmod/c_pistol.mdl"
SWEP.ViewModel = "models/weapons/tfa_mmod/c_pistol.mdl"

SWEP.HoldType = "revolver"

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.ReloadTime = 1.85
SWEP.Primary.ClipSize = 17
SWEP.Primary.DefaultClip = 17
SWEP.Primary.Damage = 15
SWEP.Primary.Force = 25
SWEP.RecoilForce = 1
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Wait = 0.01
SWEP.Sound = "weapon/pistol/pistol_fire_player_01.wav"

SWEP.ShellEject = true
SWEP.ShellModel = "models/weapons/shell.mdl"
SWEP.ShellScale = 1
SWEP.ShellOffset = Vector(5, 2, 0)
SWEP.ShellAngle = Angle(0, 90, 0)
SWEP.ShellVelocity = 20


SWEP.WorldPos = Vector(-8,-3,1)
SWEP.WorldAng = Angle(1,0,0)
SWEP.AttPos = Vector(25,5,-2)
SWEP.AttAng = Angle(-0.5,0,0)
SWEP.HolsterAng = Angle(0,-90,0)
SWEP.HolsterPos = Vector(-16,4,2)

SWEP.BoltBone = "p_slide" -- Скебоб
SWEP.BoltVec = Vector(-1,0,0)

SWEP.IconPos = Vector(60,-30,-4)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = false

SWEP.ZoomPos = Vector(10,-5,-1.8)
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
        Time = 1.5
    },
}

SWEP.Reload1 = "zcitysnd/sound/weapons/makarov/handling/makarov_magout.wav"
SWEP.Reload2 = "zcitysnd/sound/weapons/makarov/handling/makarov_maghit.wav"
SWEP.Reload3 = "zcitysnd/sound/weapons/m9/handling/m9_boltrelease.wav"
SWEP.Reload4 = false