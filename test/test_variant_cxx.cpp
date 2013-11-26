#include <iostream>
#include <boost/variant/apply_visitor.hpp>
#include <boost/variant/static_visitor.hpp>
#include <bridge.hpp>

#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MAIN
#include <boost/test/unit_test.hpp>

class fn : public boost::static_visitor<> {
public:
  explicit fn(int depth)
    : depth_(depth) {}

  void operator()(const boost::blank&) const {
    indent_();
    std::cout << "blank\n";
  }

  void operator()(const std::string& value) const {
    indent_();
    std::cout << "string:" << value << "\n";
  }

  void operator()(const node& node) const {
    indent_();
    std::cout << "{\n";

    for (const auto& i : node.data) {
      boost::apply_visitor(fn { depth_ + 1 }, i);
    }

    indent_();
    std::cout << "}\n";
  }

private:
  int depth_;

  void indent_() const {
    for (int i = 0; i < depth_; ++i) {
      std::cout << "  ";
    }
  }
};

BOOST_AUTO_TEST_CASE(test_variant) {
  boost::blank b;
  std::cout << typeid(b).name() << "\n";

  {
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

  {
    auto v = get_variant2();
    boost::apply_visitor(fn { 0 }, v);
  }

  {
    auto v = parse_variant3("42");
    assert(v.which() == 0);
    assert(boost::get<int>(v) == 42);
  }

  {
    auto v = parse_variant3("x");
    assert(v.which() == 1);
    assert(boost::get<int>(v) == 'x');
  }
}
