#include <iostream>
#include <bridge.hpp>

#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MAIN
#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_CASE(test_variant) {
  boost::blank b;
  std::cout << typeid(b).name() << "\n";

  variant1 v;
  std::cout
      << typeid(v).name() << "\n"
      << v.which()        << "\n"
      << v.type().name()  << "\n";
  boost::get<boost::blank>(v);

  v = variant1(42);
  std::cout
      << typeid(v).name() << "\n"
      << v.which()        << "\n"
      << v.type().name()  << "\n"
      << boost::get<double>(v) << "\n";

  v = variant1("foo");
  std::cout
      << typeid(v).name() << "\n"
      << v.which()        << "\n"
      << v.type().name()  << "\n"
      << boost::get<std::string>(v) << "\n";
}
