WCP = LibStub("AceAddon-3.0"):NewAddon("WCP", "AceComm-3.0", "AceSerializer-3.0")
WCP.LIB = {}

WCP.messagePrefix = "WCP"
WCP.frame = {}
WCP.player_name = UnitName("player")

function WCP.info(message)
  DEFAULT_CHAT_FRAME:AddMessage("|cff00d2d6WCP:|r " .. message, 1.0, 1.0, 0)
end

function WCP.alert(message)
  DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000WCP:|r " .. message, 1.0, 1.0, 0)
end

function WCP.submit_event(event, target)
  if(target) then
    WCP.addon_whisper_message(WCP:Serialize(event), target)
  else
    WCP.addon_raid_message(WCP:Serialize(event))
  end
end

function WCP.addon_raid_message(message)
  WCP:SendCommMessage(WCP.messagePrefix, message, "RAID")
end

function WCP.addon_whisper_message(message, target)
  WCP:SendCommMessage(WCP.messagePrefix, message, "WHISPER", target)
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

-- @note Lua does not have a String#split method implemented,
--       but WoW does. We just delegate here.
function WCP.split(...)
  strsplit(...)
end
