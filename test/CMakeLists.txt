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
    ${CMAKE_BINARY_DIR}/src/optional_int.java
    ${CMAKE_BINARY_DIR}/src/optional_sample.java
    ${CMAKE_BINARY_DIR}/src/optional_string.java
    ${CMAKE_BINARY_DIR}/src/sample.java
  )
  ADD_TEST(NAME ${name}
    COMMAND ${Java_JAVA_EXECUTABLE}
      -classpath ${name}.jar
      -enableassertions
      ${name} ${CMAKE_BINARY_DIR}/src/bridge_java.jnilib
  )
ENDFUNCTION(VAPOROID_ADD_TEST_JAVA)

VAPOROID_ADD_TEST_LUA(test_optional_lua)
VAPOROID_ADD_TEST_JAVA(TestOptionalJava)
