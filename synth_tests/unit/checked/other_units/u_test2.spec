res : int;



bar : State  {\(h : heap). sel (h, res) == 5} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 2};



c3' : State  {\(h : heap). not (sel (h, res) > 8)} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};



goal : State  
        {\(h : heap). sel (h, res) == 0} 
		
		v : { v : int | true} 
		
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10};

