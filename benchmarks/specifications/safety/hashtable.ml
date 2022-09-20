

(*query1
given a key k and a value v, 
and two tables h1 and h2, 
return a (different) table with elems from both h1 and h2
Uniqueness Invariant intact, 
further (k,v) must be present in the output queue and not present in the 
inputs
*) 	
k : 'a -> v : 'b
h1 : ('a * 'b) t ->
h2 : ('a * 'b) t -> 
	
{true}
v : ('a * 'b) t 
{Elems (v) = Elems (h1) U Elems (h2) 
/\ Mem (k, v) v
/\ NEq (v, h1)
/\ NEq (v, h2)
/\ not (k \in Keys (h1'))
/\ not (k \in Keys (h2'))
}


(*query2
given  two table tables h1 and h2 
return a (different) table with the intesection of h1 and h2 , with values from h2
*)
h1 : ('a * 'b) t ->
h2 : ('a * 'b) t -> 
	
{true}
v : ('a * 'b) t 
{Elems (v) = Intersection (Elems (h1) Elems (h2)) 
/\ NEq (v, h1)
/\ NEq (v, h2)
\forall k. Keys (v). ValueOf (k, v) = ValueOf (k, h2)
}



(*query3
given  two table tables h1 and h2 
return a (different) table with the intesection of h1 and h2 , with values from h1
*)
h1 : ('a * 'b) t ->
h2 : ('a * 'b) t -> 
	
{true}
v : ('a * 'b) t 
{Elems (v) = Intersection (Elems (h1) Elems (h2)) 
/\ NEq (v, h1)
/\ NEq (v, h2)
\forall k. Keys (v). ValueOf (k, v) = ValueOf (k, h1)
}

