
/*local attachments = {
    ["holo1"] = "Holo Sight 1",
    ["holo2"] = "Holo Sight 2",
    ["holo3"] = "Holo Sight 3",
    ["optic1"] = "Optical Sight 1",
    ["optic2"] = "Optical Sight 2",
    ["supp1"] = "Suppressor 1",
    ["supp2"] = "Suppressor 2",
    ["grip1"] = "Foregrip"
}

local function IsAttachmentCategory(att, category)
    return att:StartWith(category)
end

local function OpenAttachmentMenu()
    if IsValid(AttachmentMenu) then
        AttachmentMenu:Remove()
        return
    end

    AttachmentMenu = vgui.Create("DFrame")
    AttachmentMenu:SetSize(350, 500)
    AttachmentMenu:Center()
    AttachmentMenu:SetTitle("Меню обвесов")
    AttachmentMenu:SetDraggable(false)
    AttachmentMenu:ShowCloseButton(true)
    AttachmentMenu:MakePopup()
    
    AttachmentMenu.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(10, 10, 10, 240))
        surface.SetDrawColor(150, 0, 0, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.DrawOutlinedRect(1, 1, w-2, h-2)
    end

    local scroll = vgui.Create("DScrollPanel", AttachmentMenu)
    scroll:Dock(FILL)
    scroll:DockMargin(5, 5, 5, 5)

    local categories = {
        {"Прицелы", {"holo1", "holo2", "holo3", "optic1", "optic2"}},
        {"ДТК и глушители", {"supp1", "supp2"}},
        {"Рукоятки", {"grip1"}}
    }

    for _, catData in ipairs(categories) do
        local catName, catAttachments = unpack(catData)
        
        local category = scroll:Add("DCollapsibleCategory")
        category:SetLabel(catName)
        category:Dock(TOP)
        category:DockMargin(0, 0, 0, 5)
        
        category.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(20, 20, 20, 220))
            surface.SetDrawColor(120, 0, 0, 200)
            surface.DrawOutlinedRect(0, 0, w, h)
        end
        
        local content = vgui.Create("DPanelList", category)
        content:SetAutoSize(true)
        content:SetSpacing(3)
        content:SetPadding(3)
        category:SetContents(content)
        
        for _, att in ipairs(catAttachments) do
            local btn = vgui.Create("DButton")
            btn:SetText(attachments[att])
            btn:SetTall(30)
            btn:DockMargin(0, 0, 0, 3)
            
            btn.Paint = function(self, w, h)
                if self:IsHovered() then
                    draw.RoundedBox(4, 0, 0, w, h, Color(50, 0, 0, 220))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(30, 30, 30, 220))
                end
                surface.SetDrawColor(120, 0, 0, 180)
                surface.DrawOutlinedRect(0, 0, w, h)
            end
            
            btn.DoClick = function()
                local categoryPrefix = att:sub(1, 4)
                
                for existingAtt, _ in pairs(attachments) do
                    if IsAttachmentCategory(existingAtt, categoryPrefix) then
                        RunConsoleCommand("dettach", existingAtt)
                    end
                end
                
                if not att:StartWith("none") then
                    RunConsoleCommand("attach", att)
                end
                
                AttachmentMenu:Remove()
            end
            
            content:AddItem(btn)
        end
    end
end

concommand.Add("hg_attachment_menu", OpenAttachmentMenu)