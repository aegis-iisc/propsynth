tbl : ref [int];
Tbl0 : [int];
Tbl' : [int];
Tbl :  [int];




fresh_str : State  {\(h : heap). true} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				len (v) == 3 /\
				ilssel (h', tbl) = Tbl' =>  
				mem (Tbl', s) = false};


average_len : State  {\(h : heap).ilssel (h, tbl) = Tbl 
					/\ size (Tbl) > 0} 
				v : { v : int | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				(ilssel (h', tbl) = Tbl'
					/\ ilssel (h, tbl) = Tbl)  
				=> 
			 	 (not (min (Tbl') > v) /\
				 not (v > max (Tbl')) /\
				 ilssel (h', tbl) =ilssel (h, tbl)
				)};




add : (s : {v : int | true}) ->  
			State  {\(h : heap).
				(ilssel (h, tbl) = Tbl =>  
				(mem (Tbl, s) = false))} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				
				(ilssel (h', tbl) = Tbl'
					/\ ilssel (h, tbl) = Tbl)  
				=> 
				(
				(mem (Tbl', s) = true) /\ 
				len (Tbl') == len (Tbl) + len (s) /\ 
				size (Tbl') == size (Tbl) + 1
				)};


goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
			(ilssel (h, tbl) = Tbl  => (mem (Tbl, s) = false))}
				v : {v : int | true}
		  	{\(h : heap), (v : int), (h' : heap). 
				(ilssel (h', tbl) = Tbl'
					/\ ilssel (h, tbl) = Tbl)  
				=> 
				(
					not (min (Tbl') > v) /\
					not (v > max (Tbl')) /\
					size (Tbl') == size (Tbl) + 2 /\
					mem (Tbl', s) = true /\
					len (Tbl') == len (Tbl) + len (s) + 3 )
			};
