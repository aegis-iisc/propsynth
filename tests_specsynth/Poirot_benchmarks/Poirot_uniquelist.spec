qualifier slen : ulist :-> int;
qualifier ulist : ulist :-> bool;
qualifier shd : ulist :-> int;
qualifier smem : ulist :-> int :-> bool;


subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};

Unil : {v : ulist | \(u : int).
                    smem (v, u) = false /\ 
                    not (shd (v) = u) /\
                    slen (v) == 0 /\
                    ulist (v) = true};
sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};

Ucons : (x : {v : int | [v>0] \/ [v=0]}) -> 
       (xs : {v : ulist | ulist (v) = true}) -> 
                {v : ulist | 
                    \(u : int). 
                        (smem (v, u) = true <=> (smem (xs, u) = true \/ [u = x])) /\
                        (shd (v) = u <=> [u = x]) /\
                        (shd (v) = u => smem (v, u) = true) /\
                        (slen (v) == slen (xs) + 1) /\
                        (ulist (v) = true)
                         }; 



goal : (size: { v : int | true}) -> 
                (x0 : {v : int | [v>0] \/ [v=0]}) -> 
                    {v : ulist | \(u : int). 
                            slen (v) == size /\
                            ulist (v) = true /\    
                            (smem (v, u) = true => [u = x0])};


                                                 