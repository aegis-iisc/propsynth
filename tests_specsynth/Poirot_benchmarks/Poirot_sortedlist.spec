
qualifier slen : list :-> int;
qualifier slist : list :-> bool;
qualifier shd : list :-> int;
qualifier sorder : list :-> int :-> int :-> bool;
qualifier smem : list :-> int :-> bool;


gt_eq_int_gen : (n: int) -> {v : int | [v > n] \/ [v=n]}; 


subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};

Nil : {v : list | \(u : int).
                    smem (v, u) = false /\ 
                    not (shd (v) = u) /\
                    slen (v) == 0 /\
                    slist (v) = true};
sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};

Cons : (x : {v : int | [v>0] \/ [v=0]}) -> 
       (xs : {v : list | slist (v) = true}) -> 
                {v : list | 
                    \(u : int). 
                        (smem (v, u) = true => (not [x > u])) /\
                        (shd (v) = u <=> [u = x]) /\
                        (shd (v) = u => smem (v, u) = true) /\
                        (slen (v) == slen (xs) + 1) /\
                        (slist (v) = true)
                         }; 

goal : (size : { v : int | true}) -> 
                (x0 : {v : int | [v>0] \/ [v=0]}) -> 
                    {v : list | \(u : int). 
                            slen (v) == size /\
                            slist (v) = true /\    
                            (smem (v, u) = true => not [x0 > u])};
