AddEventHandler("OnPluginStart", function()

    config:Reload("mvp")

    config:Create("mvp", {
        prefix = "{darkred}[MVP]{default}",
        menucolor = "00B869",
        volume  = { 0, 20, 40, 60, 80, 100},
        musickits =  {}
    })

    local musicKits = config:Fetch("mvp.musickits")

    if type(musicKits) ~= "table" then
        print("{darkred} Error:{default} musickits in config has to be an array (table).")
        return EventResult.Continue
    end

    for key, value in pairs(musicKits) do
        if type(value) ~= "table" or value.path == nil or value.display == nil then
            print("{darkred} Error:{default} Cannot parse a musickits: " .. key)
            return EventResult.Continue
        end
        value.id = key
        table.insert(MusicKits, value)
        MusicKitsIndex[key] = #MusicKits
        precacher:PrecacheSound(value.path)

    end

    local out, _ = FetchTranslation("mvp.loaded"):gsub("{COUNT}", #MusicKits)
    print(out)

    return EventResult.Continue
end)

AddEventHandler("OnPlayerCookieLoaded", function(event, playerid)
    if exports["cookies"]:HasPlayerCookie(playerid, "mvp.kit") and exports["cookies"]:HasPlayerCookie(playerid, "mvp.volume") then return EventResult.Continue end
    exports["cookies"]:SetPlayerCookie(playerid, "mvp.kit", "default")
    exports["cookies"]:SetPlayerCookie(playerid, "mvp.volume", 100)
    return EventResult.Continue
end)
