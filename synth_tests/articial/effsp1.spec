plen : int;
inp : list;


type pair = Pair of int * list
			| Empty; 	


relation proj1 (Pair (x,y)) = (x); 
relation proj2 (Pair (x,y)) = (y);




relation len (nil) = (0) 
			| (cons(x,xs)) =  (1) + len(xs); 



len : State  {\(h : heap). sel (h, plen) == 0 } 
	         v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				sel (h, inp) = inp0 
				/\ v = hd (inp0)   
				/\ sel (h', plen) == sel (h, plen) + v 
				};


ts : State  {\(h : heap). sel (h, plen) > 2} 
		    v : { v : list | true } 
		    {\(h : heap), (v : list), (h' : heap). 
			 len (v) == 2   
		     /\ sel (h', plen) == sel (h, plen) - 2};


content : State  {\(h : heap). sel (h, plen) > 0} 
				v : { v : list | true } 
				{\(h : heap), (v : list), (h' : heap). 
				len (v) == sel (h, plen)  
				/\ sel (h', plen) == 0};



goal : State  {\(h : heap). sel (h, plen) == 0} 
		v : { v : pair | proj2 (v) = pr2 /\
		len (pr2) = porj1 (v) - 2 } 
		{\(h : heap), (v : pair), (h' : heap). 
		proj2 (v) = pr2 /\
		proj1 (v) = pr1 /\ 
		len (pr2) = pr1 - 2 
		/\ sel (h', plen) ==0};

