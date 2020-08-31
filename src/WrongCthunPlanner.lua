local dotPos = {
  [1] = {1, 98}, --melee        		--
  [2] = {-32, 131}, --healer    		-|
  [3] = {-20, 170}, --ranged    		-|Group 1
  [4] = {22, 171}, --ranged     		-|
  [5] = {34, 132}, --healer/ranged    --
  [6] = {67, 71}, -- melee      		--
  [7] = {69, 118}, --healer     		-|
  [8] = {105, 137}, --ranged    		-|Group 2
  [9] = {134, 107}, --ranged    		-|
  [10] = {115, 70}, --healer/ranged   --
  [11] = {-66, 69}, -- melee    		--
  [12] = {-113, 69}, --healer   		-|
  [13] = {-132, 106}, --ranged  		-|Group 3
  [14] = {-66, 116}, --ranged   		-|
  [15] = {-103, 135}, --healer/ranged --
  [16] = {97, 4}, -- melee      		--
  [17] = {130, 37}, --healer    		-|
  [18] = {169, 24}, --ranged    		-|Group 4
  [19] = {170, -17}, --ranged   		-|
  [20] = {130, -30}, --healer/ranged  --
  [21] = {-93, 2}, -- melee     		--
  [22] = {-126, -31}, --healer  		-|
  [23] = {-166, -19}, --ranged  		-|Group 5
  [24] = {-166, 22}, --ranged   		-|
  [25] = {-127, 35}, --healer/ranged  --
  [26] = {69, -64}, -- melee    		--
  [27] = {117, -64}, --healer   		-|
  [28] = {135, -100}, --ranged  		-|Group 6
  [29] = {107, -129}, --ranged  		-|
  [30] = {70, -110}, --healer/ranged  --
  [31] = {-65, -65}, -- melee   		--
  [32] = {-65, -112}, --healer  		-|
  [33] = {-101, -131}, --ranged 		-|Group 7
  [34] = {-130, -102}, --ranged 		-|
  [35] = {-112, -66}, --healer/ranged --
  [36] = {3, -92}, -- melee     		--
  [37] = {36, -126}, --healer   		-|
  [38] = {24, -165}, --ranged   		-|Group 8
  [39] = {-18, -165}, --ranged  		-|
  [40] = {-30, -126} --healer/ranged  --
}

local checkRoster = {}
local WrongCthunPlanner_PlayerName, _ = UnitName("player")
local successfulRequest = C_ChatInfo.RegisterAddonMessagePrefix("WrongCthunPlanner")
local firstFill = nil

if not successfulRequest then
  DEFAULT_CHAT_FRAME:AddMessage("|cff00d2d6WrongCthunPlanner:|r Error creating addon channel.", 1.0, 1.0, 0)
end

local backdrop = {
  bgFile = "Interface\\AddOns\\WrongCthunPlanner\\Images\\CThun_Positioning.tga",
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
  tile = false,
  edgeSize = 32,
  insets = {
    left = 12,
    right = 12,
    top = 12,
    bottom = 12
  }
}

local frame = CreateFrame("Frame", "Cthun_room", UIParent)
frame:EnableMouse(true)
frame:SetMovable(true)
frame:SetResizable(true)
frame:SetFrameStrata("FULLSCREEN")
frame:SetHeight(534)
frame:SetWidth(534)
frame:SetScale(1)
frame:SetPoint("CENTER", 0, 0)
frame:SetBackdrop(backdrop)
frame:SetAlpha(1.00)
frame.x = frame:GetLeft()
frame.y = (frame:GetTop() - frame:GetHeight())
frame:Hide()

frame:RegisterEvent("CHAT_MSG_ADDON")
frame:SetScript(
"OnEvent",
function(...)
  local _, _, prefix, msg, dist, sender = ...
  if prefix == "WrongCthunPlanner" then
    if msg == "SHARE" then
      DEFAULT_CHAT_FRAME:AddMessage("|cff00d2d6WrongCthunPlanner:|r Accepting share..", 1.0, 1.0, 0)
      frame:Show()
      WrongCthunPlanner_FillGrid()
    end

    if msg == "CHECK" then
      C_ChatInfo.SendAddonMessage("WrongCthunPlanner", "CHECKRES: " .. WrongCthunPlanner_PlayerName, "WHISPER", sender)
    end

    if string.find(msg, "CHECKRES: ") then
      local _, start = string.find(msg, "CHECKRES: ")
      local name = string.sub(msg, start + 1, string.len(msg))

      for i, v in ipairs(checkRoster) do
        if v == name then
          table.remove(checkRoster, i)
        end
      end
    end
  end
end
)

local resizeframe
local Width = frame:GetWidth()
local Height = frame:GetHeight()

