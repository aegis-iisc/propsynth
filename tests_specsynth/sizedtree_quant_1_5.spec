
qualifier tlen : tree :-> int;

Leaf : {v : tree | tlen (v) == 0};
dummy : {v : unit | true};


Node : (root : {v : int | true}) -> 
                       (ltree : {v : tree | true}) -> 
                       (rtree : {v : tree | true}) ->
                       {v: tree | \(u : int),(sizel : int), (sizer : int). 
                        (tlen (ltree) == sizel /\ tlen(rtree) == sizer /\ [sizel=sizer] /\ u == sizel + 1) => (tlen (v) == u)};   




sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};


int_gen : (d:unit) -> { v : int | ([v>0] \/ [v=0])}; 

subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};


goal : (s0 : { v : int | true} ) -> 
            {v : tree | \(u:int). 
               (tlen (v) == u) => [u = s0]};


