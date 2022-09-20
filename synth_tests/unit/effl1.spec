res : int;



c3' : State  {\(h : heap). not (sel (h, res) > 8)} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};

c2 : State  {\(h : heap). sel (h, res) > 4} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 10};


goal : State  
        {\(h : heap). sel (h, res) == 0} 
		
		v : { v : int | true} 
		
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10};

