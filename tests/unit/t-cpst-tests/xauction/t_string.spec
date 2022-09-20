    
formula guardloop = \(h : heap).  ilssel (h, inp) = l0  /\ hd (l0) == i /\ 
			        ilssel (h, pat) = l1 /\ hd (l1) == j /\ 
				i == j;
				
formula inv1 = \(h : heap). (ilssel (h, out) = l2 /\ ilssel (h, pat) = l3) => elems (l2) C= elems (l3);

formula guardexit =  \(h : heap).    ilssel (h, pat) = l4 /\ hd (l4) == eps;   
			

l0 : [int];		
l1 :[int];
l2 : [int];
l3 : [int];
l4 : [int];
pat : ref  [int];
str : [int];
out : ref [int];
eps : int; 
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). 
			ilssel (h', pat) = str  
			/\ ilssel (h', inp) = ilssel (h, inp)};  

step1 : State {\(h : heap). true} unit {\(h:heap),(v:unit),(h':heap). 	
				ilssel (h, out) = l3 
				/\ ilssel (h', out) = l4 
				/\ len (l4) == (len(l3) + 1) /\ elems (l4) = {(i)} U elems (l3) };

step2 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

finalqf : State {\(h:heap). true} [int] {\(h : heap), (v: [int]), (h' : heap). v = ilssel (h', out)};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'};

annot : State  {\(h:heap). true} [int] {\(h : heap), (v: [int]), (h' : heap). elems (v) C= elems (str)};


