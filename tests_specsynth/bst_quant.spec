
qualifier tlen : tree :-> int;
qualifier sortedtree : tree :-> bool;
qualifier tmem : tree :-> int :-> bool;


dummy : {v : unit | true};

bool_gen : (u:unit) -> {v : bool | [v=true] <=>[v=true] /\
                                    [v=false] <=> [v=false]};


lt_eq_one : (s : int) -> {v : bool | [v=true] <=> not [s > 1] /\ 
                            [v=false] <=> [s>1]};


decrement : (n : {v : int | true}) ->  {v : int | v == n -- 1};

int_range : (a : int) -> (b : int) -> {v : int | not [a > v] /\ not [v > b]};


increment : (n : {v : int | true}) ->  {v : int | v == n + 1};


Leaf : {v : tree | \(u : int).
                    tmem (v, u) = false /\ 
                    sortedtree (v) = true /\
                    tlen (v) == 0};



Node : (root : { v : int | [v>0] \/ [v=0]}) -> 
                    (ltree : {v : tree | tlen (v) > 0 \/ tlen (v) == 0 }) -> 
                    (rtree : {v : tree | tlen (v) > 0 \/ tlen (v) == 0}) -> 
                {v : tree | 
                    \(ul:int), (ur : int), (u:int), (sizel : int), (sizer : int). 
                (
                    (
                        (tmem (ltree, ul) = true /\ tlen (ltree) == sizel)  => 
                        ([root > ul] /\ (ul > root -- sizel))
                    )/\ sortedtree (ltree) = true
                )/\
                (
                    (
                        (tmem (rtree, ur) = true /\ tlen (rtree) == sizer)  => 
                        ([ur > root] /\ (root > ur -- sizer))
                    )/\ sortedtree (rtree) = true
                )
                /\
                (tmem (v, u) = true => 
                        (u > (root -- sizel) /\ root > (u -- sizer))) 
                                  /\ sortedtree (v) = true};    

goal : (d : {v : int | [v >0] \/ [v=0]}) -> 
        (lo : int) -> 
        (hi : { v : int | v == lo + d}) -> 
        {v : tree | \(u : int).
            
            (hi == (lo + d)) /\ 
            
            (
                (tmem (v, u) = true => 
                ([u > lo] /\ [hi > u]) 
                ) /\
                sortedtree (v) = true /\
                ([d > u] => tlen (v) == u)
            )   
            };
