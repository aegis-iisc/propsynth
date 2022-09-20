
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  

uid : int;
l0 : [int];
l1 : [int];

finalqf : State  {\(h : heap). true } 
	int 
	{\(h : heap), (v : int), (h' : heap). ilssel (h, inp) = l0 /\ ilssel (h', inp) = l1 /\ elems (l1) C= elems (l0) };
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  {\(h : heap). true } 
	int 
	{\(h : heap), (v : int), (h' : heap). ilssel (h, inp) = l0 /\ ilssel (h', inp) = l1 /\ elems (l1) C= elems (l0) };
   


