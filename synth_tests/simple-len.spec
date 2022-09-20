plen : int;
inp : list;
pr2 : list;
pr1 : int;



type pair = Pair of int * list
			| Empty; 	


relation proj1 (Pair (x,y)) = (x); 
relation proj2 (Pair (x,y)) = (y);



len : State  {\(h : heap). sel (h, plen) == -1 } 
	         v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				 sel (h', plen) == sel (h, plen) + v 
				/\ [v > 2] };

len'  : State  {\(h : heap). sel (h, plen) == -1 } 
	         v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				 sel (h', plen) == sel (h, plen) + v 
				/\ [v > 1] };
 


ts : State  {\(h : heap). sel (h, plen) > 2} 
		    v : { v : list | true } 
		    {\(h : heap), (v : list), (h' : heap). 
			 len (v) == 2   
		     /\ sel (h', plen) == sel (h, plen) -- 2};


content : State  {\(h : heap). sel (h, plen) > 0} 
				v : { v : list | true } 
				{\(h : heap), (v : list), (h' : heap). 
				len (v) == sel (h, plen)  
				/\ sel (h', plen) == 0};



content' : State  {\(h : heap). sel (h, plen) > 0} 
				v : { v : list | true } 
				{\(h : heap), (v : list), (h' : heap). 
				len (v) == sel (h, plen)  
				/\ sel (h', plen) == sel (h, plen) -- 1};




ts' : State  {\(h : heap). sel (h, plen) > 1} 
		    v : { v : list | true } 
		    {\(h : heap), (v : list), (h' : heap). 
			 len (v) == 2   
		     /\ sel (h', plen) == sel (h, plen) -- 1};




goal : State  {\(h : heap). sel (h, plen) == -1} 
		v : { v : pair | true} 
		{\(h : heap), (v : pair), (h' : heap). 
		proj2 (v) = pr2 /\
		proj1 (v) = pr1 /\ 
		len (pr2) = pr1 -- 2 
		/\ sel (h', plen) ==0};

