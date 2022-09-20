
formula guard1 = \(h : heap). [sig = 0] /\  ilssel (h,inp) = l  /\ hd (l) == i /\ ([i = 0]);

formula guard2 = \(h : heap). [sig = 1] /\  ilssel (h,inp) = l  /\ hd (l) == i /\ ([i = 1]);

res : ref int;
l : [int];
sig : int;
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h, res) == 0 /\ ilssel (h, inp) = ilssel (h', inp)};  
step1 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h', res) == i};  

step2 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h', res) == i};  

finalqf1 : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). sel (h, res) == v /\ ilssel (h', inp) = ilssel (h, inp)};

finalqf2 : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). sel (h, res) == v /\ ilssel (h', inp) = ilssel (h, inp)};

finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

annot : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). [v = 1] \/ [v = 0]}; 	 



