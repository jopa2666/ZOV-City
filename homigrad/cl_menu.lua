local modes = {}
modes.slider = function(optiondata, panel)
    local sliderPanel = vgui.Create("DPanel", panel)
    sliderPanel:Dock(TOP)
    sliderPanel:DockMargin(10, 5, 10, 5)
    sliderPanel:SetTall(50)
    sliderPanel.Paint = function(self, w, h)
        surface.SetDrawColor(30, 30, 30, 200)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(50, 0, 0, 80)
        surface.DrawRect(0, 0, w, h/2)
        
        surface.SetDrawColor(150, 0, 0, 50)
        surface.DrawOutlinedRect(0, 0, w, h, 1)
    end

    local label = vgui.Create("DLabel", sliderPanel)
    label:Dock(TOP)
    label:DockMargin(5, 3, 5, 0)
    label:SetText(optiondata.desc)
    label:SetFont("ZOV_OptionText")
    label:SetTextColor(Color(255, 255, 255))
    label:SizeToContents()

    local slider = vgui.Create("DNumSlider", sliderPanel)
    slider:Dock(FILL)
    slider:DockMargin(10, 0, 10, 3)
    slider:SetMin(optiondata.min)
    slider:SetMax(optiondata.max)
    slider:SetDecimals(optiondata.decimals or 0)
    slider:SetConVar(optiondata.convar)
    slider:SetText("")
    slider.Slider.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, h/2-2, w, 4, Color(50, 50, 50))
        draw.RoundedBox(4, 0, h/2-2, w*self:GetSlideX(), 4, Color(80, 0, 0))
    end
    slider.Slider.Knob.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(200, 0, 0))
    end
    slider.TextArea.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(40, 40, 40))
        self:DrawTextEntryText(Color(255, 255, 255), Color(200, 0, 0), Color(255, 255, 255))
    end
end

modes.switcher = function(optiondata, panel)
    local switchPanel = vgui.Create("DPanel", panel)
    switchPanel:Dock(TOP)
    switchPanel:DockMargin(10, 5, 10, 5)
    switchPanel:SetTall(40)
    switchPanel.Paint = function(self, w, h)
        surface.SetDrawColor(30, 30, 30, 200)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(50, 0, 0, 80)
        surface.DrawRect(0, 0, w, h/2)
        
        surface.SetDrawColor(150, 0, 0, 50)
        surface.DrawOutlinedRect(0, 0, w, h, 1)
    end

    local checkbox = vgui.Create("DCheckBox", switchPanel)
    checkbox:Dock(LEFT)
    checkbox:DockMargin(10, 10, 5, 10)
    checkbox:SetSize(20, 20)
    checkbox:SetConVar(optiondata.convar)
    checkbox.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(80, 40, 40))
        surface.SetDrawColor(255, 0, 0, 100)
        surface.DrawOutlinedRect(0, 0, w, h, 1)
        
        if self:GetChecked() then
            draw.RoundedBox(2, 2, 2, w-4, h-4, Color(200, 0, 0))
        end
    end

    local label = vgui.Create("DLabel", switchPanel)
    label:Dock(FILL)
    label:DockMargin(5, 0, 5, 0)
    label:SetText(optiondata.desc)
    label:SetFont("ZOV_OptionText")
    label:SetTextColor(Color(255, 255, 255))
    label:SizeToContents()
end

surface.CreateFont("ZOV_OptionTitle", {
    font = "Roboto",
    size = 24,
    weight = 800,
    antialias = true
})

surface.CreateFont("ZOV_OptionText", {
    font = "Roboto",
    size = 16,
    weight = 500,
    antialias = true
})

local options = {}
function hg.AddOptionPanel(convarname, mode, optiondata, category)
    optiondata = optiondata or {}
    category = category or "other"
    optiondata.convar = convarname
    options[category] = options[category] or {}
    options[category][convarname] = {mode, optiondata}
end

