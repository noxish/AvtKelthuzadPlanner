WCP.LIB.Events = {}

function WCP.LIB.Events.ON_GROUP_JOINED()
  WCP.submit_event({ type = "REQUEST_SHARE" })
end

function WCP.LIB.Events.ON_GROUP_ROSTER_UPDATE()
  WCP.grid:refresh()
end

function WCP.LIB.Events.ON_REQUEST_SHARE()
  if(WCP.player:is_leader()) then
    WCP.UI.Dot.share_positions()
  end
end

function WCP.LIB.Events.ON_SHARE()
  WCP.frame:show()
end

function WCP.LIB.Events.ON_SHARE_POSITIONS(payload)
  WCP.UI.Dot.set_positions(payload)
end

function WCP.LIB.Events.ON_VERSION_CHECK(_, _, _, _, target)
  WCP.submit_event({
    type = "VERSION_RESPONSE",
    payload = {
      name = WCP.player_name,
      version = WCP.Version.to_string()
    }
  }, target)
end

function WCP.LIB.Events.ON_VERSION_RESPONSE(payload)
  WCP.LIB.CheckAddon.installed(payload["name"], payload["version"])
end

-- Generic event handler delegates to correct handler
-- @todo Replace w/ AceEvent
function WCP.LIB.Events.handle(...)
  local _, event_type = ...

  if(not event_type) then return false end

  WCP.LIB.Events["ON_" .. event_type]()
end
