local menuOpen = false
local accentColor = Color(200, 50, 50)
local textColor = Color(255, 255, 255)
local bgColor = Color(30, 30, 30, 240)

surface.CreateFont("ZOV_Title", {
    font = "HS.20",
    size = 48,
    weight = 1000,
    antialias = true
})

surface.CreateFont("ZOV_MenuItem", {
    font = "HS.20",
    size = 24,
    weight = 500,
    antialias = true
})

surface.CreateFont("ZOV_InfoText", {
    font = "HS.20",
    size = 16,
    weight = 500,
    antialias = true
})


local menuItems = {
    {text = "Продолжить", action = function() 
        menuOpen = false
        gui.EnableScreenClicker(false)
    end},
    {text = "Настройки", action = function() 
        RunConsoleCommand("hg_options")
        menuOpen = false
        gui.EnableScreenClicker(false)
    end},
    {text = "ULX Меню", action = function() 
        RunConsoleCommand("ulx", "menu")
        menuOpen = false
        gui.EnableScreenClicker(false)
    end},
    {text = "Стандартное меню", action = function()
        menuOpen = false
        gui.EnableScreenClicker(false)
        gui.ActivateGameUI()
    end},
    {text = "Отключиться", action = function() 
        RunConsoleCommand("disconnect")
    end},
}

local function DrawVerticalGradient(x, y, w, h, color1, color2)
    render.PushFilterMag(TEXFILTER.ANISOTROPIC)
    render.PushFilterMin(TEXFILTER.ANISOTROPIC)
    
    for i = 0, h do
        local ratio = i / h
        local r = Lerp(ratio, color2.r, color1.r)
        local g = Lerp(ratio, color2.g, color1.g)
        local b = Lerp(ratio, color2.b, color1.b)
        local a = Lerp(ratio, color2.a, color1.a)
        
        surface.SetDrawColor(r, g, b, a)
        surface.DrawRect(x, y + i, w, 1)
    end
    
    render.PopFilterMag()
    render.PopFilterMin()
end

local function DrawZOVMenu()
    if not menuOpen then return end
    
    local w, h = ScrW(), ScrH()
    
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
    
    local menuW, menuH = 350, 500
    local menuX, menuY = w/2 - menuW/2, h/2 - menuH/2
    
    DrawVerticalGradient(menuX, menuY, menuW, menuH, 
        Color(30, 30, 30, 240), 
        Color(50, 20, 20, 240)
    )
    
    local title = "ZOV-City"
    local titleX = menuX + menuW/2.6
    
    surface.SetTextColor(accentColor)
    surface.SetFont("ZOV_Title")
    local zovW = surface.GetTextSize("ZOV")
    surface.SetTextPos(titleX - zovW/2, menuY + 20)
    surface.DrawText("ZOV")
    
    surface.SetTextColor(textColor)
    surface.SetTextPos(titleX - zovW/2 + zovW, menuY + 20)
    surface.DrawText("-City")

    surface.SetDrawColor(accentColor.r, accentColor.g, accentColor.b, 100)
    surface.DrawLine(menuX + 20, menuY + 80, menuX + menuW - 20, menuY + 80)
    
    for i, item in ipairs(menuItems) do
        local itemY = menuY + 120 + (i-1)*70
        local hover = (gui.MouseX() > menuX and gui.MouseX() < menuX + menuW and 
                      gui.MouseY() > itemY and gui.MouseY() < itemY + 60)
        
        if hover then
            DrawVerticalGradient(menuX + 20, itemY, menuW - 40, 60, 
                Color(accentColor.r, accentColor.g, accentColor.b, 200),
                Color(accentColor.r + 30, accentColor.g + 30, accentColor.b + 30, 220)
            )
        else
            DrawVerticalGradient(menuX + 20, itemY, menuW - 40, 60, 
                Color(60, 60, 60, 180),
                Color(80, 80, 80, 200)
            )
        end
        
        draw.SimpleText(item.text, "ZOV_MenuItem", menuX + menuW/2, itemY + 30, 
                       hover and textColor or Color(200, 200, 200), 
                       TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local function ZOVMenuMousePress()
    if not menuOpen then return end
    
    local w, h = ScrW(), ScrH()
    local menuW, menuH = 400, 500
    local menuX, menuY = w/2 - menuW/2, h/2 - menuH/2
    
    for i, item in ipairs(menuItems) do
        local itemY = menuY + 120 + (i-1)*70
        
        if gui.MouseX() > menuX + 20 and gui.MouseX() < menuX + menuW - 20 and
           gui.MouseY() > itemY and gui.MouseY() < itemY + 60 then
            item.action()
            surface.PlaySound("ui/buttonclick.wav")
            return true
        end
    end
    
    return true
end

local function ToggleZOVMenu()
    menuOpen = not menuOpen
    
    if menuOpen then
        gui.SetMousePos(ScrW()/2, ScrH()/2)
        gui.EnableScreenClicker(true)
    else
        gui.EnableScreenClicker(false)
    end
    
    if gui.IsGameUIVisible() then
        gui.HideGameUI()
    end
end

local menuWasPressed = false
hook.Add("Think", "ZOVMenuThink", function()
    if input.IsKeyDown(KEY_ESCAPE) and not menuWasPressed then
        menuWasPressed = true
        ToggleZOVMenu()
    elseif not input.IsKeyDown(KEY_ESCAPE) then
        menuWasPressed = false
    end
end)

hook.Add("HUDPaint", "DrawZOVMenu", DrawZOVMenu)
hook.Add("GUIMousePressed", "ZOVMenuMousePress", ZOVMenuMousePress)

hook.Add("HUDShouldDraw", "HideDefaultMenu", function(name)
    if menuOpen and name == "CHudMenu" then
        return false
    end
end)