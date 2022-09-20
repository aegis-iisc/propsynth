tbl : ref [int];
Tbl0 : [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;

mem : (s  : { v : int | true}) -> 
			State  {\(h : heap). true} 
			v : { v : bool | true} 
			{\(h : heap), (v : bool), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				([v=true] <=> ( mem(Tbl', s) = true))/\ 
				([v=false] <=> (mem (Tbl', s) = false))};



remove 	: (s : {v : int  | true}) ->  
			State  {\(h : heap).ilssel (h, tbl) = Tbl /\ 
						(mem (Tbl, s) = true)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				(mem (Tbl', s) = false) /\ 
				len (Tbl') == len (Tbl) - len (s) /\ 
				size (Tbl') == size (Tbl) - 1};

take_head : State  {\(h : heap).ilssel (h, tbl) = Tbl 
					/\ size (Tbl) > 0} 
				v : { v : int | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				(mem (Tbl', v) = false) /\ 
				len (Tbl') == len (Tbl) - len (v) /\ 
				size (Tbl') == size (Tbl) - 1};



twice_average_len : 
			State  {\(h : heap).ilssel (h, tbl) = Tbl /\ size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				ilssel (h', tbl) = Tbl' /\ 
				not (min (Tbl') > v)};






average_len : State  {\(h : heap).
					exists(Tbl : [int]).
					not (sel (h, num) > 2) /\
					(Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0)
					} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				exists (Tbl' : [int]).
				 sel (h', num) == sel (h, num) /\
				 ilssel (h', tbl) = Tbl'
				 /\
			 	 (not (min (Tbl') > v) /\
				 not (v > max (Tbl')) /\
				 ilssel (h', tbl) =ilssel (h, tbl)
				)};


fresh_str : State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				exists (Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				len (v) == 3 /\
				(ilssel (h', tbl) = Tbl' =>  
				mem (Tbl', v) = false)};


add : (s : {v : int | true}) ->  
			State  {\(h : heap).
				exists (Tbl : [int]). 
				not (sel (h, num) > 2) /\
					
				ilssel (h, tbl) = Tbl /\  
				(mem (Tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				exists (Tbl' : [int]).
				sel (h', num) == sel (h, num) /\
				
				ilssel (h', tbl) = Tbl'
				/\ 
				(
				(mem (Tbl', s) = true) /\ 
				len (Tbl') == len (Tbl) + len (s) /\ 
				size (Tbl') == size (Tbl) + 1 
				)};


goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
				exists (Tbl : [int]). 
				sel (h, num) == 0 /\
				ilssel (h, tbl) = Tbl /\
				(mem (Tbl, s) = false)}
				v : {v : float | true}
		  	{\(h : heap), (v : float), (h' : heap). 
				exists (Tbl' : [int]). 
				not (sel (h, num) > 2) /\
				ilssel (h', tbl) = Tbl'
					
				/\  
				(
					not (min (Tbl') > v) /\
					not (v > max (Tbl')) /\
					size (Tbl') == size (Tbl) + 2 /\
					mem (Tbl', s) = true /\
					len (Tbl') == len (Tbl) + len (s) + 3 )
			};
