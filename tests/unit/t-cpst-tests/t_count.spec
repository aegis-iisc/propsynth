
formula g = \(h : heap),(y : pair). fst (y) == n; 
formula inv =  \(h:heap), (y : pair). snd (y) = o3 /\ len (o3) == fst (y) ;
o : [int];
o0 : [int];
o1 : [int];
o2 : [int];
ofinal : [int];
n : int;
o3 : [int];
f : y -> x -> {v : pair | \(v:pair ), (y: pair),(x:int).snd (v) = o2 /\ snd(y) = o1 /\ fst (v) == fst (y) + 1 /\ len (o2) == len (o1) + 1}; 
acc : {acc : pair | snd (acc) = o /\ elems (o) = {()} /\ fst(v) == 0 /\ len (o) == 0};

annotfold: State  {\(h : heap). snd (acc) = o /\ elems (o) = {()} /\ fst(acc) == 0 /\ len (o) == 0 } 
	pair 
	{\(h : heap), (v : pair), (h' : heap). snd (v) = ofinal /\ len (ofinal) == n};  




