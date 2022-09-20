p : tree;
ar : tree;
t_alt : State  {\(h : heap). sel (h, ind) == I} 
		tree 
		{\(h : heap), (v : tree), (h' : heap). indent (v) > I /\ children (v) = chs /\ offsideTreeList (I, chs) = true};


