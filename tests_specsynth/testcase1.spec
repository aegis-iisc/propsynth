qualifier smem : list :-> int :-> bool;


b : {v : bool | true}; 
s0 : { v : int | [v>0] \/ [v=0]};
x0 : { v : int  | [v>0] \/ [v=0]};

subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};

goal : (s : { v : int | true}) -> 
                (x : {v : int | true}) -> 
                    {v : list | \(u : int). 
                            (smem (v, u) = true => [u = x])};

