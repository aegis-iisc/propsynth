
qualifier numblack : rbtree :-> int;
qualifier nordered : rbtree :-> bool;
qualifier hdcolor : rbtree :-> bool;


dummy : {v : unit | true};


bool_gen : (d:unit) -> {v : bool | [v=true] <=>[v=true] /\
                                    [v=false] <=> [v=false]};

sizecheck : (s : int) -> 
        {v : bool | [v=true] <=> [s=0] /\ 
                    [v=false] <=> [s>0]};



int_gen : (d:unit) -> { v : int | ([v>0] \/ [v=0])}; 

subs : (n : {v : int | true}) ->  {v : int | v == n -- 1};


lt_eq_one : (s : int) -> {v : bool | [v=true] <=> not [s > 1] /\ 
                            [v=false] <=> [s>1]};



int_range : (a : int) -> (b : int) -> {v : int | not [a > v] /\ not [v > b]};


increment : (n : {v : int | true}) ->  {v : int | v == n + 1};

Rbtleaf : {v : rbtree | numblack (v) == 0 /\
                        nordered (v) = false 
                           };

RbtNode1 : (c : {v : bool | [v = false]}) -> 
          (ltree : {v : rbtree | \(sizel : int).
                        ([sizel > 0] \/ [sizel = 0]) /\
                        numblack (v) == sizel /\
                        nordered (v) = true /\
                        ([sizel = 0] => hdcolor (v) = true)    
                     })  -> 
           (r : int) -> 
           (rtree : {v : rbtree | \(sizer : int), (sizel : int).
                    (numblack (ltree) == sizel) /\
                    [sizer = sizel] /\
                    (numblack (v) == sizer) /\
                    nordered (v) = true /\
                    ([sizer = 0] => hdcolor (v) = true) 
            }) -> 
        {v : rbtree | \(u : int). 
                hdcolor (v) = false /\
                ((u = numblack (ltree) + 1) => 
                    (numblack (v) = u /\ 
                    nordered (v) = true
                    )
                 )   
        };          

RbtNode2 : (c : {v : bool | true}) -> 
          (ltree : {v : rbtree | \(sizel : int).
                        ([sizel > 0] \/ [sizel = 0]) /\
                        numblack (v) == sizel /\
                        nordered (v) = true /\
                        hdcolor (v) = false    
                     })  -> 
           (r : int) -> 
           (rtree : {v : rbtree | \(sizer : int), (sizel : int).
                    (numblack (ltree) == sizel) /\
                    [sizer = sizel] /\
                    (numblack (v) == sizer) /\
                    nordered (v) = true /\
                    hdcolor (v) = false 
            }) -> 
        {v : rbtree | \(sizel : int). 
                numblack (ltree) == sizel /\
                hdcolor (v) = true /\
                numblack (v) == sizel /\ 
                nordered (v) = true
        };

goal : (inv : {v : int | [v>0] \/ [v=0]}) -> 
       (c : bool) -> 
       (height : {v : int | 
            ([v>0] \/ [v=0]) /\ 
            ([c=true] => inv == v + v) /\
            ([c=false] => inv == v + v + 1)
            }) -> 
       {v : rbtree | \(u : int).
        numblack(v) == height /\
        nordered(v) = true /\
       ( 
        ([c=true] /\ hdcolor(v) = false) \/
        ([c=false] /\ ([height=0] => hdcolor (v) = true))
        )};     



          

