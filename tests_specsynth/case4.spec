
qualifier slen : list :-> int;
subs : (n1 : int) ->  {v : int | v == n1 -- 1};
nil : {v : list | slen (v) == 0};

int_gen : int; 
sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ [v=false] <=> [s > 0]};

cons : (x : int) -> (xs : list) -> {v : list | slen(v) == slen (xs) + 1}; 
goal : (s : {v : int | true}) -> {v : list | slen (v) == s};


