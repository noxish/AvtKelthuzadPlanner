local successfulRequest = C_ChatInfo.RegisterAddonMessagePrefix("WrongCthunPlanner")

if not successfulRequest then
  WCP.alert("Error creating addon channel.")
end

WCP.frame = WCP.UI.CthunFrame.create()
WCP.grid = WCP.LIB.Grid:create()

SLASH_WrongCthunPlanner1 = "/wcp"
SlashCmdList.WrongCthunPlanner = WCP.LIB.SlashCommands.handle
