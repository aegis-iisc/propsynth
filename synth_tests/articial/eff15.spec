res : int;
other : int;

bar : State  {\(h : heap). sel (h, res) == 5 } 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 2
		/\ sel (h', other) == sel (h, other)};

foo : State  {\(h : heap). true} 
	v : { v : int |  [v=5]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v 
	/\ [v=5]
	/\ sel (h', other) == sel (h, other)};




baz : State  {\(h : heap). sel (h, res) == 7 } 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3
		/\ sel (h', other) == sel (h, other)};

c3' : State  {\(h : heap). not (sel (h, res) > 8)
		/\ sel (h, other) == 0} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		 sel (h', res) == sel (h, res) + 5 /\
		sel (h', other) == sel (h, other) + 5};



goal : State  {\(h : heap). sel (h, res) == 0 
		/\ sel (h, other) == 0} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		 sel (h', res) == 10 
		/\ sel (h', other) == 0};

