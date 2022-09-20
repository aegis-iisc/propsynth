tbl : ref [int];
Tbl0 : [int];
Tbl' : [int];
Tbl :  [int];
Tbl1' : [int];
Tbl1 :  [int];
num : ref int;








average_len : State  {\(h : heap).
					\(Tbl : [int]).
					not (sel (h, num) > 1) /\
					(Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0)
					} 
				v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				 sel (h', num) == sel (h, num) /\
				 ilssel (h', tbl) = Tbl'
				 /\
			 	 (not (min (Tbl') > v) /\
				 not (v > max (Tbl')) /\
				 ilssel (h', tbl) =ilssel (h, tbl)
				)};


fresh_str : State 
			{\(h : heap). not (sel (h, num) > 1)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				len (v) == 3 /\
				
				(ilssel (h', tbl) = Tbl' =>  
				mem (Tbl', v) = false)};


add : (s : {v : int | true}) ->  
			State  {\(h : heap).
				\(Tbl : [int]). 
				not (sel (h, num) > 1) /\
					
				ilssel (h, tbl) = Tbl /\  
				(mem (Tbl, s) = false)} 
				v : { v : unit | true} 
			
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) /\
				
				ilssel (h', tbl) = Tbl'
				/\ 
				(
				(mem (Tbl', s) = true) /\ 
				len (Tbl') == len (Tbl) + len (s) /\ 
				size (Tbl') == size (Tbl) + 1 
				)};


goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
				\(Tbl : [int]). 
				sel (h, num) == 0 /\
				ilssel (h, tbl) = Tbl /\
				(mem (Tbl, s) = false)}
				v : {v : int | true}
		  	{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]). 
				not (sel (h, num) > 1) /\
				ilssel (h', tbl) = Tbl'
					
				/\  
				(
					not (min (Tbl') > v) /\
					not (v > max (Tbl')) /\
					size (Tbl') == size (Tbl) + 2 /\
					mem (Tbl', s) = true /\
					len (Tbl') == len (Tbl) + len (s) + 3 )
			};


