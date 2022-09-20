l0 : [int];
l : [int];
lin : [int];
out : ref [int];
l3 : [int];
l4 : [int];
l5 : [int];
l6 : [int];
lout : [int];
outexit : [int];
identifiers : ref [intlist];
types : ref [intlist];
I0 : [intlist];
formula guardloop = \(h : heap).  ilssel (h, inp) = l0  /\ hd (l0) == i /\  
				  ([i=48] \/ [i=49] \/ [i=50]); 
				
formula inv1 = \(h : heap). ilssel (h, inp) = l /\ elems (l) C= elems (lin);

formula guardexit =  \(h : heap). ilssel (h, inp) = l0  /\ hd (l0) == i /\  
				 (not ([i=48] \/ [i=49] \/ [i=50])) 
				 /\ ilssel (h, out) = outexit 
				 /\ Ilssel (h, identifiers) = I0 
				 /\ not (contains (I0, outexit) = true);   
			
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). 
			ilssel (h, inp) = lin   
			/\ ilssel (h', inp) = ilssel (h, inp) };  

steploop : State {\(h : heap). true} unit {\(h:heap),(v:unit),(h':heap). 	
				ilssel (h, inp) = l3 
				/\ ilssel (h', inp) = l4 
				/\ elems (l4) C= elems (l3)
				/\ ilssel (h, out) = l5 /\
				ilssel (h', out) = l6 /\
				elems (l6) = {(i)} U elems (l5)};

step2 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

finalqf : State {\(h:heap). true} [int] {\(h : heap), (v: [int]), (h' : heap). v = ilssel (h', out) 
							/\ ilssel (h', inp) = l1 
							/\ ilssel (h, inp) = l0 
							/\ elems (l1) C= elems (l0) 
							/\ Ilssel (h, types) = Tin
							/\ Ilssel (h', types) = Tout /\
							Ielems (Tout) = Ielems (Tin) U {(v)}};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'};


annot : State  {\(h : heap).  Ilssel (h, identifiers) = I } 
		[int] 
		{\(h : heap), (v : [int]), (h' : heap). ilssel (h', inp) = l1 
							/\ ilssel (h, inp) = l0 
							/\ elems (l1) C= elems (l0)
							/\ not (contains (I, v) = true)
							/\ Ilssel (h, types) = Tin
							/\ Ilssel (h', types) = Tout /\
							Ielems (Tout) = Ielems (Tin) U {(v)}};


