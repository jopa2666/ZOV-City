if SERVER then
    local webhookURL = "COCAINE: i wanna to believe"
    local function PostDiscord(message, logType)
        //if not webhookURL or webhookURL == "" then return end
    
        local payload = {
            ["content"] = nil,
            ["username"] = "Ну бля ээ ну биля хз ну бисмиляххх",
            ["embeds"] = {{
                ["title"] = "Log",
                ["description"] = message,
                ["color"] = logType == "Error" and 15158332 or logType == "Warning" and 16747008 or 11534591,
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }
    
        http.Post(webhookURL, {
            payload_json = util.TableToJSON(payload)
        }, function(result)
            print("[Discord Logs] Sent.")
        end, function(failReason)
            print("[Discord Logs] Error!  " .. failReason)
        end)
    end
    
    function DiscordLog(message, logType)
        do return end
  
        logType = logType or "Info"
        PostDiscord(message, logType)
    end

    concommand.Add("discord_log",function(ply,c,args)
        if IsValid(ply) and !ply:IsSuperAdmin() then
            return
        end

        DiscordLog(args[1] or "shto","Info")
    end)
    
    hook.Add("PlayerInitialSpawn", "LogPlayerSpawn", function(ply)
        DiscordLog(ply:Nick() .. " | " .. ply:SteamID() .. "   -   " .. " Зашёл.", "Info")
    end)
    
    hook.Add("PlayerDisconnected", "LogPlayerDisconnect", function(ply)
        DiscordLog(ply:Nick() .. " | " .. ply:SteamID() .. "   -   " .. " Вышел.", "Info")
    end)
    
    hook.Add("PlayerSpawnedProp", "LogPlayerSpawnedProp", function(ply, model)
        DiscordLog(ply:Nick() .. " | " .. ply:SteamID() .. "   -   " .. " заспавнил: " .. model, "Info")
    end)
    
    hook.Add("PlayerSpawnedSENT", "LogPlayerSpawnedSENT", function(ply, ent)
        DiscordLog(ply:Nick() .. " | " .. ply:SteamID() .. "   -   " .. " заспавнил: " .. ent:GetClass(), "Info")
    end)
    
    hook.Add("PlayerSpawnedNPC", "LogPlayerSpawnedNPC", function(ply, npc)
        DiscordLog(ply:Nick() .. " | " .. ply:SteamID() .. "   -   " .. " заспавнил: " .. npc:GetClass(), "Info")
    end)
    
    hook.Add("PlayerSpawnedRagdoll", "LogPlayerSpawnedRagdoll", function(ply, model, ent)
        DiscordLog(ply:Nick() .. " | " .. ply:SteamID() .. "   -   " .. " заспавнил: " .. model, "Info")
    end)
    
    hook.Add("PlayerSpawnedVehicle", "LogPlayerSpawnedVehicle", function(ply, ent)
        DiscordLog(ply:Nick() .. " | " .. ply:SteamID() .. "   -   " .. " заспавнил: " .. ent:GetClass(), "Info")
    end)
    
    hook.Add("PlayerSpawnedEffect", "LogPlayerSpawnedEffect", function(ply, model, ent)
        DiscordLog(ply:Nick() .. " | " .. ply:SteamID() .. "   -   " .. " заспавнил: " .. model, "Info")
    end)
    
    hook.Add("PlayerGiveSWEP", "LogPlayerGiveSWEP", function(ply, class, swep)
        DiscordLog(ply:Nick() .. " | " .. ply:SteamID() .. "   -   " .. " заспавнил: " .. class, "Info")
    end)
    
    hook.Add("PlayerSay", "LogPlayerChat", function(ply, text)
        if not string.find(text, "@everyone") and not string.find(text, "@here") and not string.find(text, "*drop") and not string.find(text, "*inv") then
            DiscordLog(ply:Nick() .. " | " .. ply:SteamID() .. "   -   " .. " said: " .. text, "Info")
        end
    end)
    end