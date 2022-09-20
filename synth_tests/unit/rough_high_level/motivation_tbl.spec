tbl : list;

mem : ({s : string | true}) -> 
			State  {\(h : heap). true} 
			v : { v : bool | true} 
			{\(h : heap), (v : bool), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				([v==true] <=> mem tbl' s) /\ 
				[v==false] <=> not (mem tbl' s)};

fresh_str : State  {\(h : heap). true} 
			v : { v : string | true} 
			{\(h : heap), (v : string), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				not (mem tbl' s)};


add : ({s : string | true}) ->  
			State  {\(h : heap). sel (h, tbl) = tbl /\ not (mem tbl s)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				(mem tbl' s) /\ 
				len (tbl') == len (tbl) + len (s) /\ 
				size (tbl') == size (tbl) + 1};

remove 	: ({s : string | true}) ->  
			State  {\(h : heap). sel (h, tbl) = tbl /\ (mem tbl s)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				not (mem tbl' s) /\ 
				len (tbl') == len (tbl) - len (s) /\ 
				size (tbl') == size (tbl) - 1};

drop_head : State  {\(h : heap). sel (h, tbl) = tbl /\ size (tbl) > 0} 
				v : { v : string | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				sel (h, tbl) = tbl /\ 
				not (mem tbl' v) /\ 
				len (tbl') == len (tbl) - len (v) /\ 
				size (tbl') == size (tbl) - 1};



average_len : State  {\(h : heap). sel (h, tbl) = tbl /\ size (tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				 not (min (tbl') > v) /\
				 not (v > max (tbl')) /\
				 sel (h', tbl) = sel (h, tbl)};



sort : State  {\(h : heap). true} 
				v : { v : unit | true} 
			 {\(h : heap), (v : unit), (h' : heap). 
				sel (h, tbl) = tbl /\ 
				 sorted (tbl)};



size : State  {\(h : heap). true} 
				v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				sel (h, tbl) = tbl /\ 
				 size (tbl) == v};



length : State  {\(h : heap). true} 
				v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				sel (h, tbl) = tbl /\ 
				 len (tbl) == v};


goal : ({s : string | true}) -> State {\(h : heap). true}
			v : {v : float | true}
			 {\(h : heap), (v : int), (h' : heap). 
				sel (h', tbl) = tbl' /\ 
				not (min (tbl') > v) /\
				not (v > max (tbl')) /\
				size (tbl') == size (tbl) + 1 /\
				not mem (tbl, s) =>  len (tbl') == len (tbl) + len (s) /\ 
				mem (tbl, s) => len (tbl') > len (tbl)
				sorted (tbl')};
