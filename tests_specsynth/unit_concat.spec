
qualifier  smem : Stack :-> a :-> bool;
qualifier  shd : Stack  :-> a :-> bool;
qualifier  sempty : Stack :-> bool;

is_empty : (s : Stack) -> {v : bool | \(u:a). 
                                        ([v=true] => sempty (s) = true /\ smem (s, u) = false) };




goal : (s1 : Stack) -> 
       (s2 : Stack) -> 
        {v : Stack | \(u : a).
            (shd (v, u) = true => (shd (s1, u) = true \/ shd (s2, u) = true)) /\
            (smem (v, u) = true <=> (smem (s1, u) = true \/ smem (s2, u) = true))};
