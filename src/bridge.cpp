#include <iostream>
#include <boost/current_function.hpp>
#include "bridge.hpp"

void put_string(const std::string& value) {
  std::cerr << BOOST_CURRENT_FUNCTION << ": " << value << "\n";
}

std::string get_string() {
  std::cerr << BOOST_CURRENT_FUNCTION << "\n";
  return "foo";
}
