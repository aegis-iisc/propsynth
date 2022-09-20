tbl : ref [int];
Tbl0 : [int];
Tbl' : [int];
Tbl :  [int];
Tbl1' : [int];
Tbl1 :  [int];




average_len : State  {\(h : heap).
					\(Tbl : [int]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				 ilssel (h', tbl) = Tbl'
				 /\
			 	 (not (min (Tbl') > v) /\
				 not (v > max (Tbl')) /\
				 ilssel (h', tbl) =ilssel (h, tbl)
				)};


add : (s : {v : int | true}) ->  
			State  {\(h : heap).
				exists (Tbl : [int]). 
				ilssel (h, tbl) = Tbl /\  
				(mem (Tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [int]).
				ilssel (h', tbl) = Tbl'
				/\ 
				(
				(mem (Tbl', s) = true) /\ 
				len (Tbl') == len (Tbl) + len (s) /\ 
				size (Tbl') == size (Tbl) + 1 
				)};


goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
			exists (Tbl : [int]). 
				ilssel (h, tbl) = Tbl 
				/\ (mem (Tbl, s) = false)}
				v : {v : int | true}
		  	{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]). 
				ilssel (h', tbl) = Tbl'
					
				/\  
				(
					not (min (Tbl') > v) /\
					not (v > max (Tbl')) /\
					size (Tbl') == size (Tbl) + 1 /\
					mem (Tbl', s) = true /\
					len (Tbl') == len (Tbl) + len (s) )
			};
