%{
#include "bridge.hpp"
%}

%include typemaps.i
%include std_string.i
%include std_vector.i
%include any.i
%include blank.i
%include optional.i
%include variant.i
%include bridge.hpp

%template(optional_int)    boost::optional<int>;
%template(optional_string) boost::optional<std::string>;
%template(optional_sample) boost::optional<sample>;

REGISTER_ANY(int,    int)
REGISTER_ANY(string, std::string)
REGISTER_ANY(sample, sample)

%template(variant1) boost::variant<boost::blank, double, std::string>;
REGISTER_VARIANT(variant1, blank,  boost::blank)
REGISTER_VARIANT(variant1, double, double)
REGISTER_VARIANT(variant1, string, std::string)

%template(variant2) boost::variant<boost::blank, std::string, boost::recursive_wrapper<node> >;
%template(variant2_vector) std::vector<variant2>;
REGISTER_VARIANT(variant2, blank,  boost::blank)
REGISTER_VARIANT(variant2, string, std::string)
REGISTER_VARIANT(variant2, node,   node)

%template(variant3) boost::variant<int, char>;
REGISTER_VARIANT(variant3, int,  int)
REGISTER_VARIANT(variant3, char, char)
