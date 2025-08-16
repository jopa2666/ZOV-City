hg = hg or {}

local sides = {
    ["sv_"] = "sv_",
    ["sh_"] = "sh_",
    ["cl_"] = "cl_",
    ["_sv"] = "sv_",
    ["_sh"] = "sh_",
    ["_cl"] = "cl_",
}

local load_priority = {
    ["sh_"] = 1,
    ["sv_"] = 2,
    ["cl_"] = 3
}

local function AddFile(File, dir)
    local fileSide = string.lower(string.Left(File, 3))
    local fileSide2 = string.lower(string.Right(string.sub(File, 1, -5), 3))
    local side = sides[fileSide] or sides[fileSide2] or "cl_"
    
    MsgN("[Homigrad Loader] Loading: ", dir .. File, " as ", side)
    
    if SERVER and side == "sv_" then
        include(dir .. File)
    elseif side == "sh_" then
        if SERVER then AddCSLuaFile(dir .. File) end
        include(dir .. File)
    elseif side == "cl_" then
        if SERVER then
            AddCSLuaFile(dir .. File)
        else
            include(dir .. File)
        end
    else
        if SERVER then AddCSLuaFile(dir .. File) end
        include(dir .. File)
    end
end

local function IncludeDir(dir)
    dir = dir .. "/"
    local files, directories = file.Find(dir .. "*", "LUA")
    
    if files then
        table.sort(files, function(a, b)
            local sideA = sides[string.lower(string.Left(a, 3))] or sides[string.lower(string.Right(string.sub(a, 1, -5), 3))] or "cl_"
            local sideB = sides[string.lower(string.Left(b, 3))] or sides[string.lower(string.Right(string.sub(b, 1, -5), 3))] or "cl_"
            return (load_priority[sideA] or 3) < (load_priority[sideB] or 3)
        end)

        for k, v in ipairs(files) do
            if string.EndsWith(v, ".lua") then 
                if not string.StartWith(v, "cl_weapon_selector") then
                    AddFile(v, dir)
                end
            end
        end
        
        for k, v in ipairs(files) do
            if string.EndsWith(v, ".lua") and string.StartWith(v, "cl_weapon_selector") then
                AddFile(v, dir)
            end
        end
    end

    if directories then
        for k, v in ipairs(directories) do
            IncludeDir(dir .. v)
        end
    end
end

local function Run()
    local time = SysTime()
    print("Loading homigrad...")
    hg.loaded = false
    
    IncludeDir("homigrad")
    
    if CLIENT then
        hook.Add("InitPostEntity", "LoadHotbar", function()
            timer.Simple(1, function()
                if hg.CustomHotbar then
                    hg.CustomHotbar.ShowUntil = CurTime() + hg.CustomHotbar.ShowTime
                    print("[Homigrad] Hotbar initialized")
                end
            end)
        end)
    end
    
    hg.loaded = true
    print("Loaded homigrad, " .. tostring(math.Round(SysTime() - time, 5)) .. " seconds needed")
end

function hg.IncludeDir(dir)
    IncludeDir(dir)
end

if hg and not hg.loaded then
    hook.Add("InitPostEntity", "homigrad", function() Run() end)
elseif hg and hg.loaded then
    Run()
end