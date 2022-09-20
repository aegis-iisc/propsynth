res : int;

type pair = Pair of int * char;


foopure : (ls : { v : list | true}) ->  { v : pair |  true}; 



bar : (arg1 : { v : int | true}) ->  

	State  {\(h : heap). sel (h, res) == 5} 
		v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == sel (h, res) + 2};


foo : (ls : { v : list | len (v) > 0}) -> 
	  State  {\(h : heap). (sel (h, res) == 0)} 
	v : { v : int |  [v=5]} 
	{\(h : heap), (v : int), (h' : heap).  sel (h', res) == v /\ [v=5]};


foo'' : (ls : { v : list | len (v) > 0}) -> 
State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : int |  [v=20]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=25]};


foo' : (ls : { v : list | len (v) == 0}) -> 
	
	State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : int |  [v=10]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=10]};



bar' : (l1 : { v : list | true}) ->
	 State  {\(h : heap). (sel (h, res) == 25)} 
	v : { v : int |  [v=20]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == sel (h, res) + 5};


bar'' : (l1 : { v : list | len (ls) > 0}) -> State  {\(h : heap). not (sel (h, res) > 25)} 
	v : { v : int |  [v=20]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == sel (h, res) + 10};



baz : (l1 : { v : list | true}) -> 
	    (l2 : {v : char | true}) -> 	

	State  {\(h : heap). sel (h, res) == 7} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};



c3' : (ls : { v : list | len (v) > 0}) -> 
		State  {\(h : heap). not (sel (h, res) > 5)} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};



goal : (ls : {v : list | true}) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : pair | true} 
	{\(h : heap), (v : pair), (h' : heap). 
		sel (h', res) == 10 
		};

