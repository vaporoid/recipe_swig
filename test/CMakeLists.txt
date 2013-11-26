FUNCTION(VAPOROID_ADD_TEST_CXX name)
  ADD_EXECUTABLE(${name} ${name}.cpp ${CMAKE_SOURCE_DIR}/src/bridge.cpp)
  TARGET_LINK_LIBRARIES(${name} boost_unit_test_framework)
  ADD_TEST(${name} ${name})
ENDFUNCTION(VAPOROID_ADD_TEST_CXX)

FUNCTION(VAPOROID_ADD_TEST_LUA name)
  ADD_TEST(NAME ${name}
    COMMAND env
      "LUA_PATH=${CMAKE_SOURCE_DIR}/src/?.lua;;"
      "LUA_CPATH=${CMAKE_BINARY_DIR}/src/?.so;;"
      lua ${name}.lua
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  )
ENDFUNCTION(VAPOROID_ADD_TEST_LUA)

FUNCTION(VAPOROID_ADD_TEST_JAVA name)
  ADD_JAR(${name}
    ${name}.java
    ${CMAKE_BINARY_DIR}/src/Bridge.java
    ${CMAKE_BINARY_DIR}/src/BridgeJNI.java
    ${CMAKE_BINARY_DIR}/src/any.java
    ${CMAKE_BINARY_DIR}/src/blank.java
    ${CMAKE_BINARY_DIR}/src/optional_int.java
    ${CMAKE_BINARY_DIR}/src/optional_sample.java
    ${CMAKE_BINARY_DIR}/src/optional_string.java
    ${CMAKE_BINARY_DIR}/src/sample.java
    ${CMAKE_BINARY_DIR}/src/variant1.java
  )
  ADD_TEST(NAME ${name}
    COMMAND ${Java_JAVA_EXECUTABLE}
      -classpath ${name}.jar
      -enableassertions
      ${name} ${CMAKE_BINARY_DIR}/src/bridge_java.jnilib
  )
ENDFUNCTION(VAPOROID_ADD_TEST_JAVA)

VAPOROID_ADD_TEST_CXX(test_optional_cxx)
VAPOROID_ADD_TEST_LUA(test_optional_lua)
VAPOROID_ADD_TEST_JAVA(TestOptionalJava)

VAPOROID_ADD_TEST_CXX(test_any_cxx)
VAPOROID_ADD_TEST_LUA(test_any_lua)
VAPOROID_ADD_TEST_JAVA(TestAnyJava)

VAPOROID_ADD_TEST_CXX(test_variant_cxx)
VAPOROID_ADD_TEST_LUA(test_variant_lua)
VAPOROID_ADD_TEST_JAVA(TestVariantJava)
