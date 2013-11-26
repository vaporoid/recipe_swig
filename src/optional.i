%{
#include <boost/optional.hpp>
%}

namespace boost {
  template <typename T>
  class optional {
  public:
    optional();
    optional(const T&);
    optional(bool, const T&);
    optional(const optional&);

    const T& get() const;
    const T& get_value_or(const T& default_) const;

    %extend {
      void set(const T& rhs) {
        *self = rhs;
      }

      void set(const optional& rhs) {
        *self = rhs;
      }

      void reset() {
        *self = boost::none;
      }

      bool is_initialized() const {
        return static_cast<bool>(*self);
      }
    }
  };
}
