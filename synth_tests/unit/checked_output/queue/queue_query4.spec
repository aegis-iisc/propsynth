q : ref queue;
num : ref int;
Q : queue;
Q' : queue;

fresh_el :  State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Q' : queue).
				sel (h', num) == sel (h, num) + 1 /\
				qsel (h', q) = Q' /\  
				qsel (h', q) = qsel (h, q) /\
				qmem (Q', v) = false};

add : (x : { v : int | true})   -> State {\(h : heap). 
									\(Q : queue).
									qsel (h, q) = Q => 
									qmem (Q, x) = false}
									v : {v : unit | true}
									{\(h : heap), (v : unit), (h' : heap).
									\(Q : queue), (Q' : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									qmem (Q', x) = true /\
									qsize (Q') == qsize (Q) + 1 /\
									sel (h', num) == sel (h, num)};


take : 	State {\(h : heap).	
				\(Q : queue).
									qsel (h, q) = Q => 
									qsize (Q) > 0}
									v : {v : int | true}
									{\(h : heap), (v : int), (h' : heap).
									\(Q : queue), (Q' : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									qmem (Q', v) = false /\
									qsize (Q') == qsize (Q) -- 1 /\
									sel (h', num) == sel (h, num)};



peek : State {\(h : heap). \(Q: queue). (qsel (h, q) = Q => qsize (Q) > 0)}
							  v : {v : int | true}
							 {\(h : heap), (v : int), (h' : heap).
							 \(Q : queue), (Q' : queue).
								qsel (h', q) = Q'/\
								qsel (h, q) = Q /\
								qmem (Q', v) = true /\
								sel (h', num) == sel (h, num) /\
								Q' = Q
							  };



clear :	State {\(h : heap). 
								\(Q: queue).
								(qsel (h, q) = Q
								 => qsize (Q) > 0)}
							  v : {v : unit | true}
							 {\(h : heap), (v : unit), (h' : heap).
							 	\(Q : queue), (Q' : queue).
								qsel (h', q) = Q' /\
								qsel (h, q) = Q /\
								sel (h', num) == sel (h, num) /\
								empty (Q') = true /\
								qsize (Q') == 0
							  };

goal : (x : {v : int | true})-> 
	State {\(h : heap).
			\(Q: queue).
			qsel (h, q) = Q /\
			qmem (Q, x) = false /\
			not  (0 > qsize (Q))
		 }
			v : {v : int | true}  
	{\(h : heap), (v : int), (h' : heap). 
		\(Q: queue), (Q': queue).
		(qsel (h, q) = Q /\
		qsel (h', q) = Q') => 
		(qmem (Q', x) = true /\
		qsize (Q') == qsize (Q) + 1)

	};

(*
 \x.
do locbound22 <- apply add  (, x ) ---> return x


*)