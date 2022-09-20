
Forward Problem:
{res = 0}
x1 : ??int 
x4 : ??char

(res <= 4 /\ res > 2) /\ res <= 10 => 
	forall res' = res + 1 => res' <= 5 /\ res' > 3

x3  <- foo_float x1 x4 ; 
{res <= 5 /\ res > 3 forall res' = 10 => res' = 10} 
x2 <- baz' x1 x3
{res = 10} Pair _

-------------------------------------------------------
Case1 foo : 
	wp (foo ls, _) =  BREAK 

		res = 0 /\ \forall res' = res + 7 => res' <= 5 /\ res' > 3 /\ true


Case2 foo' BREAK
	wp () = 
		res > 3 /\ \forall res' = 10 => res' <= 5 /\ res' > 3 



Case bar' : (*scenario 3*) FLIP

		P(X) = res <= 3 /\ \forall res' = res + 1 =>  
		res' <= 5 /\ res' > 3 

		(*Abduction*)
		find a P0 
		such that 
		P0 /\ P(X) => \forall res' = res + 1 =>  res' <= 5 /\ res' > 3  
		P0 = res > 2 

Forward 
[ls : list], {res = 0} x1 : int {P0 /\ P(X)}		

(~~)

[ls : list], {res = 0} x1 : int {res' >2 /\ res' <= 3}	

(~~)

[ls : list], {res = 0} x1 : int {res' = 3}	


(*The forward learning based algorithm kicks in at this point giving*)

Case foo_float : 
	  res <= 10 /\ \forall res'  = res + 1 => 
	  					res' <= 5 /\ res' > 3

Find a P0, such that 
	P0 /\ res <=10 => forall res' = res + 1 => res' <= 5 /\ res' > 3

P0 = (res <= 4 /\ res > 2) /\ res <= 10 => 
	forall res' = res + 1 => res' <= 5 /\ res' > 3

------

{res = 0}
x1 : ??int 
x4 : ??char

(res <= 4 /\ res > 2) /\ res <= 10 => 
	forall res' = res + 1 => res' <= 5 /\ res' > 3

x3  <- foo_float x1 x4 ; 
{res <= 5 /\ res > 3 forall res' = 10 => res' = 10} 
x2 <- baz' x1 x3
{res = 10} Pair _

---------------------------------------------------------------------------
[ls : list], {res = 0} 
x1 : ??int ; 
x3 : ??float; 
{res <= 5 /\ res > 3 forall res' = 10 => res' = 10} 
x2 <- baz' x1 x3
{res = 10} Pair _

--------------------------------------------------------------------------

Case baz' : (*scenario 1*) Continue

	wp (bar ls x1, (res= 10)) = 
		Pre (baz) /\ (\forall Post (baz) => Required_Post)


		= res <= 5 /\ res > 3 /\ forall res' = 10 => res' = 10




Case bar : (*scenario 2*)

	wp (bar x1, (res= 10)) = 
		Pre (bar) /\ (\forall Post (bar) => Required_Post)


		= (res > 0 /\ res <= 5) /\
			\forall res' = res + 3 => res' = 10 	


	find a P0 such that 
		P0 /\ res > 0 /\ res <= 5 /\
			\forall res' = res + 3 => res' = 10		

			

-------------------------------------------------------
[ls : list], {res = 0} x1 : int ; x2 : char ; {res = 10} Pair _
------------------------------------------------------------------

[ls : list], {res = 0} x1 : int ; x2 : char ; Pair (x1, x2) {res = 10}

-----------------------------------------------
[ls : list], {res = 0} H1 : pair {res = 10}
-----------------------------------------------------
goal : (ls : {v : list | true}) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : pair | true} 
	{\(h : heap), (v : pair), (h' : heap). 
			sel (h', res) == 10 
		};

***************************************