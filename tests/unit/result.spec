boundx : int; 
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h' = h};  
finalqf : State {\(h:heap). true} int {\(h : heap), (v: pair), (h' : heap). v = boundx};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'};

annot : StExc  {\(h:heap). true} int {\(h : heap), (v: int), (h' : heap). v = boundx};


