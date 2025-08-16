util.AddNetworkString("LobotomySFX")
util.AddNetworkString("DeathScreen")
util.AddNetworkString("PlayDeathSound")

DamageMultipliers = {
    [DMG_CLUB] = 1,
    [DMG_BULLET] = 2,
    [DMG_SLASH] = 0.4,
    [DMG_BLAST] = 4,
}

PainMultipliers = {
    [DMG_CLUB] = 0.5,
    [DMG_BULLET] = 0.75,
    [DMG_SLASH] = 0.4,
    [DMG_BLAST] = 10,
}

local Reasons = {
    [DMG_BULLET] = "died_by",
    [DMG_BUCKSHOT] = "died_by",
    [DMG_BLAST] = "dead_blast",
    [DMG_CLUB] = "died_by",
    [DMG_SLASH] = "died_by",
    [DMG_BURN] = "dead_burn",
}

local FALL_SOUND = "zcity/other/fallstatic.wav"
local MIN_VELOCITY = 525
local MIN_FALL_SPEED = 520
local MAX_FALL_SPEED = 2000
local SOUND_FADE_TIME = 0.5
local fallSoundChannel = nil
local lastValidPosition = Vector(0,0,0)
local blindnessMaterial = Material("overlays/blindness.png", "smooth unlitgeneric")

local fallEffectProgress = 0

local function GetPlayerEntity(ply)
    return IsValid(ply.FakeRagdoll) and ply.FakeRagdoll or ply
end

local function CalculateTotalSpeed(vel)
    return vel:Length()
end

local function UpdateFallSound(ent, speed)
    if speed > MIN_FALL_SPEED then
        if not fallSoundChannel then
            fallSoundChannel = CreateSound(ent, FALL_SOUND)
            fallSoundChannel:Play()
            fallSoundChannel:ChangeVolume(0, 0)
        end
        local targetVol = math.Clamp((speed - MIN_FALL_SPEED) / (MAX_FALL_SPEED - MIN_FALL_SPEED), 0.1, 1)
        fallSoundChannel:ChangeVolume(targetVol, 1)
    elseif fallSoundChannel then
        local currentVol = fallSoundChannel:GetVolume()
        if currentVol > 0.1 then
            fallSoundChannel:ChangeVolume(math.max(0, currentVol - FrameTime() * 2), 0.1)
        else
            fallSoundChannel:Stop()
            fallSoundChannel = nil
        end
    end
end

local function ApplyScreenShake(ply, intensity) -- ни работаеть в рагдолё :cccc
    local shake = intensity * 0
    if IsValid(ply.FakeRagdoll) then
        util.ScreenShake(ply.FakeRagdoll:GetPos(), shake * 1.5, shake * 1.5, 1, 500)
        net.Start("LobotomySFX")
            net.WriteVector(ply.FakeRagdoll:GetPos())
            net.WriteFloat(shake * 1.5)
        net.Send(ply)
    else
        util.ScreenShake(ply:GetPos(), shake, shake, 0.7, 300)
    end
end

hook.Add("Think", "FallEffects_Update", function()
    local ply = LocalPlayer()
    if not IsValid(ply) or not ply:Alive() then
        fallEffectProgress = 0
        if fallSoundChannel then
            fallSoundChannel:Stop()
            fallSoundChannel = nil
        end
        return
    end

    local ent = GetPlayerEntity(ply)
    local vel = ent:GetVelocity()
    local totalSpeed = CalculateTotalSpeed(vel)
    lastFallSpeed = totalSpeed

    local targetProgress = math.Clamp((totalSpeed - MIN_FALL_SPEED) / (MAX_FALL_SPEED - MIN_FALL_SPEED), 0, 1)
    fallEffectProgress = Lerp(FrameTime() * 3, fallEffectProgress, targetProgress)

    UpdateFallSound(ent, totalSpeed)
    
    if totalSpeed > MIN_FALL_SPEED then
        ApplyScreenShake(ply, fallEffectProgress)
    end
end)

hook.Add("RenderScreenspaceEffects", "FallBlindnessEffect", function()
    if fallEffectProgress > 0.01 then
        render.SetMaterial(blindnessMaterial)
        render.DrawScreenQuadEx(
            0, 0, 
            ScrW(), ScrH(), 
            Color(255, 255, 255, 200 * fallEffectProgress)
        )
        
        local tab = {
            ["$pp_colour_colour"] = Lerp(fallEffectProgress, 1, 0.8),
            ["$pp_colour_contrast"] = Lerp(fallEffectProgress, 1, 1.3),
            ["$pp_colour_brightness"] = Lerp(fallEffectProgress, 0.1, -0.1)
        }
        DrawColorModify(tab)
    end
end)

hook.Add("PlayerDeath", "FallEffects_Cleanup", function(ply)
    if ply == LocalPlayer() then
        fallEffectProgress = 0
        if fallSoundChannel then
            fallSoundChannel:Stop()
            fallSoundChannel = nil
        end
    end
end)

