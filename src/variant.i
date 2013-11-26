%{
#include <boost/variant/variant.hpp>
#include <boost/variant/get.hpp>

// #include <boost/mpl/assert.hpp>
// #include <boost/mpl/bool.hpp>
// BOOST_MPL_ASSERT((boost::mpl::bool_<BOOST_VARIANT_LIMIT_TYPES == 20>));

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
    typename T0,
    typename T1  = boost::detail::variant::void_,
    typename T2  = boost::detail::variant::void_,
    typename T3  = boost::detail::variant::void_,
    typename T4  = boost::detail::variant::void_,
    typename T5  = boost::detail::variant::void_,
    typename T6  = boost::detail::variant::void_,
    typename T7  = boost::detail::variant::void_,
    typename T8  = boost::detail::variant::void_,
    typename T9  = boost::detail::variant::void_,
    typename T10 = boost::detail::variant::void_,
    typename T11 = boost::detail::variant::void_,
    typename T12 = boost::detail::variant::void_,
    typename T13 = boost::detail::variant::void_,
    typename T14 = boost::detail::variant::void_,
    typename T15 = boost::detail::variant::void_,
    typename T16 = boost::detail::variant::void_,
    typename T17 = boost::detail::variant::void_,
    typename T18 = boost::detail::variant::void_,
    typename T19 = boost::detail::variant::void_
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
