SWEP.Base = "weapon_melee"
SWEP.Category = "Ближний Бой"
SWEP.Author = "Homigrad"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_cleaver.mdl"
SWEP.WorldModel = "models/props_junk/garbage_glassbottle003a_chunk01.mdl"

SWEP.HoldAng = Angle(0,0,0)
SWEP.HoldPos = Vector(3,0.6,-5)

SWEP.AnimAng = Angle(0,0,-2)
SWEP.AnimPos = Vector(-10,0,2)

SWEP.IconAng = Angle(90,0,180)
SWEP.IconPos = Vector(110,0,0)

SWEP.ModelScale = 1

SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.Rarity = 4

SWEP.AnimWait = 2
SWEP.AttackTime = 0.3
SWEP.AttackAng = Angle(0,0,30)
SWEP.AttackWait = 0.25
SWEP.AttackDist = 40
SWEP.AttackDamage = 35
SWEP.AttackType = DMG_SLASH
SWEP.NoLHand = true

SWEP.HoldType = "melee"

SWEP.AttackHitFlesh = "models/weapons/tfa_nmrih/v_me_cleaver.mdl"
SWEP.AttackHit = "physics/glass/glass_bottle_break1.wav"
SWEP.DeploySnd = "physics/metal/weapon_impact_soft1.wav"

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