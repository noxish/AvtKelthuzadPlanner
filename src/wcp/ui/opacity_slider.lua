WCP.UI.OpacitySlider = {}

function WCP.UI.OpacitySlider.attach_to(frame)
  local slider = CreateFrame("Slider", "MySlider1", frame, "OptionsSliderTemplate")
  slider:SetPoint("BOTTOM", frame, "BOTTOM", 0, 20)
  slider:SetMinMaxValues(0.05, 1.00)
  slider:SetValue(1.00)
  slider:SetValueStep(0.05)
  slider:SetResizable(true)
  getglobal(slider:GetName() .. "Low"):SetText("5%")
  getglobal(slider:GetName() .. "High"):SetText("100%")
  getglobal(slider:GetName() .. "Text"):SetText("Opacity")
  slider:SetScript("OnValueChanged", function(self)
    local value = slider:GetValue()
    frame:SetAlpha(value)
  end)
end
