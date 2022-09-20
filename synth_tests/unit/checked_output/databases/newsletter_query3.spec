D : [nlrecord];
D' : [nlrecord];
d : ref [nlrecord];
NS : nlrecord;
Cs : code;
Cu : code;
Cn : code;

select : (d : { v : ref [nlrecored] | true}) -> 
		 (n  : { v : string | true})
							-> (u : { v :string | true}) -> 
									 
									 State {\(h : heap).
									 	\(D : [nlrecord]).
									 	dsel (h, d) = D => 
									 	nlmem (D, n, u) = true
									 	} 
										v : { v : nlrecord | true}
									   {\(h: heap),(v : nlrecord),(h': heap).
										\(D : [nlrecord]), (D' : [nlrecord]).
										dsel (h', d) = D' /\
										dsel (h, d) = D /\
										D' = D /\
										nlmem (D, n, u) = true /\
										nletter (v) = n /\ 
										user (v) = u
										};


nlmem : (d : { v : ref [nlrecored] | true}) -> 
		(n  : { v : string | true}) -> 
		(u : { v :string | true}) -> 
									 State {\(h : heap).true} 
										v : {v : bool | true} 
									{\(h: heap),(v : bool),(h': heap).
										\(D : [nlrecord]), (D' : [nlrecord]).
										dsel (h', d) = D' /\
										dsel (h, d) = D /\
										D' = D /\
										[v = true] <=> nlmem (D, n, u) = true /\
										[v = false] <=> nlmem (D, n, u) = false
										};


subscribe :  (d : { v : ref [nlrecored] | true}) -> 
			 (n  : { v : string | true})-> 
			 (u : { v :string | true}) -> 
					State {\(h : heap). 
							\(D : [nlrecord]).
								dsel (h', d) = D' => nlmem (D , n , u) = false}
					v : { v : code | true}  
						{\(h: heap),(v : code),(h': heap).
							\(D : [nlrecord]), (D' : [nlrecord]), (NS : nlrecord).
							dsel (h', d) = D'/\
							dsel (h, d) = D /\
							nlmem (D', n, u) = true/\
							ns (D', n, u) = NS /\ 		
							subscribed (NS) = false /\
							code (NS) = Cs /\ 
							v = code (NS)
							};	







unsubscribe :  (d : { v : ref [nlrecored] | true}) -> 
			 (n  : { v : string | true})-> 
			 (u : { v :string | true}) -> 
					State {\(h : heap). 
							\(D : [nlrecord]).
								dsel (h', d) = D' => nlmem (D , n , u) = true}
					v : { v : code | true}  
						{\(h: heap),(v : code),(h': heap).
							\(D : [nlrecord]), (D' : [nlrecord]), (NS : nlrecord).
							dsel (h', d) = D'/\
							dsel (h, d) = D /\
							nlmem (D', n, u) = true/\
							ns (D', n, u) = NS /\ 		
							subscribed (NS) = true  /\
							code (NS) = Cu /\ 
							v = code (NS)
							};	


confirm: (c : { v : code | true}) -> 
			 (n  : { v : string | true})-> 
			 (u : { v :string | true}) -> 
		State {\(h:heap).
				\(D : [nlrecord]).
				dsel (h, d) = D =>
				(nlmem (D, n, u) = true) /\
				(c = Cs \/ c = Cu) }
			v : {v : unit | true}
			{ \(h: heap),(v : code),(h': heap).
				\(D : [nlrecord]), (D' : [nlrecord]), (NS : nlrecord).
				dsel (h', d) = D'/\
				dsel (h, d) = D /\
				ns (D', n, u) = NS /\ 		
				nlmem (D', n, u) = true /\
				code (NS) = Cn /\		
				(c = Cs => subscribed (NS) = true) /\
				(c = Cu => subscribed (NS) = false)
			};






read :  (d : { v : ref [nlrecored] | true}) -> 
		(n  : { v : string | true})-> 
		(u : { v :string | true}) -> 
		State {\(h : heap). 
				\(D : [nlrecord]).
					dsel (h, d) = D =>
						(nlmem (D , n , u) = true /\ 
						ns (D, n, u) = NS /\
						subscribed (NS) = true
						)
				}
				v : { v : [string] | true}  
			{\(h: heap),(v : [string]),(h': heap).
				\(D : [nlrecord]), (D' : [nlrecord]), (NS : nlrecord).
				dsel (h', d) = D'/\
				dsel (h, d) = D /\
				nlmem (D', n, u) = true /\
				ns (D', n, u) = NS /\ 		
				subscribed (NS) = true /\
				v = articles (NS)};
		
		 
remove : (d : { v : ref [nlrecored] | true}) -> 
		 (n  : { v : string | true})-> 
		 (u : { v :string | true}) -> 
				State {\(h : heap). 
						\(D : [nlrecord]).
						(dsel (h, d) = D =>
							(nlmem (D , n , u) = true /\ 
							(ns (D, n, u) = NS => 
							subscribed (NS) = false /\
							code (NS) = Cn))
						)	
					}
				v : { v : unit | true}  
				{\(h: heap),(v : code),(h': heap).
						\(D : [nlrecord]), (D' : [nlrecord]), (NS : nlrecord).
							dsel (h', d) = D' /\ 
							dsel (h, d) = D /\
							nlmem (D', n, u) = false 
				};
		 




goal : 	 (d : { v : ref [nlrecored] | true}) -> 
		 (n  : { v : string | true})-> 
		 (u : { v :string | true}) -> 
				State {\(h : heap). 
						true}
				v : { v : [string] | true}  
				{\(h: heap),(v : [string]),(h': heap).
						\(D : [nlrecord]), (D' : [nlrecord]), (NS : nlrecord).
							dsel (h', d) = D' /\ 
							dsel (h, d) = D /\
							nlmem (D', n, u) = true /\
							ns (D', n, u) = NS /\
							subscribed (NS) = false 
				};
		 
