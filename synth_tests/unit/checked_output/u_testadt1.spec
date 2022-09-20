res : int;


type tree = Leaf 
			| Node of int * tree * tree;



relation len (Leaf) = 0 
			| (Node (n, left, right)) = 1 + len (left) + len (right);
			 


foo : (ls : { v : list | len (v) > 0}) -> 
	
	State  {\(h : heap). not (sel (h, res) > 20)} 
	v : { v : char |  true} 
	{\(h : heap), (v : char), (h' : heap). sel (h', res) == sel (h, res) + 3};



baz : 
		(l1 : { v : list | true}) -> 
	    (l2 : {v : char | true}) -> 	

		State  {\(h : heap). sel (h, res) == 3} 
		v : { v : int | true} 
		{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == sel (h, res) + 7};



goal : (tr : {v : tree | true}) -> 
	
	State  
        {\(h : heap). sel( h, res) == 0 } 
	v : { v : int | true} 
	{\(h : heap), (v : int), (h' : heap). 
		sel (h', res) == 10 
		};

