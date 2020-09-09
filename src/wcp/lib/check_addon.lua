WCP.LIB.CheckAddon = {}
WCP.LIB.CheckAddon.current_roster = nil

WCP.LIB.CheckAddon.Roster = {}
WCP.LIB.CheckAddon.Roster.__index = WCP.LIB.CheckAddon.Roster

local private = {}

function WCP.LIB.CheckAddon.run()
  WCP.LIB.CheckAddon.current_roster = WCP.LIB.CheckAddon.Roster.create()

  WCP.submit_event({ type = "VERSION_CHECK" })

  WCP.info("checking if everyone has the addon installed")
  C_Timer.After(3, private.handle_result)
end

function WCP.LIB.CheckAddon.installed(name, version)
  if WCP.LIB.CheckAddon.current_roster == nil then return false end

  WCP.LIB.CheckAddon.current_roster:handle_installed(name, version)
end

function WCP.LIB.CheckAddon.Roster.create()
  local self = {}

  setmetatable(self, WCP.LIB.CheckAddon.Roster)

  self.missing = {}
  self.installed = {}

  for i = 1, 40 do
    local name, _ = GetRaidRosterInfo(i)

    if name then table.insert(self.missing, name) end
  end

  return self
end

function WCP.LIB.CheckAddon.Roster:handle_installed(name, version)
  for i, existing_name in pairs(self.missing) do
    if existing_name == name then
      table.remove(self.missing, i)

      self.installed[version] = self.installed[version] or {}
      table.insert(self.installed[version], name)
    end
  end
end

function private.handle_result()
  local roster = WCP.LIB.CheckAddon.current_roster

  if table.getn(roster.missing) > 0 then
    WCP.alert("Missing: " ..  table.concat(roster.missing, ", "))
  end

  for version, installed in pairs(roster.installed) do
    WCP.info("Installed (" .. version .. "): " ..  table.concat(installed, ", "))
  end

  if table.getn(roster.missing) <= 0 then
    WCP.info("All players have WCP installed!")
  end
end
