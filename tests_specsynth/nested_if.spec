
qualifier slen : list :-> int;
qualifier slist : list :-> bool;
qualifier shd : list :-> int;
qualifier sorder : list :-> int :-> int :-> bool;
qualifier smem : list :-> int :-> bool;


un : unit;
bool_gen : (u : unit) -> {v : bool | [v=true] <=>[v=true] /\
                                    [v=false] <=> [v=false]};

sizecheck : (s : int) -> 
    {v : bool | [v=true] <=> [s=0] /\ 
                [v=false] <=> [s>0]};


gt_eq_int_gen : (n3: int) -> {v : int | [v > n3] \/ [v = n3]}; 


Nil : {v : list | \(u : int).
                    slen (v) == 0};
goal : (size : { v : int | true}) -> 
                    {v : list | \(u : int). 
            (slen (v) == u => ( ([u > 0] \/ [u = 0]) /\ 
                             [u = size]))};
