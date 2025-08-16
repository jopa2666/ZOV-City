hook.Add("Player Think","Gavno_Anim",function(ply)
    local mul = math.Clamp((ply:GetNWFloat("LastPickup",0) - CurTime()) / 0.2,0,1)

    if mul > 0 and ply:GetActiveWeapon() and !ply:GetActiveWeapon().ishgwep then
	    hg.bone.Set(ply,"r_forearm",Vector(0,0,0),Angle(-50 * mul,-10 * mul,0),1,0.6)
	    hg.bone.Set(ply,"r_upperarm",Vector(0,0,0),Angle(0,-70 * mul,0),1,0.5)
	    hg.bone.Set(ply,"r_clavicle",Vector(0,0,0),Angle(0,0,10 * mul),1,0.6)
    end
end)

-- я долбаеб
local redTheme = {
    background = Color(255, 0, 0, 220),
    slotActive = Color(200, 40, 40),
    slotInactive = Color(80, 0, 0),
    highlight = Color(255, 80, 80, 50),
    text = Color(255, 255, 255),
    textShadow = Color(200, 0, 0, 150)
}

local gradientMat = Material("vgui/gradient_down")
local glowMat = Material("sprites/glow04_noz")