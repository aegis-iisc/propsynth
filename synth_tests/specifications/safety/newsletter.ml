
(*src : On the automated verification of web applications
with embedded SQL
*)
type code = Cs  | Cu | Un
(*database a record of {fields:value}*)
type NS = {nletter : string; 
		   user : string ; 
		   subscribed : bool ; 
		   code : code ; articles_read : [string]}  list ref 


inv dataBaseInv = Inv

select : d : NS -> n : string -> u : string -> {true} 
										v : bool 
										{mem (d, n, u)}


subscribe : d : NS -> 
			n : string -> 
			u : string -> 
					State {mem (d , n , u)}
					(v, d') :  (code * NS) 
					{post_subscribe}


unsubscibe : d : NS -> n : string -> u : string -> 
					State {_}
					(v, d') :  (code * NS) 
					{_}


pr1 : (code * NS) -> code
pr2 : (code * NS) -> NS




read :  d : NS
		n : string -> 
		u : string -> 
		State { (n, u) \in d /\ 
			subscribed(n, u) = true}
		(x,y) : (acticles list  * NS)
		{articles_read (n, u) = x /\ 
		y = d}
		
		 


confirm: c : code -> 
		  n : string -> 
		  u : string -> 
		State {c = Cs \/ c = Cu }
		v : ( unit * NS)
		{ c = Cs => subscribed (n, u) = true /\ 
		c = Cu => subscribed (n, u ) = false}



confirm_incorrect : 
		c : code -> 
		State {pre_confirm_inc}
		v : (unit * NS) 
		{post_confirm_inc}





(*safety query*)

goal : 	d : NS -> 
		n : string -> 
		u : string -> 
		->  State {_}
			v : articles list
		{ _}


(*a correct solution*)
			let mem = select d n u in 
			if (!mem)
				_ <- add_user u;
			 	_ <- add_nl n u ; 
			 	cs <- subscribe d n u;
			 	_ <- confirm cs d n u
			 	return read d n u
			else  	
				cs <- subscribe n u;
			 	_ <- confirm cs n u
			 	return read d n u



(*functional query1*)
goal : d : NS -> n : string -> u : string  
			->  State {true}
				v : articles list
				{(n, u \in NS) /\ 
				subscribed (n, u)= true 
				/\ articles_read (n, u) = v} 


let mem = select d n u in 
			if (!mem)
				_ <- add_user u;
			 	_ <- add_nl n u ; 
			 	cs <- subscribe n u;
			 	_ <- confirm cs n u
			 	
			 	read <-  read d n u;
			 	return read;
			else  	
				cs <- subscribe n u;
			 	_ <- confirm cs n u
			 	
			 	return read d n u

(*functional query2*)
(*Think of a transaction to allow a user to read a set of aru and again close the 
	subscription*)
	
goal : d : NS -> n : string -> u : string  
			->  State {true}
				v : articles list
				{(n, u \in NS) /\ 
				subscribed (n, u)= false 
				/\ articles_read (n, u) = v} 


let mem = select d n u in 
			if (!mem)
				_ <- add_user u;
			 	_ <- add_nl n u ; 
			 	cs <- subscribe n u;
			 	_ <- confirm cs n u
			 	
			 	read <-  read d n u;
			 	cu <- unsubscibe n u;
			 	_ <- confirm n u;
			 	return read;
			else  	
				cs <- subscribe n u;
			 	_ <- confirm cs n u
			 	read <-  read d n u;
			 	cu <- unsubscibe n u;
			 	_ <- confirm n u;
			 	return read;