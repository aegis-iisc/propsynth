
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  

l1: [tree];
l2 :[tree];
ind : ref int;
I : int;
finalqf : State  {\(h : heap). sel (h, ind) == I } 
	[tree] 
	{\(h : heap), (v : [tree]), (h' : heap). offsideTreeList (I, v) = true /\ h' = h };
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  {\(h : heap). sel (h, ind) == I } 
	[tree] 
	{\(h : heap), (v : [tree]), (h' : heap). offsideTreeList (I, v) = true /\ h' = h };

   


