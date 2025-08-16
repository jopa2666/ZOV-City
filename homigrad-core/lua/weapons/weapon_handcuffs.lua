SWEP.PrintName = "Стяжки" 
//SWEP.Instructions = "Связать человека"
SWEP.Category = "Остальное"

SWEP.Slot = 5
SWEP.SlotPos = 3
SWEP.Spawnable = true

SWEP.WorldModel = "models/freeman/flexcuffs.mdl"

SWEP.WorldPos = Vector(0.5,-0,0.5)
SWEP.WorldAng = Angle(0,0,-90)

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1

SWEP.Bodygroups = {[1]=1}
SWEP.DrawAmmo = false
SWEP.EnableTransformModel = true

SWEP.Rarity = 1

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

SWEP.IconPos = Vector(40,0,-1)
SWEP.IconAng = Angle(0,0,180)

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
    hg.DrawWeaponSelection(self,x,y,wide,tall,alpha)
end

function SWEP:IsCuff()
    local ply = self:GetOwner()

    if SERVER then
        self:SetNWBool("IsSelfCuff",ply:KeyDown(IN_ATTACK))
        return ply:KeyDown(IN_ATTACK)
    else
        return self:GetNWBool("IsSelfCuff")
    end
end

function SWEP:IsSelfCuff()
    local ply = self:GetOwner()

    if SERVER then
        self:SetNWBool("IsCuff",ply:KeyDown(IN_ATTACK2))
        return ply:KeyDown(IN_ATTACK2)
    else
        return self:GetNWBool("IsCuff")
    end
end

function SWEP:Step()
    local ply = self:GetOwner()

    if !IsValid(ply) then
        return
    end

    if ply:GetActiveWeapon() != self then
        return
    end
 
	if self:IsCuff() then
        hg.bone.Set(ply,"r_upperarm",Vector(0,0,0),Angle(0,-40,0),1,0.075)
        hg.bone.Set(ply,"r_forearm",Vector(0,0,0),Angle(10,25,0),1,0.125)
        hg.bone.Set(ply,"r_hand",Vector(0,0,0),Angle(0,0,-70),1,0.075)   
    elseif self:IsSelfCuff() then
        hg.bone.Set(ply,"r_upperarm",Vector(0,0,0),Angle(0,-40,0),1,0.075)
        hg.bone.Set(ply,"r_forearm",Vector(0,0,0),Angle(0,25,0),1,0.125)
        hg.bone.Set(ply,"r_hand",Vector(0,0,0),Angle(20,0,-50),1,0.075)      

        hg.bone.Set(ply,"l_upperarm",Vector(0,0,0),Angle(10,-50,0),1,0.075)
        hg.bone.Set(ply,"l_forearm",Vector(0,0,0),Angle(10,0,0),1,0.125)
        hg.bone.Set(ply,"l_hand",Vector(0,0,0),Angle(0,0,0),1,0.075)      
    else
        hg.bone.Set(ply,"r_hand",Vector(0,0,0),Angle(0,0,30),1,0.1)
	    hg.bone.Set(ply,"r_forearm",Vector(0,0,0),Angle(10,-10,20),1,0.1)
	    hg.bone.Set(ply,"r_upperarm",Vector(0,0,0),Angle(20,-50,0),1,0.1)
    
        hg.bone.Set(ply,"l_upperarm",Vector(0,0,0),Angle(0,0,0),1,0.275)
        hg.bone.Set(ply,"l_forearm",Vector(0,0,0),Angle(0,0,0),1,0.225)
        hg.bone.Set(ply,"l_hand",Vector(0,0,0),Angle(0,0,0),1,0.275)   
    end
end

function SWEP:Initialize()
    hg.Weapons[self] = true
    self:SetHoldType("slam")
end

if SERVER then
    util.AddNetworkString("cuff")
    util.AddNetworkString("CuffRemoveModel")
else
    net.Receive("cuff",function(len)
        local self = net.ReadEntity()
        self.CuffPly = net.ReadEntity()
        self.CuffTime = net.ReadFloat()
    end)
    net.Receive("CuffRemoveModel",function()
        local p = net.ReadEntity()
        local cuffs = p:GetActiveWeapon()

        if cuffs:GetClass() != "weapon_handcuffs" then return end

        cuffs.ClientModel:SetNoDraw(true)
    end)
end

function SWEP:CuffRope(rag)
    constraint.Rope(
    rag,
    rag,
    rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )),
    rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" )),
    Vector(0,0,0),
    Vector(0,0,0),
    -2,
    0,
    0,
    0,
    "cable/rope.vmt",
    false,
    Color(255,255,255))
