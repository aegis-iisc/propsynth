

formula g = \(h : heap),(y : [pair]). not true; 
formula inv =  \(h:heap), (y : [pair]). wellformed (y) = true;

f : {y : [pair] | wellformed (y) = true} -> {x : pair | snd (x) = l /\ len (l) ==  fst (x)} 
		-> {v : [pair] | \(v: [pair]), (y: [pair]),(x:pair). wellformed (v) = true};

acc : {v : [pair]| wellformed (v) = true};

annotfold: State  {\(h : heap). wellformed (acc) = true} 
	[pair] 
	{\(h : heap), (v : [pair]), (h' : heap). wellformed (acc) = true };  


