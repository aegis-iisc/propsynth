


qualifier fsel : heap :-> ref bool :-> bool;
res : ref int;
flag : ref bool;




bar : State  {\(h : heap). sel (h, res) == 5 /\ 
				fsel (h, flag) = false} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 2 /\ 
		fsel (h', flag) = true};

foo : State  {\(h : heap). (sel (h, res) == 0)} 
	v : { v : int |  [v=5]} 
	{\(h : heap), (v : int), (h' : heap).  
		fsel (h', flag) = fsel (h, flag) /\
		sel (h', res) == v /\ [v=5]};


foo' : State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : int |  [v=20]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=25]};



bar' : State  {\(h : heap). (sel (h, res) == 25)} 
	v : { v : int |  [v=20]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == sel (h, res) + 5};


bar'' : State  {\(h : heap). (sel (h, res) == 25)} 
	v : { v : int | true } 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == sel (h, res) + 10};



baz : State  {\(h : heap). sel (h, res) == 7} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};

c3' : State  {\(h : heap). not (sel (h, res) > 8)} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};



goal : State  
        {\(h : heap). sel (h, res) == 0 /\ 
		fsel (h, flag) = false} 
		
		v : { v : int | true} 
		
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10  
		};


