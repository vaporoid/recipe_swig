#ifndef BRIDGE_HPP
#define BRIDGE_HPP

#include <string>
#include <boost/any.hpp>
#include <boost/blank.hpp>
#include <boost/optional.hpp>
#include <boost/variant/variant.hpp>
#include <boost/variant/get.hpp>

void put_string(const std::string& value);
std::string get_string();

boost::optional<std::string> get_empty_optional_string();
boost::optional<std::string> get_optional_string();

boost::any get_empty_any();
boost::any get_any_int();
boost::any get_any_string();
boost::any get_any_sample();

class sample {
public:
  sample();
  sample(const sample& rhs);
  ~sample();
  sample& operator=(const sample& rhs);
  void run();
};

typedef boost::variant<boost::blank, double, std::string> variant1;

#endif
