local bridge = require("bridge_lua")

local v = bridge.get_empty_any()
assert(v:empty())

local v = bridge.get_any_int()
assert(not v:empty())
print(bridge.get_any_int(v))

local v = bridge.get_any_string()
assert(not v:empty())
print(bridge.get_any_string(v))

local v = bridge.get_any_sample()
assert(not v:empty())
bridge.get_any_sample(v):run();
v:set(bridge.get_empty_any());

local v = bridge.new_any_int(69);
assert(not v:empty())
print(bridge.get_any_int(v))
print(v:type_name())

local result = bridge.add(42, 69)
print(result)
