typedefterm : [int];
typeexp : int;
annot : State  {\(h : heap).  Ilssel (h, identifiers) = I } 
		[int] 
		{\(h : heap), (v : [int]), (h' : heap). ilssel (h', inp) = l1 
							/\ ilssel (h, inp) = l0 
							/\ elems (l1) C= elems (l0)
							/\ not (contains (I, v) = true)
							/\ Ilssel (h, types) = Tin
							/\ Ilssel (h', types) = Tout /\
							Ielems (Tout) = Ielems (Tin) U {(v)}};


