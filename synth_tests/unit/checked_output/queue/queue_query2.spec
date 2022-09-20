q : ref queue;
num : ref int;
Q : queue;
P : queue;
Q' : queue;
P' : queue;
Qv : queue;
ulit : unit; 

create : State 
		{\(h : heap). true} 
		v : { v : ref queue | true} 
		{\(h : heap), (v : ref queue), (h' : heap). 
		\(Q' : queue ).
		 sel (h', num) == sel (h, num) + 1 /\
		 qsel (h', v) = Q' /\  
		 empty (Q') = true};

fresh_el : (p : { v : ref queue | true}) -> 
			State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Q' : queue).
				sel (h', num) == sel (h, num) + 1 /\
				qssel (h', q) = Q' /\  
				qsel (h', q) = qsel (h, q) /\
				mem (Q', v) = false};

add : (x : { v : int | true}) -> (q : { v : ref queue | true})  
							-> State {\(h : heap). 
									\(Q : queue).
									qsel (h, q) = Q => 
									qmem (Q, x) = false}
									v : {v : unit | true}
									{\(h : heap), (v : unit), (h' : heap).
									\(Q : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									qmem (Q', x) = true /\
									qsize (Q') == qsize (Q) + 1 /\
									sel (h', num) == sel (h, num)};


is_empty : (q : { v : ref queue | true}) -> 
								State {\(h:heap).true}
								  v :  {v : bool | true}
								  {\(h : heap), (v : bool), (h' : heap).
								  	\(Q : queue), (Q' : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									[v=true] <=> (qsize (Q) = 0) /\ 
									[v=false] <=> (qsize (Q) > 0) /\
									Q' = Q};


take : (q : { v : ref queue | true}) -> 
								State {\(h : heap). 
									\(Q : queue).
									qsel (h, q) = Q => 
									qsize (Q) > 0}
									v : {v : int | true}
									{\(h : heap), (v : int), (h' : heap).
									\(Q : queue), (Q' : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									qmem (Q', v) = false /\
									qsize (Q') == qsize (Q) - 1 /\
									sel (h', num) == sel (h, num)};



peek : (q : { v : ref queue | true}) -> State {\(h : heap). 
								\(Q: queue).
									qsel (h, q) = Q => qsize (Q) > 0}
							  v : {v : int | true}
							 {\(h : heap), (v : int), (h' : heap).
							 \(Q : queue), (Q' : queue).
								qsel (h', q) = Q'/\
								qsel (h, q) = Q /\
								qmem (Q, v) = true /\
								sel (h', num) == sel (h, num) /\
								Q' = Q
							  };



pop_n : (n : { v : int | true}) -> (q : { v : ref queue | true}) -> 
								State {\(h : heap).
										\(Q:queue).
										qsel (h, q) = Q => 
										not (n > qsize (Q))}
							  v : {v : [int] | true}
							 {\(h : heap), (v : [int]), (h' : heap).
							 	\(Q : queue), (Q' : queue).
								qsel (h', q) = Q'/\
								qsel (h, q) = Q /\
								sel (h', num) == sel (h, num) /\
								qsize (Q') = qsize (Q) - n /\
								elems (v) C qelems (Q) /\
								len (v) = n 
							  };
 
clear : (q : { v : ref queue | true}) -> 
							State {\(h : heap). true}
							  v : {v : unit | true}
							 {\(h : heap), (v : unit), (h' : heap).
							 	\(Q : queue), (Q' : queue).
								qsel (h', q) = Q' /\
								qsel (h, q) = Q /\
								sel (h', num) == sel (h, num) /\
								empty (Q') = true
							  };
 


copy : (q : { v : ref queue | true}) -> 
							State {\(h : heap). true}
							  v : {v : ref queue | true}
							 {\(h : heap), (v : ref queue), (h' : heap).
							 \(Q : queue), (Q' : queue), (Qnew : queue).
								qsel (h', q) = Q'/\
								qsel (h, q) = Q /\
								qsel (h, v) = Qnew /\
								sel (h', num) == sel (h, num) /\
								Qnew = Q /\ 
								Q' = Q 
							  };
 

length : (q : { v : ref queue | true}) -> 
				State {\(h : heap). true}
							  v : {v : int | true}
							 {\(h : heap), (v : int), (h' : heap).
							 \(Q : queue), (Q' : queue).
								qsel (h, q) = Q /\
								qsel (h', q) = qsel (h, q) /\
								sel (h', num) == sel (h, num) /\
								v = qsize (Q)
							  };
  
contains : (q : { v : ref queue | true}) ->  (s : {v : int | true}) ->  
			State  
			{\(h : heap). true} 
			v : { v : bool | true} 
			
			{\(h : heap), (v : bool), (h' : heap). 
				\(Q' : queue), (Q: queue).
				qsel (h', q) = Q'/\
				qsel (h, q) = Q /\
				Q' = Q /\
				([v=true] <=> ( qmem(Q', s) = true))/\ 
				([v=false] <=> (qmem (Q', s) = false))
			};




intersection : (p : { v : ref queue | true}) -> (q : { v : ref queue | true}) ->
						State 
							{\(h : heap). 	
								\(P : queue), (Q: queue).
								(qsel (h, p) = P /\ qsel (h, q) = Q)
								 => (qsize (P) > 0 \/ qsize (Q) >0)
							} 
								v : { v : ref queue | true} 
							
							{\(h : heap), (v : ref queue), (h' : heap). 
								\(P : queue), (Q: queue), (Qv : queue).
								qsel (h, p) = P /\
								qsel (h, q) = Q /\
								qsel (h', v) = Qv /\
								disjoint (P, Qv) = true /\
								disjoint (Q, Qv) = true 
							};

transfer : (p : { v : ref queue | true}) -> (q : { v : ref queue | true}) ->
						State {\(h : heap). 
								\(P : queue), (Q: queue).
								(qsel (h, p) = P /\ qsel (h, q) = Q)
								 =>
									(disjoint (P, Q) = true) 
								} 
								v : { v : unit | true} 
							{\(h : heap), (v : unit), (h' : heap). 
								\(P : queue), (Q: queue).
								qsel (h, p) = P /\
								qsel (h, q) = Q /\
								qsel (h', p) = P' /\
								qsel (h', q) = Q' /\
								qsize (Q') == qsize (Q) + qsize (P) /\
								qelems (Q') = qelems (Q) U qelems (P) /\
								empty (P') = true

							};
														 				

of_list : (l : {v : [int] | true}) -> 
					State {\(h : heap). true}
						v : {v : ref queue | true}
					{\(h : heap), (v : ref queue), (h' : heap). 
						\(Q': queue).
							qsel (h', v) = Q' /\
							qsize (Q') = isize (l) /\
							qelems (Q') = elems (l) 
					};	



to_list : (q : {v : ref queue | true}) -> 
					State {\(h : heap). true}
						v : {v : [int] | true}
					{\(h : heap), (v : [int]), (h' : heap). 
						\(Q: queue).
						 qsel (h, q) = Q /\
						 qsel (h, q) = Q' /\
						 Q' = Q /\
						 qsize (Q') = isize (v) /\
						 qelems (Q') = elems (v) 
					};	


sort : (l : {v : [int] | true}) -> 
				State {\(h : heap).true} 
				v : {v : [int] | true} 
				{\(h : heap), (v : [int]), (h' : heap).
					elems (l) = elems (v) /\ 
					sorted (v) = true};



goal : (p : {v : ref queue | true}) -> 
	   (q : { v : ref queue | true}) ->  
		State {\(h : heap).true} 
		v : {v : unit | true}
		
		{\(h : heap), (v : unit), (h' : heap). 
		\(Q: queue), (P: queue), (Q' : queue), (P': queue).
		qsel (h, q) = Q /\
		qsel (h', q) = Q' /\
		qsel (h, p) = P /\
		qsel (h', p) = P' /\
		qelems (Q') = qelems (Q) /\
		disjoint (P', Q') = true 
	 	
	};
