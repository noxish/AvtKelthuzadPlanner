WCP = {}
WCP.LIB = {}
WCP.UI = {}

WCP.messagePrefix = "WCP"
WCP.frame = {}
WCP.player_name, _ = UnitName("player")

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