local function Resizer(frame)
  local s = frame:GetWidth() / Width
  local childrens = {frame:GetChildren()}
  for _, child in ipairs(childrens) do
    if child ~= resizeframe then
      child:SetScale(s)
    end
  end
  frame:SetHeight(Height * s)
end

local function ResizeFrame(frame)
  resizeframe = CreateFrame("Frame", "CthunResize", frame)
  resizeframe:SetPoint("BottomRight", frame, "BottomRight", -8, 7)
  resizeframe:SetWidth(16)
  resizeframe:SetHeight(16)
  resizeframe:SetFrameLevel(frame:GetFrameLevel() + 7)
  resizeframe:EnableMouse(true)
  local resizetexture = resizeframe:CreateTexture(nil, "Artwork")
  resizetexture:SetPoint("TopLeft", resizeframe, "TopLeft", 0, 0)
  resizetexture:SetWidth(16)
  resizetexture:SetHeight(16)
  resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
  frame:SetMaxResize(Width * 1.5, Height * 1.5)
  frame:SetMinResize(Width / 2.0, Height / 2.0)
  frame:SetResizable(true)
  resizeframe:SetScript(
  "OnEnter",
  function(self)
    resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
  end
  )
  resizeframe:SetScript(
  "OnLeave",
  function(self)
    resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
  end
  )
  resizeframe:SetScript(
  "OnMouseDown",
  function(self, button)
    if button == "RightButton" then
      frame:SetWidth(Width)
      frame:SetHeight(Height)
    else
      resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
      frame:StartSizing("Right")
    end
  end
  )
  resizeframe:SetScript(
  "OnMouseUp",
  function(self, button)
    local x, y = GetCursorPosition()
    local fx = self:GetLeft() * self:GetEffectiveScale()
    local fy = self:GetBottom() * self:GetEffectiveScale()
    if x >= fx and x <= (fx + self:GetWidth()) and y >= fy and y <= (fy + self:GetHeight()) then
      resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    else
      resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    end
    frame:StopMovingOrSizing()
  end
  )
  local scrollframe = CreateFrame("ScrollFrame", "CthunScroll", frame)
  scrollframe:SetWidth(Width)
  scrollframe:SetHeight(Height)
  scrollframe:SetPoint("Topleft", frame, "Topleft", 0, 0)
  frame:SetScript(
  "OnSizeChanged",
  function(self)
    Resizer(frame)
  end
  )
end

ResizeFrame(frame)

local WrongCthunPlanner_Slider = CreateFrame("Slider", "MySlider1", frame, "OptionsSliderTemplate")
WrongCthunPlanner_Slider:SetPoint("BOTTOM", frame, "BOTTOM", 0, 20)
WrongCthunPlanner_Slider:SetMinMaxValues(0.05, 1.00)
WrongCthunPlanner_Slider:SetValue(1.00)
WrongCthunPlanner_Slider:SetValueStep(0.05)
WrongCthunPlanner_Slider:SetResizable(true)
getglobal(WrongCthunPlanner_Slider:GetName() .. "Low"):SetText("5%")
getglobal(WrongCthunPlanner_Slider:GetName() .. "High"):SetText("100%")
getglobal(WrongCthunPlanner_Slider:GetName() .. "Text"):SetText("Opacity")
WrongCthunPlanner_Slider:SetScript(
"OnValueChanged",
function(self)
  local value = WrongCthunPlanner_Slider:GetValue()
  frame:SetAlpha(value)
end
)

local WrongCthunPlanner_Header = CreateFrame("Frame", "WrongCthunPlanner_Header", frame)
WrongCthunPlanner_Header:SetPoint("TOP", frame, "TOP", 0, 12)
WrongCthunPlanner_Header:SetWidth(256)
WrongCthunPlanner_Header:SetHeight(64)
WrongCthunPlanner_Header:SetBackdrop(
{
  bgFile = "Interface\\DialogFrame\\UI-DialogBox-Header"
}
)

WrongCthunPlanner_Header:SetScript(
"OnMouseDown",
function(self, button)
  frame:StartMoving("TOPLEFT")
  frame:SetUserPlaced(true)
end
)

WrongCthunPlanner_Header:SetScript(
"OnMouseUp",
function(self, button)
  frame:StopMovingOrSizing()
end
)

local WrongCthunPlanner_Fontstring = WrongCthunPlanner_Header:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
WrongCthunPlanner_Fontstring:SetPoint("CENTER", WrongCthunPlanner_Header, "CENTER", 0, 12)
WrongCthunPlanner_Fontstring:SetText("WrongCthun Planner")

local button = CreateFrame("Button", "WrongCthunPlanner_Close", frame)
button:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
button:SetHeight(32)
button:SetWidth(32)
button:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
button:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
button:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
button:SetScript(
"OnLoad",
function()
  button:RegisterForClicks("AnyUp")
end
)
button:SetScript(
"OnClick",
function()
  frame:Hide()
end
)

