local bridge = require("bridge_lua")

bridge.put_string("foo")
local s = bridge.get_string()
io.write(s, "\n")
