tbl : ref [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;


mem : (s  : { v : int | true}) -> 
			State  
			{\(h : heap). true} 
			v : { v : bool | true} 
			
			{\(h : heap), (v : bool), (h' : heap). 
				\(Tbl' : [int]), (Tbl: [int]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				sel (h', num) == sel (h, num) /\
				ilssel (h', tbl) = ilssel (h, tbl) /\
				size (Tbl') == size (Tbl) /\
				([v=true] <=> ( mem(Tbl', s) = true))/\ 
				([v=false] <=> (mem (Tbl', s) = false))};


fresh_str : State 
			{\(h : heap). not (sel (h, num) > 2)} 
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
				not  (0 > size (Tbl))}
				v : {v : unit | true}
		  	{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				(ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl')   
				=> 
				((mem (Tbl', s) = true) /\
				size (Tbl') == size (Tbl) + 2 )
				
			};



(*
\s.
b<- mem S
if (b) then  
 locbound319 <- apply fresh_int  
 ( ---> do locbound332 <- apply add  (, locbound319 );
 x <- fresh_int
_ <- apply add (x)
z <- avg_len ()
ret z.
else 
  
 ( ---> do locbound332 <- apply add  (, s );
 x <- fresh_int
_ <- apply add (x)
z <- avg_len ()
ret z.


\ (tbl, s).
	b<- mem tbl s
	if (b) then  
     	b1 <- fresh_str tbl;  
     	_ <- add_tbl tbl b1 ;
     	b3 <- fresh_str tbl;
     	_ <- add_tbl b3;
     	b5 <- avg_len tbl;
     	b6 <- size_tbl 
     	ret Pair (b5, b6)
    else 
		b7 <- fresh_str tbl;  
 		_ <- add_tbl tbl b1 ;
 		b9 <- avg_len tbl;
		b10 <- size_tbl 
		ret Pair (b9, b10)
	
 ( ---> do locbound332 <- apply add  (, s );
 x <- fresh_int
_ <- apply add (x)
z <- avg_len ()
ret z.


 *)