hook.Add("PlayerSpawn", "FallEffects_Cleanup", function(ply)
    if ply == LocalPlayer() then
        fallEffectProgress = 0
    end
end)

hook.Add("PlayerDeath", "StopFallSoundOnDeath", function(ply)
    if ply == LocalPlayer() and fallSoundChannel then
        fallSoundChannel:Stop()
        fallSoundChannel = nil
    end
end)

local function StopFallSound()
    if fallSoundChannel then
        fallSoundChannel:FadeOut(SOUND_FADE_TIME)
        fallSoundChannel = nil
    end
end

hook.Add("PlayerDeath", "FallSound_Death", function(ply)
    if ply == LocalPlayer() then
        StopFallSound()
    end
end)

hook.Add("PlayerSpawn", "FallSound_Spawn", function(ply)
    if ply == LocalPlayer() then
        StopFallSound()
    end
end)

hook.Add("Think", "FallSound_Update", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    
    local ent = GetPlayerEntity(ply)
    local vel = ent:GetVelocity()
    local speed = CalculateTotalSpeed(vel)
    
    if speed > 50 then
        lastValidPosition = ent:GetPos()
    end
    
    if speed > MIN_VELOCITY then
        local volume = math.Clamp((speed - MIN_VELOCITY) / 200, 0.1, 1)
        
        if not fallSoundChannel then
            fallSoundChannel = CreateSound(ent, FALL_SOUND)
            fallSoundChannel:Play()
        end
        
        fallSoundChannel:ChangeVolume(volume, 0.1)
        
        sound.PlayFile(FALL_SOUND, "3d noplay", function(station)
            if IsValid(station) then
                station:SetPos(lastValidPosition)
                station:Play()
            end
        end)
    else
        if fallSoundChannel then
            local currentVol = fallSoundChannel:GetVolume()
            if currentVol > 0.1 then
                fallSoundChannel:ChangeVolume(math.max(0, currentVol - FrameTime() * 2), 0.1)
            else
                fallSoundChannel:Stop()
                fallSoundChannel = nil
            end
        end
    end
end)

hook.Add("OnReloaded", "FallSound_Cleanup", function()
    StopFallSound()
end)

hook.Add("PlayerDeath","Homigrad_DeathScreen",function(ply,attacker,killedby)
    if !ply.LastDMGInfo then
        return
    end

    ply:SetNWString("KillReason",ply.KillReason)
    ply:SetNWEntity("LastInflictor",ply.LastDMGInfo:GetInflictor())
    ply:SetNWEntity("LastAttacker",killedby)
    ply.PLYSPAWN_OVERRIDE = false
    timer.Simple(0,function()
        if IsValid(ply.FakeRagdoll) and IsValid(ply.FakeRagdoll:GetPhysicsObject()) then
            ply.FakeRagdoll:GetPhysicsObject():SetMass(20)
            ply.AppearanceOverride = false    
        end
    end)
end)

RagdollDamageBoneMul={
    [HITGROUP_LEFTLEG]=0.70,
    [HITGROUP_RIGHTLEG]=0.70,

    [HITGROUP_GENERIC]=1.35,

    [HITGROUP_LEFTARM]=0.70,
    [HITGROUP_RIGHTARM]=0.70,

    [HITGROUP_CHEST]=1.25,
    [HITGROUP_STOMACH]=1.20,

    [HITGROUP_HEAD]=2.30,
}

function GetPhysicsBoneDamageInfo(ent,dmgInfo)
    local pos = dmgInfo:GetDamagePosition()
    local dir = dmgInfo:GetDamageForce():GetNormalized()

    dir:Mul(1024 * 8)

    local tr = {}
    tr.start = pos
    tr.endpos = pos + dir
    tr.filter = filter
    filterEnt = ent
    tr.ignoreworld = true

    local result = util.TraceLine(tr)
    if result.Entity != ent then
        tr.endpos = pos - dir

        return util.TraceLine(tr).PhysicsBone
    else
        return result.PhysicsBone
    end
end

