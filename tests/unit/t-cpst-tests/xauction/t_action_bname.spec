init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  



bname : [int];
finalqf : State  {\(h : heap). true} 
	[int] 
	{\(h : heap), (v : [int]), (h' : heap). v = bname };
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  {\(h : heap). true} 
	[int]
	{\(h : heap), (v : [int]), (h' : heap). v = bname};

   


