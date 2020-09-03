WCP.LIB.Grid = {}
WCP.LIB.Grid.__index = WCP.LIB.Grid

-- Initializer
function WCP.LIB.Grid.create()
  local self = {}

  setmetatable(self, WCP.LIB.Grid)

  self.groups = {}
  self.populated = false

  return self
end

function WCP.LIB.Grid:set_marks()
  if(self.populated == false) then self:refresh() end

  for group_index, group in pairs(self.groups) do
    local member = group.members[1]

    if (member ~= nil) then
      SetRaidTarget(member.name, group_index)
    end
  end
end

function WCP.LIB.Grid:refresh()
  WCP.UI.Dot.reset_all()

  self.groups = {}
  self:populate()
  self:draw()
end

function WCP.LIB.Grid:populate()
  for raid_index = 1, 40 do
    local member = WCP.LIB.Member:create(raid_index)

    self:add_member(member)
  end
  self.populated = true
end

function WCP.LIB.Grid:add_member(member)
  if self.groups[member.subgroup] == nil then
    self.groups[member.subgroup] = WCP.LIB.Group:create(member.subgroup)
  end

  self.groups[member.subgroup]:add_member(member)
end

function WCP.LIB.Grid:draw()
  for group_index, group in pairs(self.groups) do
    for member_index, member in pairs(group.members) do
      local position_index = ((group_index - 1) * 5) + member_index
      WCP.UI.Dot.create_or_update(position_index, member.name, member.class)
    end
  end
end
