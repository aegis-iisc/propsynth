
qualifier  smem : list :-> a :-> bool;
qualifier  shd : list  :-> a :-> bool;
qualifier  sempty : list :-> bool;
qualifier slen : list :-> int;

is_empty : (s : list) -> {v : bool | \(u:a). 
                                        ([v=true] => sempty (s) = true /\ smem (s, u) = false) };


top : (s : list) -> {v : a | (smem(s, v) = true) /\ (shd(s, v) = true)};

tail : (s : list) -> {v : list | \(u : a). 
                                    (smem(s, u) = true <=> (smem (v, u) = true \/ shd(s, u) = true))};

push : (x : a) -> 
        (s : list) -> 
        {v : list | \(u : a). 
            ((smem (v, u) = true /\ smem (s, u) = true) => 
                    not ([x = u] \/ shd (v, u) = true)) /\
                    ((smem (v, u) = true /\ smem (s, u) = false) => 
                    ([x = u] \/ shd (v, u) = true)) /\
                        (([x=u] \/ shd (v, u) = true \/ shd (s, u) = true \/ smem (s, u) = true ) => 
                        smem (v, u) = true)};




goal : (s1 : list) -> 
       (s2 : list) -> 
        {v : list | \(u : a).
            (shd (v, u) = true => (shd (s1, u) = true \/ shd (s2, u) = true)) /\
            (smem (v, u) = true <=> (smem (s1, u) = true \/ smem (s2, u) = true))};

