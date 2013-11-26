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

local function indent (depth)
  for i = 1, depth do
    io.write("  ")
  end
end

local function fn (v, depth)
  local which = v:which()
  if which == 0 then
    indent(depth)
    io.write("blank\n")
  elseif which == 1 then
    indent(depth)
    io.write("string:", bridge.get_variant2_string(v), "\n")
  elseif which == 2 then
    indent(depth)
    io.write("{\n")
    local data = bridge.get_variant2_node(v).data
    for i = 0, data:size() - 1 do
      fn(data[i], depth + 1)
    end
    indent(depth)
    io.write("}\n")
  end
end

fn(bridge.get_variant2(), 0)
