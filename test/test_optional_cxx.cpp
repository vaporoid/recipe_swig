#include <cassert>
#include <iostream>
#include <bridge.hpp>

#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MAIN
#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_CASE(test_optional) {
  put_string("foo");
  auto s = get_string();
  std::cout << s << "\n";

  {
    boost::optional<int> v { };
    std::cout << v << "\n";
    std::cout << v.get_value_or(69) << "\n";
    v = 105;
    std::cout << v << "\n";
    std::cout << v.get_value_or(69) << "\n";
  }

  {
    boost::optional<int> v { 42 };
    std::cout << v << "\n";
    std::cout << v.get_value_or(69) << "\n";
    v = boost::none;
    std::cout << v << "\n";
    std::cout << v.get_value_or(69) << "\n";
  }

  {
    boost::optional<std::string> v { get_empty_optional_string() };
    assert(!v);

    v = get_optional_string();
    assert(v);
    std::cout << *v << "\n";
  }

  {
    boost::optional<sample> v { };
    std::cout << "start\n";
    v = sample();
    v->run();
    v = boost::none;
    std::cout << "end\n";
  }
}