local num_dots = 0

local function newDot(x, y, name, class)
  num_dots = num_dots + 1

  local dot

  if _G["CthunDot_" .. num_dots] == nil then
    dot = CreateFrame("Button", "CthunDot_" .. num_dots, frame)
    dot:SetResizable(true)
    dot:SetPoint("CENTER", frame, "CENTER", x, y)
    dot:EnableMouse(true)

    local texdot = dot:CreateTexture(nil, "OVERLAY")
    dot.texture = texdot
    texdot:SetAllPoints(dot)

    if (name == "Empty") then
      texdot:SetTexture(nil)
    else
      texdot:SetTexture("Interface\\AddOns\\WrongCthunPlanner\\Images\\playerdot_" .. class .. ".tga")
    end

    dot:SetFrameLevel(dot:GetFrameLevel() + 3)
  else
    dot = _G["CthunDot_" .. num_dots]

    if (name == "Empty") then
      dot.texture:SetTexture(nil)
    else
      dot.texture:SetTexture("Interface\\AddOns\\WrongCthunPlanner\\Images\\playerdot_" .. class .. ".tga")
    end
  end

  if (WronWrongCthunPlanner_PlayerName == name) then
    dot:SetWidth(32)
    dot:SetHeight(32)
  else
    dot:SetWidth(16)
    dot:SetHeight(16)
  end

  dot:RegisterEvent("GROUP_ROSTER_UPDATE")
  dot:SetScript(
  "OnEvent",
  function()
    WrongCthunPlanner_WipeReserves(true)
  end
  )

  dot:SetScript(
  "OnEnter",
  function()
    GameTooltip:SetOwner(dot, "ANCHOR_RIGHT")
    GameTooltip:SetText(name)
    GameTooltip:Show()
  end
  )
  dot:SetScript(
  "OnLeave",
  function()
    GameTooltip:Hide()
  end
  )

  dot:SetScale(frame:GetEffectiveScale())
  Resizer(frame)
  return dot
end

