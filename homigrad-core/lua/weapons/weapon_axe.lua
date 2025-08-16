SWEP.Base = "weapon_melee"
SWEP.Category = "Ближний Бой" // HERE IS JOHNY
SWEP.Author = "Homigrad"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_bat_metal.mdl"
SWEP.WorldModel = "models/props/CS_militia/axe.mdl"

SWEP.HoldAng = Angle(3,-20,-94)
SWEP.HoldPos = Vector(4.25,0.6,8)

SWEP.AnimAng = Angle(0,0,-40)
SWEP.AnimPos = Vector(-8,0,0)

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
SWEP.AttackTime = 0.4
SWEP.AttackAng = Angle(0,-30,30)
SWEP.AttackWait = 0.25
SWEP.AttackDist = 95
SWEP.AttackDamage = 75
SWEP.AttackType = DMG_SLASH
SWEP.NoLHand = false
SWEP.LHand = true

SWEP.SecondaryAttackTime = 0.4
SWEP.SecondaryAttackAng = Angle(0, 0, 0)
SWEP.SecondaryAttackWait = 0.3
SWEP.SecondaryAttackDist = 45
SWEP.SecondaryAttackDamage = 25
SWEP.SecondaryAttackType = DMG_CLUB
SWEP.SecondaryAttackHit = "physics/body/body_medium_impact_hard1.wav"
SWEP.SecondaryAttackHitFlesh = "physics/body/body_medium_impact_hard5.wav"

SWEP.HoldType = "melee"

SWEP.AttackHitFlesh = "snd_jack_hmcd_axehit.wav"
SWEP.AttackHit = "weapons/melee/rifle_swing_hit_world.wav"
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
    ["shove"] = {
        Source = "shove",
        MinProgress = 0.5,
        Time = 1.2
    }
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
    hg.PlayAnim(self, "shove")
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

    debugoverlay.Line(
        tr.StartPos, tr.HitPos, 2,
        (IsValid(ent) and (ent:IsPlayer() or ent:IsRagdoll() or ent:IsNPC())) and Color(0, 255, 0) or Color(255, 38, 0),
        false
    )

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