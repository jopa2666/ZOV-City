SWEP.Base = "homigrad_base"
SWEP.PrintName = "РПК-74М"
SWEP.Category = "Оружие: Пулемёты"
SWEP.Spawnable = true
SWEP.AvailableSights = {
    "holo1", -- Barska
    "holo2", -- Kobra
    "holo3", -- Eotech553
    "holo5", -- Valday 1P78
    "optic1", -- SIG Bravo-4
    "optic2", -- ELCAN SpecterDR
    "optic3", -- FLIR R32
}
SWEP.AvailableSuppressors = {
    "supp1", -- SilencerCo Hybrid
    "supp3", -- DD Wave Muzzle Brake
    "supp2", -- AWC Thor PSR
}


SWEP.WorldModel = "models/weapons/arccw/c_ur_ak.mdl"
SWEP.ViewModel =  "models/weapons/arccw/c_ur_ak.mdl"

SWEP.Bodygroups = {[1] = 5,[2] = 1,[3] = 0,[4] = 0,[5] = 0,[6] = 5,[7] = 4,[8] = 0,[9] = 2}

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.2,[2] = 1.25,[3] = 2,[4] = 2.1},
}

SWEP.Primary.ReloadTime = 3.5
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 75
SWEP.Primary.DefaultClip = 75
SWEP.Primary.Damage = 45
SWEP.Primary.Force = 15
SWEP.Primary.Ammo = "7.62x39 mm"
SWEP.Primary.Wait = 0.09
SWEP.Sound = "zcitysnd/sound/weapons/ak47/ak47_fp.wav"
SWEP.SuppressedSound = "sounds_zcity/ak74/supressor.wav"
SWEP.RecoilForce = 0.75

SWEP.WorldPos = Vector(-3,1,1)
SWEP.WorldAng = Angle(0.65,0.1,4)
SWEP.AttPos = Vector(37,2.9,-2.5)
SWEP.AttAng = Angle(0.5,-0.2,0)
SWEP.HolsterAng = Angle(0,-10,0)
SWEP.HolsterPos = Vector(-18,0,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine4"

SWEP.IconPos = Vector(135,-21.25,-2)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = true

SWEP.Rarity = 5

SWEP.BoltBone = "vm_bolt"
SWEP.BoltVec = Vector(0,2,0)

SWEP.MountType = "dovetail"
SWEP.MountModel = "models/weapons/arc9_eft_shared/atts/mounts/mount_dovetail_aksion_kobra.mdl"
SWEP.MountPos = Vector(0.71,5,3.1)
SWEP.MountAng = Angle(0,0,0)
SWEP.MountScale = 0.75

SWEP.AttBone = "tag_weapon"

SWEP.AttachmentPos = {
    ['sight'] = Vector(3,0,4.9),
    ['barrel'] = Vector(27,0,2.7),
}

SWEP.AttachmentAng = {
    ['sight'] = Angle(0,0,-90),
    ['barrel'] = Angle(0,0,-90),
}

SWEP.ZoomPos = Vector(6,-2.57,-0.8)
SWEP.ZoomAng = Angle(0,-0.26,0)

SWEP.Animations = {
	["idle"] = {
        Source = "idle",
    },
	["draw"] = {
        Source = "draw",
        MinProgress = 0.5,
        Time = 1.35
    },
    ["reload"] = {
        Source = "reload_drum",
        MinProgress = 0.5,
        Time = 3.25
    },
    ["reload_empty"] = {
        Source = "reload_drum_empty",
        MinProgress = 0.5,
        Time = 3.55
    }
}

SWEP.Reload1 = "zcitysnd/sound/weapons/rpk/handling/rpk_magout.wav"
SWEP.Reload2 = "zcitysnd/sound/weapons/rpk/handling/rpk_magin.wav"
SWEP.Reload3 = "zcitysnd/sound/weapons/rpk/handling/rpk_boltback.wav"
SWEP.Reload4 = "zcitysnd/sound/weapons/rpk/handling/rpk_boltrelease.wav"

function SWEP:Initialize()
    self.BaseClass.Initialize(self)
    
    if not self.InitialSight then
        self.InitialSight = table.Random(self.AvailableSights)
    end
end

function SWEP:GetRandomSuppressor()
    local validSupps = {}
    
    for _, suppName in ipairs(self.AvailableSuppressors) do
        if hg.Attachments[suppName] then
            table.insert(validSupps, suppName)
        end
    end
    
    return #validSupps > 0 and table.Random(validSupps) or nil
end


function SWEP:Deploy()
    self.BaseClass.Deploy(self)
    
    timer.Simple(0.1, function()
        if IsValid(self) then
            if self.InitialSight then
                hg.force_attachment(self, self.InitialSight)
            end
            
            local randomSupp = self:GetRandomSuppressor()
            if randomSupp then
                hg.force_attachment(self, randomSupp)
            end
            
            self.Bodygroups[6] = 12
            self:SetupModel(true)
        end
    end)
end
