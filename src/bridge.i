%{
#include "bridge.hpp"
%}

%include std_string.i
%include optional.i

%template(optional_int)    boost::optional<int>;
%template(optional_string) boost::optional<std::string>;
%template(optional_sample) boost::optional<sample>;

%include bridge.hpp
