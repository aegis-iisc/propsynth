tbl : ref [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;


createPair : (p1 : {v : float | true}) -> (p2 : {v : int | true}) -> 
											{v : pair | fst (v) == p1 /\
												snd (v) == p2}; 

pr1 : (p : {v : pair | true}) -> {v : float | fst (p) == v};

pr2 : (p : {v : pair | true}) -> {v : int | snd (p) == v};


size : State 
			{\(h : heap). true} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]),(Tbl : [int]).
				ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl' /\  
				v == size (Tbl) /\
				ilssel (h', tbl) = ilssel (h, tbl)};


fresh_str : State 
			{\(h : heap). not (sel (h, num) > 1)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				ilssel (h', tbl) = Tbl' /\  
				ilssel (h', tbl) = ilssel (h, tbl) /\
				mem (Tbl', v) = false};






average_len : State  {\(h : heap).
					\(Tbl : [int]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				ilssel (h', tbl) = 	ilssel (h, tbl) 
				};



remove 	: (s : {v : int  | true}) ->  (t : {v : tbl | true}) -> 

			State  {\(h : heap).
							\(Tbl : [int]).
							sel (h, tbl) = Tbl =>  
							(mem (Tbl, s) = true)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\  
				(mem (Tbl', s) = false /\ 
				size (Tbl') == size (Tbl) - 1)};


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
				size (Tbl') == size (Tbl) + 1
				};


goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
			 \(Tbl : [int]). 
				sel (h, num) == 0 /\
				ilssel (h, tbl) = Tbl /\
				not  (0 > size (Tbl)) /\
				(mem (Tbl, s) = false)}
				v : {v : pair | true}
		  	{\(h : heap), (v : pair), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				(ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl')   
				=> 
				((mem (Tbl', s) = true) /\
				size (Tbl') == size (Tbl) + 1 /\
				snd (v) == size (Tbl'))
				
			};

