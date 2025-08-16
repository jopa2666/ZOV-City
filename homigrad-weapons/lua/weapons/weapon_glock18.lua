SWEP.Base = "homigrad_base"
SWEP.PrintName = "Glock 18"
SWEP.Category = "Оружие: Пистолеты"
SWEP.Spawnable = true
SWEP.AvailableSuppressors = {
    "supp4", -- SilencerCO Osprey
    "supp5", -- NO SUPPRESSOR
}

SWEP.Bodygroups = {[1] = 2,[2] = 0,[3] = 3}

SWEP.WorldModel = "models/weapons/arccw/c_ud_glock.mdl"
SWEP.ViewModel = "models/weapons/arccw/c_ud_glock.mdl"

SWEP.HoldType = "revolver"

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.Automatic = true
SWEP.Primary.ReloadTime = 1.85
SWEP.Primary.ClipSize = 22
SWEP.Primary.DefaultClip = 22
SWEP.Primary.Damage = 25
SWEP.Primary.Force = 15
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Wait = 0.08
SWEP.RecoilForce = 1
SWEP.Sound = "sounds_zcity/glock17/close.wav"
SWEP.SubSound = "hmcd/hndg_beretta92fs/beretta92_fire1.wav"
SWEP.SuppressedSound = "sounds_zcity/hk_usp/supressor.wav"

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

SWEP.ZoomPos = Vector(8,-2.31,-2.45)
SWEP.ZoomAng = Angle(-0.5,0,0)

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
        Source = "reload_33",
        MinProgress = 0.5,
        Time = 2
    },
    ["reload_empty"] = {
        Source = "reload_empty_33",
        MinProgress = 0.5,
        Time = 2
    }
}

SWEP.Reload1 = "zcitysnd/sound/weapons/makarov/handling/makarov_magout.wav"
SWEP.Reload2 = "zcitysnd/sound/weapons/makarov/handling/makarov_maghit.wav"
SWEP.Reload3 = "zcitysnd/sound/weapons/m9/handling/m9_boltrelease.wav"
SWEP.Reload4 = false

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
            
            self.Bodygroups[6] = 6
            self:SetupModel(true)
        end
    end)
end