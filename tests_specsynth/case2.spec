qualifier smem : list :-> int :-> bool;
qualifier slen : list :-> int;


var_xs3 : {v : list | slen(s) > slen (v)};
var_xs4  : {v : list | slen (s) == slen (v) + 1};
x : {v : int | true};
zero  : {v : int | [v = 0]}; 
goal : (s : list) -> {v : int | v == slen (s)};
