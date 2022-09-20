tbl : ref [string];
Tbl' : [string];
Tbl :  [string];
num : ref int;


type pair = Pair of float * int

createpair : (f  : { v : float | v > 0}) -> 
			 (i  : { v : int | i >= 0}) -> {v : pair | true}

mem : (s  : { v : string | true}) ->  
			{ v : bool | \(h : heap), (v : bool), (h' : heap). 
				\(Tbl' : [string]), (Tbl: [string]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				Tbl' = Tbl /\
				([v=true] <=> ( mem(Tbl', s) = true))/\ 
				([v=false] <=> (mem (Tbl', s) = false))
				};


size : State 
			{\(h : heap). true} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [string]), (Tbl: [string]).
				clsel (h, tbl) = Tbl /\  
				clsel (h', tbl) = Tbl' /\  
				v == size (Tbl) /\
				clsel (h', tbl) = clsel (h, tbl)};




fresh_str : State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : string | true} 
			{\(h : heap), (v : string), (h' : heap). 
				\(Tbl' : [string]).
				sel (h', num) == sel (h, num) + 1 /\
				ilssel (h', tbl) = Tbl' /\  
				ilssel (h', tbl) = ilssel (h, tbl) /\
				mem (Tbl', v) = false};



lower : (s  : { v : string | true}) -> 
				 State  {\(h : heap).
					\(Tbl : [string]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : flaot | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				\(Tbl' : [string]), (Tbl: [string]).
				ilssel (h', tbl) = 	Tbl' /\
				ilssel (h, tbl) = Tbl  /\
				Tbl' = Tbl /\
				sel (h', num) == sel (h, num) /\
				[v > 0]
				};


uppper : (s  : { v : string | true}) -> 
				 State  {\(h : heap).
					\(Tbl : [string]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				\(Tbl' : [string]), (Tbl: [string]).
				ilssel (h', tbl) = 	Tbl' /\
				ilssel (h, tbl) = Tbl  /\
				Tbl' = Tbl /\
				sel (h', num) == sel (h, num) /\
				[v > 0]
				};



average_len : State  {\(h : heap).
					\(Tbl : [string]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				ilssel (h', tbl) = 	ilssel (h, tbl) 
				/\ 
				sel (h', num) == sel (h, num) /\
				minmax (Tbl', v) = true
				};



add : (s : {v : string | true}) ->  
			State  {\(h : heap).
				\(Tbl : [string]). 
				ilssel (h, tbl) = Tbl =>  
				(mem (Tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [string]), (Tbl: [string]).
	
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				mem (Tbl', s) = true /\
				size (Tbl') == size (Tbl) + 1 /\
				sel (h', num) == sel (h, num) 
				};

clear : State  {\(h : heap).true } 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [string]), (Tbl: [string]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				size (Tbl') = 0 /\
				sel (h', num) == sel (h, num) 
				};



removelessthan : (s : {v : string | true}) ->  
			State  {\(h : heap).true } 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [string]), (Tbl: [string]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				size (Tbl') <= size (Tbl)/\
				sel (h', num) == sel (h, num) 
				};



goal : (s : {v : string | true}) -> 
		State {\(h : heap). 
			 \(Tbl : [string]). 
				sel (h, num) == 0 /\
				ilssel (h, tbl) = Tbl /\
				not  (0 > size (Tbl)) }
				v : {v : pair | true}
		  	{\(h : heap), (v : pair), (h' : heap). 
				\(Tbl' : [string]), (Tbl : [string]).
				ilslsel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl')   
				=> 
				((mem (Tbl', s) = true) /\
				size (Tbl') == size (Tbl) + 1) /\
				snd (v)  = size (Tbl')
				minmax (fst (v)) = true
				
			};


goal (s : string) =  
b1 <- mem (s);
if (b1) then
	s1 <- fresh_str ();
	_ <- add s1;
	x1 <- average_len ();
	y1 <- size ();  
	return Pair (x1, y1)
else 
	_ <- add s1;
	x1 <- average_len ();
	y1 <- size ();  
	return Pair (x1, y1)




