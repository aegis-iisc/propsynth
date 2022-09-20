q : ref queue;
num : ref int;



predicate disjoint p q = 
predicate unique : Q : queue :-> bool
predicate empty : Q : queue  :-> bool 
predicate elems : Q : queue :-> Set int 
predicate size : Q : queue :-> int 
predicate mem  : Q : queue :-> x : int -> bool


create : unit -> State 
		{\(h : heap). true} 
		v : { v : ref queue | true} 
		{\(h : heap), (v : ref queue), (h' : heap). 
		\(Q' : queue ).
		 sel (h', num) == sel (h, num) + 1 /\
		 qssel (h', v) = Q' /\  
		 empty (Q') = true };



val create : unit -> 'a t
(* Return a new queue, initially empty.
 *)



fresh_el : State 
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
									mem (Q, x) = false}
									v : {v : unit | true}
									{\(h : heap), (v : unit), (h' : heap).
									\(Q : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									mem (Q', x) = true /\
									size (Q') == size (Q) + 1 /\
									sel (h', num) == sel (h, num)};

val add : x : int -> q : 'a t -> {x \notin q} unit {x \in q'}
(* add x q adds the element x at the end of the queue q, returning a unit, does inplace addition.*)


(*what should we do about synonyms*)
enque : x : int -> q : ref queue > State {\(h : heap). 
									mem (q, x) = false}
									v : {v : unit | true}
									{\(h : heap), (v : unit), (h' : heap).
									\(Q : queue), (Q' : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									mem (Q', x) = true /\
									size (Q') == size (Q) + 1 /\
									sel (h', num) == sel (h, num)};


val enque : x : 'a -> q : 'a t -> {x \notin q} unit {x \in q'}

val push : x : 'a -> q : 'a t -> {x \notin q} unit {x \in q'}
(* push is a synonym for add.
 *)


is_empty : q : ref queue -> State {\(h:heap).true}
								  v :  {v : bool | true}
								  {\(h : heap), (v : unit), (h' : heap).
								  	\(Q : queue), (Q' : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									[v=true] <=> (size (Q) = 0) /\ 
									[v=false] <=> (size (Q) > 0)
									Q' = Q};

val is_empty : q : 'a t -> {true} v : bool {v=true <=> size (q) = 0 /\ empty (q)
										/\ v=false <=> size q > 0}

take : q : ref queue > State {\(h : heap). 
									\(Q : queue).
									qsel (h, q) = Q => 
									size (Q) > 0}
									v : {v : int | true}
									{\(h : heap), (v : int), (h' : heap).
									\(Q : queue), (Q' : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									mem (Q', v) = false /\
									size (Q') == size (Q) - 1 /\
									sel (h', num) == sel (h, num)};


val take : q : 'a t -> {size (q) > 0} v : 'a 
						{v \notin q' /\ size (q') = size(q) - 1}
(* take q removes and returns the first element in queue q, or raises Queue.Empty if the queue is empty.
 synonyms pop, dequeue
 *)

val pop : q : 'a t -> {size (q) > 0} v : 'a {v \notin q' /\ size (q') = size(q) - 1}
(* pop is a synonym for take.
 *)


peek : q : ref queue -> Stexc {\(h : heap). 
								\(Q: queue).
									qsel (h, q) = Q => size (Q) > 0}
							  v : {v : int | true}
							 {\(h : heap), (v : int), (h' : heap).
							 \(Q : queue), (Q' : queue).
								qsel (h', q) = Q'/\
								qsel (h, q) = Q /\
								mem (Q, v) = true /\
								sel (h', num) == sel (h, num) /\
								Q' = Q
							  };


(*This will be challenging to handle, due to expception refinement in the post-condition*)
peek_opt : q : ref queue -> Stexc {\(h : heap). 
								 true}
							  v : {v : option int | true}
							 {\(h : heap), (v : option int), (h' : heap).
							 \(Q : queue), (Q' : queue).
								qsel (h', q) = Q'/\
								qsel (h, q) = Q /\
								sel (h', num) == sel (h, num) /\
								(empty (Q) = true => v = Err /\ Q' = Q) \/ 
								(empty (Q) = false => v = Val el /\ Q' = Q)
							  };
 


val peek : q : 'a t -> {size (q) > 0} v : 'a {v \in q' /\ size (q') = size(q)}
(* peek q returns the first element in queue q, without removing it from the queue, or raises Queue.Empty if the queue is empty.
 *)



pop_n : n : int -> q : ref queue > 
								State {\(h : heap).
										\(Q:queue).
										sel (h, q) = Q => 
										not (n > size (Q))}
							  v : {v : [int] | true}
							 {\(h : heap), (v : [int]), (h' : heap).
							 	\(Q : queue), (Q' : queue).
								qsel (h', q) = Q'/\
								qsel (h, q) = Q /\
								sel (h', num) == sel (h, num) /\
								size (Q') = size (Q) - n /\
								elems (v) C qelems (Q) /\
								len (v) = n 
							  };
 
val pop_n : n : int -> q : 'a t -> {size (q) >= n} 
								v : unit 
								{size (q') = size (q) - n
															 }
(*a function to drom n elements*)

(*synonym for peek *)
val top : q : 'a t -> {size (q) > 0} v : 'a {v \in q' /\ size (q') = size(q)}



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
 

val clear : 'a t -> {true } unit {Empty (q')}
(* Discard all elements from a queue.
 *)

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
 

val copy : p : 'a t ->  {true} v : 'a t {Equal (p,v)}
(* Return a copy of the given queue.
 *)

length : q : ref queue -> Stexc {\(h : heap). true}
							  v : {v : int | true}
							 {\(h : heap), (v : int), (h' : heap).
							 \(Q : queue), (Q' : queue).
								qsel (h, q) = Q /\
								qsel (h, q') = qsel (h, q) /\
								sel (h', num) == sel (h, num) /\
								v = size (Q)
							  };
  

val length : 'a t -> int

val iter : ('a -> unit) -> 'a t -> unit
(* iter f q applies f in turn to all elements of q, from the least recently entered to the most recently entered. The queue itself is unchanged.
 *)
val fold : ('b -> 'a -> 'b) -> 'b -> 'a t -> 'b
(* fold f accu q is equivalent to List.fold_left f accu l, where l is the list of q's elements. The queue remains unchanged.
 *)
(*mem*)
val contains : q : ref queue->   (s : {v : int | true}) ->  
			State  
			{\(h : heap). true} 
			v : { v : bool | true} 
			
			{\(h : heap), (v : bool), (h' : heap). 
				\(Q' : queue), (Q: queue).
				qsel (h', tbl) = Q'/\
				qsel (h, tbl) = Q /\
				Q' = Q /\
				([v=true] <=> ( mem(Q', s) = true))/\ 
				([v=false] <=> (mem (Q', s) = false))
			};




(*returns a new queue by removing the intersection of the elems*)
intersection : (p : ref queue ) -> (q : ref queue ) ->
						State 
							{\(h : heap). 	
								\(P : queue), (Q: queue)
								 => (size (P) > 0 \/ size (Q) >0)} 
								v : { v : ref queue | true} 
							
							{\(h : heap), (v : ref queue), (h' : heap). 
								\(P : queue), (Q: queue), (Qv : queue).
								qsel (h, p) = P /\
								qsel (h, q) = Q /\
								qsel (h', v) = Qv /\
								disjoint P Qv /\
								disjoint Q Qv 
							};

val remove_intersection p : 'a t  -> q : 'a t -> {true} v : 'a t {disjoint p v /\ 
																  disjoint q v 
																  Disjoint p' q'}




(* transfer q1 q2 adds all of q1's elements at the end of the queue q2, then clears q1. It is equivalent to the sequence iter (fun x -> add x q2) q1; clear q1, but runs in constant time. *)
(*query transfer*)

transfer : (p : ref queue ) -> (q : ref queue ) ->
						State 
							{\(h : heap). true} 
								v : { v : ref queue | true} 
							{\(h : heap), (v : ref queue), (h' : heap). 
								\(P : queue), (Q: queue) (Qv : queue).
								qsel (h, p) = P /\
								qsel (h, q) = Q /\
								qsel (h', p) = P' /\
								qsel (h', q) = Q' /\
								size (Q') = size (Q) + size (P) /\
								elems (Q') = elems (Q) U elems (p)
								empty (P') = true

							};

val transfer : p : ref queue -> 
				q : ref queue -> {\( h: heap).} 
										v : unit {Elems (q') = 
												Elems (p) U Elems (q)
												/\ Empty (p')
														 				}



val of_list : 'a list -> 'a t

(*of_list list returns a queue t with the elements of list in the same order as the elements of list (i.e. the first element of t is the first element of the list).*)

val to_list : 'a t -> 'a list

val sort : l : [int] -> 
						{true} 
						v : [int] 
						{elems (l) = elems (v) /\
						 sorted v}


(*query1
given an element x and two queues p and q, return a sorted q with elems from both p and 
	q and Uniqueness Invariant intact, further x must be present in the output queue. 	
*)
x : int -> 
p : ref queue -> 
q : ref queue ->  
	State {true}
		v : ref queue  
	{elems (v) C= elems (p) U elems (q) 
	 disjoint v p' /\
	 disjoint v q' /\
	 mem (v, x) = true
	 mem (p', x) = false /\
	 mem (q', x) = false}



(* query2 
remove the disjoint elements from p , but keep in q *)
p : ref queue > q : ref queue -> 
	State {true} 
		v : unit 
	{disjoint p' q' /\
	 elems (q') = elems (q) /\
 }	



(*query3
remove the disjoint elements from q , but keep in p*)
p : ref queue > q : ref queue -> 
	State {true} 
		v : unit 
	{disjoint p' q' /\
	 elems (p') = elems (p) /\
 }	


(*query4
 give the highest number of the first list, which is not in both lists while*)
p : ref queue > q : ref queue -> 
	State {true} 
		v : int 
	{disjoint p' q' /\
	 elems (p') = elems (p) /\
	 mem (p, v) = true /\
	 mem (q, v) = false /\
	 \forall el. elems (p'). v > el}
 }	


(**query)






