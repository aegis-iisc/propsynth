relation notin s 
	[] = true 
	x::xs = not (streq (s, x) /\ notin (s, xs)

s: [char];
annot :  State  {\(h : heap). true} 
	 [bidderinfo]
	{\(h : heap), (v : [bidderinfo]), (h' : heap). notin (s, v)};
   


