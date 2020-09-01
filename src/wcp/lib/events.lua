WCP.LIB.Events = {}

local private = {}

-- Handle WoW Events
function WCP.LIB.Events.handle(...)
  local unknown, event_type = ...

  if(event_type == "CHAT_MSG_ADDON") then
    private.handle_chat_msg_addon_event(...)
  elseif(event_type == "GROUP_ROSTER_UPDATE") then
    WCP.grid:refresh()
  else
    -- print(unknown)
    -- print(event_type)
  end
end

function private.handle_chat_msg_addon_event(...)
  local _, event_type, prefix, msg, dist, sender = ...

  if prefix ~= "WrongCthunPlanner" then return false end

  if msg == "SHARE" then handle_share_event() end
  if msg == "CHECK" then handle_check_event(sender) end
  if string.find(msg, "CHECKRES: ") then handle_check_result_event(msg) end
end

local function handle_share_event()
  WCP.info("Accepting share..")
  WCP.frame:Show()
  WCP.grid:refresh()
end

local function handle_check_event(sender)
  WCP.addon_whisper_message("CHECKRES: " .. WCP.player_name, sender)
end

local function handle_check_result_event(message)
  print("handle_check_result_event")
  print(message)
  local _, start = string.find(msg, "CHECKRES: ")
  local name = string.sub(msg, start + 1, string.len(msg))

  WCP.Lib.CheckAddon.installed(name)
end
