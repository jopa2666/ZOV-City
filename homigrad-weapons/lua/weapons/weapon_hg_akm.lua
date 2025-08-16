SWEP.Base = "homigrad_base"
SWEP.PrintName = "AKM"
SWEP.Category = "ХЛ2 Оружие: Винтовки"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/akm/w_akm.mdl"
SWEP.WorldModelReal = "models/weapons/akm/c_akm.mdl"
SWEP.ViewModel = "models/weapons/akm/c_akm.mdl"

SWEP.Bodygroups = {[1] = 1,[2] = 0,[3] = 0,[4] = 0,[5] = 0,[6] = 8,[7] = 0,[8] = 0,[9] = 2,[10] = 2}

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.55,[2] = 1.2,[3] = 1.85,[4] = 2},
}

SWEP.Primary.ReloadTime = 2.4
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Damage = 53
SWEP.Primary.Force = 1
SWEP.Primary.Ammo = "7.62x39 mm"
SWEP.Primary.Wait = 0.08
SWEP.Sound = "weapon/akm/akm_fire_player_02.wav"
SWEP.RecoilForce = 1.4

SWEP.WorldPos = Vector(-5,-1,0)
SWEP.WorldAng = Angle(0,0,0)
SWEP.AttPos = Vector(37,3.3,-4)
SWEP.AttAng = Angle(0,0,0)
SWEP.HolsterAng = Angle(140,0,180)
SWEP.HolsterPos = Vector(-16,6,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine2"

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.BoltBone = "charge"
SWEP.BoltVec = Vector(1.5,0,0)

SWEP.ZoomPos = Vector(6.7,-3.4,-1.3)
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

SWEP.IconPos = Vector(140,-19,-1)
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
        Time = 2.7
    },
    ["reload_empty"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 2.7
    },
}
