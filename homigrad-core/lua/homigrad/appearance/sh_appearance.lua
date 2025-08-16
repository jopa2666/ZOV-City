hg = hg or {}
hg.Apperance = hg.Apperance or {}

-- Модели игроков
local PlayerModels = {
    [1] = { -- Мужские модели
        "models/player/group01/male_01.mdl",
        "models/player/group01/male_02.mdl",
        "models/player/group01/male_03.mdl",
        "models/player/group01/male_04.mdl",
        "models/player/group01/male_05.mdl",
        "models/player/group01/male_06.mdl",
        "models/player/group01/male_07.mdl",
        "models/player/group01/male_08.mdl",
        "models/player/group01/male_09.mdl",
        "models/chs_community/necollins.mdl",
        "models/chs_community/mannytko.mdl"
    },
    [2] = { -- Женские модели
        "models/player/group01/female_01.mdl",
        "models/player/group01/female_02.mdl",
        "models/player/group01/female_03.mdl",
        "models/player/group01/female_04.mdl",
        "models/player/group01/female_05.mdl",
        "models/player/group01/female_06.mdl",
        "models/chs_community/blinked.mdl",
        "models/chs_community/soda.mdl"
    }
}

hg.Apperance.PlayerModels = PlayerModels

-- Случайные имена
hg.Apperance.RandomNames = {
    [1] = { -- Мужские имена
        "Mike", "Dave", "John", "Fred", "Steven", "Sergio", "Joel", "Samuel", "Larry", "Sean"
    },
    [2] = { -- Женские имена
        "Denise", "Joyce", "Jane", "Sara", "Emily", "Charlotte", "Cathy", "Ruth", "Julia", "Anna"
    }
}

-- Стили одежды
hg.Apperance.ClothesStyles = {
    ["normal"] = { [1] = "models/humans/male/group01/normal", [2] = "models/humans/female/group01/normal" },
    ["formal"] = { [1] = "models/humans/male/group01/formal", [2] = "models/humans/female/group01/formal" },
    ["plaid"] = { [1] = "models/humans/male/group01/plaid", [2] = "models/humans/female/group01/plaid" }
}

-- Дефолтные настройки внешности
hg.Apperance.DefaultApperanceTable = {
    Gender = 1, -- 1 = male, 2 = female
    Name = "",
    Model = "models/player/group01/male_01.mdl",
    Color = Color(255,255,255),
    ClothesStyle = "normal",
    Attachmets = {}
}

-- Сетевые сообщения
util.AddNetworkString("HG_UpdateAppearance")
util.AddNetworkString("HG_RequestAppearance")

-- Функция для проверки пола
function hg.IsFemale(ent)
    if not IsValid(ent) then return false end
    local model = ent:GetModel()
    if not model then return false end
    
    for _, femaleModel in ipairs(hg.Apperance.PlayerModels[2]) do
        if model == femaleModel then return true end
    end
    return false
end

-- Получение случайной внешности
function hg.GetRandomAppearance(ply)
    local appearance = table.Copy(hg.Apperance.DefaultApperanceTable)
    
    appearance.Gender = math.random(1, 2)
    appearance.Name = hg.Apperance.RandomNames[appearance.Gender][math.random(1, #hg.Apperance.RandomNames[appearance.Gender])]
    appearance.Model = hg.Apperance.PlayerModels[appearance.Gender][math.random(1, #hg.Apperance.PlayerModels[appearance.Gender])]
    appearance.Color = Color(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    appearance.ClothesStyle = hg.Apperance.ClothesStyles[table.GetKeys(hg.Apperance.ClothesStyles)[math.random(1, #table.GetKeys(hg.Apperance.ClothesStyles))]][appearance.Gender]
    
    return appearance
end

-- Применение внешности
function hg.ApplyAppearance(ply, appearance)
    if not IsValid(ply) then return end
    
    timer.Simple(0.1, function()
        if not IsValid(ply) then return end
        
        -- Проверка и установка модели
        local model = appearance.Model or hg.Apperance.DefaultApperanceTable.Model
        if not util.IsValidModel(model) then
            model = hg.Apperance.DefaultApperanceTable.Model
        end
        
        ply:SetModel(model)
        ply:SetPlayerColor(Vector(appearance.Color.r/255, appearance.Color.g/255, appearance.Color.b/255))
        
        -- Сохранение внешности
        ply.Appearance = appearance
        ply:SetNWString("HG_Appearance", util.TableToJSON(appearance))
    end)
end

-- Загрузка внешности при спавне
hook.Add("PlayerSpawn", "HG_ApplyAppearanceOnSpawn", function(ply)
    if not ply.Appearance then
        ply.Appearance = hg.GetRandomAppearance(ply)
    end
    
    hg.ApplyAppearance(ply, ply.Appearance)
end)

-- Серверная часть
if SERVER then
    -- Обработка запроса внешности от клиента
    net.Receive("HG_RequestAppearance", function(len, ply)
        if not IsValid(ply) then return end
        
        local appearance = ply.Appearance or hg.GetRandomAppearance(ply)
        net.Start("HG_UpdateAppearance")
            net.WriteTable(appearance)
        net.Send(ply)
    end)

    -- Обработка обновления внешности от клиента
    net.Receive("HG_UpdateAppearance", function(len, ply)
        if not IsValid(ply) then return end
        
        local appearance = net.ReadTable()
        if not appearance then return end
        
        -- Валидация данных
        if not hg.Apperance.PlayerModels[appearance.Gender] or 
           not table.HasValue(hg.Apperance.PlayerModels[appearance.Gender], appearance.Model) then
            ply:ChatPrint("Недопустимая модель!")
            return
        end
        
        ply.Appearance = appearance
        hg.ApplyAppearance(ply, appearance)
    end)
end

-- Клиентская часть
if CLIENT then
    -- Запрос внешности при загрузке
    hook.Add("InitPostEntity", "HG_RequestAppearance", function()
        net.Start("HG_RequestAppearance")
        net.SendToServer()
    end)

    -- Получение внешности от сервера
    net.Receive("HG_UpdateAppearance", function()
        local appearance = net.ReadTable()
        if not appearance then return end
        
        LocalPlayer().Appearance = appearance
    end)

    -- Сохранение внешности в файл
    function hg.SaveAppearance(appearance)
        if not file.IsDir("hg_appearance", "DATA") then
            file.CreateDir("hg_appearance")
        end
        
        file.Write("hg_appearance/" .. LocalPlayer():SteamID64() .. ".json", util.TableToJSON(appearance))
    end

    -- Загрузка внешности из файла
    function hg.LoadAppearance()
        local path = "hg_appearance/" .. LocalPlayer():SteamID64() .. ".json"
        if file.Exists(path, "DATA") then
            return util.JSONToTable(file.Read(path, "DATA"))
        end
        return nil
    end
end