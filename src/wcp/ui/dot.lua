-- Experimental
WCP.UI.Dot = {}
WCP.UI.Dot.__index = WCP.UI.Dot
WCP.UI.Dot.all = {}

local positions = {
  [1] = {1, 98},       --melee         --
  [2] = {-32, 131},    --healer        -|
  [3] = {-20, 170},    --ranged        -|Group 1
  [4] = {22, 171},     --ranged        -|
  [5] = {34, 132},     --healer/ranged --
  [6] = {67, 71},      -- melee        --
  [7] = {69, 118},     --healer        -|
  [8] = {105, 137},    --ranged        -|Group 2
  [9] = {134, 107},    --ranged        -|
  [10] = {115, 70},    --healer/ranged --
  [11] = {-66, 69},    -- melee        --
  [12] = {-113, 69},   --healer        -|
  [13] = {-132, 106},  --ranged        -|Group 3
  [14] = {-66, 116},   --ranged        -|
  [15] = {-103, 135},  --healer/ranged --
  [16] = {97, 4},      -- melee        --
  [17] = {130, 37},    --healer        -|
  [18] = {169, 24},    --ranged        -|Group 4
  [19] = {170, -17},   --ranged        -|
  [20] = {130, -30},   --healer/ranged --
  [21] = {-93, 2},     -- melee        --
  [22] = {-126, -31},  --healer        -|
  [23] = {-166, -19},  --ranged        -|Group 5
  [24] = {-166, 22},   --ranged        -|
  [25] = {-127, 35},   --healer/ranged --
  [26] = {69, -64},    -- melee        --
  [27] = {117, -64},   --healer        -|
  [28] = {135, -100},  --ranged        -|Group 6
  [29] = {107, -129},  --ranged        -|
  [30] = {70, -110},   --healer/ranged --
  [31] = {-65, -65},   -- melee        --
  [32] = {-65, -112},  --healer        -|
  [33] = {-101, -131}, --ranged        -|Group 7
  [34] = {-130, -102}, --ranged        -|
  [35] = {-112, -66},  --healer/ranged --
  [36] = {3, -92},     -- melee        --
  [37] = {36, -126},   --healer        -|
  [38] = {24, -165},   --ranged        -|Group 8
  [39] = {-18, -165},  --ranged        -|
  [40] = {-30, -126}   --healer/ranged --
}

function WCP.UI.Dot.create_or_update(number, ...)
  local dot = WCP.UI.Dot.all[number]

  if dot == nil then
    dot = WCP.UI.Dot:create(number, ...)
    WCP.UI.Dot.all[number] = dot
  else
    dot:update(number, ...)
  end

  dot:refresh()
end

function WCP.UI.Dot.reset_all()
  for i, dot in pairs(WCP.UI.Dot.all) do
    dot:update(dot.number, nil, nil)
    dot:refresh()
  end
end

-- Initializer
function WCP.UI.Dot:create(...)
  local self = {}

  setmetatable(self, WCP.UI.Dot)

  self:update(...)
  self:create_frame()

  return self
end

function WCP.UI.Dot:update(number, name, class)
  self.number = number
  self.name = name
  self.class = class

  if self.name == nil then self.name = "Empty" end
end

function WCP.UI.Dot:create_frame()
  local x = positions[self.number][1]
  local y = positions[self.number][2]

  self.button = CreateFrame("Button", "CthunDot_" .. self.number, WCP.frame)
  self.button:SetResizable(true)
  self.button:SetPoint("CENTER", WCP.frame, "CENTER", x, y)
  self.button:EnableMouse(true)
  self.button:SetFrameLevel(self.button:GetFrameLevel() + 3)

  local texdot = self.button:CreateTexture(nil, "OVERLAY")
  self.button.texture = texdot
  texdot:SetAllPoints(self.button)

  self:refresh()
end

function WCP.UI.Dot:refresh()
  self:update_texture()
  self:update_tooltip()

  self.button:SetScale(WCP.frame:GetEffectiveScale())
  -- Resizer(frame)
end

function WCP.UI.Dot:update_texture()
  if (self.class == nil) then
    self.button.texture:SetTexture(nil)
  else
    self.button.texture:SetTexture("Interface\\AddOns\\WrongCthunPlanner\\Images\\playerdot_" .. self.class .. ".tga")
  end

  if (WCP.player_name == self.name) then
    self.button:SetWidth(32)
    self.button:SetHeight(32)
  else
    self.button:SetWidth(16)
    self.button:SetHeight(16)
  end
end

function WCP.UI.Dot:update_tooltip()
  self.button:SetScript("OnEnter", function()
    GameTooltip:SetOwner(self.button, "ANCHOR_RIGHT")
    GameTooltip:SetText(self.name)
    GameTooltip:Show()
  end)

  self.button:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
end
