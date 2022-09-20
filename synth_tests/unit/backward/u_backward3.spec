res : ref int;

type pair = Pair of int * char;



 
bar : (arg1 : { v : int | true}) ->  

	State  {\(h : heap). (sel (h, res) > 0) /\ not (sel (h, res) > 5)} 
		v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};


foo : (ls : { v : list | true }) -> 
	  State  {\(h : heap). sel (h, res) == 0} 
	v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap).  sel (h', res) == sel (h, res)+7};



baz : (l1 : { v : list | true}) -> 
	    (l2 : {v : char  | true}) -> 	

	State  {\(h : heap). sel (h, res) > 5} 
		v : { v : char | true} 
		{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == 10};





bar' : (ls : { v : list | true}) -> 
	
	State  {\(h : heap). not (sel (h, res) > 3)} 
	v : { v : int |  true} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == sel (h, res) + 1};





foo' : (ls : { v : list | true}) -> 
	
	State  {\(h : heap). (sel (h, res) > 3) /\ not (sel (h, res) == 10)} 
	v : { v : int |  [v=10]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=10]};





baz' : (arg1 : { v : int | true}) ->

	State  {\(h : heap). not (sel (h, res) > 5) /\ (sel (h, res) > 3)} 
		v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == 10};


goal : (ls : {v : list | true}) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : pair | true} 
	{\(h : heap), (v : pair), (h' : heap). 
			sel (h', res) == 10 
		};


		