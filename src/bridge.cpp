#include <iostream>
#include <boost/current_function.hpp>
#include "bridge.hpp"

void put_string(const std::string& value) {
  std::cout << BOOST_CURRENT_FUNCTION << ": " << value << std::endl;
}

std::string get_string() {
  std::cout << BOOST_CURRENT_FUNCTION << std::endl;
  return "foo";
}

boost::optional<std::string> get_empty_optional_string() {
  return boost::none;
}

boost::optional<std::string> get_optional_string() {
  return std::string("foo");
}

sample::sample() {
  std::cout << BOOST_CURRENT_FUNCTION << ": " << this << std::endl;
}

sample::sample(const sample& rhs) {
  std::cout << BOOST_CURRENT_FUNCTION << ": " << this << ": " << &rhs << std::endl;
}

sample::~sample() {
  std::cout << BOOST_CURRENT_FUNCTION << ": " << this << std::endl;
}

sample& sample::operator=(const sample& rhs) {
  std::cout << BOOST_CURRENT_FUNCTION << ": " << this << ": " << &rhs << std::endl;
}

void sample::run() {
  std::cout << BOOST_CURRENT_FUNCTION << ": " << this << std::endl;
}
