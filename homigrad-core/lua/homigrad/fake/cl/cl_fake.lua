local MEDICAL_MODELS = {
    ["models/carlsmei/escapefromtarkov/medical/alusplint.mdl"] = true,
    ["models/carlsmei/escapefromtarkov/medical/automedkit.mdl"] = true,
    ["models/carlsmei/escapefromtarkov/medical/salewa.mdl"] = true,
    ["models/carlsmei/escapefromtarkov/medical/medkit.mdl"] = true,
    ["models/carlsmei/escapefromtarkov/medical/ifak.mdl"] = true,
    ["models/carlsmei/escapefromtarkov/medical/grizzly.mdl"] = true,
    ["models/carlsmei/escapefromtarkov/medical/bandage_army.mdl"] = true,
    ["models/jellik/heroin.mdl"] = true,
    ["models/jellik/heroin.mdl"] = true,
    
    ["models/weapons/w_models/w_medkit.mdl"] = true
}

local function CleanupRagdollModels(rag)
    if IsValid(rag) then
        if IsValid(rag.MedicalWepModel) then
            rag.MedicalWepModel:Remove()
            rag.MedicalWepModel = nil
        end
        if IsValid(rag.GrenadeModel) then
            rag.GrenadeModel:Remove()
            rag.GrenadeModel = nil
        end
    end
end

hook.Add("PostDrawOpaqueRenderables", "DrawFakeWeapons", function()
    for _, ply in ipairs(player.GetAll()) do
        if ply:GetNWBool("Fake") and IsValid(ply.FakeRagdoll) then
            local rag = ply.FakeRagdoll
            local wep = ply:GetActiveWeapon()
            
            if IsValid(wep) then
                local model = wep.WorldModel or wep.ViewModel
                
                if model and MEDICAL_MODELS[model:lower()] then
                    if not IsValid(rag.MedicalWepModel) or rag.MedicalWepModel:GetModel() ~= model then
                        CleanupRagdollModels(rag)
                        rag.MedicalWepModel = ClientsideModel(model)
                        rag.MedicalWepModel:SetParent(rag)
                    end
                    
                    local boneid = rag:LookupBone("ValveBiped.Bip01_R_Hand")
                    if boneid then
                        local pos, ang = rag:GetBonePosition(boneid)
                        if pos and ang then
                            ang:RotateAroundAxis(ang:Up(), 45)
                            ang:RotateAroundAxis(ang:Forward(), 25)
                            pos = pos + ang:Forward() * 5 + ang:Right() * 3 + ang:Up() * -2
                            
                            rag.MedicalWepModel:SetPos(pos)
                            rag.MedicalWepModel:SetAngles(ang)
                            rag.MedicalWepModel:DrawModel()
                        end
                    end
                elseif IsValid(rag.MedicalWepModel) then
                    CleanupRagdollModels(rag)
                end
            end
            
            if IsValid(wep) and (wep.Base == "weapon_gren_base" or wep:GetClass():StartWith("grenade_")) then
                if not IsValid(rag.GrenadeModel) then
                    CleanupRagdollModels(rag)
                    local model = wep.WorldModel or wep.ViewModel or "models/weapons/w_grenade.mdl"
                    rag.GrenadeModel = ClientsideModel(model)
                    rag.GrenadeModel:SetParent(rag)
                end
                
                local boneid = rag:LookupBone("ValveBiped.Bip01_R_Hand")
                if boneid then
                    local pos, ang = rag:GetBonePosition(boneid)
                    if pos and ang then
                        ang:RotateAroundAxis(ang:Up(), 15)
                        ang:RotateAroundAxis(ang:Forward(), 5)
                        pos = pos + ang:Forward() * 5 + ang:Right() * 3 + ang:Up() * -2
                        
                        rag.GrenadeModel:SetPos(pos)
                        rag.GrenadeModel:SetAngles(ang)
                        rag.GrenadeModel:DrawModel()
                    end
                end
            elseif IsValid(rag.GrenadeModel) then
                CleanupRagdollModels(rag)
            end
        elseif IsValid(ply.FakeRagdoll) then
            CleanupRagdollModels(ply.FakeRagdoll)
        end
    end
end)


hook.Add("EntityRemoved", "CleanupFakeModelsOnRemove", function(ent)
    if ent:GetClass() == "prop_ragdoll" then
        CleanupRagdollModels(ent)
    end
end)

hook.Add("Player Think", "CleanupFakeModels", function(ply)
    if not ply:GetNWBool("Fake") and IsValid(ply.FakeRagdoll) then
        CleanupRagdollModels(ply.FakeRagdoll)
    end
end)

