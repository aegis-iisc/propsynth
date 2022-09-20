tbl : list;

mem : (s  : { v : string | true}) -> 
			State  {\(h : heap). true} 
			v : { v : bool | true} 
			{\(h : heap), (v : bool), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				([v=true] <=> (mem (tbl', s) = true))/\ 
				([v=false] <=> (mem (tbl', s) = false))};

fresh_str : State  {\(h : heap). true} 
			v : { v : string | true} 
			{\(h : heap), (v : string), (h' : heap). 
				len (v) == 3 /\
				sel (h', tbl) = tbl' /\ 
				mem (tbl', s) = false};


add : (s : {v : string | true}) ->  
			State  {\(h : heap). sel (h, tbl) = tbl /\ 
				(mem (tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				(mem (tbl', s) = true) /\ 
				len (tbl') == len (tbl) + len (s) /\ 
				size (tbl') == size (tbl) + 1};
				


remove 	: (s : {v : string | true}) ->  
			State  {\(h : heap). sel (h, tbl) = tbl /\ 
				(mem (tbl, s) = true)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				(mem (tbl', s) = false) /\ 
				len (tbl') == len (tbl) - len (s) /\ 
				size (tbl') == size (tbl) - 1};

take_head : State  {\(h : heap). sel (h, tbl) = tbl /\ size (tbl) > 0} 
				v : { v : string | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				sel (h, tbl) = tbl /\ 
				(mem (tbl', v) = false) /\ 
				len (tbl') == len (tbl) - len (v) /\ 
				size (tbl') == size (tbl) - 1};



average_len : State  {\(h : heap). sel (h, tbl) = tbl /\ size (tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				 not (min (tbl') > v) /\
				 not (v > max (tbl')) /\
				 sel (h', tbl) = sel (h, tbl)};


twice_average_len : 
			State  {\(h : heap). sel (h, tbl) = tbl /\ size (tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				not (min (tbl') > v)};



sort : State  {\(h : heap). true} 
				v : { v : unit | true} 
			 {\(h : heap), (v : unit), (h' : heap). 
				sel (h, tbl) = tbl /\ 
				 sorted (tbl)};



size : Pure  {\(h : heap). true} 
				v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				sel (h, tbl) = tbl /\ 
				 size (tbl) == v};



length : Pure  {\(h : heap). true} 
				v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				sel (h, tbl) = tbl /\ 
				 len (tbl) == v};




goal : ({s : string | true}) -> 
	State {\(h : heap). sel h tbl = tbl0}
			v : {v : float | true}
		  {\(h : heap), (v : float), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				not (min (tbl') > v) /\
				not (v > max (tbl')) /\
				
				size (tbl') = size (tbl) + 2 /\
				(mem (tbl', s) = true) /\
				
				((not (mem (tbl, s) = true)) 
					/\ len (tbl') == len (tbl) + len (s) + 3) \/ 
				((mem (tbl, s) = true) 
					/\ len (tbl') == len (tbl) + 6)
				};
