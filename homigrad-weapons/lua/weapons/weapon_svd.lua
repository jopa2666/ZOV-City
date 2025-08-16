SWEP.Base = "homigrad_base"
SWEP.PrintName = "СВД"
SWEP.Category = "Оружие: Снайперские Винтовки"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/arccw/dm1973/c_dmi_svd_spetsnaz.mdl"
SWEP.ViewModel = "models/weapons/arccw/dm1973/c_dmi_svd_spetsnaz.mdl"

SWEP.HoldType = "ar2"

SWEP.Primary.ReloadTime = 2
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Damage = 45
SWEP.Primary.Force = 1
SWEP.Primary.Ammo = "7.62x51 mm"
SWEP.Primary.Wait = 0.4
SWEP.Sound = "weapons/arccw/dmi_spetsnaz_svd/svd_fire1.wav"
SWEP.RecoilForce = 4.5

SWEP.WorldPos = Vector(-3,-0.5,1)
SWEP.WorldAng = Angle(1,0,0)
SWEP.AttPos = Vector(32,5.15,-3.45)
SWEP.AttAng = Angle(0,0.2,0)
SWEP.HolsterAng = Angle(0,-10,0)
SWEP.HolsterPos = Vector(-28,-3,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine4"

SWEP.BoltBone = "j_bolt"
SWEP.BoltVec = Vector(-2.5,0,0)

SWEP.MountType = "picatinny"

SWEP.AttBone = "tag_weapon"

SWEP.AvaibleAtt = {
    ["sight"] = true,
    ["barrel"] = true,
    ["grip"] = false
}

SWEP.AttachmentPos = {
    ['sight'] = Vector(2,0,4),
    ['barrel'] = Vector(15.5,0,0.35),
    ['grip'] = Vector(-9,0,-1)
}
SWEP.AttachmentAng = {
    ['sight'] = Angle(0,0,-1),
    ['barrel'] = Angle(0,0,0),
    ['grip'] = Angle(-90,0,90)
}

SWEP.IconPos = Vector(170,-22,-2.5)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = true

SWEP.Rarity = 5

SWEP.ZoomPos = Vector(4,-2.95,-0.70)
SWEP.ZoomAng = Angle(-0.8,-0.05,0)

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

SWEP.Reload1 = "zcitysnd/sound/weapons/ak74/handling/ak74_magout.wav"
SWEP.Reload2 = "zcitysnd/sound/weapons/aks74u/handling/aks_magin.wav"
SWEP.Reload3 = "zcitysnd/sound/weapons/ak74/handling/ak74_boltback.wav"
SWEP.Reload4 = "zcitysnd/sound/weapons/ak74/handling/ak74_boltrelease.wav"

function SWEP:PostAnim()
    if self.Attachments and self.Attachments['sight'] and self.Attachments['sight'][1] then
        self.Bodygroups[6] = 0
    end
end
    
function SWEP:Deploy()
    self.BaseClass.Deploy(self)
    
    timer.Simple(0.1, function()
        if IsValid(self) then
            hg.force_attachment(self, "optic4")
            self.Bodygroups[6] = 3
            self:SetupModel(true)
        end
    end)
end