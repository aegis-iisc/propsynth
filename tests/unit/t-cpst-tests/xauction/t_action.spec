init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  



sname : [char];
rating : int;
finalqf : State  {\(h : heap). true} 
	sellerinfo 
	{\(h : heap), (v : sellerinfo), (h' : heap). name (v) = sname /\ rating (v) = rating};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : : State  {\(h : heap). true} 
	sellerinfo 
	{\(h : heap), (v : tree), (h' : heap). name (v) = sname /\ rating (v) = rating};

   


