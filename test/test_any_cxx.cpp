#include <cassert>
#include <iostream>
#include <bridge.hpp>

#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MAIN
#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_CASE(test_variant) {
  {
    auto v = get_empty_any();
    assert(v.empty());
  }

  {
    auto v = get_any_int();
    assert(!v.empty());
    std::cout << boost::any_cast<int>(v) << "\n";
  }

  {
    auto v = get_any_string();
    assert(!v.empty());
    std::cout << boost::any_cast<std::string>(v) << "\n";
  }

  {
    auto v = get_any_sample();
    assert(!v.empty());
    boost::any_cast<sample>(v).run();
    v = get_empty_any();
  }

  {
    boost::any v(69);
    assert(!v.empty());
    std::cout << boost::any_cast<int>(v) << "\n";
  }
}
