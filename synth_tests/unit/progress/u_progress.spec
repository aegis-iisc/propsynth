tbl : ref [int];



libFun : State {\(h : heap). true}
				v : {v : int | true}
		  	{\(h : heap), (v : int), (h' : heap). 
				ilssel (h', tbl) = ilssel (h, tbl)};
 


goal : (s : {v : int | true}) -> 
		State {\(h : heap). true}
				v : {v : int | true}
		  	{\(h : heap), (v : int), (h' : heap). [v > 0]};

