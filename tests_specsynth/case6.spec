qualifier slen : list :-> int;
qualifier slist : list :-> bool;
qualifier shd : list :-> int;


subs : (n : {v : int | [v > 0]}) ->  {v : int | v == n -- 1};
gt : (n1 : {v : int | [v>0]}) -> (n2 : {v : int | [v>0]}) -> 
        { v : bool | [v=true] <=> [n1>n2] /\ 
                    [v=false] <=> not [n1>n2]};

nil : {v : list | slist (v) = true 
                    /\ slen (v) == 0};
int_gen : (n3: int) -> {v : int | [v > n3]}; 

sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};

cons : (x : int) -> 
       (xs : {v : list | slist (v) = true }) -> 
                {v : list | 
                    ( (not (slen (v) == 0)) => shd (xs) > x) /\
                    (shd (xs) > x) => 
                                (slist (v) = true /\ 
                                 slen (v) == slen (xs) + 1 /\
                                 shd (v) > x)}; 

goal : (s : { v : int | [v >0]}) -> 
            (x0 :int) -> 
            {v : list | slist (v) = true 
                            /\ slen (v) == s 
                            /\ (slen (v) > 0 
                                    =>  
                                    shd (v) > x0) };

