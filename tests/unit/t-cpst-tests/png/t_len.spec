
formula guard1 = \(h : heap). ilssel (h,inp) = l  /\ hd (l) == i /\ ([i = 0] \/ [i = 1] \/ [i = 2] \/ [i = 3]); 
res : ref int;
l1 : [int];
l2 : [int];
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h, res) == 0 /\ ilssel (h, inp) = ilssel (h', inp)};  
step1 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h', res) ==  i /\ ilssel (h,inp) = l1 /\  ilssel (h', inp) = l2 /\ elems (l2) C= elems (l1)};  

finalqf : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). sel (h, res) == v /\ ilssel (h', inp) = ilssel (h, inp)};

finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

annot : State  
	{\(h : heap). true} int 
	{\(h : heap), (v1 : int), (h' : heap). ilssel(h, inp) = l /\  hd (l) == v1 /\ ([v1 = 0] \/ [v1 = 1] \/ [v1 = 2] \/ [v1 = 3]) }; 	 



