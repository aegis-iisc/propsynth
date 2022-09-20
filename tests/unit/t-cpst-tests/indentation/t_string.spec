iinp : [intpair]
l0 : [int];		
l1 :[int];
l2 : [int];
l3 : [int];
l4 : [int];
pat : [int];
str : [int];
out : [int];
start : int;
   
formula guard1 = \(h : heap).   pssel (h, iinp) = l0  /\ hd (l0) == i /\ 
			        ilssel (h, pat) = l1 /\ hd (l1) == j /\ 
				fstint(i) == j /\  sndint(i) >  sel (h, ind);
				
formula inv1 = \(h : heap). (ilssel (h, out) = l2 /\ ilssel (h, pat) = l3) => elems (l2) C= elems (l3);

formula guard2 =  \(h : heap).    ilssel (h, pat) = l4 /\ hd (l4) == nil;   
			
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). 
			ilssel (h', pat) = str  
			/\ ilssel (h', inp) = ilssel (h, inp) /\ start == sndint(i)};  

step1 : State {\(h : heap). true} unit {\(h:heap),(v:unit),(h':heap). 	
				ilssel (h, out) = l3 
				/\ ilssel (h', out) = l4 
				/\ elems (l4) = {(j)} U elems (l3) };

step2 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

finalqf : State {\(h:heap). true} tree {\(h : heap), (v: tree), (h' : heap). node (v) = ilssel (h', out) /\ indent (v) == start /\ children (v) = nil};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'};

annot : State  {\(h:heap). true} tree {\(h : heap), (v: tree), (h' : heap).  node (v) = ilssel (h', out) /\ indent (v) == start /\ children (v) = nil};


