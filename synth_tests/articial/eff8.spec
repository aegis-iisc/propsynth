res : int;
c1 : State  {\(h : heap). true} 
	v : { v : int |  [v=5]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=5]};




c2 : State  {\(h : heap). sel (h, res) == 5} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == sel (h, res) + 2};

c3 : State  {\(h : heap). sel (h, res) == 7} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == sel (h, res) + 3};




goal : State  {\(h : heap). true} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == 10};


