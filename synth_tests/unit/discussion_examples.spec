
1. We have an implementation(1.0) of the backward WP algorithm.

better : u_bw_6.spec &&  u_test10.spec, u_test9.spec
similar: u_bw_purefun2.spec
u_bw_purefun3.spec

worse : u_bw_prefun4.spec


2. more realistic examples : 
example_tbl1.spec

example_tbl2.spec : The distinguisher map just explodes
 





--------------------------------------
3. The high level idea is as follows:
goal : {P} v : T {Q} 

ci : (xi : ti) -> Pure {true} v : T {Qi} 

ci : (xi : ti) -> State {Pi} v : T {Qi} 


The WP check is as follows:
	
	wp (ci, Q) = 
	\forall h. Pi h 
			/\ \forall v:T h'. Qi (h v h') => Q (h v h')


	*ci is a valid choice
	 ---------------------- 		
		\forall h. Pi h 
			=> \forall v:T h'. Qi (h v h') => Q (h v h')

Example : 

goal : (ls : {v : list | true}) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : pair | true} 
	{\(h : heap), (v : pair), (h' : heap). 
			sel (h', res) == 10 
		};


baz' : (arg1 : { v : int | true}) ->

	State  {\(h : heap). not (sel (h, res) > 5) /\ (sel (h, res) > 3)} 
		v : { v : char | true} 
	
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == 10};


	wp ((baz' x1:{int | true}), sel (h', res) == 10) 
		=  \forall h. 
			not (sel (h, res) > 5) /\ (sel (h, res) > 3)
			/\ forall h', v. sel (h', res) == 10 => sel (h', res) == 10)







The challenges in the backward synthesis:
------------------------------------------------------
1. The abducive-inference of the frame.

goal : {P} v : T {Q} 

ci : (xi : ti) -> Pure {true} v : T {Qi} 
ci : (xi : ti) -> State {Pi} v : T {Qi} 


The WP check is as follows:
	
	wp (ci, Q) = \forall h. Pi h /\ \forall v:T h'. Qi (h v h') => Q (h v h')


Example : 
goal : (ls : {v : list | true}) -> State  
        {res = 0 } 
		v : { v : pair | true} 
		{res' = 10 /\ fst (v) > 0};




foopure  : (ai : { v : int | true}) -> 
			(ac : { v : char | true}) ->  Pure {true}
										{v : pair }
										{ h'= h /\ fst (v) > 0}; 



wp (foopure, Q) = \forall h. true h /\ \forall v : pair. h'.
								h' = h /\ fst (v) > 0 =>  (res' = 10) /\ fst (v) > 0


(*so we cannot chose a backward path like*)

{P} [??:pair] {res' = 10 /\ fst (v) > 0}

====> (not allowed)

{P} x1 <- [??:int];
	y1 <- [??:char];
	wp (foopure Q)
	foopair ( x1 , y1) 
	{res' = 10 /\ fst (v) > 0}


(*If we can find an abductive frame*)


	wp_framed (ci, Q) = \forall h. frame /\ Pi h /\ 
								\forall v:T h'. Qi (h v h') /\ frame  
												=> Q (h v h')


	wp_framed (foopure, Q) = \forall h. res = 10 /\ true h /\ 
								\forall v : pair. h'.
								res' = 10 /\ 
								h' = h /\ fst (v) > 0 =>  (res' = 10) /\ fst (v) > 0




{P} [??:pair] {res' = 10 /\ fst (v) > 0}

====> (Allowed)

{P} x1 <- [??:int];
	y1 <- [??:char];
	wp_framed (foopure Q)
	foopair ( x1 , y1) 
	{res' = 10 /\ fst (v) > 0}



2. Inherent Non-determinism in the the order of the inferred Holes : 

Both of the following choices are valid, We look for both the orederings and the Type specification is NOT Strong enough to discard one over the other in general.


{P} x1 <- [??:int];
	y1 <- [??:char];
	wp_framed (foopure Q)
	foopair ( x1 , y1) 
	{res' = 10 /\ fst (v) > 0}


OR 

{P} y1 <- [??:char];
	x1 <- [??:int];
	wp_framed (foopure Q)
	foopair ( x1 , y1) 
	{res' = 10 /\ fst (v) > 0}


3. Many possible Backward choices, may lead to a COSTLY initial choice:

See example u_backward_prefun4


ci : [(xi : ti)] -> State {Pi} v : T {Qi} 

cj : [(xj : tj)] -> State {Pj} v : T {Qj} 



Goal : {P} v : T {Q}


=====> 

{P} x1 <- [??:t1];
	x2 <- [??:t2];
	xn <- [?? : tn]
	...
	xj <- [??:tj];

	wp_framed (Q, cj (x1, x2,....xj))


	{Q}

======> 


{P} x1 <- [??:t1];
	x2 <- [??:t2];
	xn <- [?? : tn]
	-------------------------- FORWARD FAILS TO FIND a solution for [??:tn] 
	wp_framed (Q, cn-1 ())

	...
	xj <- [??:tj];

	wp_framed (Q, cj (x1, x2,....xj))


	{Q}




======>  BACKTRACK



{P} x1 <- [??:t1];
	x2 <- [??:t2];
	...
	xi <- [??:tj];

	wp_framed (Q, cj (x1, x2,....xi))


	{Q}



4) The CDCL algorithm does not show up in most cases:
Change the algorithm for a bounded path of length K.






5) We should now try to fix the domain of the problems we are attempting to solve: so that we do not over-engineer the algorithm for these toy domains:

1. Fix the spec, uninterpreted functions and linear arithmetic.
2. Fix the domain of the program.
		monExp (me) : 
			1. monadic Calculus of Moggi minus the recursive functions.
			2. Holed monadic expression.


(*Limitations*)
a) The specifications uses LIA+select_update
	- as we include more complex specs, we start seeing limitations of Z3 start to show up.
	- The problem with polymorhic version of the specifications show up.
	-dependening on the domain, we may have to do substantial engineering to make the approach work.

b) The specifications currently are non-inductive, I am not very sure I should continue with this restriction.


6) Some examples of Domains:
	i) Haskell vs OCaml vs Scala 
		a) A HaskellDB library.
		b) Haskell Mutable Key-Value Store Haskell Cache.


