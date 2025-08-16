SWEP.Base = "homigrad_base"
SWEP.PrintName = "Desert Eagle IMI"
SWEP.Category = "Оружие: Пистолеты"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/arccw/c_ud_deagle.mdl"
SWEP.ViewModel = "models/weapons/arccw/c_ud_deagle.mdl"

SWEP.HoldType = "revolver"

SWEP.Primary.ReloadTime = 3
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 7
SWEP.Primary.Damage = 55
SWEP.Primary.Force = 30
SWEP.Primary.Ammo = ".50 Action Express"
SWEP.Primary.Wait = 0.2
SWEP.Sound = "sounds_zcity/deagle/close.wav"

SWEP.holdtypes = {
    ["revolver"] = {[1] = 0.15,[2] = 0.85,[3] = 1.3,[4] = 0},
    ["revolver_empty"] = {[1] = 0.15,[2] = 1.15,[3] = 1.6,[4] = 0},
}

SWEP.Skin = 0

SWEP.RecoilForce = 3

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.WorldPos = Vector(-2,-1,1.5)
SWEP.WorldAng = Angle(1,-1,0)
SWEP.AttPos = Vector(25.5,2.55,-3.85)
SWEP.AttAng = Angle(0.5,0,0)
SWEP.HolsterAng = Angle( 0,-90,0)
SWEP.HolsterPos = Vector(-14,4.5,8)
SWEP.HolsterBone = "ValveBiped.Bip01_Pelvis"

SWEP.BoltBone = "Slide"
SWEP.BoltVec = Vector(0,0,-2.75)

SWEP.IconPos = Vector(50,-17.5,1)
SWEP.IconAng = Angle(0,90,0)

SWEP.Rarity = 5

SWEP.TwoHands = false

SWEP.ZoomPos = Vector(5,-2.65,-1.48)
SWEP.ZoomAng = Angle(0,0,0)

SWEP.Animations = {
	["idle"] = {
        Source = "idle",
    },
	["draw"] = {
        Source = "ready",
        MinProgress = 0.5,
        Time = 1.5
    },
    ["reload"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 3
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        MinProgress = 0.5,
        Time = 3.5
    }
}

SWEP.Reload1 = "weapons/arccw_ur/deagle/magout_old.ogg"
SWEP.Reload2 = "weapons/arccw_ur/deagle/magin.ogg"
SWEP.Reload3 = "weapons/arccw_ur/deagle/chamber.ogg"
SWEP.Reload4 = false

function SWEP:PostAnim()
    if self.BoltBone and self.BoltVec and CLIENT then
        local bone = self:GetWM():LookupBone(self.BoltBone)

        if bone then
            self:GetWM():ManipulateBonePosition(bone,self.BoltVec * self.animmul)
        end
    end

    if self:Clip1() == 0 and !self.reload then
        self.animmul = 1
    else 
        self.animmul = LerpFT(0.25,self.animmul,0)
    end
end
