res : int;

bar : State  {\(h : heap). sel (h, res) == 5} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 2};


foo : State  {\(h : heap). (sel (h, res) == 0)} 
	v : { v : int |  [v=5]} 
	{\(h : heap), (v : int), (h' : heap).  
            sel (h', res) == v /\ [v=5]};



baz : State  {\(h : heap). sel (h, res) == 7} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};

c3' : State  {\(h : heap). (sel (h, res) == 0)} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};


c3'' : State  {\(h : heap). (sel (h, res) == 3)} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) -- 3};

goal : State  
        {\(h : heap). sel (h, res) == 0} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10};

