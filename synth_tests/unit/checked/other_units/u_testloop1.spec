res : int;



foo : State  {\(h : heap). true} 
	v : { v : int |  true} 
	{\(h : heap), (v : int), (h' : heap).  sel (h', res) == v /\ [v=5]};



goal : State  
        {\(h : heap). sel (h, res) == 0} 
		
		v : { v : int | true} 
		
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10};

