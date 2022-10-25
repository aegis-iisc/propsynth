
qualifier tlen : tree :-> int;

dummy : {v : unit | true};

leaf : {v : tree | tlen (v) == 0};


(*There is an issue here, when synthesizing the 3rd argument, the pre-condition cannot be proved 
            without first fixing the second argument, this holds in general for any ith argument.)
node : (root : {v : int | ([v>0] \/ [v=0])}) -> 
                      (sizel : {v : int | true}) -> 
                       (ltree : {v : tree | \(u:int). 
                               (tlen (v) == u) => (tlen (v) == sizel)}) -> 
                       (sizer : {v : int | true}) -> 
                       (rtree : {v : tree | \(u:int). 
                                 (tlen (v) == u) => (tlen (v) == sizer)}) ->
                       {v: tree | \(u : int). (u == sizel + 1) => (tlen (v) == u)};   



sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};


int_gen : (d:unit) -> { v : int | ([v>0] \/ [v=0])}; 

subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};




goal : (s0 : { v : int | true} ) -> 
            {v : tree | \(u:int). 
               (tlen (v) == u) => [u = s0]};
