%{
#include <boost/variant/variant.hpp>
#include <boost/variant/get.hpp>

template <typename U, typename T>
inline U make_variant(const T& value) {
  return U(value);
}

template <typename U, typename T>
inline const U& get_variant(const T& value) {
  return boost::get<U>(value);
}
%}

namespace boost {
  template <
    typename T0 = boost::detail::variant::void_,
    typename T1 = boost::detail::variant::void_,
    typename T2 = boost::detail::variant::void_,
    typename T3 = boost::detail::variant::void_,
    typename T4 = boost::detail::variant::void_,
    typename T5 = boost::detail::variant::void_,
    typename T6 = boost::detail::variant::void_,
    typename T7 = boost::detail::variant::void_,
    typename T8 = boost::detail::variant::void_,
    typename T9 = boost::detail::variant::void_
  >
  class variant {
  public:
    variant();
    variant(const variant&);

    int which() const;
    bool empty() const;

    %extend {
      void set(const variant& rhs) {
        *self = rhs;
      }

      const char* type_name() const {
        return self->type().name();
      }
    }
  };
}

template <typename U, typename T>
U make_variant(const T&);

template <typename U, typename T>
U get_variant(const T&);
