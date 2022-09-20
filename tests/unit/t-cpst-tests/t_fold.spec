l : [int];
l1 : [int];
l2 : [int];
l' : [int];

formula g = \(h : heap),(y : [int]). not true; 
formula inv =  \(h:heap), (y : [int]). elems (y) C= elems (l1);
f : y -> x -> {v : [int] | \(v:[int]), (y: [int]),(x:int ). elems (v) = {(x)} U elems (y)}; 
acc : {acc : [int]| elems (acc) = {()} };

annotfold: State  {\(h : heap). elems (acc) = {()} /\ ilssel (h, inp) = l1 /\ elems (acc) C= elems (l1)} 
	[int] 
	{\(h : heap), (v : [int]), (h' : heap). elems (v) C= elems (l1) };  




