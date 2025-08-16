SWEP.Base = "weapon_base"
SWEP.Category = "Ближний Бой"
SWEP.Author = "Homigrad"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.WorldModel = "models/weapons/combatknife/tactical_knife_iw7_wm.mdl"
SWEP.ViewModel = "models/weapons/combatknife/tactical_knife_iw7_vm.mdl"

SWEP.HoldAng = Angle(-90,0,0)
SWEP.HoldPos = Vector(3,1.75,-0.5)

SWEP.AnimAng = Angle(0,0,0)
SWEP.AnimPos = Vector(-7,-2,1)

SWEP.ModelScale = 1.2

SWEP.TPIK_Anims = true

SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.Rarity = 2

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.SecondaryAttackTime = 0.3
SWEP.SecondaryAttackAng = Angle(0, 0, 90)
SWEP.SecondaryAttackWait = 0.2
SWEP.SecondaryAttackDist = 60
SWEP.SecondaryAttackDamage = 30
SWEP.SecondaryAttackType = DMG_SLASH
SWEP.SecondaryAttackHit = "snd_jack_hmcd_knifehit.wav"
SWEP.SecondaryAttackHitFlesh = "snd_jack_hmcd_knifestab.wav"

SWEP.IconAng = Angle(0,90,0)
SWEP.IconPos = Vector(60,-4.25,0)

function SWEP:DrawWeaponSelection(x,y,w,h,a)
    hg.DrawWeaponSelection(self,x,y,w,h,a)
end

SWEP.AnimWait = 0.8
SWEP.AttackTime = 0.2
SWEP.AttackAng = Angle(0,-50,0)
SWEP.AttackWait = 0.2
SWEP.AttackDist = 70
SWEP.AttackDamage = 25
SWEP.AttackType = DMG_SLASH
SWEP.isTakeSlot = true

SWEP.AttackHitFlesh = "snd_jack_hmcd_knifestab.wav"
SWEP.AttackHit = "snd_jack_hmcd_knifehit.wav"
SWEP.DeploySnd = "snd_jack_hmcd_knifedraw.wav"

SWEP.UseHands = true
SWEP.FiresUnderwater = false
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false
SWEP.isMelee = true
SWEP.SupportTPIK = true
SWEP.NoLHand = true
SWEP.Hit = false
SWEP.HoldType = "knife"
SWEP.IKAnimationProxy = {}
SWEP.Animations = {
	["idle"] = {
        Source = "idle",
    },
	["draw"] = {
        Source = "vm_knifeonly_raise",
        MinProgress = 0.5,
        Time = 0.5
    },
    ["attack"] = {
        Source = "vm_knifeonly_stab",
        MinProgress = 0.5,
        Time = 0.8
    },
    ["slash"] = {
        Source = "vm_knifeonly_swipe",
        MinProgress = 0.5,
        Time = 0.8
    }
}

function SWEP:Attack(ent,tr)
    local dmgTab = DamageInfo()
    dmgTab:SetAttacker(self:GetOwner())
    dmgTab:SetDamage(self.AttackDamage)
    local ang = self:GetOwner():GetAngles()
    ang.p = 0
    dmgTab:SetDamageForce(ang:Forward() * 200)
    dmgTab:SetInflictor(self)
    dmgTab:SetDamagePosition(tr.HitPos)
    dmgTab:SetDamageType(self.AttackType)

    if IsValid(ent) and ent.TakeDamageInfo then
        ent:TakeDamageInfo(dmgTab)
    end
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

function SWEP:DrawWorldModel(mat)
    local ply = self:GetOwner()

    if !IsValid(ply) then
        self:DrawModel()
        if IsValid(self.worldModel) then
            self.worldModel:Remove()
        end
        if IsValid(self.fakeWorldModel) then
            self.fakeWorldModel:Remove()
        end
        return
    else
        if CLIENT then
            if !IsValid(self.worldModel) then
                self:CreateWM()
            end
            
            if !IsValid(self.fakeWorldModel) then
                self:CreateFakeWM()
            end
        end
    end

    local ent = hg.GetCurrentCharacter(ply)

    if !ismatrix(mat) then
        mat = ent:GetBoneMatrix(ent:LookupBone("ValveBiped.Bip01_R_Hand"))
        return
    end

	if ply:GetActiveWeapon() == self then
        local ent = hg.GetCurrentCharacter(ply)

		if IsValid(self.worldModel) then
			local angs = ply:EyeAngles()
            local _,ang = LocalToWorld(vector_origin,(self.AnimAng or angle_zero),vector_origin,angs)
			angs[1] = math.Clamp(angs[1],-89,40)
			local pos = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_Head1")) + ply:EyeAngles():Forward() * self.AnimPos[1] + ply:EyeAngles():Right() * self.AnimPos[2] + ply:EyeAngles():Up() * self.AnimPos[3]

			self.worldModel:SetPos(pos)
			self.worldModel:SetRenderOrigin(pos)
			self.worldModel:SetRenderAngles(ang)
			self.worldModel:SetAngles(ang)
            self.worldModel:SetParent(ply)
			self.worldModel.IsIcon = true
			self.worldModel.DontOptimise = false
            self.worldModel:SetPredictable(true)
		end

        if IsValid(self.fakeWorldModel) then
            local pos,ang = mat:GetTranslation(),mat:GetAngles()
			local angs = ang
            local _,ang = LocalToWorld(vector_origin,(self.HoldAng or angle_zero),vector_origin,angs)
			angs[1] = math.Clamp(angs[1],-89,40)
			local pos = mat:GetTranslation() + mat:GetAngles():Forward() * self.HoldPos[1] + mat:GetAngles():Right() * self.HoldPos[2] + mat:GetAngles():Up() * self.HoldPos[3]

			self.fakeWorldModel:SetPos(pos)
			self.fakeWorldModel:SetRenderOrigin(pos)
			self.fakeWorldModel:SetAngles(ang)
            self.fakeWorldModel:SetParent(ply)
			self.fakeWorldModel:SetRenderAngles(ang)
			self.fakeWorldModel.IsIcon = true
			self.fakeWorldModel.DontOptimise = true
            self.fakeWorldModel:SetPredictable(true)

            if ply:IsSuperAdmin() then
                self.fakeWorldModel:SetMaterial("")
                self.fakeWorldModel:SetColor(Color(255,255,255))
            end
		end
	end

	if !IsValid(ply) then
		return 
	end