hg.AddOptionPanel("hg_optimization", "switcher", {desc = "Включите если у вас слабый ПК (Не отрисовывает объекты не в поле зрения)"}, "optimization")
hg.AddOptionPanel("hg_fov", "slider", {desc = "Изменяет FOV", min = 70, max = 100}, "other")
hg.AddOptionPanel("r_shadows", "switcher", {desc = "Вкл/Выкл тени (Не будет работать фонарик)"}, "optimization")
hg.AddOptionPanel("mat_specular", "switcher", {desc = "Вкл/Выкл отражения"}, "optimization")
hg.AddOptionPanel("mat_queue_mode", "slider", {desc = "Многоядерная обработка графики", min = 0, max = 3}, "optimization") -- Исправлены min/max
hg.AddOptionPanel("hg_nofovzoom", "switcher", {desc = "Вкл/Выкл увеличения FOV в прицеле"}, "other")
hg.AddOptionPanel("hg_smooth_cam", "switcher", {desc = "Вкл/Выкл уменьшение чуствительности в прицеле (Функция хуйня!)"}, "other")

local function CreateOptionsMenu()
    local menuW, menuH = 550, 600
    local menuX, menuY = ScrW()/2 - menuW/2, ScrH()/2 - menuH/2

    local MainFrame = vgui.Create("DFrame")
    MainFrame:SetPos(menuX, menuY)
    MainFrame:SetSize(menuW, menuH)
    MainFrame:SetTitle("")
    MainFrame:SetDraggable(false)
    MainFrame:ShowCloseButton(false)
    MainFrame:MakePopup()
    
    function MainFrame:Paint(w, h)
        surface.SetDrawColor(20, 20, 20, 240)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(40, 0, 0, 80)
        surface.DrawRect(0, 0, w, h/2)
        
        surface.SetDrawColor(185, 0, 0, 80)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
        surface.SetDrawColor(200, 0, 0, 30)
        surface.DrawOutlinedRect(2, 2, w-4, h-4, 1)

        draw.SimpleText("ZOV-City | Настройки", "ZOV_OptionTitle", w/2, 20, Color(255, 255, 255), TEXT_ALIGN_CENTER)
        
        surface.SetDrawColor(200, 0, 0, 80)
        surface.DrawLine(20, 55, w-20, 55)
        surface.SetDrawColor(200, 0, 0, 30)
        surface.DrawLine(20, 56, w-20, 56)
    end

    local closeBtn = vgui.Create("DButton", MainFrame)
    closeBtn:SetSize(80, 25)
    closeBtn:SetPos(menuW - 90, 15)
    closeBtn:SetText("Закрыть")
    closeBtn:SetFont("ZOV_OptionText")
    closeBtn:SetTextColor(Color(255, 255, 255))
    closeBtn.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, self:IsHovered() and Color(200, 0, 0, 200) or Color(60, 60, 60, 200))
    end
    closeBtn.DoClick = function()
        MainFrame:Close()
    end

    local DScrollPanel = vgui.Create("DScrollPanel", MainFrame)
    DScrollPanel:SetPos(15, 60)
    DScrollPanel:SetSize(menuW - 30, menuH - 75)
    
    local optLabel = vgui.Create("DLabel", DScrollPanel)
    optLabel:Dock(TOP)
    optLabel:DockMargin(0, 5, 0, 5)
    optLabel:SetText("Оптимизация")
    optLabel:SetFont("ZOV_OptionTitle")
    optLabel:SetTextColor(Color(200, 0, 0))
    optLabel:SizeToContents()

    for k,v in pairs(options["optimization"]) do
        modes[v[1]](v[2], DScrollPanel)
    end

    local otherLabel = vgui.Create("DLabel", DScrollPanel)
    otherLabel:Dock(TOP)
    otherLabel:DockMargin(0, 15, 0, 5)
    otherLabel:SetText("Прочее")
    otherLabel:SetFont("ZOV_OptionTitle")
    otherLabel:SetTextColor(Color(200, 0, 0))
    otherLabel:SizeToContents()

    for k,v in pairs(options["other"]) do
        modes[v[1]](v[2], DScrollPanel)
    end
end

concommand.Add("hg_options", function()
    CreateOptionsMenu()
end)