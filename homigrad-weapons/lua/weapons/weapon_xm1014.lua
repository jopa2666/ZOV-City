SWEP.Base = "homigrad_base"
SWEP.PrintName = "XM-1014"
SWEP.Category = "Оружие: Дробовики"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/arccw/c_ud_m1014.mdl"
SWEP.ViewModel = "models/weapons/arccw/c_ud_m1014.mdl"

SWEP.HoldType = "ar2"

SWEP.Primary.ReloadTime = 1.7
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Damage = 24
SWEP.Primary.Force = 15
SWEP.NumBullet = 8
SWEP.Primary.Ammo = "12/70 gauge"
SWEP.Sound = "zcitysnd/sound/weapons/firearms/shtg_mossberg500/m500_fire_01.wav"
SWEP.InsertSound = "pwb2/weapons/m4super90/shell.wav"
SWEP.Primary.ReloadTime = 0.25
SWEP.Primary.Wait = 0.15

SWEP.IsShotgun = true

SWEP.WorldPos = Vector(-1,-0.5,1)
SWEP.WorldAng = Angle(1,0,0)
SWEP.AttPos = Vector(37,2.76,-2.2)
SWEP.AttAng = Angle(0.2,-0.1,0)
SWEP.HolsterAng = Angle(0,-20,0)
SWEP.HolsterPos = Vector(-25,3,5)
SWEP.HolsterBone = "ValveBiped.Bip01_Spine4"

SWEP.BoltBone = "1014_bolt"
SWEP.BoltVec = Vector(0,0,-2)

SWEP.IconPos = Vector(130,-17,-0)
SWEP.IconAng = Angle(0,90,0)

SWEP.TwoHands = true

SWEP.AttBone = "1014_parent"

SWEP.MountType = "picatinny"

SWEP.AvaibleAtt = {
    ["sight"] = true,
    ["barrel"] = false,
    ["grip"] = false
}

SWEP.AttachmentPos = {
    ['sight'] = Vector(2,0,1.55),
}
SWEP.AttachmentAng = {
    ['sight'] = Angle(-90,0,-90),
}

SWEP.ZoomPos = Vector(6,-2.73,-1)
SWEP.ZoomAng = Angle(-0.3,0,0)

SWEP.RecoilForce = 3

SWEP.Animations = {
    ["pump"] = {
        Source = "cycle",
        Time = 0.3
    },
    ["draw"] = {
        Source = "draw",
        Time = 1
    },
    ["idle"] = {
        Source = "idle",
        Time = 1
    },
    ["insert"] = {
        Source = "sgreload_insert",
        Time = 1
    },
    ["insert_start"] = {
        Source = "sgreload_start",
        Time = 1.5
    },
    ["insert_start_empty"] = {
        Source = "sgreload_start_empty",
        Time = 1.2
    },
    ["insert_end"] = {
        Source = "sgreload_finish",
        Time = 1.2
    },
}

SWEP.Reload1 = false
SWEP.Reload2 = false
SWEP.Reload3 = false
SWEP.Reload4 = false

SWEP.Slot = 2
SWEP.SlotPos = 0

function SWEP:ReloadFunc()
    self.AmmoChek = 5
    if self.reload then
        self.NextShoot = CurTime() + 1
        return
    end
    local ply = self:GetOwner()
    if ply:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0 then
        return
    end
    if self:Clip1() >= self.Primary.ClipSize or self:Clip1() >= self:GetMaxClip1() then
        return
    end

    self.reload = CurTime() + self.Primary.ReloadTime

    self.NextShoot = CurTime() + 1
    
    if SERVER then
        net.Start("hg reload")
        net.WriteEntity(self)
        net.Broadcast()
    end

    local isempty = self:Clip1() == 0

    if !self.isup then
        if self:Clip1() == 0 then
            hg.PlayAnim(self,"insert_start_empty")
            if SERVER then
                    self:SetClip1(math.Clamp(self:Clip1()+1,0,self:GetMaxClip1()))
                    ply:SetAmmo(ply:GetAmmoCount( self:GetPrimaryAmmoType() )-1, self:GetPrimaryAmmoType())

                    timer.Simple(self.Primary.ReloadTime * 2.5,function()
                        if SERVER then
                            local pos,ang = self:WorldModel_Transform()
                            sound.Play(self.InsertSound,pos,95,math.random(95,105),0.75)
                        end
                        timer.Simple(0.1,function()
                            local pos,ang = self:WorldModel_Transform()
                            sound.Play("weapons/arccw_ur/spas12/forearm_forward.ogg",pos,95,math.random(95,105),0.75)
                        end)
                    end)
            end
        else
            hg.PlayAnim(self,"insert_start")
        end
        self.isup = true
    end

    //ply:SetAnimation(PLAYER_RELOAD)

    if not IsValid(self) or not IsValid(self:GetOwner()) then return end
        local wep = self:GetOwner():GetActiveWeapon()
        if IsValid(self) and IsValid(ply) and (IsValid(wep) and wep or self:GetOwner().ActiveWeapon) == self then
            self.AmmoChek = 5
            self:SetHoldType(self.HoldType)
            timer.Simple(self.Primary.ReloadTime + (isempty and 1 or 0),function()
                local pos,ang = self:WorldModel_Transform()
                if ply:GetAmmoCount( self:GetPrimaryAmmoType() ) > 0 then
                    hg.PlayAnim(self,"insert")
                    self:SetClip1(math.Clamp(self:Clip1()+1,0,self:GetMaxClip1()))
                    ply:SetAmmo(ply:GetAmmoCount( self:GetPrimaryAmmoType() )-1, self:GetPrimaryAmmoType())

                    if SERVER then
                        sound.Play(self.InsertSound,pos,95,math.random(95,105),0.75)
                    end
                end

                timer.Simple(0.9,function()
                    if !ply:KeyDown(IN_RELOAD) or self:Clip1() == self:GetMaxClip1() or ply:GetAmmoCount( self:GetPrimaryAmmoType() ) == 0 then
                        hg.PlayAnim(self,"insert_end")
                        self.isup = false
                    end

                    self.reload = nil
                end)

                if ply:GetAmmoCount( self:GetPrimaryAmmoType()) != 0 and self:Clip1() != self:GetMaxClip1() then                    
                    //ply:AnimResetGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD)

                    //ply:SetAnimation(PLAYER_IDLE)
                end
            end)
        end
end