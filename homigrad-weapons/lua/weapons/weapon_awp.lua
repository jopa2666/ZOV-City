SWEP.Base = "homigrad_base"
SWEP.PrintName = "AWP"
SWEP.Category = "Оружие: Снайперские Винтовки"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/arccw/c_ur_aw.mdl"
SWEP.ViewModel = "models/weapons/arccw/c_ur_aw.mdl"

SWEP.Bodygroups = {[1] = 0,[2] = 0,[3] = 0,[4] = 0,[5] = 0,[6] = 0,[7] = 0,[8] = 0}

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.27,[2] = 0.7,[3] = 1.45,[4] = 1.47},
}

SWEP.Primary.ReloadTime = 3.85
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 5
SWEP.Primary.Damage = 45
SWEP.Primary.Force = 7.5
SWEP.Primary.Ammo = "7.62x51 mm"
SWEP.Primary.Wait = 1.15
SWEP.Sound = "arccw_uc/common/ub12ga/fire-02.ogg"
SWEP.SuppressedSound = "zcitysnd/sound/weapons/m4a1/m4a1_suppressed_fp.wav"
SWEP.RecoilForce = 7.5

SWEP.WorldPos = Vector(-2,-0.5,1.35)
SWEP.WorldAng = Angle(1,0,0)
SWEP.AttPos = Vector(20,3.55,-3.5)
SWEP.AttAng = Angle(0,0,0)
SWEP.HolsterAng = Angle(0,-10,0)
SWEP.HolsterPos = Vector(-28,-1,10)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine4"

SWEP.IconPos = Vector(145,-25,-3)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = true

SWEP.Rarity = 5

SWEP.BoltBone = nil
SWEP.BoltVec = nil

SWEP.ZoomPos = Vector(4,-3.38,-0.55)
SWEP.ZoomAng = Angle(0,0,0)

SWEP.MountType = "picatinny"

SWEP.AttBone = "tag_weapon"

SWEP.AttachmentPos = {
    ['sight'] = Vector(3,0,4.9),
    ['barrel'] = Vector(24,0,2.7),
}

SWEP.AttachmentAng = {
    ['sight'] = Angle(0,0,-90),
    ['barrel'] = Angle(0,0,-90),
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
    ["fire"] = {
        Source = "cycle",
        MinProgress = 0.5,
        Time = 2
    },
    ["reload"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 4
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        MinProgress = 0.5,
        Time = 4
    }
}

SWEP.Reload1 = "weapons/arccw_ur/aw_placeholders/boltback.ogg"
SWEP.Reload2 = "weapons/arccw_ur/aw_placeholders/magout.ogg"
SWEP.Reload3 = "weapons/arccw_ur/aw_placeholders/magin.og"
SWEP.Reload4 = "weapons/arccw_ur/aw_placeholders/boltforward.ogg"

/*function SWEP:Deploy()
    self.BaseClass.Deploy(self)
    
    timer.Simple(0.1, function()
        if IsValid(self) then
            hg.force_attachment(self, "optic10")
            self:SetupModel(true)
        end
    end)
end*/