hook.Add("EntityTakeDamage", "Homigrad_damage", function(ent, dmginfo)
    if IsValid(ent:GetPhysicsObject()) and dmginfo:IsDamageType(DMG_BULLET+DMG_BUCKSHOT+DMG_CLUB+DMG_GENERIC+DMG_BLAST) then ent:GetPhysicsObject():ApplyForceOffset(dmginfo:GetDamageForce():GetNormalized() * math.min(dmginfo:GetDamage() * 10,3000),dmginfo:GetDamagePosition()) end
    local ply = (ent:IsRagdoll() and hg.RagdollOwner(ent) or ent)
    if ent.IsArmor then
        ply = (ent:IsRagdoll() and hg.RagdollOwner(ent) or ent)
    end

    if dmginfo:IsDamageType(DMG_BLAST) then
        local ply = (ent:IsRagdoll() and hg.RagdollOwner(ent) or ent)
        if IsValid(ply) and ply:IsPlayer() then
            local intensity = math.Clamp(dmginfo:GetDamage() / 50, 0.5, 5)
            ApplyExplosionShake(intensity, 1.5)
        end
    end

    if dmginfo:IsDamageType(DMG_BLAST) then
        local ply = (ent:IsRagdoll() and hg.RagdollOwner(ent) or ent)
        if IsValid(ply) and ply:IsPlayer() then
            local intensity = math.Clamp(dmginfo:GetDamage() / 50, 0.5, 5)
            ApplyExplosionShake(intensity, 1.5)
        end
    end

    if not IsValid(ply) or not ply:IsPlayer() or not ply:Alive() or ply:HasGodMode() or ent:IsRagdoll() and IsValid(ply) and ply.FakeRagdoll != ent then
        return
    end

    local rag = ply != ent and ent
    
    if rag and dmginfo:IsDamageType(DMG_CRUSH) and att and att:IsRagdoll() then
        dmginfo:SetDamage(0)

        return true
    end 

    if dmginfo:GetDamage() > 27 then
        if not ply.Fake then
            hg.Faking(ply,(IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():EyeAngles():Forward() * 15 or (Ang and Ang:Forward() * 150 or Angle(90,0,0):Forward() * 150)) * math.random(5,10))
            ply:SetHealth(ply:Health() - dmginfo:GetDamage())
        end
    end

    local physics_bone = GetPhysicsBoneDamageInfo(ent,dmginfo)

    local hitgroup
    local isfall

    local bonename = ent:GetBoneName(ent:TranslatePhysBoneToBone(physics_bone))
    ply.LastHitBoneName = bonename
    ply:SetNWString("LastHitBone",bonename)

    if BoneIntoHG[bonename] then hitgroup = BoneIntoHG[bonename] end

    local dmg_mul,dmg_type = hg.Armor_Effect(ply,ent,dmginfo,hitgroup)

    local mul = RagdollDamageBoneMul[hitgroup]

    if rag and mul then dmginfo:ScaleDamage(mul) end

    local entAtt = dmginfo:GetAttacker()
    local att =
        (entAtt:IsPlayer() and entAtt:Alive() and entAtt) or
        (entAtt:GetClass() == "wep" and entAtt:GetOwner())
    att = dmginfo:GetDamageType() != DMG_CRUSH and att or ply.LastAttacker

    if !dmginfo:IsDamageType(DMG_FALL + DMG_CRUSH) then
        ply.LastAttacker = att
        //ply:SetNWEntity("LastAttacker",att or NULL)
    end
    ply.LastHitGroup = hitgroup

    ply.KillReason = Reasons[dmginfo:GetDamageType()]
    ply:SetNWString("KillReason",ply.KillReason)

    dmginfo:SetDamageType(dmg_type)

    local LastDMGINFO = DamageInfo()
    LastDMGINFO:SetAttacker(dmginfo:GetAttacker())
    LastDMGINFO:SetDamage(dmginfo:GetDamage())
    LastDMGINFO:SetInflictor(dmginfo:GetInflictor())
    LastDMGINFO:SetDamageType(dmginfo:GetDamageType())
    LastDMGINFO:SetDamagePosition(dmginfo:GetDamagePosition())
    LastDMGINFO:SetDamageForce(dmginfo:GetDamageForce())

    ply.LastDMGInfo = LastDMGINFO

    ply:SetNWEntity("LastInflictor",LastDMGINFO:GetInflictor())

    dmginfo:ScaleDamage((DamageMultipliers[dmginfo:GetDamageType()] and DamageMultipliers[dmginfo:GetDamageType()] or 0.7))

    if dmginfo:IsDamageType(DMG_CRUSH) and rag then
        dmginfo:ScaleDamage((rag:GetVelocity():Length() > 50 and (rag:GetVelocity():Length() / 8500) or 0))
        ply.pain = math.Clamp(ply.pain + dmginfo:GetDamage() * (rag:GetVelocity():Length() / 200),0,400)
    end

    //print(ply:Health())

    ply.pain = math.Clamp(ply.pain + dmginfo:GetDamage() * (PainMultipliers[dmginfo:GetDamageType()] and PainMultipliers[dmginfo:GetDamageType()] or 0.1),0,400)

    if rag then
        ply:SetHealth(ply:Health() - dmginfo:GetDamage())    
    end

    //print(ply:Health())

    if dmginfo:IsDamageType(DMG_SLASH + DMG_BULLET + DMG_BUCKSHOT) then
        if not ply.bleed then
            ply.bleed = 0
        end
        ply.bleed = ply.bleed + dmginfo:GetDamage() * 2
    end

    if dmginfo:GetDamageType() != DMG_CRUSH then
        dmginfo:ScaleDamage(dmg_mul)
    end

    hook.Run("Homigrad_Organs",ent,dmginfo,GetPhysicsBoneDamageInfo(ent,dmginfo),ent:GetBoneName(ent:TranslatePhysBoneToBone(GetPhysicsBoneDamageInfo(ent,dmginfo))))
end)