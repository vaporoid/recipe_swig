#include <iostream>
#include <stdexcept>
#include <boost/current_function.hpp>
#include <boost/spirit/include/qi.hpp>
#include "bridge.hpp"

boost::optional<std::string> get_empty_optional_string() {
  return boost::none;
}

boost::optional<std::string> get_optional_string() {
  return std::string("foo");
}

boost::any get_empty_any() {
  return boost::any();
}

boost::any get_any_int() {
  return boost::any(42);
}

boost::any get_any_string() {
  return boost::any(std::string("foo"));
}

boost::any get_any_sample() {
  return boost::any(sample());
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
  return *this;
}

void sample::run() {
  std::cout << BOOST_CURRENT_FUNCTION << ": " << this << std::endl;
}

variant2 get_variant2() {
  return variant2 {
    node {
      {
        { boost::blank() },
        { "foo" },
        { "bar" },
        node {
          {
            { "baz" },
            { "qux" }
          }
        }
      }
    }
  };
}

// http://d.hatena.ne.jp/faith_and_brave/20100618/1276843423
variant3 parse_variant3(const std::string& value) {
  const boost::spirit::qi::rule<std::string::const_iterator, variant3()> rule
      = boost::spirit::qi::int_
      | boost::spirit::qi::char_;

  variant3 result;
  if (!boost::spirit::qi::parse(value.begin(), value.end(), rule, result)) {
    throw std::runtime_error("could not parse");
  }
  return result;
}
