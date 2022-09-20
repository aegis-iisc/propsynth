
qualifier  smem : Stack :-> a :-> bool;
qualifier  shd : Stack  :-> a :-> bool;
qualifier  sempty : Stack :-> bool;

is_empty : (s : Stack) -> {v : bool | \(u:a). 
                                        ([v=true] => sempty (s) = true /\ smem (s, u) = false) };

top : (s : Stack) -> {v : a | (smem(s, v) = true) /\ (shd(s, v) = true)};


tail : (s : Stack) -> {v : Stack | \(u : a). 
                                    (smem(s, u) = true <=> (smem (v, u) = true \/ shd(s, u) = true))};


push : (x : a) -> 
        (s : Stack) -> 
        {v : Stack | \(u : a). 
            ((smem (v, u) = true /\ smem (s, u) = true) => 
                    not ([x = u] \/ shd (v, u) = true)) /\
                    ((smem (v, u) = true /\ smem (s, u) = false) => 
                    ([x = u] \/ shd (v, u) = true)) /\
                        (([x=u] \/ shd (v, u) = true \/ shd (s, u) = true \/ smem (s, u) = true ) => 
                        smem (v, u) = true)};

concat : (s1 : Stack) -> 
         (s2 : Stack) -> 
         {v : Stack | \(u : a).
            (shd (v, u) = true => (shd (s1, u) = true \/ shd (s2, u) = true)) /\
            (smem (v, u) = true <=> (smem (s1, u) = true \/ smem (s2, u) = true))};


goal : (s1 : Stack) -> 
       (s2 : Stack) -> 
        {v : Stack | \(u : a).
            (shd (v, u) = true => (shd (s1, u) = true \/ shd (s2, u) = true)) /\
            (smem (v, u) = true <=> (smem (s1, u) = true \/ smem (s2, u) = true))};


(*The current implementation fails to find a solution for the else branch*)
if (is_empty s2) then 
    s1
else 
    ---    