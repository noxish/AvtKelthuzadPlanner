WCP.LIB.SlashCommands = {}

local private = {}

function WCP.LIB.SlashCommands.handle(cmd)
  if (cmd == "help") then
    private.help()
  elseif (cmd == "show" or cmd == "" or cmd == nil) then
    private.show()
  elseif (cmd == "refresh") then
    private.refresh()
  elseif (cmd == "share") then
    private.share()
  elseif (cmd == "marks") then
    private.marks()
  elseif (cmd == "check") then
    private.check()
  else
    WCP.alert("Command not found, use /wcp help")
  end
end

-- /wcp help
function private.help()
  local function add_help_message(cmd, message)
    DEFAULT_CHAT_FRAME:AddMessage("   /wcp |cff00d2d6" .. cmd .. " |r-- " .. message, 1.0, 1.0, 0)
  end

  WCP.info("Commands:")
  add_help_message("help", "Show this help menu")
  add_help_message("show", "Show the planner")
  add_help_message("refresh", "Refresh positions (e.g.: Someone died / went offline)")

  if(IsInGroup() and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player"))) then
    add_help_message("marks", "Set RaidTargetMarkers for Melees")
  end

  if(IsInGroup() and UnitIsGroupLeader("player")) then
    add_help_message("share", "Displays the planner to your raid")
    add_help_message("check", "Check if all raiders have the addon installed")
  end
end

-- /wcp show
function private.show()
  WCP.frame:Show()
  WCP.grid:refresh()
end

-- /wcp refresh
function private.refresh()
  WCP.grid:refresh()
end

-- /wcp share
function private.share()
  if IsInGroup() then
    if UnitIsGroupLeader("player") then
      WCP.frame:Show()
      WCP.grid:refresh()
      WCP.addon_raid_message("SHARE")
    else
      WCP.alert("Only the group leader can share.")
    end
  else
    WCP.alert("You need to be in a raid to use this command.")
  end
end

-- /wcp marks
function private.marks()
  WCP.grid:set_marks()
end

-- /wcp check
function private.check()
  if IsInGroup() and UnitIsGroupLeader("player") then
    WCP.LIB.CheckAddon.run()
  else
    WCP.alert("This is only available to group leaders.")
  end
end
