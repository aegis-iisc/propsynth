x : tree;
y : tree;
z : tree;
p1 : tree;

t_case: State  {\(h : heap). sel (h, ind) == I} 
		tree 
		{\(h : heap), (v : tree), (h' : heap). indentedTree I v };


