%{
#include "bridge.hpp"
%}

%include std_string.i
%include any.i
%include blank.i
%include optional.i
%include bridge.hpp

%template(optional_int)    boost::optional<int>;
%template(optional_string) boost::optional<std::string>;
%template(optional_sample) boost::optional<sample>;

%template(make_any_int)    make_any<int>;
%template(make_any_string) make_any<std::string>;
%template(make_any_sample) make_any<sample>;

%template(any_cast_int)    boost::any_cast<int>;
%template(any_cast_string) boost::any_cast<std::string>;
%template(any_cast_sample) boost::any_cast<sample>;
