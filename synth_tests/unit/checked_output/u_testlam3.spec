res : int;





baz : 
		(larg : { v : list | true}) -> 
	    
		State  {\(h : heap). sel (h, res) == 0} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 10};



goal : (ls : {v : list | true}) -> 
		(agr2 : int) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10 
		};

