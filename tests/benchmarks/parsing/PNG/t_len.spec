
formula guard1 = \(h : heap). hd_sel (h,inp) == i /\ ([i = 0] \/ [i = 1] \/ [i = 2] \/ [i = 3]); 
res : int;

init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h, res) == 0 /\ hd_sel (h, inp) == hd_sel (h', inp)};  

step1 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h', res) == i};  

finalqf : State  {\(h : heap). true} int {\(h : heap), (v : unit), (h' : heap). sel (h, res) == v};

finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

annot : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). hd_sel (h, inp) == v /\ ([v = 0] \/ [v = 1] \/ [v = 2] \/ [v = 3]) };  




