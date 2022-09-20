type buffer; 
qualifier rdom : heap :-> ref buffer :-> bool;
qualifier rmem : buffer :-> a :-> bool;
qualifier rsel : heap :-> ref buffer :-> buffer;
qualifier rlen : buffer :-> int;
qualifier rdisjoint : buffer :-> buffer :-> bool;

Max : int;

create: (capacity : { v : int | ([v > 0] \/ [v=0]) /\ not [Max > v]}) -> 
        (dummy : a) -> 
       	State {\(h : heap). true} 
			v : ref buffer 
		{ \(h : heap), (v : ref buffer), (h' : heap). 
				\(V : buffer), (V' : buffer).
		  rdom (h, v) = false /\
                  rdom (h', v) = true /\
                  rsel (h', v) = V' /\
                  rmem (V', dummy) = true /\
                  rlen (V') = 0
        };



length :  (vec : ref buffer) ->  
                State {\(h : heap). rdom (h, vec) = true} 
			    v : { v : int | true}   
                {\(h : heap), (v : int), (h' : heap). 
			\(V : buffer).
	                  v = rlen (V) /\
                         [h' = h]
                    };
       



clear : (vec : ref buffer) ->  
            State {\(h : heap). rdom (h, vec) = true} 
			 v : { v : unit | true}    
             {\(h : heap), (v : unit), (h' : heap). 
				    \(V : buffer), (V' : buffer).
	                rsel (h, vec) = V /\    
                    rsel (h', vec) = V' /\ 
                    rlen (V') = 0 
            };


pop : (a1 : ref buffer)  -> 
       State {\(h : heap).
                \(V1: buffer). 
                        rdom (h, a1) = true
                 } 
			     v : { v : a | true} 
                {\(h : heap), (v : a), (h' : heap). 
				 \(V1: buffer), (V1' : buffer). 
                    rsel (h, a1) = V1 /\ 
                    rsel (h', a1) = V1' /\
                    rmem (V1', v) = false /\
                    rlen (V1') = rlen (V1) - 1
                };



get : (vec : ref buffer) -> 
        (n : int) ->  
           State {\(h : heap).
                        \(V: buffer). 
                        rdom (h, vec) = true /\ 
                        (rsel (h, vec) = V => 
                        rlen (V) > n)
                } 
			    v : { v : a | true}   
                {\(h : heap), (v : a), (h' : heap). 
				    \(V : buffer).
	                rsel (h, vec) = V /\
                        rdom (V, v) = true /\ 
                        [h' = h]
                };


copy : (a1 : ref buffer) -> 
            State {\(h : heap).
                \(V1: buffer). 
                        rdom (h, a1) = true
                 } 
			     v : { v : ref buffer | true} 
                {\(h : heap), (v : ref buffer), (h' : heap). 
				 \(V1: buffer), (VN : buffer). 
                    rsel (h, a1) = V1 /\ 
                    rsel (h, v) = VN /\
                    rsel (h', a1) = rsel (h, a1) /\
                    [VN = V1] /\
                    rlen (VN) = rlen (V1) /\
                    rdisjoint (V1, VN) = true 
                    
                };

goal : (a1 :  ref buffer) ->   
        State {\(h : heap). rdom (h, a1) = true} 
			v : ref buffer 
		{ \(h : heap), (v : ref buffer), (h' : heap). 
		\(V1 : buffer), (VN : buffer).
		  rdom (h', v) = true /\
                  (rsel (h, a1) = V1 /\ 
                  rsel (h, v) = VN ) => 
                  
                  (rsel (h', a1) = rsel (h, a1) /\
                  [VN = V1] /\
                  rlen (VN) = rlen (V1) /\
                  rdisjoint (V1, VN) = true) 
                 
        };

