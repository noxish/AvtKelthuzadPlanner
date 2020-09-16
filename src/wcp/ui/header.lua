WCP.UI.Header = {}

function WCP.UI.Header.attach_to(parent)
  local header = CreateFrame("Frame", nil, parent)
  header:SetPoint("TOP", parent, "TOP", 0, 12)
  header:SetWidth(256)
  header:SetHeight(64)
  header:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Header"
  })

  header:SetScript("OnMouseDown", function()
    parent:StartMoving("TOPLEFT")
    parent:SetUserPlaced(true)
  end)

  header:SetScript("OnMouseUp", function()
    parent:StopMovingOrSizing()
  end)

  local title = header:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  title:SetPoint("CENTER", header, "CENTER", 0, 12)
  title:SetText("WrongCthun Planner")
end