end
function SWEP:Cuff(rag)
    if self.Cuffed == true or rag.Cuffed then return end
    if !rag then
        return
    end
    self.Cuffed = true
    rag.Cuffed = true
    hg.RagdollOwner(rag):SetNWBool("Cuffed",true)
    if not rag then return end

    local ArmRight = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" )) )
    local ArmLeft = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )) )

    rag:EmitSound("weapons/357/357_reload3.wav")

    ArmLeft:SetPos(ArmRight:GetPos())

    local CuffEnt = ents.Create("prop_physics")
    CuffEnt:SetAngles(ArmRight:GetAngles())
    CuffEnt:SetPos(ArmRight:GetPos())
    CuffEnt:SetModel(self.WorldModel)
    CuffEnt:SetBodygroup(1,1)
    CuffEnt:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    CuffEnt:Spawn()

    for i = 1,2 do
        self:CuffRope(rag)
    end

    constraint.Weld(CuffEnt,rag,0,rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" )),0,true,false)
    constraint.Weld(CuffEnt,rag,0,rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )),0,true,false)

    self:GetOwner():SelectWeapon("weapon_hands")

    self:Remove()
end

local function GetPly(tr)
    local ent = tr.Entity
    if not IsValid(ent) then return end

    local ent = RagdollOwner(ent) or ent
    
    if ent:GetNWBool("Cuffs",false) then return end
    if not ent:IsPlayer() then return ent:GetClass() == "prop_ragdoll" and ent end
    if not ent:GetNWBool("fake") or ent:HasGodMode() then return end

    return ent
end

local cuffTime = 0.5

if SERVER then
    hook.Add("Player Spawn","Cuffs",function(ply)
        ply:SetNWBool("Cuffs",false)
    end)

    hook.Add("PlayerSwitchWeapon","!Cuffs",function(ply,old,new)
        if ply:GetNWBool("Cuffs",false) then return true end
    end)

    function SWEP:SecondaryAttack()
        local owner = self:GetOwner()

        local tr = hg.eyeTrace(owner)
        if not tr then return end

        local ply = owner

        if IsValid(ply) and ply.Cuffed then return end

        if ply then
            owner:EmitSound("weapons/357/357_reload1.wav")

            self.CuffPly = ply
            self.CuffTime = CurTime()

            self:SendCuff()
        end
    end

    function SWEP:PrimaryAttack()
        if IsValid(self.CuffPly) then return end

        local owner = self:GetOwner()

        local tr = hg.eyeTrace(owner)
        if not tr then return end

        local ply = GetPly(tr)

        if IsValid(ply) and ply.Cuffed then return end

        if ply then
            owner:EmitSound("weapons/357/357_reload1.wav")

            self.CuffPly = ply
            self.CuffTime = CurTime()

            self:SendCuff()
        end
    end
        
    function SWEP:SendCuff()
        net.Start("cuff")
        net.WriteEntity(self)
        net.WriteEntity(self.CuffPly or Entity(-1))
        net.WriteFloat(self.CuffTime)
        net.Send(self:GetOwner())
    end

    function SWEP:Think()
        local cuffPly = self.CuffPly
        if not IsValid(cuffPly) then return end

        local owner = self:GetOwner()

        local tr = hg.eyeTrace(owner)
        if not tr then return end
        
        local ply = (IsValid(tr.Entity) and (tr.Entity:IsRagdoll() and (hg.RagdollOwner(tr.Entity) != nil and hg.RagdollOwner(tr.Entity)) or (tr.Entity:IsPlayer() and tr.Entity)))

        if ply != cuffPly and cuffPly != owner then
            self.CuffPly = nil
            
            self:SendCuff()

            return
        end
         
        if cuffPly == owner then
            ply = owner
        end

        if self.CuffTime + cuffTime <= CurTime() then
            if cuffPly == owner then
                hg.Faking(owner)
            end
            timer.Simple(0,function()
                if ply:IsPlayer() then ply = ply:GetNWEntity("FakeRagdoll") end

                if IsValid(self) and self.Cuff then
                    self:Cuff(ply)
                end
            end)
        end
    end
end

if SERVER then return end

function SWEP:Holster()
    if self.ClientModel then
    self.ClientModel:Remove()
    end
    return true 
end

function SWEP:OwnerChanged()
    if self.ClientModel then
    self.ClientModel:Remove()
    end
end

