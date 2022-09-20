l0 : [int];
l1 : [int];
topen : [int];
tclose : [int];
proteins : ref [intlist];
Pin : [intlist];
Pout : [intlist];
pname : [int];
annot : State  {\(h : heap). Ilssel (h, proteins) = Pin  } 
	[int] 
	{\(h : heap), (v : [int]), (h' : heap). 
		ilssel (h, inp) = l0 /\ ilssel (h', inp) = l1 /\ elems (l1) C= elems (l0)
		/\ not (contains (Pin, v) = true)
		/\ Ilssel (h', proteins) = Pout
		/\ Ielems (Pout) = Ielems (Pin) U {(v)} 
		/\ contains (Pout, v) = true};


