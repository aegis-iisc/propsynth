tbl : ref [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;


mem : (s  : { v : int | true}) ->  { v : bool | \(h : heap), (v : bool), (h' : heap). 
				\(Tbl' : [int]), (Tbl: [int]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				Tbl' = Tbl /\
				([v=true] <=> ( mem(Tbl', s) = true))/\ 
				([v=false] <=> (mem (Tbl', s) = false))
				};


fresh_str : State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				ilssel (h', tbl) = Tbl' /\  
				ilssel (h', tbl) = ilssel (h, tbl) /\
				mem (Tbl', v) = false};



remove 	: (s : {v : int  | true}) ->  (t : {v : tbl | true}) -> 

			State  {\(h : heap).sel (h, tbl) = Tbl /\ 
						(mem (Tbl, s) = true)} 
				v : { v : tbl | true} 
			
			{\(h : heap), (v : unit), (h' : heap). 
				sel (h', tbl) = Tbl' /\ 
				(mem (Tbl', s) = false) /\ 
				len (Tbl') == len (Tbl) - len (s) /\ 
				size (Tbl') == size (Tbl) - 1};




average_len : State  {\(h : heap).
					\(Tbl : [int]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				ilssel (h', tbl) = 	ilssel (h, tbl) 
				/\ 
				sel (h', num) == sel (h, num)
				};



add : (s : {v : int | true}) ->  
			State  {\(h : heap).
				\(Tbl : [int]). 
				ilssel (h, tbl) = Tbl =>  
				(mem (Tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				mem (Tbl', s) = true /\
				size (Tbl') == size (Tbl) + 1 /\
				sel (h', num) == sel (h, num) 
				};


goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
			 \(Tbl : [int]). 
				sel (h, num) == 0 /\
				ilssel (h, tbl) = Tbl /\
				not  (0 > size (Tbl)) }
				v : {v : float | true}
		  	{\(h : heap), (v : float), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				(ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl')   
				=> 
				(mem (Tbl', s) = true /\
				size (Tbl') == size (Tbl) + 1) 
				
			};