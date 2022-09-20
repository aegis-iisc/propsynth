tbl : ref [int];
Tbl0 : [int];
Tbl' : [int];
Tbl :  [int];
Tbl1 : [int];


average_len : State  {\(h : heap).
				 let Tbl = ilssel (h, tbl in) in 
				 size (Tbl) > 0
				 } 
				v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				 let 
				 ilssel (h', tbl) =ilssel (h, tbl) /\
				 not (min (ilssel (h', tbl)) > v) /\
				 not (v > max (ilssel (h', tbl))) /\
				 };




add : (s : {v : int | true}) ->  
			State  {\(h : heap).
				(mem (ilssel (h, tbl), s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				
				Tbl' = ilssel (h', tbl) /\
				(mem (ilssel (h', tbl), s) = true) /\ 
				len (ilssel (h', tbl)) == len (ilssel (h, tbl)) + len (s) /\ 
				size (ilssel (h', tbl)) == size (ilssel (h, tbl)) + 1
				};


goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
			(mem (ilssel (h, tbl), s) = false)}
				v : {v : int | true}
		  	{\(h : heap), (v : int), (h' : heap). 
				
					not (min (ilssel (h', tbl)) > v) /\
					not (v > max (ilssel (h', tbl))) /\
					size (ilssel (h', tbl)) == size (ilssel (h, tbl)) + 1 /\
					mem (ilssel (h', tbl), s) = true /\
					len (ilssel (h', tbl)) == len (ilssel (h, tbl)) + len (s) 
			};
