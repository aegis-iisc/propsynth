tbl : ref [int];


average_len : State  {\(h : heap).
				 let (Tbl ilssel (h, tbl)) in 
				 size (Tbl) > 0
				 } 
				v : { v : int | true} 
			 {\(h : heap), (v : int), (h' : heap). 
				 let Tbl' = ilssel (h', tbl) 
				 	/\ Tbl = ilssel (h, tbl) in   
				 in  
				 Tbl' = Tbl /\
				 not (min (ilssel (h', tbl)) > v) /\
				 not (v > max (ilssel (h', tbl))) /\
				 };

