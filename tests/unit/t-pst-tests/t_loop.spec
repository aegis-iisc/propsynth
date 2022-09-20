
formula guardloop = \(h : heap). [i = 1] /\ sel (h, cnt) > 0; 
formula invloop = \(h : heap). sel (h, cnt) == 0;

formula guard1 = \(h : heap). [i = 0] /\ sel (h, cnt) == 0;  
out : ref int;
cnt : ref int;
boundx : int; 
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h', cnt) == boundx /\ sel (h', out) == 0};  

steploop : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h', cnt) + 1 == sel (h, cnt)
								/\ sel (h', out) == sel (h, out) + 1};  
step1 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h' = h}; 

finalqf : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). sel (h, out) == v /\ sel (h', out) == sel (h, out) /\ sel (h', cnt) == sel (h, cnt) };

finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  
	{\(h : heap).true } 
		int 
	{\(h : heap), (v : int), (h' : heap). sel (h', out) == boundx };  



