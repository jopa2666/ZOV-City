if CLIENT then
    util.AddNetworkString("PlayerGotShotText")

    local HealthMessages = {
        { min = 76, texts = { "\"АЙ!\"", "\"СУКА!\"", "\"БЛЯТЬ!\"" }, color = Color(255, 255, 255), maxTypingSpeed = 0.03, maxShake = 1 },
        { min = 41, texts = { "\"АЙ! СУКА!\"", "\"БЛЯТЬ! Я РАНЕН!\"" }, color = Color(255, 196, 196), maxTypingSpeed = 0.06, maxShake = 2 },
        { min = 21, texts = { "\"ААА!\"", "\"АЙ БЛЯТЬ! КАК ЖЕ БОЛНО!\"", "\"АААЙ! СУКА!\"" }, color = Color(237, 140, 140), maxTypingSpeed = 0.1, maxShake = 4 },
        { min = 1,  texts = { "\"БЛЯЯЯТЬ!\"", "\"ААЙ! БЛЯТЬ БОЖЕ СПАСИ МЕНЯ!\"", "\"ААААА! БЛЯТЬ!\"" }, color = Color(255, 77, 77), maxTypingSpeed = 0.15, maxShake = 6 },
        { min = 0,  texts = { "\"АА-\"", "\"СУ-\"", "\"БЛ-\"" }, color = Color(255, 0, 0), maxTypingSpeed = 0.03, maxShake = 0 }
    }

    local damageOverlay = Material("overlays/brainhemorrhageoverlay.png", "smooth unlitgeneric")
    local damageOverlayAlpha = 0
    local damageOverlayFadeTime = 0
    local damageOverlayDuration = 1.5

    local lastHealth = nil
    local justSpawned = true
    local displayText = ""
    local displayColor = Color(255, 255, 255)
    local charIndex = 0
    local typingTimer = 0
    local displayTimer = 0
    local displayDuration = 3
    local fadeDuration = 1.5
    local isTyping = false
    local isFading = false
    local alpha = 255
    local maxTypingSpeed = 0.05
    local maxShake = 0 

    local function ShowDamageOverlay()
        damageOverlayAlpha = 255
        damageOverlayFadeTime = CurTime() + damageOverlayDuration
    end

    local function getHealthData(health)
        for _, data in ipairs(HealthMessages) do
            if health >= data.min then
                return data
            end
        end
        return HealthMessages[#HealthMessages]
    end

    local function startTyping(text, color, typingSpeed, shakeAmount)
        displayText = text
        displayColor = color
        charIndex = 0
        typingTimer = 0
        displayTimer = 0
        isTyping = true
        isFading = false
        alpha = 255
        maxTypingSpeed = typingSpeed or 0.05
        maxShake = shakeAmount or 0
    end

    local shotDisplayText = ""
    local shotDisplayColor = Color(255, 0, 0)
    local shotCharIndex = 0
    local shotTypingTimer = 0
    local shotDisplayTimer = 0
    local shotDisplayDuration = 2
    local shotFadeDuration = 1
    local shotIsTyping = false
    local shotIsFading = false
    local shotAlpha = 255
    local shotMaxTypingSpeed = 0.04
    local shotMaxShake = 3

    local shotMessages = {
        "БЛЯТЬ! ЧУСТВУЮ СИЛЬНУЮ БОЛЬ В ТЕЛЕ!",
        "СУКА! МЕНЯ ПОДСТРЕЛИЛИ!",
        "СУКА! МЕНЯ ПОДСТРЕЛИЛИ! КАК ЖЕ БОЛЬНО СУКА!",
        "АЙ! БЛЯТЬ!",
        "АЙ! СУКА!"
    }

    local function startShotTyping(text, color, typingSpeed, shakeAmount)
        shotDisplayText = text
        shotDisplayColor = color
        shotCharIndex = 0
        shotTypingTimer = 0
        shotDisplayTimer = 0
        shotIsTyping = true
        shotIsFading = false
        shotAlpha = 255
        shotMaxTypingSpeed = typingSpeed or 0.04
        shotMaxShake = shakeAmount or 3
    end

    net.Receive("PlayerGotShotText", function()
        local msg = table.Random(shotMessages)
        startShotTyping(msg, shotDisplayColor, shotMaxTypingSpeed, shotMaxShake)
        ShowDamageOverlay()
    end)

    hook.Add("HUDPaint", "HealthAndShotMessageTypingEffect", function()
        local dt = FrameTime()

        if damageOverlayAlpha > 0 then
            if CurTime() > damageOverlayFadeTime then
                damageOverlayAlpha = math.max(0, damageOverlayAlpha - (dt * 255))
            end
            
            render.SetMaterial(damageOverlay)
            render.DrawScreenQuadEx(0, 0, ScrW(), ScrH(), Color(255, 255, 255, damageOverlayAlpha))
        end

        if displayText ~= "" then
            if isTyping then
                typingTimer = typingTimer + dt
                if typingTimer >= maxTypingSpeed then
                    typingTimer = typingTimer - maxTypingSpeed
                    charIndex = charIndex + 1
                    if charIndex > #displayText then
                        charIndex = #displayText
                        isTyping = false
                        displayTimer = 0
                    end
                end
            elseif displayTimer < displayDuration then
                displayTimer = displayTimer + dt
                if displayTimer >= displayDuration then
                    isFading = true
                    fadeTimer = 0
                end
            elseif isFading then
                fadeTimer = (fadeTimer or 0) + dt
                alpha = math.Clamp(255 * (1 - fadeTimer / fadeDuration), 0, 255)
                if alpha <= 0 then
                    isFading = false
                    displayText = ""
                end
            end

            local textToDraw = string.sub(displayText, 1, charIndex)
            surface.SetFont("Trebuchet24")
            local w, h = surface.GetTextSize(textToDraw)
            local baseX = (ScrW() - w) / 2
            local baseY = ScrH() - h - 50

            local shakeX, shakeY = 0, 0
            if maxShake > 0 then
                local time = CurTime() * 10
                shakeX = math.sin(time * 3) * maxShake * 0.5 + math.sin(time * 7) * maxShake * 0.5
                shakeY = math.cos(time * 5) * maxShake * 0.5 + math.cos(time * 11) * maxShake * 0.5
                shakeX = math.Clamp(shakeX, -maxShake, maxShake)
                shakeY = math.Clamp(shakeY, -maxShake, maxShake)
            end

            local outlineColor = Color(0, 0, 0, alpha)
            local x, y = baseX + shakeX, baseY + shakeY

            for dx = -1, 1 do
                for dy = -1, 1 do
                    if dx ~= 0 or dy ~= 0 then
                        draw.SimpleText(textToDraw, "Trebuchet24", x + dx, y + dy, outlineColor)
                    end
                end
            end
            local col = Color(displayColor.r, displayColor.g, displayColor.b, alpha)
            draw.SimpleText(textToDraw, "Trebuchet24", x, y, col)
        end


        if shotDisplayText ~= "" then
            if shotIsTyping then
                shotTypingTimer = shotTypingTimer + dt
                if shotTypingTimer >= shotMaxTypingSpeed then
                    shotTypingTimer = shotTypingTimer - shotMaxTypingSpeed
                    shotCharIndex = shotCharIndex + 1
                    if shotCharIndex > #shotDisplayText then
                        shotCharIndex = #shotDisplayText
                        shotIsTyping = false
                        shotDisplayTimer = 0
                    end
                end
            elseif shotDisplayTimer < shotDisplayDuration then
                shotDisplayTimer = shotDisplayTimer + dt
                if shotDisplayTimer >= shotDisplayDuration then
                    shotIsFading = true
                    shotFadeTimer = 0
                end
            elseif shotIsFading then
                shotFadeTimer = (shotFadeTimer or 0) + dt
                shotAlpha = math.Clamp(255 * (1 - shotFadeTimer / shotFadeDuration), 0, 255)
                if shotAlpha <= 0 then
                    shotIsFading = false
                    shotDisplayText = ""
                end
            end

            local textToDraw = string.sub(shotDisplayText, 1, shotCharIndex)
            surface.SetFont("Trebuchet24")
            local w, h = surface.GetTextSize(textToDraw)
            local baseX = (ScrW() - w) / 2
            local baseY = ScrH() - h - 100 

            local shakeX, shakeY = 0, 0
            if shotMaxShake > 0 then
                local time = CurTime() * 10
                shakeX = math.sin(time * 3) * shotMaxShake * 0.5 + math.sin(time * 7) * shotMaxShake * 0.5
                shakeY = math.cos(time * 5) * shotMaxShake * 0.5 + math.cos(time * 11) * shotMaxShake * 0.5
                shakeX = math.Clamp(shakeX, -shotMaxShake, shotMaxShake)
                shakeY = math.Clamp(shakeY, -shotMaxShake, shotMaxShake)
            end

            local outlineColor = Color(0, 0, 0, shotAlpha)
            local x, y = baseX + shakeX, baseY + shakeY

            for dx = -1, 1 do
                for dy = -1, 1 do
                    if dx ~= 0 or dy ~= 0 then
                        draw.SimpleText(textToDraw, "Trebuchet24", x + dx, y + dy, outlineColor)
                    end
                end
            end

            local col = Color(shotDisplayColor.r, shotDisplayColor.g, shotDisplayColor.b, shotAlpha)
            draw.SimpleText(textToDraw, "Trebuchet24", x, y, col)
        end
    end)


    hook.Add("Think", "CheckHealthChange", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
        local health = ply:Health()
        if justSpawned then
            lastHealth = health
            justSpawned = false
            return
        end
        if lastHealth and health < lastHealth then
            local data = getHealthData(health)
            local msg = table.Random(data.texts)
            startTyping(msg, data.color, data.maxTypingSpeed, data.maxShake)
        end
        lastHealth = health
    end)

    hook.Add("PlayerSpawn", "ResetHealthMessageFlag", function(ply)
        if ply == LocalPlayer() then
            justSpawned = true
            lastHealth = nil
            displayText = ""
            isTyping = false
            isFading = false
        end
    end)
end

if SERVER then
    util.AddNetworkString("PlayerGotShotText")

    hook.Add("EntityTakeDamage", "NotifyPlayerGotShotText", function(target, dmginfo)
        if not target:IsPlayer() then return end

        local attacker = dmginfo:GetAttacker()
        if not IsValid(attacker) then return end

        if attacker:IsPlayer() or attacker:IsNPC() then
            net.Start("PlayerGotShotText")
            net.Send(target)
        end
    end)
end