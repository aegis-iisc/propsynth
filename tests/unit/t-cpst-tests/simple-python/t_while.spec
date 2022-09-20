whileterm : tree;
test : tree;
colon : tree;
children0 : [tree];
suite : [tree];
children : [tree];

t_while : State  {\(h : heap). sel (h, ind) == I} 
		tree 
		{\(h : heap), (v : tree), (h' : heap). indent (v) > I /\ children (v) = chs /\ offsideTreeList (I, chs) = true};


