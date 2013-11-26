%{
#include "bridge.hpp"
%}

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

%template(make_any_int)    make_any<int>;
%template(make_any_string) make_any<std::string>;
%template(make_any_sample) make_any<sample>;
%template(get_any_int)    get_any<int>;
%template(get_any_string) get_any<std::string>;
%template(get_any_sample) get_any<sample>;

%template(variant1) boost::variant<boost::blank, double, std::string>;
%template(make_variant1_blank)  make_variant<variant1, boost::blank>;
%template(make_variant1_double) make_variant<variant1, double>;
%template(make_variant1_string) make_variant<variant1, std::string>;
%template(get_variant1_blank)  get_variant<boost::blank, variant1>;
%template(get_variant1_double) get_variant<double,       variant1>;
%template(get_variant1_string) get_variant<std::string,  variant1>;

%template(variant2) boost::variant<boost::blank, std::string, boost::recursive_wrapper<node> >;
%template(variant2_vector) std::vector<variant2>;
%template(get_variant2_string) get_variant<std::string, variant2>;
%template(get_variant2_node)   get_variant<node,        variant2>;

%template(variant3) boost::variant<int, char>;
%template(get_variant3_int)  get_variant<int,  variant3>;
%template(get_variant3_char) get_variant<char, variant3>;
