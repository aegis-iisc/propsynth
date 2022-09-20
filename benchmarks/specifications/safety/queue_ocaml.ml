type 'a t 

predicate Disjoint p q = ..
predicate Unique



val create : unit -> 'a t
(* Return a new queue, initially empty.
 *)
val add : x : 'a -> q : 'a t -> {x \notin q} unit {x \in q'}
(* add x q adds the element x at the end of the queue q.

alias val enque : x : 'a -> q : 'a t -> {x \notin q} unit {x \in q'}
 *)
val push : x : 'a -> q : 'a t -> {x \notin q} unit {x \in q'}
(* push is a synonym for add.
 *)

val is_empty : q : 'a t -> {true} v : bool {v=true <=> size (q) = 0 /\ empty (q)
										/\ v=false <=> size q > 0}

val take : q : 'a t -> {size (q) > 0} v : 'a 
						{v \notin q' /\ size (q') = size(q) - 1}
(* take q removes and returns the first element in queue q, or raises Queue.Empty if the queue is empty.
 synonyms pop, dequeue
 *)

Since 4.08
val pop : q : 'a t -> {size (q) > 0} v : 'a {v \notin q' /\ size (q') = size(q) - 1}
(* pop is a synonym for take.
 *)
val peek : q : 'a t -> {size (q) > 0} v : 'a {v \in q' /\ size (q') = size(q)}
(* peek q returns the first element in queue q, without removing it from the queue, or raises Queue.Empty if the queue is empty.
 *)

val drop_n : n : int -> q : 'a t -> {size (q) >= n} 
								v : unit 
								{size (q') = size (q) - n
															 }

val top : q : 'a t -> {size (q) > 0} v : 'a {v \in q' /\ size (q') = size(q)}
top is a synonym for peek.

val clear : 'a t -> {true } unit {Empty (q')}
(* Discard all elements from a queue.
 *)
val copy : p : 'a t ->  {true} v : 'a t {Equal (p,v)}
(* Return a copy of the given queue.
 *)
val is_empty : 'a t -> bool

val length : 'a t -> int

val iter : ('a -> unit) -> 'a t -> unit
(* iter f q applies f in turn to all elements of q, from the least recently entered to the most recently entered. The queue itself is unchanged.
 *)
val fold : ('b -> 'a -> 'b) -> 'b -> 'a t -> 'b
(* fold f accu q is equivalent to List.fold_left f accu l, where l is the list of q's elements. The queue remains unchanged.
 *)

val contains : q -> a -> {true} v : bool 
					{[v=true] <=> (a \in q) /\ [v=false] <=> (a \notin q)}

val remove_intersection p : 'a t  -> q : 'a t -> {true} v : 'a t {Disjoint p' v /\ 
																  Disjoint q' v 
																  Disjoint p' q'}

val transfer : p : 'a t -> q : 'a t -> {Disjoint p q} 
										v : unit {Elems (q') = 
												Elems (p) U Elems (q)
												/\ Empty (p')
														 				}


(* transfer q1 q2 adds all of q1's elements at the end of the queue q2, then clears q1. It is equivalent to the sequence iter (fun x -> add x q2) q1; clear q1, but runs in constant time. *)

val sort : q : 'a t -> {true} 
						v : 'a t 
						{Elems (q) = Elems (v) /\ Sorted v}


(*query1
given an element x and two queues p and q, return a sorted q with elems from both p and 
	q and Uniqueness Invariant intact, further x must be present in  the output queue. 	
*)
x : 'a -> 
p : 'a t -> 
q : 'a t ->  {true}
v : 'a t {Elems (v) = Elems (p) U Elems (q) 
											/\Sorted (v)
											x \in q

											}



(* query2 
remove the disjoint elements from p , but keep in q*)

p : 'a t > q : 'a t -> {true} v : unit {Disjoint p' q' /\ Elems (q') = Elems (q)}	



(*query3
remove the disjoint elements from q , but keep in p*)

p : 'a t > q : 'a t -> {true} v : unit {Disjoint p' q' /\ Elems (p') = Elems (p)}	



