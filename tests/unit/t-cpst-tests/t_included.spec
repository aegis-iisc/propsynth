formula guard1 = \(h : heap). ilssel (h,inp) = l /\ hd (l) = i  /\ [i = 0] /\ hd (l) C= elems (l); 
res : ref int;
l1 : [int];
l2 : [int];
l' : [int];
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h, res) == 0 /\ ilssel (h, inp) = ilssel (h', inp)};  

step1 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h', res) == i /\ ilssel (h,inp) = l1 /\  ilssel (h', inp) = l2 /\ elems (l2) C= elems (l1)  };  

finalqf : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). sel (h, res) == v /\ ilssel (h, inp) = ilssel (h', inp)};

finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

annot : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). ilssel (h, inp) = l1 /\ v = hd (l)  /\ ([v = 0]) /\ {(v)} C= elems (l1) /\
									ilssel (h', inp) = l2 /\ elems (l2) C= elems (l) };  




