formula guardtrue = \(h : heap).  ilssel (h, inp) = l0  /\ hd (l0) == i /\ 
				 ([i = 0] \/ [i = 1] \/ [i = 2] \/ [i = 3]);
				

out : ref int;
l0 : [int];		
l1 :[int];

init : State {\(h : heap). true} 
			unit 
			{\(h : heap), (v : unit), (h' : heap). 
			sel (h', out) == 0   /\ ilssel (h', inp) = ilssel (h, inp) };  


step1 : State {\(h : heap). true} unit {\(h:heap),(v:unit),(h':heap). 
				sel (h', out)  == i  };

finalqf : State {\(h:heap). true} int {\(h : heap), (v: int), (h' : heap). v == sel (h, out)};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'};

annot : State  {\(h:heap). true} int {\(h : heap), (v: int), (h' : heap). ([v = 0] \/ [v = 1] \/ [v = 2] \/ [v = 3]) };


