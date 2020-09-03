WCP.UI.Header = {}

function WCP.UI.Header.attach_to(frame)
  local header = CreateFrame("Frame", nil, frame)
  header:SetPoint("TOP", frame, "TOP", 0, 12)
  header:SetWidth(256)
  header:SetHeight(64)
  header:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Header"
  })

  header:SetScript("OnMouseDown", function()
    frame:StartMoving("TOPLEFT")
    frame:SetUserPlaced(true)
  end)

  header:SetScript("OnMouseUp", function()
    frame:StopMovingOrSizing()
  end)

  local title = header:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  title:SetPoint("CENTER", header, "CENTER", 0, 12)
  title:SetText("WrongCthun Planner")
end
