res : int;
foo : State  {\(h : heap). true} 
	v : { v : int |  [v=5]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=5]};


c2 : State  {\(h : heap). sel (h, res) == 5} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == sel (h, res) + 2};


c2' : State  {\(h : heap). sel (h, res) > 4} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == sel (h, res) + 1};


c2'' : State  {\(h : heap). sel (h, res) > 5} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == sel (h, res) + 5};




c4 : State  {\(h : heap). sel (h, res) == 7} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == sel (h, res) + 5};



c5 : State  {\(h : heap). sel (h, res) == 7} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == sel (h, res) + 5};


c3 : State  {\(h : heap). sel (h, res) == 7} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == sel (h, res) + 3};

c3' : State  {\(h : heap). not (sel (h, res) > 8)} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == sel (h, res) + 3};



goal : State  {\(h : heap). true} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == 10};

