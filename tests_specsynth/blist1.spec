
qualifier smem : list :-> int :-> bool;
qualifier slen : list :-> int;

un : {v : unit | true};
one : {v : int | [v=1]};
int_gen : (u : unit) -> {v : int | [v > 0]};
subs : (n1 : int) -> {v : int | v == n1 -- 1};
nil : {v : list | slen (v) == 0};
cons : (x : int) -> (xs : list) -> {v : list | slen(v) == slen (xs) + 1}; 
sizecheck : (s : int) -> {v : bool | [v=true] <=> [s=0] /\ [v=false] <=> [s > 0]};


goal : (s : {v : int | [v > 0] \/ [v=0]}) -> {v : list | slen (v) == s};


