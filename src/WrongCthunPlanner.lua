SLASH_WrongCthunPlanner1 = "/wcp"
SlashCmdList.WrongCthunPlanner = WCP.LIB.SlashCommands.handle

function WCP:OnInitialize()
  self:RegisterComm(WCP.messagePrefix, WCP.OnCommReceived)

  WCP.UI.Dot.init()

  WCP.player = WCP.LIB.Member.create(0)
  WCP.grid = WCP.LIB.Grid.create()
  WCP.frame = WCP.UI.CthunFrame.create()
end

function WCP.OnCommReceived(prefix, message, distribution, sender)
  if(prefix ~= WCP.messagePrefix) then return false end

  local is_event, event = WCP:Deserialize(message)

  if is_event then
    WCP.LIB.Events["ON_" .. event["type"]](event["payload"], prefix, message, distribution, sender)
  -- else
    -- WCP.alert("Can not process: " .. message)
  end
end
