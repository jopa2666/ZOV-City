SWEP.Base = "weapon_melee"
SWEP.Category = "ХЛ2 Ближний Бой"
SWEP.Author = "Homigrad"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_hatchet.mdl"
SWEP.WorldModel = "models/weapons/iceaxe/w_iceaxe.mdl"

SWEP.HoldAng = Angle(90,90,0)
SWEP.HoldPos = Vector(5.85,1.5,-13)

SWEP.AnimAng = Angle(-10,0,0)
SWEP.AnimPos = Vector(-12,0,-5)

SWEP.ModelScale = 1

SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.Rarity = 4
SWEP.HoldType = "melee"
SWEP.AnimWait = 1.25
SWEP.AttackTime = 0.2
SWEP.AttackAng = Angle(0,-20,0)
SWEP.AttackWait = 0.4
SWEP.AttackDist = 75
SWEP.AttackDamage = 30
SWEP.AttackType = DMG_SLASH
SWEP.NoLHand = true

SWEP.IconAng = Angle(90,0,-90)
SWEP.IconPos = Vector(65,0,1.25)

SWEP.AttackHitFlesh = {"weapons/melee/flesh_impact_sharp_02.wav","weapons/melee/flesh_impact_sharp_05.wav","weapons/melee/flesh_impact_sharp_03.wav","weapons/melee/flesh_impact_sharp_04.wav"}
SWEP.AttackHit = {"weapons/melee/metal_solid_impact_bullet1.wav","weapons/melee/metal_solid_impact_bullet3.wav"}
SWEP.DeploySnd = "weapons/melee/melee_holster_temp2.wav"

SWEP.Animations = {
	["idle"] = {
        Source = "Idle",
    },
	["draw"] = {
        Source = "Draw",
        MinProgress = 0.5,
        Time = 0.5
    },
    ["attack"] = {
        Source = "Attack_Quick",
        MinProgress = 0.5,
        Time = 1.5
    },
}