local bridge = require("bridge_lua")

bridge.put_string("foo")
print(bridge.get_string())
