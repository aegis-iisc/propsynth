init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  

deaths : int;
min : int;
max : int;
finalqf : State  {\(h : heap). true} triple {\(h : heap), (v : triple), (h' : heap). pr1 (v) == deaths  /\ pr2(v) == min /\ pr3 (v) == max };
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  {\(h : heap). true} triple {\(h : heap), (v : triple), (h' : heap). pr1 (v) == deaths /\ pr2(v) == min /\ pr3 (v) == max };
   


