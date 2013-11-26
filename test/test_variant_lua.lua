local bridge = require("bridge_lua")

local b = bridge.blank()
print(swig_type(b))

local v = bridge.variant1()
print(swig_type(v))
print(v:which())
print(v:type_name())
bridge.get_variant1_blank(v)

v:set(bridge.make_variant1_double(42))
print(swig_type(v))
print(v:which())
print(v:type_name())
print(bridge.get_variant1_double(v))

v:set(bridge.make_variant1_string("foo"))
print(swig_type(v))
print(v:which())
print(v:type_name())
print(bridge.get_variant1_string(v))
