q : ref queue;
num : ref int;
Q : queue;
Q' : queue;

fresh_el :  State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Q' : queue),(Q : queue).
				sel (h', num) == sel (h, num) + 1 /\
				qsel (h', q) = Q' /\  
				qsel (h, q) = Q /\
				qsize (Q') = qsize(Q) /\
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



tbl : ref [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;

create_pair : (p1 : {v : int | true}) -> 
				(p2 : {v : float | true}) -> { v : pair | true}; 

fresh_str : State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				ilssel (h', tbl) = Tbl' /\  
				ilssel (h', tbl) = ilssel (h, tbl) /\
				mem (Tbl', v) = false};



size : State 
			{\(h : heap). true} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]),(Tbl : [int]).
				ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl' /\  
				v == size (Tbl) /\
				ilssel (h', tbl) = ilssel (h, tbl)};


average_len : State  {\(h : heap).
					\(Tbl : [int]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				ilssel (h', tbl) = 	ilssel (h, tbl) 
				/\ 
				sel (h', num) == sel (h, num)
				};



add_tbl : (s : {v : int | true}) ->  
			State  {\(h : heap).
				\(Tbl : [int]). 
				ilssel (h, tbl) = Tbl =>  
				(mem (Tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				mem (Tbl', s) = true /\
				size (Tbl') == size (Tbl) + 1 /\
				sel (h', num) == sel (h, num) 
				};




goal : (x : {v : int | true})-> 
	State {\(h : heap).
			\(Q: queue).
			sel (h, num) == 0 /\
			qsel (h, q) = Q /\
			qmem (Q, x) = true /\
			not  (0 > qsize (Q))
		 }
			v : {v : unit | true}  
	{\(h : heap), (v : unit), (h' : heap). 
		\(Q: queue), (Q': queue).
		(qsel (h, q) = Q /\
		qsel (h', q) = Q') => 
		(qmem (Q', x) = true /\
		qsize (Q') == qsize (Q) + 1)

	};
