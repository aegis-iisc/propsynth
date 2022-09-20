type pq;
qualifier pqdom : heap :-> ref pq :-> bool;
qualifier pqsel : heap :-> ref pq :-> pq;
qualifier pqlen : pq   :-> int; 
qualifier pqmem : pq   :-> int :-> bool;
qualifier minimum : pq :-> int;

Top : int;
num : ref int;

create : State {\(h : heap). not (sel (h, num) > 1)} 
			v : ref pq 
		{\(h : heap), (v : ref pq), (h' : heap). 
				\(P : pq), (P' : pq).
			            pqdom (h', v) = true  /\
                  pqsel (h', v) = P' /\
                  pqlen (P') = 0 /\
                  minimum (P') = Top /\
                  sel (h', num) == sel (h, num) + 1
    };


is_empty : (pqueue: ref pq) ->  
                State {\(h : heap). pqdom (h, pqueue) = true} 
			    v : { v : bool | true}   
            {\(h : heap), (v : bool), (h' : heap). 
				      \(P : pq).
	                pqsel (h, pqueue) = P /\
                  ([v = true] <=> pqlen (P) = 0) /\ 
                  [h' = h]
            };


size :  (pqueue : ref pq) ->  
                State {\(h : heap). 
                    pqdom (h, pqueue) = true} 
			    v : { v : int | true}   
                {\(h : heap), (v : int), (h' : heap). 
				        \(P : pq).
	                  v = pqlen (P) /\
                    [h' = h]
                };
       

find_min :  (pqueue : ref pq) ->  
              State 
                {\(h : heap).\(P : pq).
                    pqdom (h, pqueue) = true /\
                    (pqsel (h, pqueue) = P => 
                      pqlen (P) > 0)
                } 
			          v : { v : int| true}   
                {\(h : heap), (v : int), (h' : heap). 
				          \(P : pq), (P' : pq).
	                  v = minimum (P) /\
                    pqmem (P', v) = true /\ 
                    [h' = h]
                    };
       
  



find_min_exc : (pqueue : ref pq) ->  
              State 
                {\(h : heap). \(P : pq).
                    pqdom (h, pqueue) = true /\
                    (pqsel (h, pqueue) = P => pqlen (P) > 0)
                } 
			          v : { v : int| true}   
                {\(h : heap), (v : int ), (h' : heap). 
				          \(P : pq), (P' : pq).
	                  v = minimum (P) /\
                    pqmem (P', v) = true /\ 
                    [h' = h]
                    };
       
delete_min :  (pqueue : ref pq) ->  
                State {\(h : heap). 
                    \(P : pq).
                    pqdom (h, pqueue) = true /\
                    (pqsel (h, pqueue) = P => 
                      pqlen (P) > 0)
                    } 
			    v : { v : unit | true}   
                {\(h : heap), (v : unit), (h' : heap). 
				          \(P : pq), (P' : pq), (A : int).
	                    pqsel (h, pqueue) = P /\
                      pqsel (h', pqueue) = P' /\
                      minimum (P) = A /\
                      pqmem (P', A) = false /\
                      pqlen (P') == pqlen (P) -- 1 
                  };
  
extract_min :  (pqueue : ref pq) ->  
                State {\(h : heap). 
                    \(P : pq).
                    pqdom (h, pqueue) = true /\
                    (pqsel (h, pqueue) = P => 
                      pqlen (P) > 0)
                    } 
			    v : { v : int | true}   
                {\(h : heap), (v : int), (h' : heap). 
				          \(P : pq), (P' : pq).
	                    pqsel (h, pqueue) = P /\
                      pqsel (h', pqueue) = P' /\
                      minimum (P) = v /\
                      pqmem (P', v) = false /\
                      pqlen (P') == pqlen (P) -- 1 
                  };
  
insert :    (x : int) -> 
            (pqueue : ref pq) -> 
             State {\(h : heap). 
                    \(P : pq).
                    pqdom (h, pqueue) = true} 
			            v : { v : unit | true}   
                {\(h : heap), (v : unit), (h' : heap). 
				          \(P : pq), (P' : pq).
	                    pqsel (h, pqueue) = P /\
                      pqsel (h', pqueue) = P' /\
                      pqmem (P', x) = true /\
                      (minimum (P) > x  => 
                          minimum (P') = x) /\
                      (not (minimum (P) > x)  => 
                           minimum (P') = minimum (P))
                               
                };
   
goal0 :  (x : { v : int | [Top > v]})  -> 
        (pqueue : ref pq) -> 
            State {\(h : heap). 
                    \(P : pq).
                    pqdom (h, pqueue) = true /\
                    sel (h, num) == 2} 
			            v : { v : int | true}   
                {\(h : heap), (v : int), (h' : heap). 
				          \(P : pq), (P' : pq).
	                    sel (h', num) == 2 /\
                      (
                      pqsel (h, pqueue) = P /\
                      pqsel (h', pqueue) = P')
                      => 
                      (pqmem (P', x) = true /\
                      (minimum (P) > x  => [v = x]) /\
                       (not minimum (P) > x  => 
                           not [v = x])
                      )    
                };

goal1 : (x : { v : int | [Top > v]}) -> 
            State {\(h : heap). sel (h, num) == 1} 
			            v : { v : ref pq | true}   
                {\(h : heap), (v : ref pq), (h' : heap). 
				          \(P' : pq).
                      sel (h, num) == 2 /\
	                    (pqdom (h, v) = true /\    
                       pqsel (h', v) = P')
                      => 
                      (pqmem (P', x) = true /\
                      minimum (P') = x  
                      )    
                };

goal2 : (pqueue : ref pq) -> 
            State {\(h : heap). 
                    \(P : pq).
                    pqdom (h, pqueue) = true /\
                    pqsel (h, pqueue) = P /\ 
                    pqlen (P) > 0
                    }  
			            v : { v : ref pq | true}   
                {\(h : heap), (v : ref pq), (h' : heap). 
				          \(P : pq), (P' : pq).
	                    (pqdom (h, v) = true /\    
                       pqsel (h, v) = P /\
                       pqsel (h', v) = P')
                      => 
                      (
                      minimum (P) > minimum (P') )  
                          
                };
