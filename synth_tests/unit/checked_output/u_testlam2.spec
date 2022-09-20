res : int;




foo' : (ls : { v : list | true}) -> 
	   (l : {v : int | true}) -> 	
	
	State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : int |  true} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=10]};


baz : State  {\(h : heap). sel (h, res) == 0} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};



goal : (ls : {v : list | true}) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10 
		};

