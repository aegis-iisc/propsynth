tbl :  list ref;
Tbl0 :  list;
Tbl' : list;
Tbl : list;



mem : (s  : { v : int | true}) -> 
			State  {\(h : heap). true} 
			v : { v : bool | true} 
			{\(h : heap), (v : bool), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				([v=true] <=> ( (Tbl', s) = true))/\ 
				([v=false] <=> (mem (Tbl', s) = false))};

fresh_str : State  {\(h : heap). true} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				len (v) == 3 /\
				ilssel (h', tbl) = Tbl' /\ 
				mem (Tbl', s) = false};


add : (s : {v : sint | true}) ->  
			State  {\(h : heap). sel (h, tbl) = Tbl /\ 
				(mem (tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				sel (h', tbl) = Tbl' /\ 
				(mem (Tbl', s) = true) /\ 
				len (Tbl') == len (Tbl) + len (s) /\ 
				size (Tbl') == size (Tbl) + 1};
				


remove 	: (s : {v : int  | true}) ->  
			State  {\(h : heap). sel (h, tbl) = Tbl /\ 
						(mem (Tbl, s) = true)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				sel (h', tbl) = Tbl' /\ 
				(mem (Tbl', s) = false) /\ 
				len (Tbl') == len (Tbl) - len (s) /\ 
				size (Tbl') == size (Tbl) - 1};

take_head : State  {\(h : heap). sel (h, tbl) = Tbl 
					/\ size (Tbl) > 0} 
				v : { v : int | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				sel (h', tbl) = Tbl' /\ 
				(mem (Tbl', v) = false) /\ 
				len (Tbl') == len (Tbl) - len (v) /\ 
				size (Tbl') == size (Tbl) - 1};



average_len : State  {\(h : heap). sel (h, tbl) = Tbl 
					/\ size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				sel (h', tbl) = Tbl' /\ 
				 not (min (Tbl') > v) /\
				 not (v > max (Tbl')) /\
				 sel (h', tbl) = sel (h, tbl)};


twice_average_len : 
			State  {\(h : heap). sel (h, tbl) = Tbl /\ size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				sel (h', tbl) = Tbl' /\ 
				not (min (Tbl') > v)};



sort : State  {\(h : heap). true} 
				v : { v : unit | true} 
			 {\(h : heap), (v : unit), (h' : heap). 
				sel (h, tbl) = Tbl /\ 
				 sorted (Tbl) = true};





goal : (s : {v : int | true}) -> 
	State {\(h : heap). sel (h, tbl) = Tbl0}
			v : {v : float | true}
		  {\(h : heap), (v : float), (h' : heap). 
				sel (h', tbl) = Tbl' /\ 
				not (min (Tbl') > v) /\
				not (v > max (Tbl')) /\
				
				size (Tbl') = size (Tbl) + 2 /\
				(mem (Tbl', s) = true) /\
				
				((not (mem (Tbl, s) = true)) 
					/\ len (Tbl') == len (Tbl) + len (s) + 3) \/ 
				((mem (Tbl, s) = true) 
					/\ len (Tbl') == len (Tbl) + 6)
				};
