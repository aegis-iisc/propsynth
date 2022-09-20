res : ref int;



boolf : (i : { v : int | true}) -> State {\(h : heap). true} 
			v : { v : bool | true} 
			{\(h : heap), (v : bool), (h' : heap). 
				([v=true] <=> [i > 0]) /\
				([v=false] <=> [i = 0])};


foo' : (i : { v : int | [v = 0]}) -> 
		State  {\(h : heap). not (sel (h, res) > 20)} 
		v : { v : int |  true} 
		{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=10]};


baz :  (l1 : { v : int | [v > 0]}) -> 
	   (l2 : {v : char | true}) -> 	

	
		State  {\(h : heap). sel (h, res) == 0} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 10};



goal : (i : {v : int | true}) -> 
	 (agr2 : char) -> 
	State  {\(h : heap). sel( h, res) == 0 } 
			v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10 
		};

