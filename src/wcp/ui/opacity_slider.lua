WCP.UI.OpacitySlider = {}

function WCP.UI.OpacitySlider.attach_to(frame)
  local slider = CreateFrame("Slider", nil, frame, "OptionsSliderTemplate")
  slider:SetPoint("BOTTOM", frame, "BOTTOM", 0, 20)
  slider:SetMinMaxValues(0.05, 1.00)
  slider:SetValue(1.00)
  slider:SetValueStep(0.05)
  slider:SetResizable(true)

  slider["Low"]:SetText("5%")
  slider["High"]:SetText("100%")
  slider["Text"]:SetText("Opacity")

  slider:SetScript("OnValueChanged", function(self)
    local value = slider:GetValue()
    frame:SetAlpha(value)
  end)
end
