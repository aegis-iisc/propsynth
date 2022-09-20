res : ref int;

 
bar : (arg1 : { v : int | true}) ->  

	State  {\(h : heap). (sel (h, res) == 0)} 
		v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == sel (h, res) + 4};


bar' : (arg1 : { v : int | true}) ->  

	State  {\(h : heap). (sel (h, res) == 0)} 
		v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == sel (h, res) + 6};



foo' : (arg1 : { v : list | true}) ->  

	State  {\(h : heap). not (sel (h, res) > 5) /\ (sel (h, res) > 3)} 
		v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == 20};



baz' : (arg1 : { v : list | true}) ->  

	State  {\(h : heap). not (sel (h, res) > 5) /\ (sel (h, res) > 3)} 
		v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == 10};


goal : (ls : {v : list | true}) -> (i : { v : int | true}) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : char | true} 
	{\(h : heap), (v : char), (h' : heap). 
			sel (h', res) == 10 
		};


		