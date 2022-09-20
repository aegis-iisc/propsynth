formula g = \(h : heap),(y : [tree]). not true; 

formula inv =  \(h:heap), (y : [tree]). sel (h, ind) = I /\ offsideTreeList (I, y) = true;
l : [int];
l1 : [int];
l2 : [int];
l' : [int];

f : {y : [tree] | offsideTreeList (I, y) = true} -> 
		{x : int | offsideTree (x) = true} -> 
		{v : [tree] | \(v:[tree]), (y: [tree]),(x:tree ). sel (h, ind) == I /\ offsideTreeList (I,v ) = true}; 
acc : {v : [tree]| sel (h, ind) == I /\ offsideTreec(I, v) = true };

t_stmts :  State  {\(h : heap). sel (h, ind) == I} 
		[tree] 
		{\(h : heap), (v : [tree]), (h' : heap). offsideTreeList (I, v) = true};


