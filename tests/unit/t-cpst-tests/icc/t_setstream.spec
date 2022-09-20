inpp : ref [intpair];
inpvalue : [intpair];
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  

finalqf : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). plssel (h', inpp) = inpvalue};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

annot : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap).plssel (h', inpp) = inpvalue};  


