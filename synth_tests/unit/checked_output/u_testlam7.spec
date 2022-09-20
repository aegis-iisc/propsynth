res : int;





foo' : (ls : { v : list | len (v) == 0}) -> 
	
	State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : int |  true} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=10]};



foo : (ls : { v : list | len (v) > 0}) -> 
	
	State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : char |  true} 
	{\(h : heap), (v : char), (h' : heap). sel (h', res) == sel (h, res) + 3};



baz : 
		(l1 : { v : list | true}) -> 
	    (l2 : {v : char | true}) -> 	

		State  {\(h : heap). sel (h, res) == 3} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 7};



goal : (ls : {v : list | true}) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10 
		};

