%{
#include <boost/any.hpp>

template <typename T>
inline boost::any make_any(const T& value) {
  return boost::any(value);
}
%}

namespace boost {
  class any {
  public:
    any();
    any(const any&);

    bool empty() const;

    %extend {
      void set(const any& rhs) {
        *self = rhs;
      }

      const char* type_name() const {
        return self->type().name();
      }
    }
  };

  template <typename T>
  T any_cast(const any&);
}

template <typename T>
boost::any make_any(const T&);
