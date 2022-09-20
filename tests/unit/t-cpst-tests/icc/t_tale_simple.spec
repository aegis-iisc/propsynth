o1 : [intpair];
o : [intpair]; 
cnt : ref int;
out : ref [intpair];
bn : int;
l0 : [intpair];		
le :[intpair];
inpp : ref [intpair];
eps : int;
lin : [intpair];
lout : [intpair];
ip : intpair;
o0: [intpair];
oinit : [intpair];

formula guardloop = \(h : heap).  plssel (h, inpp) = l0  /\ phd (l0) = {(ip)} /\  not (sel (h, cnt) == bn);
formula guardexit = \(h : heap).  plssel (h, inpp) = le  /\ phd (le) = {(ip)} /\ sel (h, cnt) == bn;

formula inv = \(h : heap). plssel (h, out) = o /\ pelems (o) C= pelems (lin);
 

init : State {\(h : heap). true} 
			unit 
			{\(h : heap), (v : unit), (h' : heap). 
			sel (h', cnt) == 0 
			/\ plssel (h', out) = o
			/\ pelems (o) C= pelems (lin) 
			/\ plssel (h', inpp) = lin  
			/\ plssel (h, inpp) = lin };  


steploop : State {\(h : heap). true} unit {\(h:heap),(v:unit),(h':heap). 
				plssel (h, out) = o0 
				/\ plssel (h', out)  = o1 
				/\ pelems (o1) = {(ip)} U pelems (o0)};

stepexit :  State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'};

finalqf : State {\(h:heap). true} unit {\(h : heap), (v: unit), (h' : heap). plssel (h', inpp) = plssel (h, out)};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'};

annot :  State {\(h:heap). true} unit {\(h : heap), (v: unit), (h' : heap). (plssel (h, inpp) = lin /\ plssel (h', inpp)  = lout) => (pelems (lout) C= pelems (lin))};


