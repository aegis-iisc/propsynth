init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  

br : int;
bg : int;
bb : int;
finalqf : State  {\(h : heap). true} triple {\(h : heap), (v : triple), (h' : heap). pr1 (v) == br  /\ pr2(v) == bg /\ pr3 (v) == bb };
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  {\(h : heap). true} triple {\(h : heap), (v : triple), (h' : heap). pr1 (v) == br /\ pr2(v) == bg /\ pr3 (v) == bb };
   


