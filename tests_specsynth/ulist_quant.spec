qualifier slen : list :-> int;
qualifier ulist : list :-> bool;
qualifier shd : list :-> int;
qualifier smem : list :-> int :-> bool;


subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};

nil : {v : list | \(u : int).
                    smem (v, u) = false /\ 
                    not (shd (v) = u) /\
                    slen (v) == 0};
sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};

cons : (x : int) -> 
       (xs : {v : list | ulist (v) = true}) -> 
                {v : list | 
                    \(u : int). 
                        (smem (v, u) = true <=> (smem (xs, u) = true \/ [u = x])) /\
                        (shd (v) = u <=> [u = x]) /\
                        (shd (v) = u => smem (v, u) = true) /\
                        (slen (v) == slen (xs) + 1) }; 



goal : (s : { v : int | [v>0] \/ [v=0]}) -> 
                (x0 : int) -> 
                    {v : list | \(u : int). 
                            smem (v, u) = true => [u = x0]};

