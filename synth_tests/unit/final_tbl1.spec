
tbl : ref [string];
Tbl0 : [string];
Tbl' : [string];
Tbl :  [int];



mem : (s  : { v : int | true}) -> 
			State  {\(h : heap). true} 
			v : { v : bool | true} 
			{\(h : heap), (v : bool), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				([v=true] <=> ( mem(Tbl', s) = true))/\ 
				([v=false] <=> (mem (Tbl', s) = false))};

fresh_str : State  {\(h : heap). true} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				len (v) == 3 /\
				ilssel (h', tbl) = Tbl' /\ 
				mem (Tbl', s) = false};


add : (s : {v : sint | true}) ->  
			State  {\(h : heap).ilssel (h, tbl) = Tbl /\ 
				(mem (tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				(mem (Tbl', s) = true) /\ 
				len (Tbl') == len (Tbl) + len (s) /\ 
				size (Tbl') == size (Tbl) + 1};
				


remove 	: (s : {v : int  | true}) ->  
			State  {\(h : heap).ilssel (h, tbl) = Tbl /\ 
						(mem (Tbl, s) = true)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				(mem (Tbl', s) = false) /\ 
				len (Tbl') == len (Tbl) - len (s) /\ 
				size (Tbl') == size (Tbl) - 1};

head : State  {\(h : heap).ilssel (h, tbl) = Tbl 
					/\ size (Tbl) > 0} 
				v : { v : int | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				(mem (Tbl', v) = false) /\ 
				len (Tbl') == len (Tbl) - len (v) /\ 
				size (Tbl') == size (Tbl) - 1};



average_len : State  {\(h : heap).ilssel (h, tbl) = Tbl 
					/\ size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				 not (min (Tbl') > v) /\
				 not (v > max (Tbl')) /\
				ilssel (h', tbl) =ilssel (h, tbl)};


concat  : State  {\(h : heap).ilssel (h, tbl) = Tbl /\ 
				size (Tbl) > 0} 
				v : { v : string | true} 
			 {\(h : heap), (v : string), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				len (v) = len (Tbl')};



sort : State  {\(h : heap). true} 
				v : { v : unit | true} 
			 {\(h : heap), (v : unit), (h' : heap). 
				ilssel (h, tbl) = Tbl /\ 
				 sorted (Tbl) = true};





goal : (s : {v : string | true}) -> 
		(t : {v : tbl | true}) -> 
		State {\(h : heap). true}
			v : {v : float | true}
		  {\(h : heap), (v : float), (h' : heap). true};
