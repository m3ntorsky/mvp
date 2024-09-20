function GenerateMenu(playerid)
    local player = GetPlayer(playerid)
    if not player or not player:IsValid() then return end
    local volume = exports["cookies"]:GetPlayerCookie(playerid, "mvp.volume")
    local kitName = exports["cookies"]:GetPlayerCookie(playerid, "mvp.kit")

    local options = {}

    if volume > -1 and volume < 21 then
        table.insert(options, { "Volume: <font color='#FF0000'>" .. volume .. "%</font>", "sw_mvp volume" })
    elseif volume > 20 and volume < 71 then
        table.insert(options, { "Volume: <font color='#FFFF00'>" .. volume .. "%</font>", "sw_mvp volume" })
    elseif volume > 70 then
        table.insert(options, { "Volume: <font color='#33FF00'>" .. volume .. "%</font>", "sw_mvp volume" })
    end

    if kitName == "default" then
        table.insert(options, { "Sound: <font color='#00FF00'>Default</font>", "sw_mvp kitslist" })
    else
        table.insert(options,
            { "Sound: <font color='#00FF00'>" .. MusicKits[MusicKitsIndex[kitName]].display .. "</font>",
                "sw_mvp kitslist" })
    end

    menus:RegisterTemporary("mvp_" .. playerid, tostring(FetchTranslation("mvp.menu.title", playerid)),
        tostring(config:Fetch("mvp.menucolor")), options)
    player:HideMenu()
    player:ShowMenu("mvp_" .. playerid)
end


function GenerateVolumeMenu(playerid)
    local player = GetPlayer(playerid)
    if not player or not player:IsValid() then return end

    local volumes = config:Fetch("mvp.volume")

    if #volumes == 0 then return end
    local options = {}
    for i = 1, #volumes do
        table.insert(options, { tostring(volumes[i].."%"), "sw_mvp volume " .. volumes[i] })
    end


    menus:RegisterTemporary("mvp_volume_menu" .. playerid, tostring(FetchTranslation("mvp.menu.volume.title", playerid)),
        tostring(config:Fetch("mvp.menucolor")), options)
    player:HideMenu()
    player:ShowMenu("mvp_volume_menu" .. playerid)
end

function GenerateKitListMenu(playerid)
    local player = GetPlayer(playerid)
    if not player or not player:IsValid() then return end
    local options = {}

    for i = 1, #MusicKits do
        if MusicKits[i].id == "default" then
            table.insert(options, { MusicKits[i].display, "sw_mvp set default" })
        else
            table.insert(options, { MusicKits[i].display, "sw_mvp kit_preview " .. MusicKits[i].id })
        end
    end

    menus:RegisterTemporary("mvp_kitslist_" .. playerid, tostring(FetchTranslation("mvp.menu.kits.title", playerid)),
        tostring(config:Fetch("mvp.menucolor")), options)
    player:HideMenu()
    player:ShowMenu("mvp_kitslist_" .. playerid)
end

function GenerateKitPreviewMenu(playerid, kitName)
    local player = GetPlayer(playerid)
    if not player or not player:IsValid() then return end
    local playerKitName = tostring(exports["cookies"]:GetPlayerCookie(playerid, "mvp.kit"))

    local kit = MusicKits[MusicKitsIndex[kitName]]
    local options = {}
    if not kit or kitName == "default" then return end

    if kit.can_preview then
        table.insert(options, { tostring(FetchTranslation("mvp.menu.preview.play", playerid)), "sw_mvp play " .. kit.id })
    end

    if kit.can_equip then
        if playerKitName ~= kitName then
            table.insert(options,
                { tostring(FetchTranslation("mvp.menu.preview.equip", playerid)), "sw_mvp set " .. kit.id })
        else
            table.insert(options,
                { tostring(FetchTranslation("mvp.menu.preview.unequip", playerid)), "sw_mvp set default" })
        end
    end

    menus:RegisterTemporary("mvp_kitpreview_" .. playerid,
    tostring(FetchTranslation("mvp.menu.preview.title", playerid):gsub("{KIT_DISPLAY}", kit.display)),
        tostring(config:Fetch("mvp.menucolor")), options)
    player:HideMenu()
    player:ShowMenu("mvp_kitpreview_" .. playerid)
end
