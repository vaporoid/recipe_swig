%{
#include <boost/any.hpp>

template <typename T>
inline boost::any new_any(const T& value) {
  return boost::any(value);
}

template <typename T>
inline T get_any(const boost::any& value) {
  return boost::any_cast<T>(value);
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
boost::any new_any(const T&);

template <typename T>
T get_any(const boost::any&);

%define REGISTER_ANY(name, type)
%template(new_any_ ## name) new_any<type>;
%template(get_any_ ## name) get_any<type>;
%enddef
