qualifier tlen : tree :-> int;
qualifier sortedtree : tree :-> bool;
qualifier tmem : tree :-> int :-> bool;
qualifier rng : tree :-> int;
qualifier low : int :-> bool;
qualifier high : int :-> bool;
eq_zero : (s : { v : int | [v > 0] \/ [v=0]}) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};

decrement : (n : {v : int | true}) ->  {v : int | v == n -- 1};

int_range : (a : { v : int | true}) -> 
            (b : { v : int | true}) -> 
            {v : int | not [a > v] /\ not [v > b]};



Leaf : {v : tree | \(u : int).
                    rng (v) == 0 /\
                    tmem (v, u) = false /\ 
                    sortedtree (v) = true };



Node : 
    (root : { v : int | true}) -> 
    (ltree : {v : tree | \(u : int), (range1 : int).  
                    ( (tmem (v, u) = true /\ rng (v) == range1)  => 
                        ([root > u] /\ (u > root -- range1))
                    )/\ 
                    sortedtree (v) = true}
    ) -> 
    (rtree : {v : tree | \(u : int), (range2 : int).  
                    ( (tmem (v, u) = true /\ rng (v) == range2)  => 
                       ([u > root] /\ (root > u -- range2))
                    )/\ 
                    sortedtree (v) = true}
    ) -> 
        {v : tree | 
                    \(u : int). 
                ((u == range1 + range2) => rng (v) == u) /\
                (tmem (v, u) = true => 
                        (u > (root -- range1) /\ 
                        root > (u -- range2))) 
                    /\ sortedtree (v) = true};    


goal : (d : {v : int | [v >0] \/ [v=0]}) -> 
        (s0 : {v : int | not [d > v]}) ->
        (lo : { v : int | true}) -> 
        (hi : { v : int | v == lo + d}) -> 
        {v : tree | \(u : int).
            (
                (tmem (v, u) = true => 
                ([u > lo] /\ [hi > u]) 
                ) /\
                sortedtree (v) = true /\
                rng (v) =  d
            )   
            };
