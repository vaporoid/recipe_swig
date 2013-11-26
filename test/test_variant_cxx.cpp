#include <iostream>
#include <bridge.hpp>

#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MAIN
#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_CASE(test_variant) {
  boost::blank b;
  std::cout << typeid(b).name() << "\n";
}
