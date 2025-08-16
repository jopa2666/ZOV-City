SWEP.Base = "weapon_melee"
SWEP.Category = "Ближний Бой"
SWEP.Author = "Homigrad"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_hatchet.mdl"
SWEP.WorldModel = "models/props_junk/garbage_glassbottle003a.mdl"

SWEP.HoldAng = Angle(0,0,0)
SWEP.HoldPos = Vector(3,0.6,-5)

SWEP.AnimAng = Angle(0,0,0)
SWEP.AnimPos = Vector(-10,0,5)

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
SWEP.AttackAng = Angle(0,-40,0)
SWEP.AttackWait = 0.25
SWEP.AttackDist = 45
SWEP.AttackDamage = 30
SWEP.AttackType = DMG_SLASH
SWEP.NoLHand = true

SWEP.HoldType = "melee"

SWEP.AttackHitFlesh = "physics/glass/glass_bottle_break1.wav"
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

function SWEP:CreateBottle(pos)
        local bottle = ents.Create("prop_physics")
        bottle:SetPos(pos)
        bottle:SetAngles(AngleRand(-90, 90))
        bottle:SetModel("models/props_junk/glassbottle01a_chunk02a.mdl")
        bottle:Spawn()
        bottle:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        local phys = bottle:GetPhysicsObject()
        if IsValid(phys) then
            phys:AddVelocity(VectorRand(-90, 90))
            phys:Wake()
        end
        SafeRemoveEntityDelayed(bottle, 15)
    end
    
function SWEP:PrimaryAttackAdd(ent,trace)
    if ent and math.random(1, 2) == 2 then
        self:CreateBottle(trace.HitPos)
    
        local owner = self:GetOwner()
        owner:Give("weapon_brockenbottle")
        owner:SelectWeapon("weapon_brockenbottle")
        self:Remove()
    end
end