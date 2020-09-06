WCP.LIB.Events = {}

local private = {}

-- Handle WoW Events
function WCP.LIB.Events.handle(...)
  local _, event_type = ...

  if(event_type == "CHAT_MSG_ADDON") then
    private.handle_chat_message_addon_event(...)
  elseif(event_type == "GROUP_ROSTER_UPDATE") then
    WCP.grid:refresh()
  end
end

function private.handle_chat_message_addon_event(...)
  local _, _, prefix, message, _, sender = ...

  if prefix ~= WCP.messagePrefix then return false end

  if message == "SHARE" then private.handle_share_event() end
  if message == "CHECK" then private.handle_check_event(sender) end
  if string.find(message, "CHECKRES: ") then private.handle_check_result_event(message) end
end

function private.handle_share_event()
  WCP.info("Accepting share..")
  WCP.UI.CthunFrame.show()
end

function private.handle_check_event(sender)
  WCP.addon_whisper_message("CHECKRES: " .. WCP.player_name .. "|" .. WCP.Version.to_string(), sender)
end

function private.handle_check_result_event(message)
  local _, start = string.find(message, "CHECKRES: ")
  local name_with_version = string.sub(message, start + 1, string.len(message))

  local name, version = strsplit("|", name_with_version)
  version = version or "< 0.2.4"

  WCP.LIB.CheckAddon.installed(name, version)
end
