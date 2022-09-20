formula guard1 = \(h : heap). hd_sel (h,inp) == i /\ 
				(sel (h, cnt) > boundx) /\ 
				([i = 0] \/ [i = 1] \/ [i = 2] \/ [i = 3]);
				
formula inv1 = \(h : heap). sel (h, content) == l2 /\ len (l2) == sel (h, cnt);
formula guard2 =  \(h : heap). hd_sel (h,inp) == i /\ 
				(sel (h, cnt) == boundx);
			
cnt : int ;
content : ref [int];
boundx : int;
init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). sel (h', content) == local /\ len (local) == 0 /\ hd_sel (h, inp) == hd_sel (h', inp) /\ sel (h', cnt) == 0};  
step1 : State {\(h : heap). true} unit {\(h:heap),(v:unit),(h':heap). sel (h, content) == l0 /\ sel (h', content) == l1 /\ len (l1) = len(l0) + 1 /\ 
				sel (h', cnt) == sel (h, cnt) + 1 };
step2 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 

finalqf : State {\(h:heap). true} pair {\(h : heap), (v: pair), (h' : heap). fst (p) == boundx /\ snd (p) == sel (h, content) };
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'};

annot : StExc  {\(h:heap). true} pair {\(h : heap), (v: pair), (h' : heap). fst (p) == boundx /\ snd (p) == sel (h, content) };


