if CLIENT then
    local hg_flashlight_enable = CreateClientConVar("hg_flashlight_enable", "1", true, false)
    local hg_flashlight_distance = CreateClientConVar("hg_flashlight_distance", "1500", true, false)

    local function create(ply)
        ply.DynamicFlashlight = ProjectedTexture()
        ply.DynamicFlashlight:SetTexture("effects/arc9_eft/flashlightcookie.png")
        ply.DynamicFlashlight:SetFarZ(1200)
        ply.DynamicFlashlight:SetFOV(65)
        ply.DynamicFlashlight:SetEnableShadows(true)
        
        ply.flashlightAngles = Angle(0,0,0)
        ply.flashlightPos = Vector(0,0,0)
        ply.lastFlashlightUpdate = 0
    end

    local function remove(ply)
        if IsValid(ply.DynamicFlashlight) then
            ply.DynamicFlashlight:Remove()
            ply.DynamicFlashlight = nil
        end
        if IsValid(ply.flashlightMdl) then
            ply.flashlightMdl:Remove()
            ply.flashlightMdl = nil
        end
    end

    local flashlightModel = "models/maxofs2d/lamp_flashlight.mdl"
    local attachOffset = Vector(3, -2, 0)
    local angleOffset = Angle(0, 0, 0)
    local ragdollAttachOffset = Vector(5, -10, 0)

    hook.Add("Think", "DynamicFlashlight.Rendering", function()
        local lply = LocalPlayer()
        if not IsValid(lply) then return end

        local curTime = CurTime()
        local lply_pos = lply:GetPos()
        local dis = hg_flashlight_distance:GetFloat()

        for _, ply in ipairs(player.GetAll()) do
            if not IsValid(ply) then continue end
            
            if hg_flashlight_enable:GetBool() and ply:GetNWBool("DynamicFlashlight") and ply:GetPos():Distance(lply_pos) <= dis then
                local fake = ply:GetNWEntity("Ragdoll")
                local ent = ply

                if not ply:Alive() and IsValid(fake) then
                    ent = fake
                end

                if not ply.DynamicFlashlight then
                    create(ply)
                end

                if IsValid(ply.DynamicFlashlight) then
                    local bone
                    local pos
                    local ang = ply:EyeAngles()
                    
                    if ply:Alive() then
                        bone = ent:LookupBone("ValveBiped.Bip01_L_Clavicle")
                    else
                        bone = ent:LookupBone("ValveBiped.Bip01_L_Clavicle")
                    end
                    
                    if bone then
                        local bonePos, boneAng = ent:GetBonePosition(bone)
                        local offset = ply:Alive() and attachOffset or ragdollAttachOffset
                        pos = bonePos + boneAng:Forward() * offset.x + 
                              boneAng:Right() * offset.y + 
                              boneAng:Up() * offset.z
                    else
                        pos = ply:Alive() and ply:EyePos() or ent:GetPos()
                    end

                    local lerpFactor = math.Clamp((curTime - (ply.lastFlashlightUpdate or 0)) * 10, 0, 1)
                    ply.flashlightPos = LerpVector(lerpFactor, ply.flashlightPos or pos, pos)
                    ply.flashlightAngles = LerpAngle(lerpFactor, ply.flashlightAngles or ang, ang + angleOffset)
                    ply.lastFlashlightUpdate = curTime

                    ply.DynamicFlashlight:SetPos(ply.flashlightPos)
                    ply.DynamicFlashlight:SetAngles(ply.flashlightAngles)
                    ply.DynamicFlashlight:Update()
                end
            else
                ply:SetNWBool("DynamicFlashlight", false)
                remove(ply)
            end
        end
    end)

    hook.Add("PostDrawOpaqueRenderables", "DynamicFlashlight.Model", function()
        for _, ply in ipairs(player.GetAll()) do
            if not IsValid(ply) then continue end

            if hg_flashlight_enable:GetBool() and ply:GetNWBool("DynamicFlashlight") then
                local fake = ply:GetNWEntity("Ragdoll")
                local ent = ply
                
                if not ply:Alive() then
                    if IsValid(fake) then
                        ent = fake
                    else
                        continue
                    end
                end

                if not IsValid(ply.flashlightMdl) then
                    ply.flashlightMdl = ClientsideModel(flashlightModel)
                    ply.flashlightMdl:SetNoDraw(true)
                end

                if IsValid(ply.flashlightMdl) and ply.flashlightPos and ply.flashlightAngles then
                    ply.flashlightMdl:SetPos(ply.flashlightPos)
                    ply.flashlightMdl:SetAngles(ply.flashlightAngles)
                    ply.flashlightMdl:SetModelScale(ply:Alive() and 0.5 or 0.7)
                    ply.flashlightMdl:SetNoDraw(false)
                end
            elseif IsValid(ply.flashlightMdl) then
                ply.flashlightMdl:SetNoDraw(true)
            end
        end
    end)
end

if SERVER then
    hook.Add("PlayerButtonDown", "DynamicFlashlight.Toggle", function(ply, button)
        if button == KEY_F and ply.allowFlashlights then
            local newState = not ply:GetNWBool("DynamicFlashlight")
            ply:SetNWBool("DynamicFlashlight", newState)
            ply:EmitSound("items/flashlight1.wav", 60, newState and 100 or 80)
        end
    end)

    hook.Add("PlayerSpawn", "AllowFlashlights", function(ply)
        ply.allowFlashlights = true
    end)
end