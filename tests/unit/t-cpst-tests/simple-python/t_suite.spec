nl : tree;
stmts: [tree];
ind : ref int;
I : int;
chs : [tree];
t_suite : State  {\(h : heap). sel (h, ind) == I} 
		tree 
		{\(h : heap), (v : tree), (h' : heap). indent (v) > I /\ children (v) = chs /\ offsideTreeList (I, chs) = true};


