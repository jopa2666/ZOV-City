-- АААААА ЗСИСИИИИИ АРУЖИЕЕЕЕЕЕЕЕЕЕЕ
SWEP.Base = "homigrad_base"
SWEP.PrintName = "Арбалет"
SWEP.Category = "ХЛ2 Оружие: Снайперские Винтовки"
SWEP.Spawnable = true


SWEP.MuzzleColor = {255,255,255}

SWEP.WorldModel = "models/weapons/w_iiopncrossbow.mdl"
SWEP.WorldModelReal = "models/weapons/c_iiopncrossbow.mdl"
SWEP.ViewModel = "models/weapons/c_iiopncrossbow.mdl"

SWEP.Bodygroups = {[1] = 2,[2] = 0,[3] = 0,[4] = 0,[5] = 0,[6] = 8,[7] = 0,[8] = 0,[9] = 2,[10] = 2}

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.55,[2] = 1.2,[3] = 1.85,[4] = 2},
}

SWEP.Primary.ReloadTime = 2
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Damage = 95
SWEP.Primary.Force = 1
SWEP.Primary.Ammo = "7.62x39 mm"
SWEP.Primary.Wait = 0.01
SWEP.Sound = "weapons/crossbow/fire1.wav"
SWEP.RecoilForce = 3

SWEP.IsShotgun = true -- Нужен для отображения патронов а не магазинов

SWEP.WorldPos = Vector(-5,-2.5,0.5)
SWEP.WorldAng = Angle(0,0,0)
SWEP.AttPos = Vector(37,5.5,-2.4)
SWEP.AttAng = Angle(0.45,-0.25,0)
SWEP.HolsterAng = Angle(140,0,180)
SWEP.HolsterPos = Vector(-16,6,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine2"

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.BoltBone = nil
SWEP.BoltVec = nil

SWEP.ZoomPos = Vector(7,-5.4,2)
SWEP.ZoomAng = Angle(-0.9,0,0)

SWEP.Rarity = 4

SWEP.TwoHands = true

-- виноград, сливыыы, яблаки зеленые, бананы бананы, икс 100 икс 100, блять, гандон

SWEP.IconPos = Vector(130,-22,-3)
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
    ["fire"] = {
        Source = "fire",
        MinProgress = 0.5,
        Time = 1
    },
    ["reload"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 2
    },
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

SWEP.Reload1 = "weapons/crossbow/reload1.wav"
SWEP.Reload2 = "weapons/crossbow/bolt_load1.wav"
SWEP.Reload3 = false
SWEP.Reload4 = false

-- Беброс гоу каллаб мой никнейм - какащке 52
