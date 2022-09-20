tr : triple;
max : {v : int | v == max (tr)};
width : {v : int | v == width (tr)};
height : {v : int | v == height (tr)};

formula g_cols = \(h : heap),(y : revpair). (revsnd (y) == width (tr)); 
formula inv_cols =  \(h:heap), (y : revpair). (revfst (y) = fsty /\ ilssel (h, inp) = l /\ ilssel (h0, inp) = l0) => 
					(len (fsty) == revsnd (y) /\ (len (l) + revsnd (y) == len (l0)));
l : [int];
l0 : [int];
fsty : [int];
fstv : [int];
lac : [int];
h0 : heap;
f : y -> x -> {v : revpair | \(v:revpair), (y: revpair),(x: triple). revsnd(v) == revsnd (y) + 1}; 
acc : { acc : revpair | revfst (acc) = lac /\ len (lac) == 0 /\  revsnd (acc) == 0};
annotfold : State {\(h : heap). h0 = h } revpair {\(h:heap),(v:revpair),(h':heap). revfst (v) = fstv /\ len (fstv) == width (tr)};



