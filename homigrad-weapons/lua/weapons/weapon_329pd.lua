SWEP.Base = "homigrad_base"
SWEP.PrintName = "SW 329PD"
SWEP.Category = "Оружие: Пистолеты"
SWEP.Spawnable = true

SWEP.WorldModel = "models/weapons/arccw/c_ur_329pd.mdl"
SWEP.ViewModel = "models/weapons/arccw/c_ur_329pd.mdl"

SWEP.HoldType = "revolver"

SWEP.holdtypes = {
    ["revolver"] = {[1] = 0.25,[2] = 0.7,[3] = 2,[4] = 2.5},
}

SWEP.Bodygroups = {[1] = 2}

SWEP.Primary.ReloadTime = 3.5
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Damage = 105
SWEP.Primary.Force = 120
SWEP.Primary.Ammo = ".44 Magnum"
SWEP.Primary.Wait = 0.09
SWEP.Sound = "zcitysnd/sound/weapons/firearms/hndg_sw686/revolver_fire_01.wav"
SWEP.SubSound = "hmcd/hndg_sw686/revolver_fire_01.wav"
SWEP.RecoilForce = 1
SWEP.Empty3 = false
SWEP.Empty4 = false

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.IsRevolver = true

SWEP.WorldPos = Vector(2,0,0)
SWEP.WorldAng = Angle(1,0,-1)
SWEP.AttPos = Vector(24,2.77,-1.25)
SWEP.AttAng = Angle(0.4,-0.15,0)
SWEP.HolsterAng = Angle(0,-90,0)
SWEP.HolsterPos = Vector(-10,4,4)
SWEP.HolsterBone = "ValveBiped.Bip01_Pelvis"

SWEP.BoltBone = nil
SWEP.BoltVec = nil

SWEP.ZoomPos = Vector(4,-2.7,-0.65)
SWEP.ZoomAng = Angle(0,-0.1,0)

SWEP.can = false
SWEP.can1 = false

function SWEP:PostAnim()
    if IsValid(self.worldModel) and self.worldModel:LookupBone("speedreloader") then
        self.worldModel:ManipulateBoneScale(self.worldModel:LookupBone("speedreloader"),Vector(1,1,1) * (self.reload and 1 or 0))
    end

    if SERVER then
        self:SetNWBool("can",self.can)
        self:SetNWBool("can1",self.can1)
    end
end 

function SWEP:CanShoot()
    local ply = self:GetOwner()

    if !self.reload and !ply:KeyDown(IN_WALK) then
        if SERVER then
            if !self.can and self.can1 then
                self.can = true
            end
        
            if !self.can1 then
                local pos,ang = self:GetTrace()
                self.can1 = true
                self:SetNextShoot(CurTime() + 0.2)
                sound.Play("zcitysnd/sound/weapons/revolver/handling/revolver_cock_hammer_ready.wav",pos,75,100,1)
                hg.PlayAnim(self,"cock")
            end
        else
            if !self:GetNWBool("can1") and self:Clip1() > 0 then
                local pos,ang = self:GetTrace()
                hg.PlayAnim(self,"cock")
            end
        end
    elseif !self.reload and ply:KeyDown(IN_WALK) then
        if SERVER then
            if self.can and self.can1 then
                self.can = false
            end
        
            if self.can1 then
                local pos,ang = self:GetTrace()
                self.can1 = false
                self:SetNextShoot(CurTime() + 0.2)
                sound.Play("zcitysnd/sound/weapons/revolver/handling/revolver_cock_hammer.wav",pos,75,100,1)
                hg.PlayAnim(self,"decock")
            end
        else
            if self:GetNWBool("can1") and self:Clip1() > 0 then
                local pos,ang = self:GetTrace()
                hg.PlayAnim(self,"decock")
            end
        end
    end

    return (!self.reload and self:Clip1() > 0 and !self:IsSprinting() and !self:GetOwner():GetNWBool("otrub")) and !self:IsTooClose() and self.can
end

SWEP.Slot = 2
SWEP.SlotPos = 1

function SWEP:PrimaryAdd()
    self.can = false
    self.can1 = false
    hg.PlayAnim(self,"fire")
end

SWEP.Rarity = 4

SWEP.TwoHands = false

SWEP.IconPos = Vector(50,-17,1)
SWEP.IconAng = Angle(0,90,0)

SWEP.Animations = {
	["idle"] = {
        Source = "idle",
    },
	["draw"] = {
        Source = "draw",
        MinProgress = 0.5,
        Time = 0.5
    },
    ["reload"] = {
        Source = "reload",
        MinProgress = 0.5,
        Time = 3.5
    },
    ["cock"] = {
        Source = "cocking",
        MinProgress = 0.5,
        Time = 0.5
    },
    ["decock"] = {
        Source = "decocking",
        MinProgress = 0.5,
        Time = 0.5
    },
    ["fire"] = {
        Source = "fire",
        MinProgress = 0.5,
        Time = 0.5
    },
}

SWEP.Reload1 = "zcitysnd/sound/weapons/revolver/handling/revolver_open_chamber.wav"
SWEP.Reload2 = "zcitysnd/sound/weapons/revolver/handling/revolver_dump_rounds_01.wav"
SWEP.Reload3 = "zcitysnd/sound/weapons/revolver/handling/revolver_speed_loader_insert_01.wav"
SWEP.Reload4 = "zcitysnd/sound/weapons/revolver/handling/revolver_close_chamber.wav"