SWEP.Base = "homigrad_base"
SWEP.PrintName = "MP5"
SWEP.Category = "Оружие: ПП"
SWEP.Spawnable = true
SWEP.AvailableSights = {
   -- нетъ
}
SWEP.AvailableSuppressors = {
    "supp1", -- SilencerCo Hybrid
    "supp3", -- DD Wave Muzzle Brake
    "supp5", -- NO SUPPRESSOR
}

SWEP.WorldModel = "models/weapons/arccw/c_ur_mp5.mdl"
SWEP.ViewModel = "models/weapons/arccw/c_ur_mp5.mdl"

SWEP.HoldType = "ar2"

SWEP.Primary.Automatic = true
SWEP.Primary.ReloadTime = 3
SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Damage = 10
SWEP.Primary.Force = 2.5
SWEP.RecoilForce = 1.25
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Wait = 0.08
SWEP.Sound = "pwb/weapons/mp7/shoot.wav"
SWEP.SuppressedSound = "zcitysnd/sound/weapons/m4a1/m4a1_suppressed_fp.wav"

SWEP.WorldPos = Vector(-3,-1,1)
SWEP.WorldAng = Angle(0,0,5)
SWEP.AttPos = Vector(30,2,-3)
SWEP.AttAng = Angle(-0.4,-0.05,0)
SWEP.HolsterAng = Angle(0,-90,0)
SWEP.HolsterPos = Vector(-16,4,2)

SWEP.RecoilForce = 1.5

SWEP.BoltBone = nil
SWEP.BoltVec = nil

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.3,[2] = 0.7,[3] = 0.1,[4] = 1.7},
}

SWEP.IconPos = Vector(110,-10,1.5)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = true

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.Rarity = 4

SWEP.AttBone = "body"

SWEP.MountType = "picatinny"

SWEP.AvaibleAtt = {
    ["sight"] = false,
    ["barrel"] = true,
    ["grip"] = false
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

SWEP.ZoomPos = Vector(7,-2.96,-0.95)
SWEP.ZoomAng = Angle(-1,0,0)

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
        Time = 2.85
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        MinProgress = 0.5,
        Time = 2.85
    }
}

SWEP.Reload1 = "arccw_go/mp5/mp5_clipout.wav"
SWEP.Reload2 = "arccw_go/mp5/mp5_clipin.wav"
SWEP.Reload3 = "arccw_go/mp5/mp5_slideback.wav"
SWEP.Reload4 = "arccw_go/mp5/mp5_slideforward.wav"

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