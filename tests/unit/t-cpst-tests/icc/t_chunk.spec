sz : int;
s : [intpair];
inpp : ref [intpair];
dc1 : unit;
dc2 : unit;
dc3: unit;
annot : State  {\(h : heap). true} 
		unit 
		{\(h : heap), (v : unit), (h' : heap). plssel (h', inpp) = l1 
							/\ plssel (h, inpp) = l0 
							/\ plen (l1) = plen (l0) -- sz};


