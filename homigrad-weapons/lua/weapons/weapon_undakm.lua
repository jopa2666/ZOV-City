SWEP.Base = "homigrad_base"
SWEP.PrintName = "Underground AKM"
SWEP.Category = "Оружие: Винтовки"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/zcity/w_akm_bw.mdl"
SWEP.WorldModelReal = "models/weapons/tfa_ins2/c_akm_bw.mdl"
SWEP.ViewModel = "models/weapons/tfa_ins2/c_akm_bw.mdl"

SWEP.Bodygroups = {[1] = 1,[2] = 0,[3] = 0,[4] = 0,[5] = 0,[6] = 8,[7] = 0,[8] = 0,[9] = 2,[10] = 2}

SWEP.HoldType = "ar2"

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.55,[2] = 1.2,[3] = 1.85,[4] = 2},
}

SWEP.Primary.ReloadTime = 3.4
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Damage = 25
SWEP.Primary.Force = 1
SWEP.Primary.Ammo = "7.62x39 mm"
SWEP.Primary.Wait = 0.09
SWEP.Sound = "weapons/tfa_ins2/akm_bw/fire.wav"
SWEP.SubSound = "weapons/tfa_ins2/m4a1/m4a1_fire.wav"
SWEP.RecoilForce = 3

SWEP.WorldPos = Vector(-1,-0.5,1)
SWEP.WorldAng = Angle(0,0,0)
SWEP.AttPos = Vector(37,2.93,-2.4)
SWEP.AttAng = Angle(0.45,-0.25,0)
SWEP.HolsterAng = Angle(140,0,180)
SWEP.HolsterPos = Vector(-16,6,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine2"

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.BoltBone = "bolt"
SWEP.BoltVec = Vector(0,2,0)

SWEP.ZoomPos = Vector(4,-2.95,-1)
SWEP.ZoomAng = Angle(-0.9,-0.26,0)

SWEP.Rarity = 4

SWEP.TwoHands = true

SWEP.IconPos = Vector(150,-13,-1)
SWEP.IconAng = Angle(0,90,30)

SWEP.Animations = {
	["idle"] = {
        Source = "base_idle",
    },
	["draw"] = {
        Source = "base_draw",
        MinProgress = 0.5,
        Time = 1
    },
    ["reload"] = {
        Source = "base_reload",
        MinProgress = 0.5,
        Time = 3
    },
    ["reload_empty"] = {
        Source = "base_reloadempty",
        MinProgress = 0.5,
        Time = 3.6
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