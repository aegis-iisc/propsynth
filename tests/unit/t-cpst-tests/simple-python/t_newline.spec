ind : int;
iinp : [intpair];
l0 : [int];		
l1 :[int];
l2 : [int];
l3 : [int];
l4 : [int];
pat : ref [int];
str :  [int];
out : [int];
start : int;
nil : int; 
emptytreelist : [tree];

formula guard =  \(h : heap). true;   
			
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). 
			pssel (h',iinp) = pssel (h, iinp) /\ start == sndint(i)};  

step1 : State {\(h : heap). true} unit {\(h:heap),(v:unit),(h':heap). 	
				pssel (h, iinp) = l3 
				/\ pssel (h', iinp) = l4 
				/\ elems (l4) C= elems (l3)};


finalqf : State {\(h:heap). true} tree {\(h : heap), (v: tree), (h' : heap). sel (h, ind) == I /\ offsideTree (I, v) = true};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'};


annot : State  {\(h : heap). sel (h, ind) == I} 
		tree 
		{\(h : heap), (v : tree), (h' : heap). offsideTree(I, v) = true };


