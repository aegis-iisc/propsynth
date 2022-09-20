x : tree;
exp : tree;
of : tree;
children0 : [tree];
alts : [tree];
children : [tree];
formula g = \(h : heap),(y : [tree]). not true; 

formula inv =  \(h:heap), (y : [tree]). sel (h, ind) = I /\ offsideTreeList (I, y) = true;
l : [int];
l1 : [int];
l2 : [int];
l' : [int];

f : {y : [tree] | offsideTreeList (I, y) = true} -> 
		{x : tree | offsideTree (x) = true} -> 
		{v : [tree] | \(v:[tree]), (y: [tree]),(x:tree ). offsideTreeList (I,v ) = true}; 
acc : {v : [tree]| sel (h, ind) == I /\ offsideTreec(I, v) = true };

t_alts :  State  {\(h : heap). sel (h, ind) == I} 
		[tree] 
		{\(h : heap), (v : [tree]), (h' : heap). offdiseTreeList (I, v) = true};



t_case: State  {\(h : heap). sel (h, ind) == I} 
		tree 
		{\(h : heap), (v : tree), (h' : heap). indent (v) > I /\ children (v) = chs /\ offsideTreeList (I, chs) = true};


