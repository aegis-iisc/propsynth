

g : State  {\(h : heap). (sel (h, res) == 0) } 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3 /\
        sel (h', res) > 1 };



f : State  {\(h : heap). (sel (h, res) == 0) } 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};


goal : State  
        {\(h : heap). sel (h, res) == 0 /\ sel (h, x) == 1} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10 /\ sel (h, x) == 5};
