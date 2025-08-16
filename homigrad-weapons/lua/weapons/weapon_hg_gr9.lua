SWEP.Base = "homigrad_base"
SWEP.PrintName = "GR9"
SWEP.Category = "ХЛ2 Оружие: Пулемёты"
SWEP.Spawnable = true
SWEP.AvailableSights = {
    "optic9" -- GR9 SCOPE
}

SWEP.WorldModel = "models/weapons/hmg/w_gr9.mdl"
SWEP.WorldModelReal = "models/weapons/hmg/c_gr9.mdl"
SWEP.ViewModel = "models/weapons/hmg/c_gr9.mdl"

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.35,[2] = 1,[3] = 1.3,[4] = 0},
}

SWEP.Primary.ReloadTime = 3.5
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 90
SWEP.Primary.DefaultClip = 90
SWEP.Primary.Damage = 25
SWEP.Primary.Force = 4
SWEP.Primary.Ammo = "7.62x51 mm"
SWEP.Primary.Wait = 0.09
SWEP.Sound = "weapon/sniperrifle/sniperrifle_fire_player_03.wav"
SWEP.RecoilForce = 2
SWEP.Empty3 = false

SWEP.MuzzleColor = Color(0,153,255)

SWEP.WorldPos = Vector(-6,-5,4)
SWEP.WorldAng = Angle(1,0,-1)
SWEP.AttPos = Vector(37,6.5,-4.8)
SWEP.AttAng = Angle(0,0.5,0)
SWEP.HolsterAng = Angle(0,-20,0)
SWEP.HolsterPos = Vector(-28,1,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine4"

SWEP.BoltBone = nil -- рибята я хачу дамой
SWEP.BoltVec = nil

SWEP.ZoomPos = Vector(8,-7.3,-3)
SWEP.ZoomAng = Angle(0,0,0)

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.Rarity = 4

SWEP.TwoHands = true

SWEP.MountType = "picatinny"

SWEP.AttBone = "tag_weapon"

SWEP.AttachmentPos = {
    ['sight'] = Vector(21,7.25,-3),
    ['barrel'] = Vector(24,0,2.7),
}

SWEP.AttachmentAng = {
    ['sight'] = Angle(0,0,0),
    ['barrel'] = Angle(0,0,-90),
}

SWEP.IconPos = Vector(165,-28,-4)
SWEP.IconAng = Angle(0,90,0)

SWEP.Animations = {
	["idle"] = {
        Source = "idle",
    },
	["draw"] = {
        Source = "draw",
        MinProgress = 0.5,
        Time = 0.5
    },
    ["reload"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 4
    }
}

SWEP.Reload1 = false
SWEP.Reload2 = false
SWEP.Reload3 = false
SWEP.Reload4 = false

function SWEP:PostAnim()
    if self.Attachments and self.Attachments['sight'] and self.Attachments['sight'][1] then
        self.Bodygroups[6] = 0
    end
end
    
function SWEP:Deploy()
    self.BaseClass.Deploy(self)
    
    timer.Simple(0.1, function()
        if IsValid(self) then
            hg.force_attachment(self, "optic9")
            self.Bodygroups[6] = 3
            self:SetupModel(true)
        end
    end)
end