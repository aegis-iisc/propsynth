tbl : ref [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;



fresh_str : State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				ilssel (h', tbl) = Tbl' /\  
				ilssel (h', tbl) = ilssel (h, tbl) /\
				mem (Tbl', v) = false};



remove 	: (s : {v : int  | true}) -> 

			State  {\(h : heap).
					\(Tbl : [int]).
					ilssel (h, tbl) = Tbl => 
					(mem (Tbl, s) = true /\
					size (Tbl) > 0) } 
				      v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [int]), (Tbl: [int]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				(mem (Tbl', s) = false) /\ 
				size (Tbl') == size (Tbl) -- 1};




average_len : State  {\(h : heap).
					\(Tbl : [int]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				ilssel (h', tbl) = 	ilssel (h, tbl) /\ 
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
				mem (Tbl, s) = true  /\
				size (Tbl) > 0}
				v : {v : float | true}
		  	{\(h : heap), (v : float), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				(ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl')   
				=> 
				(mem (Tbl', s) = false /\
				not (size (Tbl') > size (Tbl))) 
				
			};


(*
\s .
apply average_len  ( 
 	 >>= \lambda locbound12 . 
 	 apply average_len  ( 
 	 >>= \lambda locbound43 . 
 	 apply remove  (, s ) 
 	 >>= \lambda locbound113 . 
 	 return locbound43 


*)			