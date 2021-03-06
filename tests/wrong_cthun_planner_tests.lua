lu = require('luaunit')

require "tests/mocks"

-- Wrapper
require "src/wcp";

-- Libs
require "src/wcp/lib/check_addon";
require "src/wcp/lib/events";
require "src/wcp/lib/grid";
require "src/wcp/lib/group";
require "src/wcp/lib/member";
require "src/wcp/lib/slash_commands";
require "src/wcp/version";

-- UI
require "src/wcp/ui";
require "src/wcp/ui/cthun_frame";
require "src/wcp/ui/cursor";
require "src/wcp/ui/dot";
require "src/wcp/ui/header";
require "src/wcp/ui/hide_button";
require "src/wcp/ui/opacity_slider";
require "src/wcp/ui/resize_area";

-- Init
require "src/WrongCthunPlanner";

-- Tests
require "tests/wcp/version";

os.exit(lu.LuaUnit.run())
