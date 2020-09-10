WCP.UI.Cursor = {
  last = nil,
  current = nil
}

function WCP.UI.Cursor.set(icon)
  WCP.UI.Cursor.last = WCP.UI.Cursor.current
  WCP.UI.Cursor.current = icon

  if(icon) then
    SetCursor("Interface/Cursor/" .. icon)
  else
    SetCursor(nil)
  end
end

function WCP.UI.Cursor.set_last()
  WCP.UI.Cursor.set(WCP.UI.Cursor.last)
end

function WCP.UI.Cursor.set_current()
  WCP.UI.Cursor.set(WCP.UI.Cursor.current)
end
