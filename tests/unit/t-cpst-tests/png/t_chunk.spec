
annot : State  {\(h : heap). true} pair 
		{\(h : heap), (v : pair), (h' : heap). 
			(ilssel (h, inp) = l => (fst (v) == hd (l))) /\ 	
			((snd (v) = con) =>  (len (con) == fst (v)))}; 
l1 : [int];
l2 : [int];

