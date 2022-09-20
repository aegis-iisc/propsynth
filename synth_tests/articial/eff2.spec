res : int;
getState : State  {\(h : heap). true} 
	v : { v : int |  [v=10]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v };

goal : State  {\(h : heap). true} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == v 
		/\ sel (h', res) == 10};
