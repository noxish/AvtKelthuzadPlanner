WCP.UI.ResizeArea = {}

-- Attach Resize Area
function WCP.UI.ResizeArea.attach_to(frame)
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

  frame:SetMaxResize(WCP.UI.CthunFrame.Default_Width * 1.5, WCP.UI.CthunFrame.Default_Height * 1.5)
  frame:SetMinResize(WCP.UI.CthunFrame.Default_Width / 2.0, WCP.UI.CthunFrame.Default_Height / 2.0)
  frame:SetResizable(true)

  resizeframe:SetScript("OnEnter", function(self)
    resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
  end)

  resizeframe:SetScript("OnLeave", function(self)
    resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
  end)

  resizeframe:SetScript("OnMouseDown", function(self, button)
    if button == "RightButton" then
      frame:SetWidth(WCP.UI.CthunFrame.Default_Width)
      frame:SetHeight(WCP.UI.CthunFrame.Default_Height)
    else
      resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
      frame:StartSizing("Right")
    end
  end)

  resizeframe:SetScript("OnMouseUp", function(self, button)
    local x, y = GetCursorPosition()
    local fx = self:GetLeft() * self:GetEffectiveScale()
    local fy = self:GetBottom() * self:GetEffectiveScale()
    if x >= fx and x <= (fx + self:GetWidth()) and y >= fy and y <= (fy + self:GetHeight()) then
      resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    else
      resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    end
    frame:StopMovingOrSizing()
  end)

  local scrollframe = CreateFrame("ScrollFrame", "CthunScroll", frame)
  scrollframe:SetWidth(WCP.UI.CthunFrame.Default_Width)
  scrollframe:SetHeight(WCP.UI.CthunFrame.Default_Height)
  scrollframe:SetPoint("Topleft", frame, "Topleft", 0, 0)

  frame:SetScript("OnSizeChanged", function(self)
    WCP.UI.CthunFrame.Resize(frame, resizeframe)
  end)
end