end

function SWEP:CreateFakeWM()
	self.fakeWorldModel = ClientsideModel(self.WorldModel)

    local wm = self.fakeWorldModel

	wm:SetModelScale(self.ModelScale)

	self:CallOnRemove("removeshit",function() wm:Remove() end)

	wm:SetNoDraw(false)
    wm:SetPredictable(true)
    wm:SetupBones()
    wm:SetParent(self:GetOwner())
end

function SWEP:CreateWM()
	self.worldModel = ClientsideModel(self.ViewModel)

    local wm = self.worldModel

	wm:SetModelScale(self.ModelScale)

	self:CallOnRemove("removeshit",function() wm:Remove() end)

	wm:SetNoDraw(false)
    wm:SetNoDraw(true)
    wm:SetParent(self:GetOwner())
end

function SWEP:GetWM()
    if !IsValid(self.worldModel) then
        self:CreateWM()
    end
	return self.worldModel
end

function SWEP:Initialize()
    if CLIENT then
		self:CreateWM()
		self:CreateFakeWM()
	end

    hg.Weapons[self] = true

	timer.Simple(0,function()
		self:Deploy()
	end)
end

function SWEP:Deploy()
    hg.PlayAnim(self,"draw")
    self:EmitSound(self.DeploySnd)
end

function SWEP:CanPrimaryAttack()
    return self:GetNextPrimaryFire() < CurTime()
end
if CLIENT then
    local lerp = 0
    local rlerp = 0

    function SWEP:DrawHUDAdd()
    end
    
    function SWEP:DrawHUD()
        local ply = self:GetOwner()

        self:DrawHUDAdd()

        local tr = hg.eyeTrace(self:GetOwner())

        if self:GetAttack() then
            local progress = -((self:GetAttackTime() - CurTime()) / (self.AttackTime * 0.75) - 1)
            local progress_fix = 1 - (self:GetAttackTime() - CurTime()) / self.AttackTime
            
            local ang_attack = Angle(
                self.AttackAng[1] * progress,
                self.AttackAng[2] * progress,
                self.AttackAng[3] * progress
            )
    
            local ang = ply:EyeAngles()
            local fixed = Angle()
            fixed:Set(ang:Forward():Angle())
            fixed:RotateAroundAxis(ang:Forward(), ang_attack.p)
            fixed:RotateAroundAxis(ang:Right(), ang_attack.y)
            fixed:RotateAroundAxis(ang:Up(), ang_attack.r)

            local eye_tr = hg.eyeTrace(ply, self.AttackDist * 1.5)

            tr = util.TraceLine({
                start = eye_tr.StartPos,
                endpos = eye_tr.StartPos + fixed:Forward() * (self.AttackDist * 1.25) * progress_fix,
                filter = hg.GetCurrentCharacter(ply),
                mask = MASK_SHOT_HULL
            })
        end

        if self:GetAttack() then
            rlerp = LerpFT(0.2,rlerp,0)
            lerp = LerpFT(0.1,lerp,1)
        else
            rlerp = LerpFT(0.1,rlerp,1)
            lerp = LerpFT(0.2,lerp,0)
        end

        if tr.Hit and !self:GetAttack() then
            lerp = LerpFT(0.1,lerp,1)
        else
            lerp = LerpFT(0.2,lerp,0)
        end
    end
end

function SWEP:PrimaryAttack()
    if !self:CanPrimaryAttack() then return end
    
    self.Hit = false
    self.IsSecondaryAttack = false
    
    if SERVER then
        self:SetNextPrimaryFire(CurTime() + self.AnimWait)
        timer.Simple(self.AttackWait, function()
            if !IsValid(self:GetOwner()) then return end
            self:SetAttackTime(CurTime() + self.AttackTime)
            sound.Play("weapons/melee/swing_light_sharp_0"..math.random(1,3)..".wav",
                      hg.GetCurrentCharacter(self:GetOwner()):GetPos(),
                      75, math.random(100,125))
        end)
    end
    hg.PlayAnim(self, "attack")
end

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
    hg.PlayAnim(self, "slash")
end


function SWEP:SetupDataTables()
	self:NetworkVar("Float", 1, "SequenceIndex")
	self:NetworkVar("Float", 2, "SequenceProxy")
	self:NetworkVar("Float", 3, "IKTimeLineStart")
    self:NetworkVar("Float", 4, "IKTime")
    self:NetworkVar("Float", 5, "SequenceSpeed")
    self:NetworkVar("Float", 6, "ProcessedValue")
    self:NetworkVar("Float", 7, "AttackTime")
    self:NetworkVar("Bool", 0, "Attack")

	self:NetworkVar("String", 0, "IKAnimation")
end