
qualifier slen : list :-> int;
qualifier slist : list :-> bool;
qualifier shd : list :-> int;
qualifier sorder : list :-> int :-> int :-> bool;
qualifier smem : list :-> int :-> bool;


gt_eq_int_gen : (n3: int) -> {v : int | [v > n3] \/ [v = n3]}; 


subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};

Nil : {v : list | \(u : int).
                    slen (v) == 0};
sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};

Cons : (x : {v : int | [v>0] \/ [v=0]}) -> 
       (xs : {v : list | true}) -> 
                {v : list | 
                    \(u : int). 
                        ((u == slen (xs) + 1) => slen (v) == u)
                         }; 




goal : (size : { v : int | true}) -> 
                    {v : list | \(u : int). 
            (slen (v) == u => ( ([u > 0] \/ [u = 0]) /\  ([u = size])))};
