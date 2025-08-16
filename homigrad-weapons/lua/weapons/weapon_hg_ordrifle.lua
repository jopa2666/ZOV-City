SWEP.Base = "homigrad_base"
SWEP.PrintName = "Ordinal Rifle"
SWEP.Category = "ХЛ2 Оружие: Винтовки"
SWEP.Spawnable = true

SWEP.MuzzleColor = Color(0,153,255)

SWEP.WorldModel = "models/weapons/w_ordinalrifle.mdl"
SWEP.WorldModelReal = "models/weapons/c_ordinalrifle.mdl"
SWEP.ViewModel = "models/weapons/c_ordinalrifle.mdl"
SWEP.InspectOffset = {
    Pos = Vector(-5, -10, -3), -- Смещение позиции при осмотре
    Ang = Angle(20, 30, 0)     -- Поворот при осмотре
}
SWEP.InspectTime = 3          -- Длительность осмотра
SWEP.IsInspecting = false     -- Флаг осмотра
SWEP.InspectStartTime = 0     -- Время начала осмотра

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.55,[2] = 1.2,[3] = 1.85,[4] = 2},
}

SWEP.Primary.ReloadTime = 2.8
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Damage = 48
SWEP.Primary.Force = 15
SWEP.Primary.Ammo = "5.45x39 mm"
SWEP.Primary.Wait = 0.08
SWEP.Sound = "weapons/projectmmod_ar3/ar3_fire2.wav"
SWEP.RecoilForce = 0.8

SWEP.WorldPos = Vector(-5,-0.5,0)
SWEP.WorldAng = Angle(0,0,-2)
SWEP.AttPos = Vector(30,4,-3)
SWEP.AttAng = Angle(0,0,0)
SWEP.HolsterAng = Angle(140,0,180)
SWEP.HolsterPos = Vector(-16,6,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine2"

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.BoltBone = "hammer1"
SWEP.BoltVec = Vector(0,-2,0)

SWEP.ZoomPos = Vector(5,-3.1,-0.1)
SWEP.ZoomAng = Angle(-0.9,-0.26,0)

SWEP.Rarity = 4

SWEP.TwoHands = true

SWEP.MountType = "dovetail"
SWEP.MountModel = "models/weapons/arc9_eft_shared/atts/mounts/mount_dovetail_aksion_kobra.mdl"
SWEP.MountPos = Vector(0.71,5,3.1)
SWEP.MountAng = Angle(0,0,0)
SWEP.MountScale = 0.75

SWEP.AttBone = "tag_weapon"

SWEP.AttachmentPos = {
    ['sight'] = Vector(3,0,4.9),
    ['barrel'] = Vector(24,0,2.7),
}

SWEP.AttachmentAng = {
    ['sight'] = Angle(0,0,-90),
    ['barrel'] = Angle(0,0,-90),
}

SWEP.IconPos = Vector(100,-17,-0.5)
SWEP.IconAng = Angle(0,90,0)

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
        Time = 3
    },
    ["reload_empty"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 3
    }
}