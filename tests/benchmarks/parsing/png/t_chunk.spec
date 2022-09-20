annot : State  {\(h : heap). true} pair 
		{\(h : heap), (v : pair), (h' : heap). 
			(ilssel (h, inp) = l => (hd (l) == fst (v))) /\ 	
			((snd (v) = con) =>  (len (con) == fst (v)))}; 
l1 : [int];
l2 : [int];

