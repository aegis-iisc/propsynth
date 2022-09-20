init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  



sname : [int];
rating : int;
finalqf : State  {\(h : heap). true} 
	pair 
	{\(h : heap), (v : pair), (h' : heap). snd (v) = sname /\  fst (v) == rating};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  {\(h : heap). true} 
	pair 
	{\(h : heap), (v : pair), (h' : heap). snd (v) = sname /\ fst (v) == rating};

   


