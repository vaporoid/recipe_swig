#ifndef BRIDGE_HPP
#define BRIDGE_HPP

#include <string>
#include <boost/optional.hpp>

void put_string(const std::string& value);
std::string get_string();

boost::optional<std::string> get_empty_optional_string();
boost::optional<std::string> get_optional_string();

class sample {
public:
  explicit sample();
  explicit sample(const sample& rhs);
  ~sample();
  sample& operator=(const sample& rhs);
  void run();
};

#endif
