SWEP.Base = "homigrad_base"
SWEP.PrintName = "M4A1"
SWEP.IconOverride = "entities/m4a1.png"
SWEP.Category = "Оружие: Винтовки"
SWEP.Spawnable = true
SWEP.AvailableSights = {
    "holo1", -- Barska
    "holo2", -- Kobra
    "holo3", -- Eotech553
    "optic1", -- SIG Bravo-4
    "optic2", -- ELCAN SpecterDR
    "optic3", -- FLIR R32
    "optic6", -- ACOG
}
SWEP.AvailableSuppressors = {
    "supp1", -- SilencerCo Hybrid
    "supp3", -- DD Wave Muzzle Brake
    "supp2", -- AWC Thor PSR
}
SWEP.WorldModel = "models/weapons/arccw/c_ud_m16.mdl"
SWEP.ViewModel = "models/weapons/arccw/c_ud_m16.mdl"

SWEP.Bodygroups = {[1] = 1,[2] = 0,[3] = 2,[4] = 2,[5] = 7,[6] = 6,[7] = 8}

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.27,[2] = 0.7,[3] = 1.45,[4] = 1.47},
}

SWEP.Primary.ReloadTime = 3
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Damage = 35
SWEP.Primary.Force = 7
SWEP.Primary.Ammo = "5.56x45 mm"
SWEP.Primary.Wait = 0.1
SWEP.Sound = "zcitysnd/sound/weapons/firearms/rifle_fnfal/fnfal_fire_01.wav"
SWEP.SubSound = "hmcd/rifle_win1892/win1892_fire_01.wav"
SWEP.SuppressedSound = "zcitysnd/sound/weapons/m4a1/m4a1_suppressed_fp.wav"
SWEP.RecoilForce = 1

SWEP.WorldPos = Vector(-4,1,0)
SWEP.WorldAng = Angle(1,0,0)
SWEP.AttPos = Vector(27,2.85,-3.45)
SWEP.AttAng = Angle(0,0,0)
SWEP.HolsterAng = Angle(0,-10,0)
SWEP.HolsterPos = Vector(-18,0,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine4"

SWEP.IconPos = Vector(95,-14.5,-20)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = true

SWEP.Rarity = 5

SWEP.BoltBone = "nil"
SWEP.BoltVec = {0,0,0}

SWEP.ZoomPos = Vector(8,-2.825,-1.4)
SWEP.ZoomAng = Angle(0,0,0)

SWEP.AttBone = "m16_parent"

SWEP.MountType = "picatinny"

SWEP.AvaibleAtt = {
    ["sight"] = true,
    ["barrel"] = true,
    ["grip"] = true
}

SWEP.AttachmentPos = {
    ['sight'] = Vector(2,0,1.55),
    ['barrel'] = Vector(15.5,0,0.35),
    ['grip'] = Vector(-9,0,-1)
}
SWEP.AttachmentAng = {
    ['sight'] = Angle(-90,0,-90),
    ['barrel'] = Angle(-90,0,-90),
    ['grip'] = Angle(-90,0,90)
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
        Time = 2.75
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        MinProgress = 0.5,
        Time = 2.75
    }
}

SWEP.Reload1 = "weapons/arccw_ud/m16/magout.ogg"
SWEP.Reload2 = "weapons/arccw_ud/m16/magin.ogg"
SWEP.Reload3 = "weapons/arccw_ud/m16/chamber_press.ogg"
SWEP.Reload4 = "weapons/arccw_ud/m16/chamber.ogg"

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
            

            self:SetupModel(true)
        end
    end)
end