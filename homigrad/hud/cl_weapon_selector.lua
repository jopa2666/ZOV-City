-- АААА ХУЕСОСЫ ОТСТАНЬТЕ
hg = hg or {}
hg.CustomHotbar = hg.CustomHotbar or {}
local CH = hg.CustomHotbar

CH.ShowTime = 2
CH.SlotCount = 6
CH.ActiveColor = Color(185, 50, 50)
CH.InactiveColor = Color(150, 0, 0)
CH.BackgroundColor = Color(125, 0, 0, 200)

CH.GradientMaterials = {
    up = Material("vgui/gradient-u"),
    down = Material("vgui/gradient-d"),
    right = Material("vgui/gradient-r"),
    left = Material("vgui/gradient-l")
}

CH.Position = {
    x = 0.5,
    y = 0.85,
    offsetX = 0,
    offsetY = 0
}

CH.Size = {
    width = 385,
    slotWidth = 60,
    height = 25,
    padding = 5
}

CH.ActiveSlot = 1
CH.LastActiveSlot = 1
CH.SlotWeapons = {}
CH.SlotIndexes = {}
for i = 1, CH.SlotCount do
    CH.SlotWeapons[i] = {}
    CH.SlotIndexes[i] = 1
end
CH.ShowUntil = 0
CH.Alpha = 0

function CH.GetWeaponPrintName(wep)
    if not IsValid(wep) then return "ЭТА ЧТО БРУХХ???" end
    
    local class = wep:GetClass()
    local localizedName = language.GetPhrase(class)
    
    if localizedName == class then
        return wep:GetPrintName() or class
    else
        return localizedName
    end
end


function CH.UpdateSlotWeapons(ply)
    if not IsValid(ply) then return end
    
    for i = 1, CH.SlotCount do
        CH.SlotWeapons[i] = {}
    end
    
    for _, wep in ipairs(ply:GetWeapons()) do
        local slot = (wep.Slot or 0) + 1
        if slot >= 1 and slot <= CH.SlotCount then
            table.insert(CH.SlotWeapons[slot], wep)
        end
    end
end


function CH.DrawHotbar()
    local ply = LocalPlayer()
    if not IsValid(ply) or not ply:Alive() then return end
    
    CH.UpdateSlotWeapons(ply)
    
    CH.Alpha = Lerp(FrameTime() * 5, CH.Alpha, CH.ShowUntil > CurTime() and 1 or 0)
    if CH.Alpha < 0.01 then return end
    
    
    local scrW, scrH = ScrW(), ScrH()
    local posX = scrW * CH.Position.x + CH.Position.offsetX - CH.Size.width/2
    local posY = scrH * CH.Position.y + CH.Position.offsetY
    local weaponNameY = posY - 20
    
    surface.SetDrawColor(ColorAlpha(CH.BackgroundColor, CH.Alpha * 255))
    surface.SetMaterial(CH.GradientMaterials.down)
    surface.DrawTexturedRect(posX, posY, CH.Size.width, CH.Size.height)

    surface.SetDrawColor(ColorAlpha(color_black, CH.Alpha * 100))
    surface.DrawOutlinedRect(posX, posY, CH.Size.width, CH.Size.height, 1)
    
    for i = 1, CH.SlotCount do
        local x = posX + (i-1) * (CH.Size.slotWidth + CH.Size.padding)
        local color = (i == CH.ActiveSlot) and CH.ActiveColor or CH.InactiveColor
        
        surface.SetDrawColor(ColorAlpha(color, CH.Alpha * 200))
        surface.SetMaterial(CH.GradientMaterials.down)
        surface.DrawTexturedRect(x, posY, CH.Size.slotWidth, CH.Size.height)
        
        surface.SetDrawColor(ColorAlpha(color_black, CH.Alpha * 150))
        surface.DrawOutlinedRect(x, posY, CH.Size.slotWidth, CH.Size.height, 1)
        
        if i == CH.ActiveSlot then
            surface.SetDrawColor(ColorAlpha(Color(255, 100, 100), CH.Alpha * 80))
            surface.SetMaterial(CH.GradientMaterials.up)
            surface.DrawTexturedRect(x, posY, CH.Size.slotWidth, CH.Size.height)
        end
        
        draw.SimpleText(
            i, 
            "HS.20", 
            x + CH.Size.slotWidth/2, 
            posY + CH.Size.height/2, 
            ColorAlpha(color_white, CH.Alpha * 255), 
            TEXT_ALIGN_CENTER, 
            TEXT_ALIGN_CENTER
        )
        
        if i == CH.ActiveSlot and #CH.SlotWeapons[i] > 0 then
            local currentIndex = CH.SlotIndexes[i] or 1
            local currentWeapon = CH.SlotWeapons[i][currentIndex]
            
            if currentWeapon then
                surface.SetDrawColor(ColorAlpha(Color(100, 0, 0), CH.Alpha * 150))
                surface.SetMaterial(CH.GradientMaterials.down)
                surface.DrawTexturedRect(posX + CH.Size.width/2 - 100, weaponNameY - 5, 200, 20)

                if #CH.SlotWeapons[i] > 0 then
                    draw.SimpleText(
                        #CH.SlotWeapons[i],
                        "HS.14", 
                        x + CH.Size.slotWidth - 8, 
                        posY + 4, 
                        ColorAlpha(color_white, CH.Alpha * 255), 
                        TEXT_ALIGN_RIGHT
                    )
                end
                
                draw.SimpleText(
                    currentWeapon:GetPrintName(), 
                    "HS.20", 
                    posX + CH.Size.width/2, 
                    weaponNameY, 
                    ColorAlpha(color_white, CH.Alpha * 255), 
                    TEXT_ALIGN_CENTER
                )
            end
        end
    end
