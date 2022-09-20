init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  

I : int;
ind : int;
x : tree;
exp : tree;
of : tree;
finalqf : State  {\(h : heap). sel (h, ind) == I } 
	[tree] 
	{\(h : heap), (v : [tree]), (h' : heap). offsideTreeList (I, v) = true};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot :  State  {\(h : heap). sel (h, ind) == I } 
	[tree] 
	{\(h : heap), (v : [tree]), (h' : heap). offsideTreeList (I, v) = true};

   


