SWEP.Base = "homigrad_base"
SWEP.PrintName = "HK MP5"
SWEP.Category = "ХЛ2 Оружие: ПП"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/mp5k/w_mp5k.mdl"
SWEP.WorldModelReal = "models/weapons/mp5k/c_mp5k.mdl"
SWEP.ViewModel = "models/weapons/mp5k/c_mp5k.mdl"

SWEP.HoldType = "smg"

SWEP.holdtypes = {
    ["smg"] = {[1] = 0.35,[2] = 1,[3] = 1.3,[4] = 0},
}

SWEP.Primary.ReloadTime = 3
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Damage = 35
SWEP.Primary.Force = 1
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Wait = 0.09
SWEP.Sound = "weapon/smg1/smg1_fire_player_01.wav"
SWEP.RecoilForce = 3.5
SWEP.Empty3 = false

SWEP.WorldPos = Vector(-5,-1.5,0)
SWEP.WorldAng = Angle(1,-2,-1)
SWEP.AttPos = Vector(37,4.3,-4.8)
SWEP.AttAng = Angle(0,0.5,0)
SWEP.HolsterAng = Angle(0,-20,0)
SWEP.HolsterPos = Vector(-28,1,5.5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine4"

SWEP.BoltBone = "negr" -- не нужная хуйня
SWEP.BoltVec = Vector(0,0,-3)

SWEP.ZoomPos = Vector(8,-4.46,-1.4)
SWEP.ZoomAng = Angle(-0.5,0.4,0)

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.Rarity = 4

SWEP.TwoHands = true

SWEP.IconPos = Vector(80,-17,-1)
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
        Source = "reload",
        MinProgress = 0.5,
        Time = 3
    }
}