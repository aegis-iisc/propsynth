res : int;

type pair = Pair of int * list;



bar : (arg1 : { v : int | true}) ->  

	State  {\(h : heap). (sel (h, res) == 9)} 
		v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == sel (h, res) + 1};


foo : (ls : { v : list | len (v) > 0}) -> 
	  State  {\(h : heap). not (sel (h, res) > 10)} 
	v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap).  sel (h', res) == sel (h, res)+3 };


foo' : (ls : { v : list | len (v) == 0}) -> 
	
	State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : int |  [v=20]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=10]};


bar' : (arg1 : { v : int | true}) ->  

	State  {\(h : heap). (sel (h, res) == 7)} 
		v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};


goal : (ls : {v : list | true}) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : pair | true} 
	{\(h : heap), (v : pair), (h' : heap). 
			sel (h', res) == 10 
		};

