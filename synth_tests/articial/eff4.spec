res : int;


e2 : State  {\(h : heap). sel (h, res) == 5} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == sel (h, res) + 5};

e1 : State  {\(h : heap). true} 
	v : { v : int |  true} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=5]};

e1' : 
	State  {\(h : heap). sel (h, res) == 6} 
	v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == sel (h, res)};



goal : State  {\(h : heap). sel (h, res) == 0} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == 10};


