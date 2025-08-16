SWEP.Base = "weapon_base"
SWEP.PrintName = "База TPIK Гранат"
SWEP.Category = "Гранаты"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.DrawAmmo = false
SWEP.SupportTPIK = true

function SWEP:Initialize()
    if hg and hg.Weapons then
        hg.Weapons[self] = true
    end
    self.worldModel = "models/pwb/weapons/w_rgd5.mdl"
    
    -- Добавляем сетевые переменные для синхронизации
    if SERVER then
        self:SetNWBool("IsGrenade", true)
        self:SetNWBool("IsThrowing", false)
    end
end

function SWEP:Deploy()
    self:SetHoldType("grenade")
    if hg and hg.PlayAnim then
        hg.PlayAnim(self, "draw")
    end
    
    -- Синхронизируем с клиентом, что граната в руках
    if SERVER then
        self:SetNWBool("IsGrenade", true)
        self:SetNWBool("IsThrowing", false)
    end
    
    return true
end

function SWEP:Holster()
    self:SafeRemoveWorldModel()
    if SERVER then
        self:SetNWBool("IsGrenade", false)
    end
    return true
end

function SWEP:OnRemove()
    self:SafeRemoveWorldModel()
    if SERVER then
        self:SetNWBool("IsGrenade", false)
    end
end

function SWEP:OwnerChanged()
    self:SafeRemoveWorldModel()
    if SERVER then
        self:SetNWBool("IsGrenade", false)
    end
end

function SWEP:ThrowGrenade()
    if not IsValid(self) or not IsValid(self:GetOwner()) then return end
    
    local grenade = ents.Create("ent_grenade")
    if IsValid(grenade) then
        local owner = self:GetOwner()
        local eyeAng = owner:EyeAngles()
        local pos = owner:GetShootPos() + eyeAng:Forward() * 25 + eyeAng:Right() * 10 - eyeAng:Up() * 5
        
        grenade:SetPos(pos)
        grenade:SetAngles(eyeAng)
        grenade:SetOwner(owner)
        grenade:Spawn()
        grenade:Activate()
        
        local phys = grenade:GetPhysicsObject()
        if IsValid(phys) then
            phys:SetVelocity(eyeAng:Forward() * 1000 + owner:GetVelocity())
        end
        
        timer.Simple(0, function()
            if IsValid(self) then
                self:SafeRemoveWorldModel()
                if SERVER then
                    self:SetNWBool("IsGrenade", false)
                end
            end
        end)
    end
end

function SWEP:PrimaryAttack()
    if not IsValid(self:GetOwner()) or self:GetOwner():GetAmmoCount(self.Primary.Ammo) <= 0 then return end
    
    self:SetNextPrimaryFire(CurTime() + 0.55)
    
    local owner = self:GetOwner()
    if SERVER then
        self:SetNWBool("IsThrowing", true)
    end
    
    if owner.Fake then
        timer.Simple(0.5, function()
            if IsValid(self) and IsValid(self:GetOwner()) then
                self:ThrowGrenade()
                if SERVER then
                    self:SetNWBool("IsThrowing", false)
                    self:SetNWBool("IsGrenade", false)
                end
            end
        end)
        return
    end
    
    timer.Simple(0.3, function()
        if IsValid(self) and IsValid(self:GetOwner()) then
            self:ThrowGrenade()
            if SERVER then
                self:SetNWBool("IsThrowing", false)
                self:SetNWBool("IsGrenade", false)
            end
        end
    end)
end