SWEP.Base = "homigrad_base"
SWEP.PrintName = "АКС-74У"
SWEP.IconOverride = "entities/ak74u.png"
SWEP.Category = "Оружие: Винтовки"
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
SWEP.ViewModel = "models/weapons/arccw/c_ur_ak.mdl"

SWEP.Bodygroups = {[1] = 6,[2] = 2,[3] = 0,[4] = 1,[5] = 0,[6] = 3,[7] = 5,[8] = 2,[9] = 1,[10] = 2}

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.55,[2] = 1.2,[3] = 1.85,[4] = 2},
}

SWEP.Primary.ReloadTime = 3
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Damage = 35
SWEP.Primary.Force = 15
SWEP.Primary.Ammo = "5.45x39 mm"
SWEP.Primary.Wait = 0.09
SWEP.Sound = "weapons/tfa_ins2/akm_bw/fire.wav"
SWEP.SubSound = "weapons/tfa_ins2/m4a1/m4a1_fire.wav"
SWEP.SuppressedSound = "sounds_zcity/ak74/supressor.wav"
SWEP.RecoilForce = 0.7

SWEP.WorldPos = Vector(-3,-0.5,1)
SWEP.WorldAng = Angle(0,0,6)
SWEP.AttPos = Vector(37,2.93,-2.4)
SWEP.AttAng = Angle(0.45,-0.25,0)
SWEP.HolsterAng = Angle(140,0,180)
SWEP.HolsterPos = Vector(-16,6,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine2"

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.BoltBone = "vm_bolt"
SWEP.BoltVec = Vector(0,2,0)

SWEP.ZoomPos = Vector(6,-2.55,-0.8)
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
    ['barrel'] = Vector(15,0,2.7),
}

SWEP.AttachmentAng = {
    ['sight'] = Angle(0,0,-90),
    ['barrel'] = Angle(0,0,-90),
}

SWEP.IconPos = Vector(130,-17,-1)
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
        Source = "reload_308",
        MinProgress = 0.5,
        Time = 3.5
    },
    ["reload_empty"] = {
        Source = "reload_308_empty",
        MinProgress = 0.5,
        Time = 3.5
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

SWEP.Reload1 = "zcitysnd/sound/weapons/ak74/handling/ak74_magout.wav"
SWEP.Reload2 = "zcitysnd/sound/weapons/aks74u/handling/aks_magin.wav"
SWEP.Reload3 = "zcitysnd/sound/weapons/ak74/handling/ak74_boltback.wav"
SWEP.Reload4 = "zcitysnd/sound/weapons/ak74/handling/ak74_boltrelease.wav"

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
            
            self.Bodygroups[6] = 3
            self:SetupModel(true)
        end
    end)
end