SoundPhrases = {
    ["1"] = "vo/npc/male01/answer02.wav",
    ["2"] = "vo/npc/male01/answer03.wav",
    ["3"] = "vo/npc/male01/answer04.wav",
    ["4"] = "vo/npc/male01/answer05.wav",
    ["5"] = "vo/npc/male01/answer07.wav",
    ["6"] = "vo/npc/male01/answer08.wav",
    ["7"] = "vo/npc/male01/answer09.wav",
    ["8"] = "vo/npc/male01/answer10.wav",
    ["9"] = "vo/npc/male01/answer12.wav",
    ["10"] = "vo/npc/male01/answer16.wav",
    ["11"] = "vo/npc/male01/answer17.wav",
    ["12"] = "vo/npc/male01/answer18.wav",
    ["13"] = "vo/npc/male01/answer21.wav",
    ["14"] = "vo/npc/male01/answer22.wav",
    ["15"] = "vo/npc/male01/answer24.wav",
    ["16"] = "vo/npc/male01/answer26.wav",
    ["17"] = "vo/npc/male01/answer30.wav",
    ["18"] = "vo/npc/male01/answer32.wav",
    ["19"] = "vo/npc/male01/answer33.wav",
    ["20"] = "vo/npc/male01/answer36.wav",
    ["21"] = "vo/npc/male01/answer38.wav",
    ["22"] = "vo/npc/male01/answer40.wav",
    ["23"] = "vo/npc/male01/cit_dropper01.wav",
    ["24"] = "vo/npc/male01/doingsomething.wav",
    ["25"] = "vo/npc/male01/evenodds.wav",
    ["26"] = "vo/npc/male01/excuseme01.wav",
    ["27"] = "vo/npc/male01/fantastic01.wav",
    ["28"] = "vo/npc/male01/getdown02.wav",
    ["29"] = "vo/npc/male01/gethellout.wav",
    ["30"] = "vo/npc/male01/gordead_ans02.wav",
    ["31"] = "vo/npc/male01/gordead_ans03.wav",
    ["32"] = "vo/npc/male01/gordead_ans05.wav",
    ["33"] = "vo/npc/male01/gordead_ans10.wav",
    ["34"] = "vo/npc/male01/gordead_ans11.wav",
    ["35"] = "vo/npc/male01/gordead_ans12.wav",
    ["36"] = "vo/npc/male01/gordead_ans13.wav",
    ["37"] = "vo/npc/male01/gordead_ques11.wav",
    ["38"] = "vo/npc/male01/headcrabs01.wav",
    ["39"] = "vo/npc/male01/headsup02.wav",
    ["40"] = "vo/npc/male01/help01.wav",
    ["41"] = "vo/npc/male01/heydoc01.wav",
    ["42"] = "vo/npc/male01/letsgo01.wav",
    ["43"] = "vo/npc/male01/no02.wav",
    ["44"] = "vo/npc/male01/ok02.wav",
    ["45"] = "vo/npc/male01/overthere02.wav",
    ["46"] = "vo/npc/male01/overhere01.wav",
}

if SERVER then
    util.AddNetworkString("PlaySoundPhrase")

    util.AddNetworkString("UpdatePhraseCount")
    
    hook.Add("PlayerInitialSpawn", "SendPhraseCount", function(ply)
        net.Start("UpdatePhraseCount")
        net.WriteUInt(#SoundPhrases, 8)
        net.Send(ply)
    end)
    
    for _, sound in pairs(SoundPhrases) do
        util.PrecacheSound(sound)
    end

    concommand.Add("hg_playphrase", function(ply, cmd, args)
        if not ply:Alive() then return end
        
        if #args < 1 then
            ply:ChatPrint("Использование: hg_playphrase <номер фразы 1-"..#SoundPhrases..">")
            return
        end
        
        local phraseNum = tonumber(args[1])
        local soundPath = SoundPhrases[tostring(phraseNum)]
        
        if not soundPath then
            ply:ChatPrint("Неверный номер фразы! Допустимо 1-"..#SoundPhrases)
            return
        end
        
        if not file.Exists("sound/"..soundPath, "GAME") then
            ply:ChatPrint("Ошибка: звуковой файл не найден!")
            return
        end
        
        if ply.NextPhraseTime and ply.NextPhraseTime > CurTime() then
            ply:ChatPrint("Подождите "..math.ceil(ply.NextPhraseTime - CurTime()).." секунду перед следующим использованием!")
            return
        end
        
        ply.NextPhraseTime = CurTime() + 1
        
        net.Start("PlaySoundPhrase")
            net.WriteEntity(ply)
            net.WriteString(soundPath)
        net.Broadcast()
    end)
end

if CLIENT then
    net.Receive("PlaySoundPhrase", function()
        local ply = net.ReadEntity()
        local soundPath = net.ReadString()
        
        if IsValid(ply) and soundPath then
            ply:EmitSound(soundPath)
        end
    end)
end