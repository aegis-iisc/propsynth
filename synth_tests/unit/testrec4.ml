res : int;


bar : State  {\(h : heap). sel (h, res) == 5} 
		v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 2};


foo : State  {\(h : heap). (sel (h, res) == 0)} 
	v : { v : int |  [v=5]} 
	{\(h : heap), (v : int), (h' : heap).  sel (h', res) == v /\ [v=5]};



foo' : {ls | len ls = 0} -> 
	
	State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : int |  [v=20]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=20]};


c3' : State  {\(h : heap). not (sel (h, res) > 5)} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};

cdecr : State  {\(h : heap). not (sel (h, res) > 0)} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 0};




goal ls = 
	[] -> 	(*pre /\ len ls = 0*)
		foo' ls
	| x :: xs -> 
		(*pre /\ len ls = 1 + len (xs)*) 
			x1 <- foo x;
			x2 <- bar;
			x3 <- cdecr;
			x4 <- goal xs;  
			return x4

