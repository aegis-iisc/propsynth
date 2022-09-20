
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  

pname : [int];
l0 : [int];
l1 : [int];
proteins : ref [intlist];
Pin : [intlist];
Pout : [intlist];
finalqf : State  {\(h : heap). Ilssel (h, proteins) = Pin  } 
	[int] 
	{\(h : heap), (v : [int]), (h' : heap). 
		[v = pname]
		/\ ilssel (h, inp) = l0 /\ ilssel (h', inp) = l1 /\ elems (l1) C= elems (l0)
		/\ not (contains (Pin, v) = true)
		/\ Ilssel (h', proteins) = Pout
		/\ Ielems (Pout) = Ielems (Pin) U {(v)} 
		/\ contains (Pout, v) = true};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  {\(h : heap). Ilssel (h, proteins) = Pin  } 
	[int] 
	{\(h : heap), (v : [int]), (h' : heap). [v = pname]
		/\ ilssel (h, inp) = l0 /\ ilssel (h', inp) = l1 /\ elems (l1) C= elems (l0)
		/\ not (contains (Pin, v) = true)
		/\ Ilssel (h', proteins) = Pout
		/\ Ielems (Pout) = Ielems (Pin) U {(v)} 
		/\ contains (Pout, v) = true};


