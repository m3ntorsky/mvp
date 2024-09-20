local playerCommands = {
    show = function(playerid, args, argc, silent)
        GenerateMenu(playerid)
    end,

    volume = function(playerid, args, argc, silent)
        if argc == 1 and args[1] == "volume" then
            GenerateVolumeMenu(playerid)
            return
        end
        local volumeToSet = tonumber(args[2])
        if argc == 2 and volumeToSet then
            local player = GetPlayer(playerid)
            if not player or not player:IsValid() then return end
            local volumes = config:Fetch("mvp.volume")
            for i = 1, #volumes do
                if volumeToSet == volumes[i] then
                    exports["cookies"]:SetPlayerCookie(playerid, "mvp.volume", volumeToSet)
                    ReplyToCommand(playerid, tostring(config:Fetch("mvp.prefix")),
                        FetchTranslation("mvp.volume_set", playerid):gsub("{VOLUME}", volumeToSet))
                    GenerateMenu(playerid)
                    break
                end
            end
        end
    end,

    kitslist = function(playerid, args, argc, silent)
        GenerateKitListMenu(playerid)
    end,
    kit_preview = function(playerid, args, argc, silent)
        local kitName = args[2]
        if argc ~= 3 and not kitName and not MusicKitsIndex[kitName] then return end
        GenerateKitPreviewMenu(playerid, kitName)
    end,

    set = function(playerid, args, argc, silent)
        local kitName = args[2]
        local kit = MusicKits[MusicKitsIndex[kitName]]
        if argc ~= 2 and not kitName and not kit then return end
        local player = GetPlayer(playerid)
        if not player or not player:IsValid() then return end
        exports["cookies"]:SetPlayerCookie(playerid, "mvp.kit", kitName)
        ReplyToCommand(playerid, tostring(config:Fetch("mvp.prefix")),
            FetchTranslation("mvp.kit_set", playerid):gsub("{KIT_DISPLAY}", kit.display))
        GenerateMenu(playerid)
    end,

    play = function(playerid, args, argc, silent)
        local kitName = args[2]
        local kit = MusicKits[MusicKitsIndex[kitName]]
        if argc ~= 2 and kitName ~= "default" and not kit then return end
        local player = GetPlayer(playerid)
        if not player or not player:IsValid() then return end
        CBaseEntity(player:CCSPlayerController():ToPtr()):EmitSound("StopSoundEvents.StopAllMusic", 100, 1.0)
        NextTick(function()
            local volume = tonumber(exports["cookies"]:GetPlayerCookie(playerid, "mvp.volume"))
            if volume and volume > 0 then
                CBaseEntity(player:CCSPlayerController():ToPtr()):EmitSound(kit.event, 100, volume)
            end
        end)
    end
}


commands:Register("mvp", function(playerid, args, argc, silent, prefix)
    if playerid < 0 then return end

    if argc < 1 then
        playerCommands["show"](playerid, args, argc, silent)
    end

    local option = args[1]

    if not playerCommands[option] then return end

    return playerCommands[option](playerid, args, argc, silent)
end)
