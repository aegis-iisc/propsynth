 
l0 : [int];		
l1 :[int];
l2 : [int];
l3 : [int];
l4 : [int];
cnt : int ;
content : [int];
boundx : int;
lc : [int];
con : [int]; 

init : State {\(h : heap). true} unit 
		{\(h : heap), (v : unit), (h' : heap). 
			ilssel (h', content) = lc /\ len (lc) == 0  
			/\ ilssel (h', inp) = ilssel (h, inp)  
			/\ sel (h', cnt) == boundx};  

  
formula guard1 = \(h : heap).  ilssel (h, inp) = l0  /\ hd (l0) = i /\ 
				(sel (h, cnt) > 0) /\ 
				([i = 0] \/ [i = 1] \/ [i = 2] \/ [i = 3]);
				
formula inv1 = \(h : heap). ilssel (h, content) = l1 /\ len (l1) + sel (h, cnt) == boundx;

formula guard2 =  \(h : heap).   ilssel (h, inp) = l2  /\ hd (l2) = i  /\ 
				(sel (h, cnt) == 0) /\
				([i = 0] \/ [i = 1] \/ [i = 2] \/ [i = 3]);
step1 : State {\(h : heap). true} 
		unit 
		{\(h:heap),(v:unit),(h':heap). 
				ilssel (h, content) = l3 
				/\ ilssel (h', content) = l4 
				/\ len (l4) == (len(l3) + 1) /\ 
				sel (h', cnt) == (sel (h, cnt) -- 1)};

step2 : State  {\(h : heap). true} 
		unit 
		{\(h : heap), (v : unit), (h' : heap). h = h'}; 

finalqf : State {\(h:heap). true} 
		pair 
		{\(h : heap), (v: pair), (h' : heap). fst (v) == boundx /\ snd (v) = ilssel (h, content)};
finalother : State  {\(h : heap). true} 
		unit 
		{\(h : heap), (v : unit), (h' : heap). h = h'};

annot : State  {\(h:heap). true} pair {\(h : heap), (v: pair), (h' : heap). fst (v) == boundx /\  
				(snd (v) = con) =>  (len (con) == fst (v))};


