tbl : ref [char];
Tbl' : [char];
Tbl :  [char];
num : ref int;


createPair : (p1 : {v : float | true}) -> (p2 : {v : int | true}) -> 
											{v : pair | fst (v) = p1 /\
												snd (v) = p2}; 

size : State 
			{\(h : heap). true} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [char]),(Tbl : [char]).
				clsel (h, tbl) = Tbl /\  
				clsel (h', tbl) = Tbl' /\  
				v == size (Tbl) /\
				clsel (h', tbl) = clsel (h, tbl)};


fresh_str : State 
			{\(h : heap). not (sel (h, num) > 1)} 
			v : { v : char | true} 
			{\(h : heap), (v : char), (h' : heap). 
				\(Tbl' : [char]).
				sel (h', num) == sel (h, num) + 1 /\
				clsel (h', tbl) = Tbl' /\  
				clsel (h', tbl) = clsel (h, tbl) /\
				cmem (Tbl', v) = false};






average_len : State  {\(h : heap).
					\(Tbl : [char]).
					Tbl = clsel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				clsel (h', tbl) = 	clsel (h, tbl) 
				};


add : (s : {v : char | true}) ->  
			State  {\(h : heap).
				\(Tbl : [char]). 
				clsel (h, tbl) = Tbl =>  
				(cmem (Tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [char]), (Tbl : [char]).
				clsel (h', tbl) = Tbl'/\
				clsel (h, tbl) = Tbl /\
				cmem (Tbl', s) = true /\
				size (Tbl') == size (Tbl) + 1
				};


goal : (s : {v : char | true}) -> 
		State {\(h : heap). 
			 \(Tbl : [char]). 
				sel (h, num) == 0 /\
				clsel (h, tbl) = Tbl /\
				not  (0 > size (Tbl)) /\
				(cmem (Tbl, s) = false)}
				v : {v : pair | true}
		  	{\(h : heap), (v : pair), (h' : heap). 
				\(Tbl' : [char]), (Tbl : [char]).
				(clsel (h, tbl) = Tbl /\  
				clsel (h', tbl) = Tbl')   
				=> 
				((cmem (Tbl', s) = true) /\
				size (Tbl') == size (Tbl) + 1)
				
			};

