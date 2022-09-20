
type queue; 
qualifier qdom : heap :-> ref queue :-> bool;
qualifier vqmem : queue :-> a :-> bool;
qualifier qsel : heap :-> ref queue :-> queue;
qualifier qlen : queue :-> int;

create : State {\(h : heap). true} 
			v : ref queue 
		{ \(h : heap), (v : ref queue), (h' : heap). 
				\(Q' : queue).
		     qdom (h', v) = true  /\
                   qsel (h', v) = Q' /\ qlen (Q') = 0
              };



push :  (x : a) -> 
        (q : ref queue)  -> 
         State {\(h : heap).
                \(Q1: queue). 
                        qdom (h, q) = true
                 } 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit), (h' : heap). 
			\(Q1: queue), (Q1' : queue). 
                    qsel (h, q) = Q1 /\ 
                    qsel (h', q) = Q1' /\
                    vqmem (Q1', x) = true /\
                    qlen (Q1') == qlen (Q1) + 1
                };


take :  (q : ref queue)  -> 
         State {\(h : heap).
                \(Q1: queue). 
                        qdom (h, q) = true /\
                        (qsel (h, q) = Q1 => qlen (Q1) > 0) 
                 } 
			     v : { v : a | true} 
                {\(h : heap), (v : a), (h' : heap). 
				 \(Q1: queue), (Q1' : queue). 
                    qsel (h, q) = Q1 /\ 
                    qsel (h', q) = Q1' /\
                    vqmem (Q1, v) = true /\
                    qlen (Q1') == qlen (Q1) -- 1
                };

pop : (q : ref queue)  -> 
         State {\(h : heap).
                \(Q1: queue). 
                        qdom (h, q) = true /\
                        (qsel (h, q) = Q1 => 
                        qlen (Q1) > 0) 
                 } 
			     v : { v : a | true} 
                {\(h : heap), (v : a), (h' : heap). 
				 \(Q1: queue), (Q1' : queue). 
                    qsel (h, q) = Q1 /\ 
                    qsel (h', q) = Q1' /\
                    vqmem (Q1, v) = true /\
                    vqmem (Q1', v) = false /\
                    qlen (Q1') == qlen (Q1) -- 1
                };
peek : (q : ref queue)  -> 
         State {\(h : heap).
                \(Q1: queue). 
                        qdom (h, q) = true /\
                        (qsel (h, q) = Q1 => 
                        qlen (Q1) > 0) 
                 } 
			     v : { v : a | true} 
                {\(h : heap), (v : a), (h' : heap). 
				 \(Q1: queue), (Q1' : queue). 
                    qsel (h, q) = Q1 /\ 
                    qsel (h', q) = Q1' /\
                    qlen (Q1') = qlen (Q1) /\
                    vqmem (Q1', q) = true 
                };

top : (q : ref queue)  -> 
         State {\(h : heap).
                \(Q1: queue). 
                        qdom (h, q) = true /\
                        (qsel (h, q) = Q1 => 
                        qlen (Q1) > 0) 
                 } 
			     v : { v : a | true} 
                {\(h : heap), (v : a), (h' : heap). 
				 \(Q1: queue), (Q1' : queue). 
                    qsel (h, q) = Q1 /\ 
                    qsel (h', q) = Q1' /\
                    qlen (Q1') = qlen (Q1) /\
                    vqmem (Q1', q) = true 
                };


clear : (q : ref queue) ->  
            State {\(h : heap). qdom (h, q) = true } 
			 v : { v : unit | true}    
             {\(h : heap), (v : unit), (h' : heap). 
				    \(Q : queue), (Q' : queue).
	                qsel (h, q) = Q /\    
                    qsel (h', q) = Q' /\ 
                    qlen (Q') = 0 
            };


copy : (q1 : ref queue) -> 
            State {\(h : heap).
                \(Q1: queue). 
                        qdom (h, q1) = true
                 } 
			     v : { v : ref queue | true} 
                {\(h : heap), (v : ref queue), (h' : heap). 
				 \(Q1: queue), (QN : queue). 
                    qsel (h, q1) = Q1 /\ 
                    qsel (h', v) = QN /\
                    qsel (h', q1) = qsel (h, q1) /\
                    qlen (QN) = qlen (Q1) 
                };


is_empty : (q : ref queue) ->  
                State {\(h : heap). 
                     qdom (h, q) = true} 
			    v : { v : bool | true}   
                {\(h : heap), (v : bool), (h' : heap). 
				    \(Q : queue), (Q' : queue).
	                  qsel (h, q) = Q /\
                      ([v = true] <=> qlen (Q) = 0) /\ 
                      ([v = false] <=> not (qlen (Q) = 0)) /\ 
                      [h' = h]
                    };


contains : (q : ref queue) ->  
             (x : a) -> 
                State {\(h : heap).\(Q : queue). 
                     qdom (h, q) = true /\
                     (qsel (h, q) = Q => qlen (Q) > 0)} 
			    v : { v : bool | true}   
                {\(h : heap), (v : bool), (h' : heap). 
			\(Q : queue), (Q' : queue).
	              qsel (h, q) = Q /\
                      ([v = true] <=> vqmem (Q, x) = true) /\ 
                      ([v = false] <=> vqmem (Q, x) = false) /\ 
                      [h' = h]
                    };


length :  (q : ref queue) ->  
                State {\(h : heap). 
                            qdom (h, q) = true} 
			    v : { v : int | true}   
                {\(h : heap), (v : int), (h' : heap). 
				\(Q : queue).
	              v = qlen (Q) /\
                     [h' = h]
                    };
       


add : (x : a) -> 
      (q : ref queue)  -> 
       State {\(h : heap).qdom (h, q) = true
                 } 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit), (h' : heap). 
				 \(Q1: queue), (Q1' : queue). 
                    qsel (h, q) = Q1 /\ 
                    qsel (h', q) = Q1' /\
                    vqmem (Q1', x) = true /\
                    qlen (Q1') == qlen (Q1) + 1 /\
                    qdom (h', q) = true 
                };


transfer : (q1 : ref queue) -> 
           (q2 : ref queue) -> 
            State {\(h : heap).
                     qdom (h, q1) = true /\ 
                     qdom (h, q2) = true /\
                     not [q1 = q2]
                 } 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit ), (h' : heap). 
				 \(Q1: queue), (Q2 : queue), (Q1' : queue), (Q2' : queue). 
                    qsel (h, q1) = Q1 /\ 
                    qsel (h', q1) = Q1' /\
                    qsel (h, q2) = Q2 /\
                    qsel (h', q2) = Q2' /\
                    qlen (Q2') == (qlen (Q1) + qlen (Q2)) /\
                    qlen (Q1') = 0 /\
                    not [q1 = q2]
                };

goal : (x : a) -> 
              State {\(h : heap). true} 
			v : ref queue 
		{ \(h : heap), (v : ref queue), (h' : heap). 
		       \(Q' : queue).
		       qdom (h', v) = false  /\
                     (qsel (h', v) = Q' => 
                     (qlen (Q') = 1 /\ 
                     vqmem (Q', x) = true))
              };

