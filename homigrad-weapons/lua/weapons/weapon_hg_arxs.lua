SWEP.Base = "homigrad_base"
SWEP.PrintName = "ARX-S"
SWEP.Category = "ХЛ2 Оружие: Снайперские Винтовки"
SWEP.Spawnable = true
SWEP.AvailableSights = {
    "optic7", -- ARXS SCOPE
}

SWEP.WorldModel = "models/weapons/sniper/w_sniper.mdl"
SWEP.WorldModelReal = "models/weapons/sniper/c_sniper.mdl"
SWEP.ViewModel = "models/weapons/sniper/c_sniper.mdl"

SWEP.Bodygroups = {[1] = 3,[2] = 9,[3] = 0,[4] = 0,[5] = 0,[6] = 12,[7] = 0,[8] = 0,[9] = 2,[10] = 2}

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.55,[2] = 1.2,[3] = 1.85,[4] = 2},
}

SWEP.Primary.ReloadTime = 2.4
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Damage = 85
SWEP.Primary.Force = 15
SWEP.Primary.Ammo = "7.62x51 mm"
SWEP.Primary.Wait = 1
SWEP.Sound = "weapon/sniperrifle/sniperrifle_fire_player_03.wav"
SWEP.RecoilForce = 5

SWEP.IsRevolver = true

SWEP.WorldPos = Vector(-4,-3,3)
SWEP.WorldAng = Angle(0,0,0)
SWEP.AttPos = Vector(40,4.5,-2.4)
SWEP.AttAng = Angle(0,0,0)
SWEP.HolsterAng = Angle(140,0,180)
SWEP.HolsterPos = Vector(-16,6,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine2"

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.BoltBone = "ninado"
SWEP.BoltVec = Vector(0,2,0)

SWEP.ZoomPos = Vector(8,-5.4,-3)
SWEP.ZoomAng = Angle(0,0,0)

SWEP.Rarity = 4

SWEP.TwoHands = true

SWEP.MountType = "picatinny"

SWEP.AttBone = "tag_weapon"

SWEP.AttachmentPos = {
    ['sight'] = Vector(21,5.35,-2.75),
    ['barrel'] = Vector(24,0,2.7),
}

SWEP.AttachmentAng = {
    ['sight'] = Angle(0,0,0),
    ['barrel'] = Angle(0,0,-90),
}

SWEP.IconPos = Vector(225,-35,-7)
SWEP.IconAng = Angle(0,90,0)

SWEP.Animations = {
	["idle"] = {
        Source = "idle",
    },
	["draw"] = {
        Source = "sniper_draw",
        MinProgress = 0.5,
        Time = 1
    },
    ["reload"] = {
        Source = "sniper_reload",
        MinProgress = 0.5,
        Time = 2.7
    },
    ["reload_empty"] = {
        Source = "sniper_reload",
        MinProgress = 0.5,
        Time = 3
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
            hg.force_attachment(self, "optic7")
            self.Bodygroups[6] = 3
            self:SetupModel(true)
        end
    end)
end