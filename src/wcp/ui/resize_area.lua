WCP.UI.ResizeArea = {}

-- Attach Resize Area
function WCP.UI.ResizeArea.attach_to(frame)
  resize_frame = CreateFrame("Frame", "CthunResize", frame)
  resize_frame:SetPoint("BottomRight", frame, "BottomRight", -8, 7)
  resize_frame:SetWidth(16)
  resize_frame:SetHeight(16)
  resize_frame:SetFrameLevel(frame:GetFrameLevel() + 7)
  resize_frame:EnableMouse(true)

  local resizetexture = resize_frame:CreateTexture(nil, "Artwork")
  resizetexture:SetPoint("TopLeft", resize_frame, "TopLeft", 0, 0)
  resizetexture:SetWidth(16)
  resizetexture:SetHeight(16)
  resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")

  frame:SetMaxResize(WCP.UI.CthunFrame.Default_Width * 1.5, WCP.UI.CthunFrame.Default_Height * 1.5)
  frame:SetMinResize(WCP.UI.CthunFrame.Default_Width / 2.0, WCP.UI.CthunFrame.Default_Height / 2.0)
  frame:SetResizable(true)

  resize_frame:SetScript("OnEnter", function(self)
    resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
  end)

  resize_frame:SetScript("OnLeave", function(self)
    resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
  end)

  resize_frame:SetScript("OnMouseDown", function(self, button)
    if button == "RightButton" then
      frame:SetWidth(WCP.UI.CthunFrame.Default_Width)
      frame:SetHeight(WCP.UI.CthunFrame.Default_Height)
    else
      resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
      frame:StartSizing("Right")
    end
  end)

  resize_frame:SetScript("OnMouseUp", function(self, button)
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
    WCP.UI.CthunFrame.Resize()
  end)

  frame.resize_area = resize_frame
end