function SWEP:CreateClientsideModel()
    if not IsValid(self.ClientModel) then
        self.ClientModel = ClientsideModel(self.WorldModel, RENDER_GROUP_OPAQUE_ENTITY)
        self.ClientModel:SetNoDraw(true)

        if not self.ACHO then
            local boneName = self.SlideBone
            if boneName == nil then return end
            local boneIndex = self.ClientModel:LookupBone(boneName)
            self.ACHO = 1
            self.ClientModel:ManipulateBonePosition(boneIndex, Vector(0, 0, 0))
        end

        local hookName = "DrawSWEPWorldModel_" .. self:EntIndex()
        hook.Add("PostDrawOpaqueRenderables", hookName, function()
            if not IsValid(self) or not IsValid(self.ClientModel) then
                hook.Remove("PostDrawOpaqueRenderables", hookName)
                return
            end
            self:DrawClientModel()
        end)
    end
end

function SWEP:DrawHUD()
    local tr = hg.eyeTrace(self:GetOwner())
    if not tr then return end
    
    local ply = GetPly(tr)

    local hit = tr.Hit and 1 or 0

    local pos = tr.HitPos:ToScreen()
    local x,y = pos.x,pos.y
    
    local frac = tr.Fraction * 100

    if ply then
        surface.SetDrawColor(Color(255, 255, 255, 255))
        draw.NoTexture()
        Circle(x, y, 5 / frac, 32)

        draw.DrawText(ply:GetNWBool("Cuffed") and string.format(hg.GetPhrase("cuffed"),ply:Name()) or string.format(hg.GetPhrase("cuff"),ply:Name()), "HS.18",x,y,color_white,TEXT_ALIGN_CENTER)

        if IsValid(self.CuffPly) then
            local anim_pos = 1 - math.Clamp((self.CuffTime + cuffTime - CurTime()) / cuffTime,0,1)

            surface.DrawRect(x - 50,y + 50,anim_pos * 100,25)
        end
    else
        surface.SetDrawColor(Color(255, 255, 255, 255 * hit))
        draw.NoTexture()
        Circle(x, y, 5 / frac, 32)
    end
end

function SWEP:WorldModel_Transform()
    local model, owner = self.ClientModel, self:GetOwner()
    if not IsValid(model) then
        self:CreateClientsideModel()
        model = self.ClientModel
    end
    if IsValid(owner) then
        local matrix = owner:GetBoneMatrix(owner:LookupBone("ValveBiped.Bip01_R_Hand"))
        if not matrix then return end

        local pos, ang = matrix:GetTranslation(), matrix:GetAngles()
        //model:SetupBones()
        model:SetNoDraw(true)
    else
        model:SetRenderOrigin(self:GetPos())
        model:SetRenderAngles(self:GetAngles())
    end
end

function SWEP:DrawWorldModel()
    local owner = self:GetOwner()
    if IsValid(owner) then
        if not IsValid(self.ClientModel) then
            self:CreateClientsideModel()
            return
        end

        if owner:GetActiveWeapon() != self or owner:GetMoveType() == MOVETYPE_NOCLIP then
            self.ClientModel:SetNoDraw(true)
            return
        end

        local attachmentIndex = owner:LookupAttachment("anim_attachment_rh")
        if attachmentIndex == 0 then return end

        local attachment = owner:GetAttachment(attachmentIndex)
        if not attachment then return end

        local Pos = attachment.Pos
        local Ang = attachment.Ang

        Pos:Add(Ang:Forward() * self.WorldPos[1])
        Pos:Add(Ang:Right() * self.WorldPos[2])
        Pos:Add(Ang:Up() * self.WorldPos[3])

        Ang:RotateAroundAxis(Ang:Right(), self.WorldAng[1])
        Ang:RotateAroundAxis(Ang:Up(), self.WorldAng[2])
        Ang:RotateAroundAxis(Ang:Forward(), self.WorldAng[3])

        Ang:Normalize()

        self.ClientModel:SetPos(Pos)
        self.ClientModel:SetAngles(Ang)
        self.ClientModel:SetModelScale(self.CorrectSize or 1)
        self.ClientModel:SetNoDraw(false)

        self.ClientModel:SetBodygroup(1,1)

        self:WorldModel_Transform()

        self.ClientModel:DrawModel()
    else
        if IsValid(self.ClientModel) then
            self.ClientModel:SetNoDraw(true)
        end
        self:DrawModel()
        self:SetBodygroup(1,1)
    end
end

function SWEP:OnRemove()
    if IsValid(self.ClientModel) then
        self.ClientModel:Remove()
        self.ClientModel = nil
    end
end