local dotRes = {
  {{"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}}, -- group 1
  {{"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}}, -- group 2
  {{"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}}, --    |
  {{"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}}, --    |
  {{"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}}, --    |
  {{"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}}, --    |
  {{"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}}, --    |
  {{"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}, {"Empty", "Empty"}}
} -- group 8

local meleeMarks = {"", "", "", "", "", "", "", ""}

local function getRaidInfo()
  meleeMarks = {"", "", "", "", "", "", "", ""}
  for i = 1, 40 do
    local name, rank, subgroup, level, _, class, zone, online, isDead, role, isML = GetRaidRosterInfo(i)

    if (class == "ROGUE" or class == "WARRIOR" or (class == "DRUID" and role == "maintank")) then
      if (dotRes[subgroup][1][1] == "Empty" or dotRes[subgroup][1][1] == name) and isDead == false then
        dotRes[subgroup][1] = {name, class}
        meleeMarks[subgroup] = name
      elseif dotRes[subgroup][5][1] == "Empty" or dotRes[subgroup][5][1] == name then
        dotRes[subgroup][5] = {name, class}
      elseif dotRes[subgroup][2][1] == "Empty" or dotRes[subgroup][2][1] == name then
        dotRes[subgroup][2] = {name, class}
      elseif dotRes[subgroup][3][1] == "Empty" or dotRes[subgroup][3][1] == name then
        dotRes[subgroup][3] = {name, class}
      else
        dotRes[subgroup][4] = {name, class}
      end
    elseif (class == "MAGE" or class == "WARLOCK" or class == "HUNTER") then
      if dotRes[subgroup][3][1] == "Empty" or dotRes[subgroup][3][1] == name then
        dotRes[subgroup][3] = {name, class}
      elseif dotRes[subgroup][4][1] == "Empty" or dotRes[subgroup][4][1] == name then
        dotRes[subgroup][4] = {name, class}
      elseif dotRes[subgroup][5][1] == "Empty" or dotRes[subgroup][5][1] == name then
        dotRes[subgroup][5] = {name, class}
      elseif dotRes[subgroup][2][1] == "Empty" or dotRes[subgroup][2][1] == name then
        dotRes[subgroup][2] = {name, class}
      else
        dotRes[subgroup][1] = {name, class}
      end
    elseif (class == "PRIEST" or class == "PALADIN" or class == "DRUID") then
      if dotRes[subgroup][2][1] == "Empty" or dotRes[subgroup][2][1] == name then
        dotRes[subgroup][2] = {name, class}
      elseif dotRes[subgroup][5][1] == "Empty" or dotRes[subgroup][5][1] == name then
        dotRes[subgroup][5] = {name, class}
      elseif dotRes[subgroup][3][1] == "Empty" or dotRes[subgroup][3][1] == name then
        dotRes[subgroup][3] = {name, class}
      elseif dotRes[subgroup][4][1] == "Empty" or dotRes[subgroup][4][1] == name then
        dotRes[subgroup][4] = {name, class}
      else
        dotRes[subgroup][1] = {name, class}
      end
    end
  end
end

function WrongCthunPlanner_FillGrid()
  WrongCthunPlanner_WipeReserves()
  getRaidInfo()
  local count = 0
  for i = 1, 8 do
    for j = 1, 5 do
      count = count + 1
      local x = ((i - 1) * 5) + j
      local dot = newDot(dotPos[x][1], dotPos[x][2], dotRes[i][j][1], dotRes[i][j][2])
    end
  end
end

local function shareGrid()
  C_ChatInfo.SendAddonMessage("WrongCthunPlanner", "SHARE", "RAID")
end

local function getRoster()
  local roster = {}

  for i = 1, 41 do
    local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(i)
    if name then
      table.insert(roster, name)
    end
  end

  return roster
end

local function markMelee()
  if firstFill == nil then
    WrongCthunPlanner_FillGrid()
    firstFill = true
  end

  for i, v in ipairs(meleeMarks) do
    if v ~= "" and UnitExists(v) then
      SetRaidTarget(v, i)
    end
  end
end

local function checkAddons()
  checkRoster = getRoster()
  C_ChatInfo.SendAddonMessage("WrongCthunPlanner", "CHECK", "RAID")
  DEFAULT_CHAT_FRAME:AddMessage(
  "|cff00d2d6WrongCthunPlanner:|r checking if everyone has the addon installed..",
  1.0,
  1.0,
  0
  )
  C_Timer.After(3, WrongCthunPlanner_CheckResults)
end

function WrongCthunPlanner_CheckResults()
  if table.getn(checkRoster) > 0 then
    DEFAULT_CHAT_FRAME:AddMessage("   |cFFFF0000Missing Addon:|r " .. table.concat(checkRoster, ", "), 1.0, 1.0, 0)
  else
    DEFAULT_CHAT_FRAME:AddMessage("   |cFF00FF00All players have WrongCthunPlanner installed!|r", 1.0, 1.0, 0)
  end
end

function WrongCthunPlanner_WipeReserves(update)
  num_dots = 0
  for i = 1, 8 do
    for j = 1, 5 do
      for k = 1, 2 do
        dotRes[i][j][k] = "Empty"
      end
    end
  end

  if update then
    WrongCthunPlanner_FillGrid()
  end
end

SLASH_WrongCthunPlanner1 = "/cthun"

local function HandleSlashCommands(str)
  if (str == "help") then
    DEFAULT_CHAT_FRAME:AddMessage("Commands:", 1.0, 1.0, 0)
    DEFAULT_CHAT_FRAME:AddMessage("   /cthun |cff00d2d6help |r-- show this help menu", 1.0, 1.0, 0)
    DEFAULT_CHAT_FRAME:AddMessage("   /cthun |cff00d2d6mark |r-- marks the main melee for each group", 1.0, 1.0, 0)
    DEFAULT_CHAT_FRAME:AddMessage("   /cthun |cff00d2d6share |r-- displays the planner to your raid", 1.0, 1.0, 0)
    DEFAULT_CHAT_FRAME:AddMessage(
    "   /cthun |cff00d2d6check |r-- check if all raiders have the addon installed",
    1.0,
    1.0,
    0
    )
  elseif (str == "fill" or str == "" or str == nil) then
    frame:Show()
    WrongCthunPlanner_FillGrid()
  elseif (str == "share") then
    if IsInGroup() then
      if UnitIsGroupLeader("player") then
        frame:Show()
        WrongCthunPlanner_FillGrid()
        shareGrid()
      else
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000WrongCthunPlanner:|r Only the group leader can share.", 1.0, 1.0, 0)
      end
    else
      DEFAULT_CHAT_FRAME:AddMessage(
      "|cFFFF0000WrongCthunPlanner:|r You need to be in a raid to use this command.",
      1.0,
      1.0,
      0
      )
    end
  elseif (str == "mark" or str == "marks") then
    markMelee()
  elseif (str == "check") then
    if IsInGroup() and UnitIsGroupLeader("player") then
      checkAddons()
    else
      DEFAULT_CHAT_FRAME:AddMessage(
      "|cFFFF0000WrongCthunPlanner:|r This is only available to group leaders.",
      1.0,
      1.0,
      0
      )
    end
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000WrongCthunPlanner:|r Command not found, use /cthun help", 1.0, 1.0, 0)
  end
end

SlashCmdList.WrongCthunPlanner = HandleSlashCommands
