
res : int;





bar : State  {\(h : heap). sel (h, res) == 5} 
		v : { v : char | true} 
		{\(h : heap), (v : char), (h' : heap). 
		sel (h', res) == sel (h, res) + 2};



foo : 	(ls : { v : list | len (v) > 0}) -> 
	State  {\(h : heap). (sel (h, res) == 0)} 
	v : { v : int |  [v=5]} 
	{\(h : heap), (v : int), (h' : heap).  sel (h', res) == v /\ [v=5]};



foo' : (ls : { v : list | len (v) == 0}) -> 
	
	State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : int |  true} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=10]};




bar' : State  {\(h : heap). (sel (h, res) == 25)} 
	v : { v : int |  [v=20]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == sel (h, res) + 5};


bar'' : State  {\(h : heap). (sel (h, res) == 25)} 
	v : { v : int |  [v=20]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == sel (h, res) + 10};



baz : (l1 : { v : list | true}) -> 
	    (l2 : {v : char | true}) -> 	

	State  {\(h : heap). sel (h, res) == 7} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};

c3' : 
	(ls : {v : list | true}) -> 

	State  {\(h : heap). not (sel (h, res) > 8)} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};





goal : (ls : {v : list | true}) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10 
		};


