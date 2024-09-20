AddEventHandler("OnRoundMvp", function(event)
    local mvpPlayerid = event:GetInt("userid")
    local mvpPlayer = GetPlayer(mvpPlayerid)
    if not mvpPlayer or not mvpPlayer:IsValid() then return EventResult.Continue end

    local mvpKitName = exports["cookies"]:GetPlayerCookie(mvpPlayerid, "mvp.kit")

    local kit = MusicKits[MusicKitsIndex[mvpKitName]]

    if mvpKitName ~= "default" and kit then
        for playerid = 0, playermanager:GetPlayerCap() - 1, 1 do
            local player = GetPlayer(playerid)
            if not player or not player:IsValid() or not player:CBaseEntity():IsValid() then goto continue end
            CBaseEntity(player:CCSPlayerController():ToPtr()):EmitSound("StopSoundEvents.StopAllMusic", 100, 1.0)
            local volume = tonumber(exports["cookies"]:GetPlayerCookie(playerid, "mvp.volume")) / 100
            if volume and volume > 0 then
                NextTick(function()
                    CBaseEntity(player:CCSPlayerController():ToPtr()):EmitSound(kit.event, 100, volume)
                    ReplyToCommand(playerid, tostring(config:Fetch("mvp.prefix")),
                    FetchTranslation("mvp.played", playerid):gsub("{KIT_DISPLAY}", kit.display))
                end)
            end
            ::continue::
        end
    end
    return EventResult.Continue
end)
