type vec;
qualifier vdom : heap :-> ref vec :-> bool;
qualifier vmem : vec :-> bool;
qualifier vsel : heap :-> ref vec :-> vec;
qualifier vlen : vec :-> int;


Max : int;


create : (capacity : { v : int | ( [v > 0] \/ [v=0]) /\ not [Max > v]}) -> 
        (dummy : a) -> 
       	State {\(h : heap). true} 
			v : ref vec 
		{ \(h : heap), (v : ref vec), (h' : heap). 
				\(V : vec), (V' : vec).
			      vdom (h, v) = false /\
                  vdom (h', v) = true /\
                  vsel (h', v) = V' /\
                  vlen (V') = 0
        };


goal :  (capacity : { v : int | ( [v > 0] \/ [v=0]) /\ not [Max > v]}) -> 
        (dummy : a) -> 
       	State {\(h : heap). true} 
			v : ref vec 
		{ \(h : heap), (v : ref vec), (h' : heap). 
				\(V : vec), (V' : vec).
			      vdom (h, v) = false /\
                  vdom (h', v) = true /\
                  (vsel (h', v) = V' => vlen (V') = 0)
        };
