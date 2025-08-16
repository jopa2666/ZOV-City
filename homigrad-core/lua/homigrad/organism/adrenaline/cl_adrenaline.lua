local is_bright = (ConVarExists("hg_adrenaline_bright") and GetConVar("hg_adrenaline_bright") or CreateClientConVar("hg_adrenaline_bright","1",true,false,"disable shit flashbang",0,1))
local sonarMaterial = Material("overlays/sonarimpact3.png")

hook.Add("EffectRender", "Adrenaline_FX", function()
    local ply = LocalPlayer()
    if not ply:Alive() then return end

    local adr = ply:GetNWFloat("adrenaline")
    if adr <= 0 then return end

    -- Стандартные эффекты
    DrawSharpen(adr, 1)
    
    if is_bright:GetBool() then
        DrawBloom(0, adr * 0.25, 0, 0, 2, 4, 1, 1, 1)
    end

    -- Новый эффект с текстурой sonarimpact
    if sonarMaterial and not sonarMaterial:IsError() then
        local alpha = math.Clamp(adr * 255, 0, 150) -- Максимальная прозрачность 150
        surface.SetMaterial(sonarMaterial)
        surface.SetDrawColor(255, 255, 255, alpha)
        
        -- Полноэкранное наложение
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        
        -- Дополнительные эффекты пульсации
        local pulse = math.sin(RealTime() * 3) * 0.1 + 0.9
        surface.SetDrawColor(255, 255, 255, alpha * 0.5 * pulse)
        surface.DrawTexturedRectUV(0, 0, ScrW(), ScrH(), 0, 0, 1, 1)
    else
        print("[ADRENALINE] Failed to load sonarimpact material!")
    end
end)

-- Оптимизация: предзагрузка материала
hook.Add("InitPostEntity", "PrecacheAdrenalineMaterials", function()
    sonarMaterial = Material("overlays/sonarimpact3.png")
end)