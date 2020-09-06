function getglobal(name)
  obj = {}

  function obj.SetText() return false end

  return obj
end

function strsplit(...)
  return {}
end

function UnitName(type)
  return "Deradon"
end


function CreateFrame(type)
  texture = {}
  function texture.SetPoint() return false end
  function texture.SetWidth() return false end
  function texture.SetHeight() return false end
  function texture.SetTexture() return false end
  function texture.SetText() return false end

  frame = {
    Low = texture,
    High = texture,
    Text = texture,
  }
  function frame.CreateFontString() return texture end
  function frame.CreateTexture() return texture end
  function frame.EnableMouse() return true end
  function frame.GetFrameLevel() return 1 end
  function frame.GetHeight() return 1 end
  function frame.GetLeft() return 1 end
  function frame.GetName() return "MockedFrame" end
  function frame.GetTop() return 1 end
  function frame.GetWidth() return 1 end
  function frame.Hide() return true end
  function frame.RegisterEvent() return true end
  function frame.SetAlpha() return true end
  function frame.SetBackdrop() return true end
  function frame.SetFrameLevel() return true end
  function frame.SetFrameStrata() return true end
  function frame.SetHeight() return true end
  function frame.SetHighlightTexture() return true end
  function frame.SetMaxResize() return true end
  function frame.SetMinMaxValues() return true end
  function frame.SetMinResize() return true end
  function frame.SetMovable() return true end
  function frame.SetNormalTexture() return true end
  function frame.SetPoint() return true end
  function frame.SetPushedTexture() return true end
  function frame.SetResizable() return true end
  function frame.SetResizable() return true end
  function frame.SetScale() return true end
  function frame.SetScript() return true end
  function frame.SetValue() return true end
  function frame.SetValueStep() return true end
  function frame.SetWidth() return true end

  return frame
end

C_ChatInfo = {}
function C_ChatInfo.RegisterAddonMessagePrefix(prefix)
  return true
end

SlashCmdList = {}
