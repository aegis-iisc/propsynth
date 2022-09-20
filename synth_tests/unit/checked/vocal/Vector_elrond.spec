(*a vec type*)
type vec;

qualifier vdom : heap :-> ref vec :-> bool;
qualifier vmem : vec :-> a :-> bool;
qualifier vsel : heap :-> ref vec :-> vec;
qualifier vlen : vec :-> int;
qualifier vdisjoint : vec :-> vec :-> bool;

Max : int;

(*a counter to bound the number of new reference creation*)
num : ref int;



(*capacity is made non-optional*)
create : (capacity : { v : int | ( [v > 0] \/ [v=0]) /\ not [Max > v]}) -> 
         (dummy : a) -> 
       	 
        State {\(h : heap). not (sel (h, num) > 1)} 
			v : ref vec 
		 {\(h : heap), (v : ref vec), (h' : heap). 
				\(V : vec), (V' : vec).
			      vdom (h, v) = false /\
                  sel (h', num) == sel (h, num) + 1 /\
                  vdom (h', v) = true /\
                  vsel (h', v) = V' /\
                  vlen (V') = 0
        };
(*how do you define  the *)
create (capacity, dummy, v, num, num') : 
    \forall u. v =  capacity >=0 /\ capacity <= Max /\ u <=> vdom (v) = true /\ vlen (v) = 0 /\ num' = num + 1

make : (dummy : a) -> 
        (n : { v : int | ([v > 0] \/ [v=0]) /\ not [Max > v]}) -> 
        (x : a) ->       
            State {\(h : heap). not (sel (h, num) > 1)} 
			    v : ref vec 
		        {\(h : heap), (v : ref vec), (h' : heap). 
		        \(V : vec), (V' : vec).
	            sel (h', num) == sel (h, num) + 1 /\
                    vsel (h', v) = V' /\ 
                    vdom (h, v) = false /\
                    vdom (h', v) = true /\
                    vmem (V', x) = true /\
                    vlen (V') = n 
                };


init : (dummy : a ) -> 
       (n : int) ->  
       (f : (x : int) -> { v :  a| true}) -> 
        State {\(h : heap). not (sel (h, num) > 1)} 
			    v : ref vec 
		        {\(h : heap), (v : ref vec), (h' : heap). 
				    \(V : vec), (V' : vec).
	                sel (h', num) == sel (h, num) + 1 /\
                        vdom (h, v) = false /\
                        vlen (V') = n 
                };


resize : (vec : ref vec) -> 
         (n : { v : int | ([v > 0] \/ [v=0]) /\ not [Max > v]}) -> 
         (x : a) ->       
         State {\(h : heap).\(V : vec). 
                        vdom (h, vec) = true /\
                        (vsel (h, vec) = V => not (n > vlen (V)))
                        } 
			 v : { v : unit | true}    
             {\(h : heap), (v : unit), (h' : heap). 
			\(V : vec), (V' : vec).
	                vsel (h, vec) = V /\    
                    vsel (h', vec) = V' /\ 
                    vlen (V) > vlen (V') /\
                    vlen (V') = n 
                    };


clear : (vec : ref vec) ->  
            State {\(h : heap). vdom (h, vec) = true} 
			 v : { v : unit | true}    
             {\(h : heap), (v : unit), (h' : heap). 
		\(V : vec), (V' : vec).
	            vsel (h', vec) = V' /\ 
                    vlen (V') = 0 
            };



is_empty : (vec : ref vec) ->  
                State {\(h : heap). vdom (h, vec) = true} 
			    v : { v : bool | true}   
                {\(h : heap), (v : bool), (h' : heap). 
				    \(V : vec), (V' : vec).
	                  vsel (h, vec) = V /\
                      ([v = true] <=> len (V) = 0) /\ 
                      [h' = h]
                    };

                
length :  (vec : ref vec) ->  
                State {\(h : heap). vdom (h, vec) = true} 
			    v : { v : int | true}   
                {\(h : heap), (v : int), (h' : heap). 
		        \(V : vec).
	                v = vlen (V) /\
                      [h' = h]
                    };
       



get : (vec : ref vec) -> 
        (n : int) ->  
           State {\(h : heap).
                        \(V: vec). 
                        vdom (h, vec) = true /\ 
                        (vsel (h, vec) = V => vlen (V) > n)
                } 
			    v : { v : a | true}   
                {\(h : heap), (v : a), (h' : heap). 
				    \(V : vec).
	                vsel (h, vec) = V /\
                        vmem (V, v) = true /\        
                         [h' = h]
                };



set : (vec : ref vec) -> 
      (n : int) ->  
      (x: a) -> 
           State {\(h : heap).
                        \(V: vec). 
                        vdom (h, vec) = true /\ 
                        (vsel (h, vec) = V => 
                        vlen (V) > n)
                } 
			    v : { v : unit | true}   
                {\(h : heap), (v : unit), (h' : heap). 
				    \(V : vec), (V' : vec).
	                vsel (h, vec) = V /\
                    vsel (h', vec) = V' /\
                    vmem (V', x) = true 
                    
                };


sub : (vec : ref vec) -> 
     (offset : int) ->  
     (n : int) -> 
        State {\(h : heap).
                \(V: vec). 
                        vdom (h, vec) = true /\ 
                        (vsel (h, vec) = V => 
                        vlen (V) > n /\ 
                        vlen (V) > offset + n)
                } 
			     v : ref vec  
                {\(h : heap), (v : ref vec), (h' : heap). 
		 \(V : vec), (NV : vec).
	            vsel (h, vec) = V /\
                    vsel (h', v) = NV /\
                    vdom (h', v) = true /\
                    vsel (h, vec) = vsel (h', vec) /\
                    (vlen (V) > vlen (NV) \/ vlen (V) = vlen (NV))
                };



fill : (vec : ref vec) -> 
     (offset : int) ->  
     (n : int) -> 
     (x : a )  ->   
        State {\(h : heap).
                \(V: vec). 
                        vdom (h, vec) = true /\ 
                        (vsel (h, vec) = V => 
                        vlen (V) > n /\ 
                        vlen (V) > offset + n )
                } 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit), (h' : heap). 
	           \(V : vec), (V' : vec).
	            vsel (h, vec) = V /\
                    vsel (h', vec) = V' /\
                    vmem (V', x) = true /\
                    vlen (V') = vlen (V) 
                };

blit : (a1 : ref vec) -> 
       (ofs1 : int) ->  
       (a2 : ref vec) -> 
       (ofs2 : int) ->  
       (n : int) -> 
       State {\(h : heap).
                \(V1: vec), (V2 : vec). 
                        vdom (h, a1) = true /\ 
                        vdom (h, a2) =  true/\
                        ((vsel (h, a1) = V1 /\ vsel (h, a2) = V2) => 
                         (vlen (V1) > ofs1 + n /\
                         vlen (V2) > ofs2 + n ))
                } 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit), (h' : heap). 
				 \(V1: vec), (V2 : vec), (V1': vec), (v2' : vec). 
                    vsel (h, a2) = V2 /\ 
                    vsel (h', a2) = V2' /\
                    vsel (h', a1) = vsel (h, a1) /\
                    vlen (V2') = vlen (V2) 
                };



append : (a1 : ref vec) -> 
         (a2 : ref vec) -> 

          State {\(h : heap).
                \(V1: vec), (V2 : vec). 
                        vdom (h, a1) = true /\ 
                        vdom (h, a2) =  true/\
                        ((vsel (h, a1) = V1 /\ vsel (h, a2) = V2) => 
                         (Max > (vlen (V1) + vlen (V2))))
                 } 
			     v : { v : ref vec | true} 
                {\(h : heap), (v : ref vec), (h' : heap). 
				 \(V1: vec), (V2 : vec), (VN : vec). 
                    vsel (h, a1) = V1 /\ 
                    vsel (h, a2) = V2 /\
                    vsel (h', v) = VN /\
                    vdom (h', v) = true /\
                    vsel (h', a1) = vsel (h, a1) /\
                    vsel (h', a2) = vsel (h, a2) /\
                    vlen (VN) == (vlen (V1) + vlen (V2))
                };



merge_right : (a1 : ref vec) -> 
              (a2 : ref vec) -> 
            
            State {\(h : heap).
                \(V1: vec), (V2 : vec). 
                        vdom (h, a1) = true /\ 
                        vdom (h, a2) =  true/\
                        ((vsel (h, a1) = V1 /\ vsel (h, a2) = V2) => 
                         Max > (vlen (V1) + vlen (V2)) /\
                         vdisjoint (V1, V2) = true)
                 } 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit), (h' : heap). 
				 \(V1: vec), (V2 : vec), (V2' : vec), (V1' : vec). 
                    vsel (h, a1) = V1 /\ 
                    vsel (h, a2) = V2 /\
                    vsel (h', a1) = V1' /\
                    vsel (h', a2) = V2' /\
                    vlen (V2') = 0 /\
                    vlen (V1') = vlen (V1) + vlen (V2) /\
                    vdisjoint (V1', V2') = true
                };



map :  (dummy : b) -> 
       (a1 : ref vec) ->  
       (f : (x : a) -> { v :  b| true}) ->
          State {\(h : heap).
                \(V1: vec). 
                        vdom (h, a1) = true} 
			     v : { v : ref vec | true} 
                {\(h : heap), (v : ref vec), (h' : heap). 
				 \(V1: vec), (VN : vec). 
                    vsel (h, a1) = V1 /\ 
                    vsel (h, v) = VN /\
                    vlen (VN) = vlen (V1) /\
                    vsel (h', a1) = vsel (h, a1)
                };




mapi :  (dummy : b) -> 
        (a1 : ref vec) ->  
        (f : (i : int) -> (x : a) -> { v :  b| true}) ->
          State {\(h : heap).
                \(V1: vec). 
                        vdom (h, a1) = true} 
			     v : { v : ref vec | true} 
                {\(h : heap), (v : ref vec), (h' : heap). 
				 \(V1: vec), (VN : vec). 
                    vsel (h, a1) = V1 /\ 
                    vsel (h, v) = VN /\
                    vlen (VN) = vlen (V1) /\
                    vsel (h', a1) = vsel (h, a1) /\
                    vdisjoint (V1, VN) = true
                };




copy : (a1 : ref vec) -> 
        (a2 : ref vec) -> 
            State {\(h : heap).
                \(V1: vec), (V2 : vec). 
                        vdom (h, a1) = true /\ vdom (h, a2) = true 
                     
                 } 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit), (h' : heap). 
				 \(V1: vec), (V2 : vec), (V1' : vec), (V2' : vec). 
                    vdom (h', a1 ) = true /\
                    vdom (h' , a2) = true /\
                    vsel (h, a1) = V1 /\ 
                    vsel (h, a2) = V2 /\
                    vsel (h', a2) = V2' /\
                    vsel (h', a1) = V1' /\
                    [V1' = V1] /\
                    vlen (V2') = vlen (V1) /\
                    vdisjoint (V1', V2') = true /\
                    vmem (V2') = vmem (V1')
                    
                };


fold_left : (a1 : ref vec)  -> 
        (f :  (l : a) -> (r : b)  -> {v : a | true}) -> 
        ( l0 : a) -> 
        {v : a | true};

        


fold_right : (a1 : ref vec)  -> 
        (f :  (l : b) -> (r : a)  -> {v : a | true}) -> 
        (l0 : a) -> 
        {v : a | true};



push : (a1 : ref vec)  -> 
       (x : a) -> 
       State {\(h : heap).
                \(V1: vec). 
                        vdom (h, a1) = true
                 } 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit), (h' : heap). 
				 \(V1: vec), (V1' : vec). 
                    vsel (h, a1) = V1 /\ 
                    vsel (h', a1) = V1' /\
                    vmem (V1', x) = true /\
                    vlen (V1') = vlen (V1) + 1
                };



pop : (a1 : ref vec)  -> 
       State {\(h : heap).
                \(V1: vec). 
                        vdom (h, a1) = true /\
                        (vsel (h, a1) = V1 => vlen (V1) > 0)
                 } 
			     v : { v : a | true} 
                {\(h : heap), (v : a), (h' : heap). 
				 \(V1: vec), (V1' : vec). 
                    vsel (h, a1) = V1 /\ 
                    vsel (h', a1) = V1' /\
                    vmem (V1', x) = false /\
                    vlen (V1') = vlen (V1) - 1
                };


top : (a1 : ref vec)  -> 
       State {\(h : heap).
                \(V1: vec). 
                        vdom (h, a1) = true /\
                        (vsel (h, a1) = V1 => vlen (V1) > 0) 
                 } 
			     v : { v : a | true} 
                {\(h : heap), (v : a), (h' : heap). 
				 \(V1: vec), (V1' : vec). 
                    vsel (h, a1) = V1 /\ 
                    vsel (h', a1) = V1' /\
                    vmem (V1', x) = false /\
                    vlen (V1') = vlen (V1) - 1
                };


goal : (capacity : { v : int | ( [v > 0] \/ [v=0]) /\ not [Max > v]}) -> 
        (dummy : a) -> 
       	(a1 : ref vec) -> 
        State {\(h : heap).
                  vdom (h, a1) = true 
                } 
			     (v : ref vec) 
                {\(h : heap), (v : ref vec), (h' : heap). 
		        \(V1: vec), (VN : vec), (V1' : vec). 
                    vsel (h, a1) = V1 /\ 
                    vsel (h', a1) = V1' /\
                    vsel (h', v) = VN /\
                    vlen (VN) == vlen (V1) + vlen (V1) /\ 
                    vlen (V1') == 0 /\
                    vmem (VN) = vmem (V1) /\
                    vdisjoint (V1', VN) = true
                };



(* A client for goal*) 
\capacity dummy a1
        x <- create dummy capacity 
        _ <- copy a1 x
        _ <- merge_right x a1
        retrun x


