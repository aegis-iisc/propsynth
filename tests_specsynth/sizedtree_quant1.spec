
qualifier tlen : tree :-> int;

dummy : {v : unit | true};

leaf : {v : tree | tlen (v) == 0};

node : (root : {v : int | ([v>0] \/ [v=0])}) ->  
                (ltree : {v : tree | true}) -> 
                (rtree : {v : tree | tlen (v) == tlen (ltree)}) ->
                       {v: tree | \(u : int), (sizel : int). 
                            (sizel == tlen (ltree) /\ u == sizel + 1) => (tlen (v) == u)};   



sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};


int_gen : (d:unit) -> { v : int | ([v>0] \/ [v=0])}; 

subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};




goal : (s0 : { v : int | true}) -> 
            {v : tree | \(u:int).(tlen (v) == u) => [u = s0]};
