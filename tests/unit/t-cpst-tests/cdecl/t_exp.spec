l0 : [int];
l1 : [int];
l4 : [int];
eps : int;
annot : State  {\(h : heap). true} [int] {\(h : heap), (v : [int]), (h' : heap). 
							ilssel (h, inp) = l0 
							/\ ilssel (h', inp) = l1 
							/\ elems (l1) C= elems (l0)};  

