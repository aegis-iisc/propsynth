res : int;






bar : State  {\(h : heap). sel (h, res) == 5} 
		v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 2};


foo : (ls : { v : list | len (v) > 0}) -> 
	  State  {\(h : heap). (sel (h, res) == 0)} 
	v : { v : int |  [v=5]} 
	{\(h : heap), (v : int), (h' : heap).  sel (h', res) == v /\ [v=5]};


foo' : (ls : { v : list | len (v) == 0}) -> 
	
	State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : int |  [v=20]} 
	{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ [v=10]};


baz : State  {\(h : heap). sel (h, res) == 7} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 3};





goal : (ls : {v : list | true}) ->
	(agr2 : int) ->  
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10 
		};

