WCP = {}
WCP.LIB = {}
WCP.UI = {}

WCP.frame = {}
WCP.player_name, _ = UnitName("player")

function WCP.info(message)
  DEFAULT_CHAT_FRAME:AddMessage("|cff00d2d6WCP:|r " .. message, 1.0, 1.0, 0)
end

function WCP.alert(message)
  DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000WCP:|r " .. message, 1.0, 1.0, 0)
end

function WCP.addon_raid_message(message)
  C_ChatInfo.SendAddonMessage("WrongCthunPlanner", "CHECKRES: " .. WCP.player_name, "WHISPER", sender)
end

function WCP.addon_whisper_message(message, receiver)
  C_ChatInfo.SendAddonMessage("WrongCthunPlanner", message, "WHISPER", receiver)
end