hook.Add("PlayerFootstep", "CustomFootstep", function(ply) if IsValid(ply.FakeRagdoll) then return true end end)

hook.Add("Player Think","Player_Fake",function(ply,time)
    ply.Fake = ply:GetNWBool("Fake")
    ply.FakeRagdoll = ply:GetNWEntity("FakeRagdoll")

    local ent = hg.GetCurrentCharacter(ply)

    if ent:IsRagdoll() then
        if ply:GetNWBool("LeftArm") then
            hg.bone.Set(ent,"l_finger0",Vector(0,0,0),Angle(0,20,0),1,0.2)
            hg.bone.Set(ent,"l_finger01",Vector(0,0,0),Angle(0,20,0),1,0.2)
            hg.bone.Set(ent,"l_finger1",Vector(0,0,0),Angle(0,-40,0),1,0.2)
            hg.bone.Set(ent,"l_finger11",Vector(0,0,0),Angle(0,-80,0),1,0.2)
            hg.bone.Set(ent,"l_finger2",Vector(0,0,0),Angle(0,-40,0),1,0.2)
            hg.bone.Set(ent,"l_finger21",Vector(0,0,0),Angle(0,-80,0),1,0.2)
        else
            hg.bone.Set(ent,"l_finger0",Vector(0,0,0),Angle(0,0,0),1,0.1)
            hg.bone.Set(ent,"l_finger01",Vector(0,0,0),Angle(0,0,0),1,0.1)
            hg.bone.Set(ent,"l_finger1",Vector(0,0,0),Angle(0,0,0),1,0.1)
            hg.bone.Set(ent,"l_finger11",Vector(0,0,0),Angle(0,0,0),1,0.1)
            hg.bone.Set(ent,"l_finger2",Vector(0,0,0),Angle(0,0,0),1,0.1)
            hg.bone.Set(ent,"l_finger21",Vector(0,0,0),Angle(0,0,0),1,0.1)
        end

        if ply:GetNWBool("RightArm") then
            hg.bone.Set(ent,"r_finger0",Vector(0,0,0),Angle(0,20,0),1,0.2)
            hg.bone.Set(ent,"r_finger01",Vector(0,0,0),Angle(0,20,0),1,0.2)
            hg.bone.Set(ent,"r_finger1",Vector(0,0,0),Angle(0,-40,0),1,0.2)
            hg.bone.Set(ent,"r_finger11",Vector(0,0,0),Angle(0,-80,0),1,0.2)
            hg.bone.Set(ent,"r_finger2",Vector(0,0,0),Angle(0,-40,0),1,0.2)
            hg.bone.Set(ent,"r_finger21",Vector(0,0,0),Angle(0,-80,0),1,0.2)
        else
            hg.bone.Set(ent,"r_finger0",Vector(0,0,0),Angle(0,0,0),1,0.1)
            hg.bone.Set(ent,"r_finger01",Vector(0,0,0),Angle(0,0,0),1,0.1)
            hg.bone.Set(ent,"r_finger1",Vector(0,0,0),Angle(0,0,0),1,0.1)
            hg.bone.Set(ent,"r_finger11",Vector(0,0,0),Angle(0,0,0),1,0.1)
            hg.bone.Set(ent,"r_finger2",Vector(0,0,0),Angle(0,0,0),1,0.1)
            hg.bone.Set(ent,"r_finger21",Vector(0,0,0),Angle(0,0,0),1,0.1)
        end
    end
end)

hook.Add("Think","Homigrad_Ragdoll_Color",function()
    for _, ent in ipairs(ents.FindByClass("prop_ragdoll")) do
        if ent:IsRagdoll() then
            if ent:GetNWVector("PlayerColor") then
                if IsValid(ent) then
                    function ent.RenderOverride()
                        hg.RagdollRender(ent)
                    end
                    ent.GetPlayerColor = function()
                        return ent:GetNWVector("PlayerColor")
                    end
                end
            end
        end
    end
end)

hook.Add("HUDPaint","Shit123",function()
    local lply = LocalPlayer()
    if ROUND_NAME == "dr" and lply:GetNWBool("Fake") and lply:Alive() then
        draw.SimpleText(string.format(hg.GetPhrase("dr_youwilldiein"),math.Clamp(math.Round(lply:GetNWFloat("TimeToDeath") - CurTime(),1),0,100000)),"H.25",ScrW()/2,ScrH()/1.5,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
end)

concommand.Add("fake",function()
    net.Start("fake")
    net.SendToServer()
end)