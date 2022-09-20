res : int;
init : State {\(h : heap). true} 
	unit 
	{\(h : heap), (v : unit), (h' : heap). sel (h', res) == 0};  

finalqf : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). 
	v == sel (h, res) /\ h' = h};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

trans_init : 
	State  
		{\(h : heap). true} 
		int 
		{\(h : heap), (v : int), (h' : heap). sel (h', res) == v /\ ( [v = 0]) };  