end

function CH.GetSlotWeapons(ply, slot)
    if not CH.SlotWeapons[slot] then
        CH.SlotWeapons[slot] = {}
        for _, wep in ipairs(ply:GetWeapons()) do
            if IsValid(wep) and (wep.Slot or 0) == (slot - 1) then
                table.insert(CH.SlotWeapons[slot], wep)
                if #CH.SlotWeapons[slot] >= CH.MaxWeaponsPerSlot then
                    break
                end
            end
        end
    else

        for i = #CH.SlotWeapons[slot], 1, -1 do
            if not IsValid(CH.SlotWeapons[slot][i]) then
                table.remove(CH.SlotWeapons[slot], i)
            end
        end
    end
    return CH.SlotWeapons[slot]
end

hook.Add("HUDPaint", "CustomHotbar_Draw", CH.DrawHotbar)

hook.Add("PlayerBindPress", "CustomHotbar_BindPress", function(ply, bind)
    if string.match(bind, "slot%d") then
        CH.SelectWeapon(ply, bind)
    end

    function CH.SelectWeapon(ply, key)
        if not IsValid(ply) or not ply:Alive() then return end
        
        local slot = tonumber(string.match(key, "slot(%d)"))
        if slot and slot >= 1 and slot <= CH.SlotCount then
            CH.LastActiveSlot = CH.ActiveSlot
            CH.ActiveSlot = slot
            CH.ShowUntil = CurTime() + CH.ShowTime
            
            local weapons = CH.GetSlotWeapons(ply, slot)
            if #weapons > 0 then
                CH.SlotIndexes[slot] = (CH.SlotIndexes[slot] % #weapons) + 1
                local selectedWeapon = weapons[CH.SlotIndexes[slot]]
                
                if IsValid(selectedWeapon) then
                    input.SelectWeapon(selectedWeapon)
                    surface.PlaySound("snds_jack_gmod/armorstep"..math.random(1,3)..".ogg")
                end
            end
        end
    end
end)

hook.Add("HUDShouldDraw", "HideDefaultWeaponSelection", function(name)
    if name == "CHudWeaponSelection" then return false end
end)

-- ПОМГИТЕ ПОЖАЛУСТА МЕН ДЕРЖТ В ЗАЛОЖНИКА
-- ПМОГИТ
-- ПРОШК УК МНЯ БЕУТ
-- ДИДЛ В ЖУПО ПХИАЮТ