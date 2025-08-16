SWEP.Base = "homigrad_base"
SWEP.PrintName = "АС ВАЛ"
SWEP.IconOverride = "entities/tasty-asval.png"
SWEP.Category = "Оружие: Винтовки"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/zcity/w_asval.mdl"
SWEP.WorldModelReal = "models/tasty/asval.mdl"
SWEP.ViewModel = "models/tasty/asval.mdl"

SWEP.Bodygroups = {[1] = 3,[2] = 9,[3] = 0,[4] = 0,[5] = 0,[6] = 12,[7] = 0,[8] = 0,[9] = 2,[10] = 2}

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.55,[2] = 1.2,[3] = 1.85,[4] = 2},
}

SWEP.Primary.ReloadTime = 2.45
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Damage = 30
SWEP.Primary.Force = 15
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Wait = 0.09
SWEP.Sound = "tasty/asval-fire.wav"
SWEP.RecoilForce = 0.5

SWEP.WorldPos = Vector(1,-1,0.5)
SWEP.WorldAng = Angle(0,0,0)
SWEP.AttPos = Vector(37,2.93,-2.4)
SWEP.AttAng = Angle(0.45,-0.25,0)
SWEP.HolsterAng = Angle(140,0,180)
SWEP.HolsterPos = Vector(-17,5,6)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine2"

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.BoltBone = "bolt"
SWEP.BoltVec = Vector(0,0,-1.5)

SWEP.ZoomPos = Vector(6,-4,-2)
SWEP.ZoomAng = Angle(-0.9,-0.26,0.5)

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

SWEP.IconPos = Vector(130,-16,-1)
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
        Time = 2
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        MinProgress = 0.5,
        Time = 2.5
    }
}

function SWEP:PostAnim()
    if self.BoltBone and self.BoltVec and CLIENT then
        local bone = self:GetWM():LookupBone(self.BoltBone)

        if bone then
            self:GetWM():ManipulateBonePosition(bone,self.BoltVec * self.animmul)
        end
    end

    if IsValid(self.worldModel) and self.worldModel:LookupBone("vm_mag2") then
        self.worldModel:ManipulateBoneScale(self.worldModel:LookupBone("vm_mag2"),Vector(1,1,1) * (self.reload != nil and 1 or 0))
        self.worldModel:ManipulateBoneScale(self.worldModel:LookupBone("tag_mag2"),Vector(1,1,1) * (self.reload != nil and 1 or 0))
    end

    self.animmul = LerpFT(0.25,self.animmul,0)
end

SWEP.Reload1 = "tasty/asval-magout.wav"
SWEP.Reload2 = "tasty/asval-magin.wav"
SWEP.Reload3 = "tasty/asval-boltback.wav"
SWEP.Reload4 = "tasty/asval-boltrelease.wav"