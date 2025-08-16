SWEP.Base = "homigrad_base"
SWEP.PrintName = "Магнум"
SWEP.Category = "ХЛ2 Оружие: Пистолеты"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/tfa_mmod/w_357.mdl"
SWEP.WorldModelReal = "models/weapons/tfa_mmod/c_357.mdl"
SWEP.ViewModel = "models/weapons/tfa_mmod/c_357.mdl"

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.HoldType = "revolver"

SWEP.holdtypes = {
    ["revolver"] = {[1] = 0.45,[2] = 0.7,[3] = 0.95,[4] = 1.2},
    ["revolver_empty"] = {[1] = 0.25,[2] = 0.8,[3] = 1,[4] = 1.7},
}

SWEP.Primary.ReloadTime = 1.9
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Damage = 75
SWEP.Primary.Force = 12
SWEP.Primary.Ammo = ".44 Magnum"
SWEP.Primary.Wait = 0.35
SWEP.Sound = "weapon/357/357_fire_player_01.wav"
SWEP.RecoilForce = 5
SWEP.Empty3 = false

SWEP.WorldPos = Vector(-6,-1,1)
SWEP.WorldAng = Angle(0.1,0,-1)
SWEP.AttPos = Vector(24,2.05,-1.25)
SWEP.AttAng = Angle(0.5,0,0)
SWEP.HolsterAng = Angle(0,-90,0)
SWEP.HolsterPos = Vector(-21,3.5,5)
SWEP.HolsterBone = "ValveBiped.Bip01_Pelvis"

SWEP.IsRevolver = true

SWEP.BoltBone = "hammer" -- давайте сюда свои сливыыы
SWEP.BoltVec = Vector(0,0,0)

SWEP.ZoomPos = Vector(10,-3.2,-1)
SWEP.ZoomAng = Angle(0,1.5,0)

SWEP.Rarity = 4

SWEP.IconPos = Vector(65,-28,-8)
SWEP.IconAng = Angle(0,90,0)

SWEP.Animations = {
	["idle"] = {
        Source = "idle01",
    },
	["draw"] = {
        Source = "draw",
        MinProgress = 0.5,
        Time = 1
    },
    ["reload"] = {
        Source = "reload",
        MinProgress = 1,
        Time = 2
    },
}

SWEP.TwoHands = false