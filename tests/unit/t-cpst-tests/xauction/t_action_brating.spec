init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  



rating : int;
finalqf : State  {\(h : heap). true} 
	int 
	{\(h : heap), (v : int), (h' : heap). v = rating };
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  {\(h : heap). true} 
	int 
	{\(h : heap), (v : int), (h' : heap). v = rating };
   


