WCP.LIB.CheckAddon = {}
WCP.LIB.CheckAddon.current_roster = nil

WCP.LIB.CheckAddon.Roster = {}
WCP.LIB.CheckAddon.Roster.__index = WCP.LIB.CheckAddon.Roster

local private = {}

function WCP.LIB.CheckAddon.run()
  WCP.LIB.CheckAddon.current_roster = WCP.LIB.CheckAddon.Roster.create()

  WCP.addon_raid_message("CHECK")
  WCP.info("checking if everyone has the addon installed")
  C_Timer.After(3, private.handle_result)
end

function WCP.LIB.CheckAddon.installed(name)
  if WCP.LIB.CheckAddon.current_roster == nil then return false end

  WCP.LIB.CheckAddon.current_roster:remove_member(name)
end

function WCP.LIB.CheckAddon.Roster.create()
  local self = {}

  setmetatable(self, WCP.LIB.CheckAddon.Roster)

  self.members = {}

  for i = 1, 40 do
    local name, _ = GetRaidRosterInfo(i)

    if name then table.insert(self.members, name) end
  end

  return self
end

function WCP.LIB.CheckAddon.Roster:remove_member(name_to_remove)
  for i, existing_name in ipairs(self.members) do
    if existing_name == name_to_remove then
      table.remove(self.members, i)
    end
  end
end

function private.handle_result()
  if table.getn(WCP.LIB.CheckAddon.current_roster.members) > 0 then
    WCP.alert("Missing Addon: " ..  table.concat(WCP.LIB.CheckAddon.current_roster.members, ", "))
  else
    WCP.info("All players have WCP installed!")
  end
end
