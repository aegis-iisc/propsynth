tbl : ref [int];
Tbl0 : [int];
Tbl' : [int];
Tbl :  [int];
Tbl1' : [int];
Tbl1 :  [int];
num : ref int;



average_len : State  {\(h : heap).
					\(Tbl : [int]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				\(Tbl' : [int]).
				 ilssel (h', tbl) = Tbl'/\
			 	 ilssel (h', tbl) = ilssel (h, tbl)
				};



add : (s : {v : int | true}) ->  
			State  {\(h : heap).
				\(Tbl : [int]). 
				ilssel (h, tbl) = Tbl /\  
				(mem (Tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [int]).
				ilssel (h', tbl) = Tbl'
				/\ 
				(
				(mem (Tbl', s) = true) /\ 
				size (Tbl') == size (Tbl) + 1 
				)};



goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
			 \(Tbl : [int]). 
				mem (Tbl, s) = false /\
				sel (h, num) == 0}
				v : {v : float | true}
		  		{\(h : heap), (v : float), (h' : heap). 
				\(Tbl' : [int]). 
				ilssel (h', tbl) = Tbl' /\ 
				size (Tbl') == size (Tbl) + 1 /\
				 mem (Tbl', s) = true 
				};
