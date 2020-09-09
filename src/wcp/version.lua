WCP.Version = {}

WCP.Version.MAJOR = 0
WCP.Version.MINOR = 3
WCP.Version.PATCH = 0
WCP.Version.PRE_RELEASE = "alpha"

function WCP.Version.to_string()
  local version = (
    WCP.Version.MAJOR .. "." ..
    WCP.Version.MINOR .. "." ..
    WCP.Version.PATCH
  )

  if(WCP.Version.PRE_RELEASE) then
    version = version .. "." .. WCP.Version.PRE_RELEASE
  end

  return version
end
