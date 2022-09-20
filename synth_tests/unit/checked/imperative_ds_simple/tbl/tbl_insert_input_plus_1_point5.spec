tbl : ref [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;

create_pair : (x : {v : int | true}) -> 
				(y: {v : float | true}) -> 
                State 
			        {\(h : heap).
                        \(Tbl : [int]). 
				    ilssel (h, tbl) = Tbl =>  
				    (mem (Tbl, x) = false)} 
			        v : { v : pair | true}
                    {\(h : heap), (v : pair), (h' : heap). 
				        \(Tbl' : [int]),(Tbl : [int]).
				            ilssel (h, tbl) = Tbl /\  
			            	ilssel (h', tbl) = Tbl' /\  
				            sel (h', num) == sel (h, num)};





fresh_str : State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				ilssel (h', tbl) = Tbl' /\  
				ilssel (h', tbl) = ilssel (h, tbl) /\
				mem (Tbl', v) = false};




size : State 
			{\(h : heap). true} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]),(Tbl : [int]).
				ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl' /\  
				v == size (Tbl) /\
                sel (h', num) == sel (h, num) /\
				ilssel (h', tbl) = ilssel (h, tbl)};


average_len : State  {\(h : heap).
					\(Tbl : [int]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				ilssel (h', tbl) = 	ilssel (h, tbl) 
				/\ sel (h', num) == sel (h, num)
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
				not  (0 > size (Tbl)) /\
				(mem (Tbl, s) = true)}
				v : {v : pair | true}
		  	{\(h : heap), (v : pair), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				(ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl')   
				=> 
				size (Tbl') == size (Tbl) + 2 
				
			};

