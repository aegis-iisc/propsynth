qualifier slen : list :-> int;
qualifier slist : list :-> bool;
qualifier shd : list :-> int;

subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};
gt : (n1 : {v : int | true}) -> (n2 : {v : int | true}) -> 
        { v : bool | [v=true] <=> [n1>n2] /\ 
                    [v=false] <=> not [n1>n2]};

nil : {v : list | slist (v) = true 
                 /\ slen (v) == 0};
int_gen : (n3: int) -> {v : int | ([v > n3] \/ [v=n3]) 
                    /\  not [v>3]}; 

sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};

cons : (x : int) -> 
       (xs : {v : list | slist (v) = true}) -> 
                {v : list | 
                     (shd (xs) > x \/ shd (xs) == x) 
                     =>
                     (slist (v) = true /\ 
                     slen (v) == slen (xs) + 1 /\
                     shd (v) == x  /\
                     slen(v) > 0) }; 

goal : (s : {v : int | true }) -> 
        (x0 : int) -> 
        {v : list |   slist (v) = true  
                      /\ slen (v) == s 
                      /\ (slen (v) > 0 <=> 
                            (shd (v) > x0 \/ shd (v) == x0))};




