qualifier slen : list :-> int;
subs : (n1 : {v : int | [v>1]}) ->  {v : int | v == n1 -- 1};
nil : {v : list | slen (v) == 0};

int_gen : {v : int | true}; 
sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>1]};

cons : (x : int) -> (xs : list) -> {v : list | slen(v) == slen (xs) + 1}; 
goal : (s : {v : int | [v>1] \/ 
            [v=0]}) -> {v : list | slen (v) == s};

