WCP = {}
WCP.LIB = {}
WCP.UI = {}

WCP.messagePrefix = "WCP"
WCP.frame = {}
WCP.player_name = UnitName("player")

function WCP.info(message)
  DEFAULT_CHAT_FRAME:AddMessage("|cff00d2d6WCP:|r " .. message, 1.0, 1.0, 0)
end

function WCP.alert(message)
  DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000WCP:|r " .. message, 1.0, 1.0, 0)
end

function WCP.addon_raid_message(message)
  C_ChatInfo.SendAddonMessage(WCP.messagePrefix, message, "RAID")
end

function WCP.addon_whisper_message(message, receiver)
  C_ChatInfo.SendAddonMessage(WCP.messagePrefix, message, "WHISPER", receiver)
end

function WCP.debug(object)
  print(WCP.dump(object))
end

function WCP.dump(object)
  if type(object) == 'table' then
    local s = "{"
    for k, v in pairs(object) do
      if type(k) ~= 'number' then k = '"'..k..'"' end

      s = s .. '['..k..'] = ' .. WCP.dump(v) .. ", "
    end
    return s .. '}'
  else
    return tostring(object)
  end
end
