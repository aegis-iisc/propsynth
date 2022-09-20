tbl : ref [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;



fresh_str : State 
			{\(h : heap). not (sel (h, num) > 0)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				ilssel (h', tbl) = Tbl' /\  
				ilssel (h', tbl) = ilssel (h, tbl) /\
				mem (Tbl', v) = false};


goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
			 \(Tbl : [int]). 
				sel (h, num) == 0 /\
				ilssel (h, tbl) = Tbl /\
				not  (0 > size (Tbl)) /\
				(mem (Tbl, s) = true)}
				v : {v : int | true}
		  	{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				(ilssel (h, tbl) = Tbl /\   
				ilssel (h', tbl) = Tbl')   
				=> 
				( size (Tbl') == size (Tbl) /\
				mem (Tbl', v) = false)					  
				
			};
