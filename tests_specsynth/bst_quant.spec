


gt_eq_int_gen : (n3: int) -> {v : int | [v > n3] \/ [v=n3]}; 


decrement : (n : {v : int | true}) ->  {v : int | v == n -- 1};



increment : (n : {v : int | true}) ->  {v : int | v == n + 1};


leaf : {v : tree | \(u : int).
                    tmem (v, u) = false /\ sortedtree (v) = true};



node : (root : int) -> (sizel : {v : int | ([v>0] \/ [v=0])} -> 
                       (ltree : {v : tree | \(u:int). 
                                (tmem (v, u) = true => [root > u] /\ (u > root -- sizel) ) /\ sortedtree (v) = true }) -> 
                       (sizer : {v : int | ([v>0] \/ [v=0])} -> 
                       (rtree : {v : tree | \(u:int). 
                                (tmem (v, u) = true =>  [u > root] /\(root > u -- sizer) ) /\ sortedtree (v) = true }) ->
                       {v: tree | \(u : int). (tmem (v, u) => (u > (soot -- sizel) /\ root > u -- sizer)) 
                                  /\ sortedtree (v) = true    
