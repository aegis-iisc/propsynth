tbl : ref [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;




fo : State  {\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				ilssel (h', tbl) = Tbl' /\  
				ilssel (h', tbl) = ilssel (h, tbl) /\
				mem (Tbl', v) = false};


f1 : (s : {v : int | true}) ->  
			State  {\(h : heap). 
				\(Tbl : [int]). 
				ilssel (h, tbl) = Tbl =>  
				(mem (Tbl, s) = false)} 
				v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				mem (Tbl', s) = true 
				};



goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
			 \(Tbl : [int]). sel (h, num) == 0}
				v : {v : int | true}
		  	{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				(ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl')   
				=> 
				mem (Tbl', s) = true 
			};

