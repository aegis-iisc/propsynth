l0 : [int];
l1 : [int];
uid : int;
topen : [int];
tclose : [int];
annot : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). ilssel (h, inp) = l0 /\ ilssel (h', inp) = l1 /\ elems (l0) C= elems (l1) };  

