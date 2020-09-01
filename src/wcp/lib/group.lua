WCP.LIB.Group = {}
WCP.LIB.Group.__index = WCP.LIB.Group

-- Initializer
function WCP.LIB.Group:create(number)
  local self = {}

  setmetatable(self, WCP.LIB.Group)

  self.number = number
  self.members = {}

  return self
end

function WCP.LIB.Group:add_member(member)
  if(member:is_available() == false) then return false end

  if(member:is_melee()) then
    self:handle_melee(member)
  elseif(member:is_range()) then
    self:handle_range(member)
  elseif(member:is_heal()) then
    self:handle_heal(member)
  end
end

function WCP.LIB.Group:handle_melee(member)
  if(self.members[1] == nil) then
    self.members[1] = member
  elseif(self.members[5] == nil) then
    self.members[5] = member
  elseif(self.members[2] == nil) then
    self.members[2] = member
  elseif(self.members[3] == nil) then
    self.members[3] = member
  else
    self.members[4] = member
  end
end

function WCP.LIB.Group:handle_range(member)
  if(self.members[3] == nil) then
    self.members[3] = member
  elseif(self.members[4] == nil) then
    self.members[4] = member
  elseif(self.members[5] == nil) then
    self.members[5] = member
  elseif(self.members[2] == nil) then
    self.members[2] = member
  else
    self.members[1] = member
  end
end

function WCP.LIB.Group:handle_heal(member)
  if(self.members[2] == nil) then
    self.members[2] = member
  elseif(self.members[5] == nil) then
    self.members[5] = member
  elseif(self.members[3] == nil) then
    self.members[3] = member
  elseif(self.members[4] == nil) then
    self.members[4] = member
  else
    self.members[1] = member
  end
end
