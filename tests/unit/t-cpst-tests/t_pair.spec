init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  

zero : int;
one : int;
finalqf : State  {\(h : heap). true} intpair {\(h : heap), (v : intpair), (h' : heap). fstint (v) == zero  /\ sndint (v) == one};
finalother : State  {\(h : heap). true} intpair {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  {\(h : heap). true} intpair {\(h : heap), (v : intpair), (h' : heap). fstint (v) == zero  /\ sndint (v) == one };
   


