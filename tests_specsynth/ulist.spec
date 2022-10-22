qualifier slen : list :-> int;
qualifier ulist : list :-> bool;
qualifier shd : list :-> int;
qualifier smem : list :-> int :-> bool;


subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};

nil : {v : list | ulist (v) = true 
                 /\ slen (v) == 0};
sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};

cons : (x : int) -> 
       (xs : {v : list | ulist (v) = true}) -> 
                {v : list | 
                     (smem (xs, x) = true \/ slen (xs) == 0) => 
                     (ulist (v) = true /\ slen (v) == slen (xs) + 1 /\ smem (v, x) = true)  }; 

goal : (s : { v : int | [v>0] \/ [v=0]}) -> 
                (x0 : int) -> 
                    {v : list | slen (v) == s /\ 
                                ulist (v) = true /\ 
                                smem (v, x0) = true };

