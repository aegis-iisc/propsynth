
res : int;
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h, res) == 0 /\ hd_sel (h, inp) == hd_sel (h', inp)};  

finalqf : State  {\(h : heap). true} int {\(h : heap), (v : unit), (h' : heap). sel (h, res) == v};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

annot : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). v = 0};  




