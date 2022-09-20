res : ref int;


boolf : (i : { v : int | true}) -> {v : bool |([v=true] <=> [i > 0]) /\
											  ([v=false] <=> [i = 0])}; 


foo_false : (i : { v : int | [v = 0]}) -> 
		State  {\(h : heap). not (sel (h, res) > 20)} 
		v : { v : int |  true} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=10]};


foo_true : (i : { v : int | [v > 0]}) -> 
		State  {\(h : heap). not (sel (h, res) > 20)} 
		v : { v : int |  true} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=10]};



goal : (i : {v : int | true}) -> 
	 (agr2 : char) -> 
	State  
        {\(h : heap). sel( h, res) == 0 } 
			v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10 
		};

