q : ref queue;
num : ref int;


create : unit -> State 
		{\(h : heap). true} 
		v : { v : ref queue | true} 
		{\(h : heap), (v : ref queue), (h' : heap). 
		\(Q' : queue ).
		 sel (h', num) == sel (h, num) + 1 /\
		 qsel (h', v) = Q' /\  
		 empty (Q') = true };





fresh_el : p : ref queue -> 
			State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Q' : queue).
				sel (h', num) == sel (h, num) + 1 /\
				qssel (h', q) = Q' /\  
				qsel (h', q) = qsel (h, q) /\
				mem (Q', v) = false};



add : x : int -> q : ref queue > State {\(h : heap). 
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

enque : (x : { v : int | true}) -> (q : { v : ref queue | true})  
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



is_empty : q : ref queue -> State {\(h:heap).true}
								  v :  {v : bool | true}
								  {\(h : heap), (v : unit), (h' : heap).
								  	\(Q : queue), (Q' : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									[v=true] <=> (qsize (Q) = 0) /\ 
									[v=false] <=> (qsize (Q) > 0)
									Q' = Q};


take : q : ref queue > State {\(h : heap). 
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



peek : q : ref queue -> Stexc {\(h : heap). 
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



pop_n : n : int -> q : ref queue > 
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
 



clear : q : ref queue -> Stexc {\(h : heap). 
								 true}
							  v : {v : unit | true}
							 {\(h : heap), (v : unit), (h' : heap).
							 \(Q : queue), (Q' : queue).
								qsel (h', q) = Q'/\
								qsel (h, q) = Q /\
								sel (h', num) == sel (h, num) /\
								(empty (Q') = true)
							  };
 


copy : q : ref queue -> Stexc {\(h : heap). true}
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
 

length : q : ref queue -> Stexc {\(h : heap). true}
							  v : {v : int | true}
							 {\(h : heap), (v : int), (h' : heap).
							 \(Q : queue), (Q' : queue).
								qsel (h, q) = Q /\
								qsel (h, q') = qsel (h, q) /\
								sel (h', num) == sel (h, num) /\
								v = qsize (Q)
							  };
  
contains : q : ref queue->   (s : {v : int | true}) ->  
			State  
			{\(h : heap). true} 
			v : { v : bool | true} 
			
			{\(h : heap), (v : bool), (h' : heap). 
				\(Q' : queue), (Q: queue).
				qsel (h', tbl) = Q'/\
				qsel (h, tbl) = Q /\
				Q' = Q /\
				([v=true] <=> ( qmem(Q', s) = true))/\ 
				([v=false] <=> (qmem (Q', s) = false))
			};




intersection : (p : ref queue ) -> (q : ref queue ) ->
						State 
							{\(h : heap). 	
								\(P : queue), (Q: queue)
								 => (qsize (P) > 0 \/ qsize (Q) >0)} 
								v : { v : ref queue | true} 
							
							{\(h : heap), (v : ref queue), (h' : heap). 
								\(P : queue), (Q: queue), (Qv : queue).
								qsel (h, p) = P /\
								qsel (h, q) = Q /\
								qsel (h', v) = Qv /\
								disjoint P Qv /\
								disjoint Q Qv 
							};





transfer : (p : ref queue ) -> (q : ref queue ) ->
						State 
							{\(h : heap). disjoint (p, q) = true } 
								v : { v : unit | true} 
							{\(h : heap), (v : ref queue), (h' : heap). 
								\(P : queue), (Q: queue) (Qv : queue).
								qsel (h, p) = P /\
								qsel (h, q) = Q /\
								qsel (h', p) = P' /\
								qsel (h', q) = Q' /\
								qsize (Q') = qsize (Q) + qsize (P) /\
								elems (Q') = elems (Q) U elems (p)
								empty (P') = true

							};
														 				



of_list : (l : {v : [int] | true}) -> 
					State {\(h : heap). true}
						v : {v : ref queue | true}
					{\(h : heap), (v : ref queue), (h' : heap). 
						\(Q': queue).
							qsel (h', v) = Q' /\
							qsize (Q') = size (l) /\
							qelems (Q') = elems (l) 
					};	



to_list : (q : {v : ref queue | true}) -> 
					State {\(h : heap). true}
						v : {v : [int] | true}
					{\(h : heap), (v : [int]), (h' : heap). 
						\(Q: queue).
						 qsel (h, v) = Q /\
						 qsel (h', v) = qsel (h, v) /\	
						 qsize (Q') = size (v) /\
						 qelems (Q') = elems (v) 
					};	


sort : (l : {v : [int] | true} -> 
						State {\(h : heap).true} 
						v : {v : [int] | true} 
						{elems (l) = elems (v) /\
						 sorted v};


(*query1 : given an element x and two queues p and q, return a q with elems from both p and 
	q and Uniqueness Invariant intact, further x must be present in the output queue. 	
*)
x : int -> 
p : ref queue -> 
q : ref queue ->  
	State {qmem (p, x) = false}
		v : ref queue  
	{elems (v) C= elems (p) U elems (q) 
	 disjoint v p' /\
	 disjoint v q' /\
	 qmem (v, x) = true
	 qmem (p', x) = false /\
	 qmem (q', x) = false}

(*one possible solution*)
goal  (x : int)  (p : ref queue)  (q : ref queue)  = 
		_ <- add p x;
		p1 <- intersection p q; 
		q <- transfer p q;
		if (mem (x, q)) then 
			res <- add x q;
			return q
		else 
			return q	 




(* query2 
remove the disjoint elements from p , but keep in q *)
p : ref queue > q : ref queue -> 
	State {true} 
		v : unit 
	{disjoint p' q' /\
	 elems (q') = elems (q) 
 }	

(*solution*)
goal  (p : ref queue)  (q : ref queue)  =
	 if (length p > 0 || length q > 0) 
	 	then
	 	q1 <- intersection p q;
	 	_ <- transfer q q1;
	 else 
	 	el <- fresh_str	p;
	 	_ <- add p el;
	 	q1 <- intersection p q;
	 	_ <- transfer q q1


(*solution2*)
goal  (p : ref queue)  (q : ref queue)  =
	 if (length p > 0 || length q > 0) 
	 	then
	 	q1 <- intersection p q;
	 	_ <- transfer q q1;
	 else 
	 	el <- fresh_str	q;
	 	_ <- add p el;
	 	q1 <- intersection p q;
	 	_ <- transfer q q1




(*query3
remove the disjoint elements from q , but keep in p*)
p : ref queue -> q : ref queue -> 
	State {true} 
		v : unit 
	{disjoint p' q' /\
	 elems (p') = elems (p) /\
 }	


(*query4
 give the highest number of the first list, which is not in both lists while*)
p : ref queue -> q : ref queue -> 
	State {true} 
		v : int 
	{disjoint p' q' /\
	 elems (p') = elems (p) /\
	 qmem (p, v) = true /\
	 qmem (q, v) = false /\
	 \forall el. elems (p'). v > el}
 }	


(* query5 
remove the disjoint elements from p , but keep in q *)
p : ref queue -> q : ref queue -> 
	State {true} 
		v : unit 
	{disjoint p' q' /\
	 elems (q') \subseteq elems (q) 
 }	




