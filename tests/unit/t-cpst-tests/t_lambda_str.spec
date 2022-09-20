
boundx : string;

init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap).  h = h'};  

finalqf : State  {\(h : heap). true} string {\(h : heap), (v : string), (h' : heap). [v = boundx]};

finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

annot : State  {\(h : heap). true} 
	string 
	{\(h : heap), (v : string), (h' : heap). [v = boundx]  };  




