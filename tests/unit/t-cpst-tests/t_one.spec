
formula guard1 = \(h : heap). hd_sel (h,inp) == i /\ ([i = 1]); 
res : ref int;

init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h, res) == 0 /\ hd_sel (h, inp) == hd_sel (h', inp) /\ ilssel (h', inp) = ilssel (h, inp)};  
step1 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h', res) == i /\ ilssel (h', inp) C= ilssel (h, inp)};  

finalqf : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). sel (h, res) == v /\ h' = h};

finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

annot : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). hd_sel (h, inp) == v /\ [v = 1] /\ ilssel (h', inp) C= ilssel (h, inp) };  




