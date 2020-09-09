WCP.UI.ResizeArea = {}

-- Attach Resize Area
function WCP.UI.ResizeArea.attach_to(frame)
  local resize_frame = CreateFrame("Frame", nil, frame)
  resize_frame:SetPoint("BottomRight", frame, "BottomRight", -8, 7)
  resize_frame:SetWidth(32)
  resize_frame:SetHeight(32)
  resize_frame:SetFrameLevel(frame:GetFrameLevel() + 7)
  resize_frame:EnableMouse(true)

  local resizetexture = resize_frame:CreateTexture(nil, "Artwork")
  resizetexture:SetPoint("TopLeft", resize_frame, "TopLeft", 0, 0)
  resizetexture:SetWidth(32)
  resizetexture:SetHeight(32)
  resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")

  resize_frame:SetScript("OnEnter", function()
    resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
  end)

  resize_frame:SetScript("OnLeave", function()
    resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
  end)

  resize_frame:SetScript("OnMouseDown", function(_, button)
    if button == "RightButton" then
      frame:SetWidth(WCP.UI.CthunFrame.Default_Width)
      frame:SetHeight(WCP.UI.CthunFrame.Default_Height)
    else
      resizetexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
      frame:StartSizing("Right")
    end
  end)

  resize_frame:SetScript("OnMouseUp", function(self)
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

  local scrollframe = CreateFrame("ScrollFrame", nil, frame)
  scrollframe:SetWidth(WCP.UI.CthunFrame.Default_Width)
  scrollframe:SetHeight(WCP.UI.CthunFrame.Default_Height)
  scrollframe:SetPoint("Topleft", frame, "Topleft", 0, 0)

  frame:SetScript("OnSizeChanged", function()
    WCP.frame:resize()
  end)

  return resize_frame
end
