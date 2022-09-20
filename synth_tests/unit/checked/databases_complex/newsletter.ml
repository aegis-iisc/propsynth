
(*src : On the automated verification of web applications
with embedded SQL
*)
type code = Cs | Cu | Cn
(*database is a list of record of {fields:value}*)
type nlrecord = 
			{nletter : string; 
		   	user : string ; 
		   	subscribed : bool ; 
		   	code : code ; 
		   	articles_read : [string]
		    };  


(*newsletter database*)
type nl =  ref [nlrecord];


predicate dsel : heap :-> nl -> [nlrecord]
predicate nlmem : [nlrecord] :-> string :-> string :-> bool 
predicate ns : [nlrecord] :-> string :-> string :-> nlrecord  
predicate goodcode : [nlrecord] :-> code :-> bool 



inv pkInv = \forall n, u, s1 s2, c1, c2. (s1 = s2 /\ c1 = c2) \/ (not NS (n, u, s1, c1) \/ not NS (n, u, s2, c2) );

select : (d : { v : nl | true}) -> (n  : { v : string | true})
							-> (u : { v :string | true}) -> 
									 State {\(h : heap).
									 	dsel (h, d) = D => 
									 	(nlmem (D, n, u) = true} 
										v : nlrecord 
										{\(h: heap),(v : nlrecord),(h': heap).
										dsel (h', d) = D' (*gives the NS*)/\
										dsel (h, d) = D (*gives the NS_gh*)/\
										D' = D /\
										(nlmem (D, n, u) = true /\
											nletter (v) = n /\ 
											user (v) = u)
										};


nlmem : (d : { v : nl | true}) -> (n  : { v : string | true})
							-> (u : { v :string | true}) -> 
									 State {\(h : heap).true} 
										v : {v : bool | true} 
										{\(h: heap),(v : [nlrecord]),(h': heap).
										dsel (h', d) = D' (*gives the NS*)/\
										dsel (h, d) = D (*gives the NS_gh*)/\
										D' = D /\
										[v = true] <=> nlmem (d, n, u) /\
										[v = false] <=> not (nlmem (d, n, u))
										};


(*: In order to subscribe a user u
to a newsletter n in a database d the function subscribe is called with inputs n and u *)
subscribe :  (d : { v : nl | true}) -> 
			 (n  : { v : string | true})-> 
			 (u : { v :string | true}) -> 
					State {\(h : heap). (*for now we do not do the sel operation*)
							not (nlmem (D , n , u)}
					v : { v : code | true}  
						{\(h: heap),(v : code),(h': heap).
							dsel (h', d) = D' (*gives the NS*)/\
							dsel (h, d) = D (*gives the NS_gh*)/\
							(nlmem (D', n, u) /\
							 (	ns (n, u, s, u, r) = NS /\ 		
							 	subscribed (NS) = false /\
							 	code (NS) = Cs /\ 
							 	v = code (NS)
									

							)};	





unsubscibe : (d : { v : nl | true}) -> 
			 (n  : { v : string | true})-> 
			 (u : { v :string | true}) -> 
					State {\(h : heap). (*for now we do not do the sel operation*)
							 dsel (h, d) = D => 
							 (nlmem (D , n , u) = true}
					v : { v : code | true}  
						{\(h: heap),(v : code),(h': heap).
							dsel (h', d) = D' (*gives the NS*)/\
							dsel (h, d) = D (*gives the NS_gh*)/\
							(nlmem (D', n, u) /\
							 ns (n, u) = NS /\ 		
							 subscribed (NS) = true /\
							 code (NS) = Cu /\
							 v = code (NS)
								

							)};	


confirm: c : code -> 
		  n : string -> 
		  u : string -> 
		State {\(h:heap).
				dsel (h, d) = D =>
				(nlmem (D, n, u) = true) /\
				(c = Cs \/ c = Cu) }
			v : {v : unit | true}
		{ 
			\(h: heap),(v : code),(h': heap).
			dsel (h', d) = D' (*gives the NS*)/\
			dsel (h, d) = D (*gives the NS_gh*)/\
			ns (D', n, u) = NS /\ 		
			(nlmem (D', n, u) = true /\
			(code (NS) = Cn) /\		
			(c = Cs => subscribed (NS) = true)) 
			/\
			(c = Cu => subscribed (NS) = false)
		};






read :  (d : { v : nl | true}) -> 
			 (n  : { v : string | true})-> 
			 (u : { v :string | true}) -> 
				State {\(h : heap). (*for now we do not do the sel operation*)
						(nlmem (D , n , u) /\ 
						ns (n, u) = NS /\
						subscribed (NS) = true}
					v : { v : [string] | true}  
			{\(h: heap),(v : code),(h': heap).
				dsel (h', d) = D' (*gives the NS*)/\
				dsel (h, d) = D (*gives the NS_gh*)/\
				(nlmem (D', n, u) /\
				(ns (n, u) = NS /\ 		
				subscribed (NS) = true /\
				v = readlist (NS)
			}
		
		 
remove : (d : { v : nl | true}) -> 
			 (n  : { v : string | true})-> 
			 (u : { v :string | true}) -> 
				State {\(h : heap). (*for now we do not do the sel operation*)
						(nlmem (D , n , u) = true /\ 
						(ns (n, u) = NS => 
						subscribed (NS) = false /\
						code (NS) = Cn)
						}
					v : { v : unit | true}  
				{\(h: heap),(v : code),(h': heap).
				dsel (h', d) = D' (*gives the NS*)/\
				dsel (h, d) = D (*gives the NS_gh*)/\
				(nlmem (D', n, u) = false 
			}
		 




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