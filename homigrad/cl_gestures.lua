local Gestures = {
    "act", "halt",
    "act", "bow",
    "act", "becon",
    "act", "agree",
    "act", "disagree",
    "act", "forward",
    "act", "group"
}

local function PlayRandomGesture()
    if not LocalPlayer():Alive() then return end
    
    local randomAnim = Gestures[math.random(#Gestures)]
    
    LocalPlayer():ConCommand("act "..randomAnim)
    

    timer.Create("GestureCooldown", 1, 1, function() end)
end


concommand.Add("hg_gesture", function()
    if not timer.Exists("GestureCooldown") then
        PlayRandomGesture()
    else
        LocalPlayer():ChatPrint("Жесты можно использовать раз в 1 секунду!")
    end
end)

hook.Add("Initialize", "GestureInit", function()
    timer.Simple(5, function()
        if LocalPlayer() then
            LocalPlayer():ChatPrint("")
        end
    end)
end)