module type MutableStack = sig
  (* ['a t] is the type of mutable stacks whose elements have type ['a].
   * The stack is mutable not in the sense that its elements can
   * be changed, but in the sense that it is not persistent:
   * the operations [push] and [pop] destructively modify the stack. *)
  type 'a t

  (* [empty ()] is the empty stack *)
  val empty : unit -> 'a t

  (* [push x s] modifies [s] to make [x] its top element.
   * The rest of the elements are unchanged. *)
  val push : 'a -> 'a t -> unit

  (* [peek s] is the top element of [s].
   * raises: [Empty] is [s] is empty. *)
  val peek : 'a t -> 'a

  (* [pop s] removes the top element of [s].
   * raises: [Empty] is [s] is empty. *)
  val pop : 'a t -> unit
end


(*int stack*)

type stack = int list ref

val empty : unit -> {true}stack {empty s'}
val push : i : int -> s: stack -> {not (i \in s)} v : stack {i \in s'}
val peek : stack -> {size s > 0} v : int {v \in s /\ top (s') = v}
val pop : stack -> {size s > 0} {v : int} {i \notint s'} 


inv : uniqueness

goal : int -> int -> (int * stack)

(*sol1*)
let lam  (i : int) (j : int)  = 
	let em = empty () in
	let st = push i em in 
	let st1 = push j em in

	return (i * em)


goal : i : int -> j : int ->  
				state 
				{empty s} 
				v : int
				{i \in s' /\ j \in s' /\ top s' = v }

let lam i j = 
		s1 <- push i;
		s2 <- push j;
		_ <- peek

