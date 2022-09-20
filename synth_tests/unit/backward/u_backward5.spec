res : int;

 
baz' : (arg1 : { v : list | true}) ->  

	State  {\(h : heap). sel (h, res) == 0 } 
		v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == 10};


goal : (ls : {v : list | true}) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
			sel (h', res) == 10 
		};


		