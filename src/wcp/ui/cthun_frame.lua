WCP.UI.CthunFrame = {}

WCP.UI.CthunFrame.Default_Width = 534
WCP.UI.CthunFrame.Default_Height = 534

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

-- Create Main Frame
function WCP.UI.CthunFrame.create()
  local frame = CreateFrame("Frame", nil, UIParent)

  frame:EnableMouse(true)
  frame:SetMovable(true)
  frame:SetResizable(true)
  frame:SetFrameStrata("FULLSCREEN")
  frame:SetHeight(WCP.UI.CthunFrame.Default_Height)
  frame:SetWidth(WCP.UI.CthunFrame.Default_Width)
  frame:SetScale(1)
  frame:SetPoint("CENTER", 0, 0)
  frame:SetBackdrop(backdrop)
  frame:SetAlpha(1.00)
  frame.x = frame:GetLeft()
  frame.y = (frame:GetTop() - frame:GetHeight())
  frame:Hide()

  frame:RegisterEvent("CHAT_MSG_ADDON")
  frame:RegisterEvent("GROUP_ROSTER_UPDATE")
  frame:SetScript("OnEvent", WCP.LIB.Events.handle)

  WCP.UI.ResizeArea.attach_to(frame)
  WCP.UI.OpacitySlider.attach_to(frame)
  WCP.UI.Header.attach_to(frame)
  WCP.UI.HideButton.attach_to(frame)

  return frame
end

function WCP.UI.CthunFrame.show()
  WCP.frame:Show()
  WCP.grid:refresh()
  WCP.UI.CthunFrame.Resize()
end

-- Reset Position and scale
function WCP.UI.CthunFrame.reset()
  local frame = WCP.frame

  frame:SetHeight(WCP.UI.CthunFrame.Default_Height)
  frame:SetWidth(WCP.UI.CthunFrame.Default_Width)
  frame:SetScale(1)
  frame:ClearAllPoints();
  frame:SetPoint("CENTER", 0, 0)
end

-- Resize given frame
function WCP.UI.CthunFrame.Resize()
  local scale = WCP.frame:GetWidth() / WCP.UI.CthunFrame.Default_Width
  local childrens = {WCP.frame:GetChildren()}
  for _, child in ipairs(childrens) do
    if child ~= WCP.frame.resize_area then
      child:SetScale(scale)
    end
  end
  WCP.frame:SetHeight(WCP.UI.CthunFrame.Default_Height * scale)
end
