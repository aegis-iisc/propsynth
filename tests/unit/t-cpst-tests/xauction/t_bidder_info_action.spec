init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  


s: [char];
bname : [char];
rating : int;
finalqf : State  {\(h : heap). true} 
	 bidderinfo
	{\(h : heap), (v : bidderinfo), (h' : heap). name (v) = bname /\ rating (v) = rating /\ not (streq (s, bname)};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot :  State  {\(h : heap). true} 
	 bidderinfo
	{\(h : heap), (v : bidderinfo), (h' : heap). name (v) = bname /\ rating (v) = rating /\ not (streq (s, bname)};
   


