do return end
SWEP.Base = "homigrad_base"
SWEP.PrintName = "AT4"
SWEP.Category = "Оружие: Гранатомёты"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/w_jmod_at4.mdl"
SWEP.WorldModelReal = "models/weapons/v_mw2_at4_new.mdl"
SWEP.ViewModel = "models/weapons/v_mw2_at4_new.mdl"

SWEP.HoldType = "ar2"

SWEP.PistolRun = true

SWEP.holdtypes = {
    ["ar2"] = {[1] = 0.8,[2] = 1.25,[3] = 1.4,[4] = 0},
}

SWEP.Primary.ReloadTime = 999999 -- это однозарядный гранатомёт нахуй ему перезарядка?
SWEP.Primary.MagTime = 2.2
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Damage = 0
SWEP.Primary.Force = 230
SWEP.Primary.Ammo = "RPG-7 Projectile"
SWEP.Primary.Wait = 0.1
SWEP.Sound = "zcitysnd/sound/weapons/rpg7/rpg7_fp.wav"

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.RecoilForce = 2

SWEP.WorldPos = Vector(3,-1,2)
SWEP.WorldAng = Angle(10,-15,10)
SWEP.AttPos = Vector(30,5.15,-2.5)
SWEP.AttAng = Angle(0.2,15,1)
SWEP.HolsterAng = Angle(0,-90,0)
SWEP.HolsterPos = Vector(-16,4,2)

SWEP.BoltBone = "Weapon_Mag_Real"
SWEP.BoltVec = Vector(1 ,1,1)

SWEP.IconPos = Vector(160,-8,-3.5)
SWEP.IconAng = Angle(0,90,0)

SWEP.Rarity = 6

SWEP.TwoHands = true
SWEP.CanSuicide = false

SWEP.ZoomPos = Vector(2,-2.45,0.65)
SWEP.ZoomAng = Angle(-10,8,25)

function SWEP:PostAnim()
    if SERVER then
        self:SetNWBool("IsEmpty",self:Clip1() == 0)
    end
    if self.BoltBone and self.BoltVec and IsValid(self.worldModel) and self:GetWM():LookupBone(self.BoltBone) then
        self.worldModel:ManipulateBoneScale(self.worldModel:LookupBone(self.BoltBone),Vector(1,1,1) * (self:GetNWBool("IsEmpty") and 0 or 1))
    end
end

function SWEP:Shoot()
    if self:GetNextShoot() > CurTime() then
        return
    end

    if self:GetOwner():GetNWBool("otrub") then
        return
    end

    self:PrimaryAdd()

    self:PrimarySpread()

    local primary = self.Primary

    if self:IsLocal() then
        vis_recoil = vis_recoil + primary.Force / 15 * self.RecoilForce
        Recoil = Recoil + 0.25
    end

    local ply = self:GetOwner()

    local ent = hg.GetCurrentCharacter(ply)

    self:SetNextShoot(CurTime() + primary.Wait)

    local Pos,Ang = self:GetTrace()

    if self.Animations["fire"] then
        hg.PlayAnim(self,"fire")
    end

    if SERVER then
        net.Start("hg shoot")
        net.WriteEntity(self)
        net.SendPVS(Pos)

        local proj = ents.Create("ent_rpg7_projectile")
        proj:SetPos(Pos)
        proj:SetAngles(Ang)
        proj:Spawn()
        proj:Launch(Ang:Forward() * 1e8)
        proj:SetOwner(ply)
    end

    if SERVER then
        //print(ent:GetPhysicsObject())
        if IsValid(ent:GetPhysicsObject()) and !ent:IsPlayer() then
            ent:GetPhysicsObject():ApplyForceCenter(-Ang:Forward() * 50)
            ent:GetPhysicsObject():SetVelocity(-Ang:Forward() * 450)
        else
            ent:SetVelocity(-Ang:Forward() * 250)
        end
    end

    if SERVER then
        sound.Play(istable(self.Sound) and self.Sound[math.random(1,#self.Sound)] or self.Sound,Pos,100,math.random(90,110),1)
        sound.Play("pwb/weapons/remington_870/shoot.wav",Pos,100,math.random(90,110),1)
        sound.Play("pwb/weapons/spas_12/shoot.wav",Pos,100,math.random(90,110),1)
    end

    if CLIENT then
        debugoverlay.Line(Pos,Pos + Ang:Forward() * 10000,2,Color(255,255,0))
    end

    local Num = self.NumBullet or 1

    local index = ply:LookupBone("ValveBiped.Bip01_Head1")

    if !IsValid(ent) then
        return  
    end

    if SERVER then
        self:TakePrimaryAmmo(1)
    end

    self:PostShoot(Pos,Ang)
end

SWEP.Animations = {
	["idle"] = {
        Source = "idle",
    },
	["draw"] = {
        Source = "draw1",
        MinProgress = 0.5,
        Time = 1.85
    },
    ["reload"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 3
    }
}

SWEP.Reload1 = "weapons/universal/uni_weapon_draw_01.wav"
SWEP.Reload2 = "zcitysnd/sound/weapons/rpg7/handling/rpg7_load2.wav"
SWEP.Reload3 = "weapons/tfa_inss/asval/bash1.wav"
SWEP.Reload4 = false