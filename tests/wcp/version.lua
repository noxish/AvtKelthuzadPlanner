TestVersion = {}

function TestVersion.testMajor()
  lu.assertEquals(WCP.Version.MAJOR, 0)
end

function TestVersion.testMinor()
  lu.assertEquals(WCP.Version.MINOR, 2)
end


function TestVersion.testPatch()
  lu.assertEquals(WCP.Version.PATCH, 4)
end

function TestVersion.testPreRelease()
  lu.assertEquals(WCP.Version.PRE_RELEASE, nil)
end

function TestVersion.test_to_string()
  lu.assertEquals(WCP.Version.to_string(), "0.2.4")
end
