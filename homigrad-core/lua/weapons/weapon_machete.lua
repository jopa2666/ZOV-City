SWEP.Base = "weapon_melee"
SWEP.Category = "Ближний Бой"
SWEP.PrintName = "Мачете"
SWEP.Author = "Homigrad"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_hatchet.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_machete.mdl"

SWEP.HoldAng = Angle(0,0,-170)
SWEP.HoldPos = Vector(3.6,0,-11)

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
SWEP.AttackWait = 0.3
SWEP.AttackDist = 70
SWEP.AttackDamage = 40
SWEP.AttackType = DMG_SLASH
SWEP.NoLHand = true

SWEP.SecondaryAttackTime = 0.4
SWEP.SecondaryAttackAng = Angle(0, 0, 90)
SWEP.SecondaryAttackWait = 0.25
SWEP.SecondaryAttackDist = 60
SWEP.SecondaryAttackDamage = 35
SWEP.SecondaryAttackType = DMG_SLASH
SWEP.SecondaryAttackHit = "weapons/melee/flesh_impact_sharp_02.wav"
SWEP.SecondaryAttackHitFlesh =  {"weapons/melee/flesh_impact_sharp_02.wav","weapons/melee/flesh_impact_sharp_05.wav","weapons/melee/flesh_impact_sharp_03.wav","weapons/melee/flesh_impact_sharp_04.wav"}

SWEP.AttackHitFlesh = {"weapons/melee/flesh_impact_sharp_02.wav","weapons/melee/flesh_impact_sharp_05.wav","weapons/melee/flesh_impact_sharp_03.wav","weapons/melee/flesh_impact_sharp_04.wav"}
SWEP.AttackHit = {"weapons/melee/metal_solid_impact_bullet1.wav","weapons/melee/metal_solid_impact_bullet3.wav"}
SWEP.DeploySnd = "weapons/melee/melee_holster_temp2.wav"

SWEP.IconAng = Angle(0,0,90)
SWEP.IconPos = Vector(110,2.1,3)

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
    ["attack2"] = {
        Source = "Attack_Quick2",
        MinProgress = 0.5,
        Time = 1.5
    },
}

function SWEP:SecondaryAttack()
    if !self:CanPrimaryAttack() then return end
    
    self.Hit = false
    self.IsSecondaryAttack = true
    
    if SERVER then
        self:SetNextPrimaryFire(CurTime() + self.AnimWait)
        timer.Simple(self.SecondaryAttackWait, function()
            if !IsValid(self:GetOwner()) then return end
            self:SetAttackTime(CurTime() + self.SecondaryAttackTime)
            sound.Play("weapons/melee/swing_heavy_sharp_0"..math.random(1,3)..".wav",
                      hg.GetCurrentCharacter(self:GetOwner()):GetPos(),
                      75, math.random(95,105))
        end)
    end
    hg.PlayAnim(self, "attack2")
    end
    
    function SWEP:Step()
    local ply = self:GetOwner()
    if not IsValid(ply) then return end
    
    if ply:GetActiveWeapon() != self then
        if IsValid(self.fakeWorldModel) then
            self.fakeWorldModel:Remove()
        end
        return
    end
    
    if SERVER then
        self:SetHoldType(self.HoldType)
        self:SetAttack(self:GetAttackTime() > CurTime())
    end
    
    local isAttacking = self:GetAttack()
    if not isAttacking then
        self.Hit = false
        return
    end
    
    if self.Hit then return end
    
    local progress = -((self:GetAttackTime() - CurTime()) / (self.AttackTime * 0.5) - 1)
    local progress_fix = 1 - (self:GetAttackTime() - CurTime()) / self.AttackTime
    
    local attackAng = self.IsSecondaryAttack and self.SecondaryAttackAng or self.AttackAng
    local attackDist = self.IsSecondaryAttack and self.SecondaryAttackDist or self.AttackDist
    local attackType = self.IsSecondaryAttack and self.SecondaryAttackType or self.AttackType
    local attackHitSound = self.IsSecondaryAttack and self.SecondaryAttackHit or self.AttackHit
    local attackHitFleshSound = self.IsSecondaryAttack and self.SecondaryAttackHitFlesh or self.AttackHitFlesh
    
    local ang_attack = Angle(
        attackAng[1] * progress,
        attackAng[2] * progress,
        attackAng[3] * progress
    )
    
    local ang = ply:EyeAngles()
    local fixed = Angle()
    fixed:Set(ang:Forward():Angle())
    fixed:RotateAroundAxis(ang:Forward(), ang_attack.p)
    fixed:RotateAroundAxis(ang:Right(), ang_attack.y)
    fixed:RotateAroundAxis(ang:Up(), ang_attack.r)
    
    local eye_tr = hg.eyeTrace(ply, attackDist * 2)
    
    local tr = util.TraceLine({
        start = eye_tr.StartPos,
        endpos = eye_tr.StartPos + fixed:Forward() * (attackDist * 1.25) * progress_fix,
        filter = hg.GetCurrentCharacter(ply),
        mask = MASK_SHOT_HULL
    })
    
    local ent = tr.Entity
    
    if not tr.Hit then return end
    
    self.Hit = true
    self:SetAttack(false)
    self:SetAttackTime(0)
    
    local isFlesh = ent:IsPlayer() or ent:IsNPC() or ent:IsRagdoll() or (
        IsValid(ent:GetPhysicsObject()) and (
            string.find(ent:GetPhysicsObject():GetMaterial(), "flesh") or
            string.find(ent:GetPhysicsObject():GetMaterial(), "player")
        )
    )
    
    local ent_ply = hg.GetCurrentCharacter(ply)
    
    local dmgTab = DamageInfo()
    dmgTab:SetAttacker(ply)
    dmgTab:SetDamage(self.IsSecondaryAttack and self.SecondaryAttackDamage or self.AttackDamage)
    dmgTab:SetDamageType(attackType)
    dmgTab:SetInflictor(self)
    dmgTab:SetDamagePosition(tr.HitPos)
    dmgTab:SetDamageForce(fixed:Forward() * 150)
    
    if IsValid(ent) and ent.TakeDamageInfo then
        ent:TakeDamageInfo(dmgTab)
    end
    
    if SERVER then
        if isFlesh then
            local snd = istable(attackHitFleshSound) and attackHitFleshSound[math.random(#attackHitFleshSound)] or attackHitFleshSound
            sound.Play(snd, ent_ply:GetPos(), 75, 100, 1)
            util.Decal("blood", tr.HitPos + tr.HitNormal * 15, tr.HitPos - tr.HitNormal * 15, ply)
        else
            local snd = istable(attackHitSound) and attackHitSound[math.random(#attackHitSound)] or attackHitSound
            sound.Play(snd, ent_ply:GetPos(), 75, 100, 1)
        end
    end
end