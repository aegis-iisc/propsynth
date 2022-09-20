D : [nlrecord];
D' : [nlrecord];
d : ref [nlrecord];

qualifier activenl : [nlrecord] :-> nl :-> bool;
qualifier activeuser : [nlrecord] :-> user :-> bool;
qualifier subsize : [nlrecord] :-> user :-> int;
qualifier nlreach : [nlrecord] :-> nl :-> int;  

select : (n  : { v : nl | true})
							-> (u : { v :user | true}) -> 
									 
									 State {\(h : heap).
									 	\(D : [nlrecord]).
									 	true} 
										v : { v : unit | true}
									   {\(h: heap),(v : unit),(h': heap).
										\(D : [nlrecord]), (D' : [nlrecord]).
										dsel (h', d) = D' /\
										dsel (h, d) = D /\
										D' = D /\
										nlmem (D, n, u) = true
										};


confirmS :  (n  : { v : nl | true})-> 
		  (u : { v : user | true}) -> 
		State {\(h:heap).
				\(D : [nlrecord]).
				(dsel (h, d) = D =>  subscribed (D, n, u) = false)}
			v : {v : unit | true}
			{ \(h: heap),(v : unit),(h': heap).
				\(D : [nlrecord]), (D' : [nlrecord]).
				dsel (h', d) = D'/\
				dsel (h, d) = D /\
				subscribed (D', n, u) = true /\ 		
				nlmem (D', n, u) = true /\
				confirmed (D', n, u) = true};






subscribe : (n  : { v : nl | true})-> 
			 (u : { v : user | true}) -> 
					State {\(h : heap). 
							\(D : [nlrecord]).
								dsel (h, d) = D => 
									(nlmem (D , n , u) = true /\ confirmed (D, n, u) = true
									/\ subscribed (D, n, u) = false)}
					v : { v : unit | true}  
						{\(h: heap),(v : unit),(h': heap).
							\(D : [nlrecord]), (D' : [nlrecord]).
							dsel (h', d) = D'/\
							dsel (h, d) = D /\
							nlmem (D', n, u) = true /\
							subscribed (D', n, u) = true /\
							subsize (D', u) == subsize (D', u) + 1 	/\	
							nlreach (D', n) == nlreach (D, n) + 1 
							};	








read :  (n  : { v : nl | true})-> 
		(u : { v : user | true}) -> 
		State {\(h : heap). 
				\(D : [nlrecord]).
					dsel (h, d) = D =>
						(nlmem (D , n , u) = true /\ 
						subscribed (D, n, u) = true
						)
				}
				v : { v : [string] | true}  
			{\(h: heap),(v : [string]),(h': heap).
				\(D : [nlrecord]), (D' : [nlrecord]).
				dsel (h', d) = D'/\
				dsel (h, d) = D /\
				nlmem (D', n, u) = true /\
				subscribed (D', n, u) = true /\ 		
				v = articles (D')};
		
		 
remove : (n  : { v : nl | true})-> 
		 (u : { v : user| true}) -> 
				State {\(h : heap). 
						\(D : [nlrecord]).
						(dsel (h, d) = D =>
							(nlmem (D , n , u) = true /\
							subscribed (D, n, u) = false) 
						)	
					}
				v : { v : unit | true}  
				{\(h: heap),(v : unit),(h': heap).
						\(D : [nlrecord]), (D' : [nlrecord]).
							dsel (h', d) = D' /\ 
							dsel (h, d) = D /\
							nlmem (D', n, u) = false 
							
				};
		 



unsubscribe : (n  : { v : nl | true})-> 
			 (u : { v : user | true}) -> 
					State {\(h : heap). 
							\(D : [nlrecord]).
								dsel (h, d) = D => 
									(nlmem (D , n , u) = true /\ confirmed (D, n, u) = true /\
									subscribed (D, n, u) = true)}
					v : { v : unit | true}  
						{\(h: heap),(v : unit),(h': heap).
							\(D : [nlrecord]), (D' : [nlrecord]).
							dsel (h', d) = D'/\
							dsel (h, d) = D /\
							nlmem (D', n, u) = true /\
							subscribed (D', n, u) = false /\ 		
							subsize (D', u) == subsize (D, u) -- 1 /\
							(nlreach (D, n) > 1 =>  activenl (D', n) = true) /\
							(subsize (D ,u ) > 1 => activeuser (D', u) = true) 
							};	




confirmU :  (n  : { v : nl | true}) -> 
		    (u : { v : user | true}) -> 
		State {\(h:heap).
				\(D : [nlrecord]).
				(dsel (h, d) = D =>  (subscribed (D, n, u) = true /\ confirmed (D, n, u) = false))}
			v : {v : unit | true}
			{ \(h: heap),(v : unit),(h': heap).
				\(D : [nlrecord]), (D' : [nlrecord]).
				dsel (h', d) = D'/\
				dsel (h, d) = D /\
				subscribed (D', n, u) = true /\ 		
				nlmem (D', n, u) = true /\
				confirmed (D', n, u) = true /\
				subsize (D', u) = subsize (D, u)};




goal : 	 (n  : { v : nl | true})-> 
		 (u : { v : user | true}) -> 
				State {\(h : heap). 
						\(D : [nlrecord]).
						dsel (h, d) = D /\
						nlmem (D , n , u) = true /\
						subscribed (D, n, u) = false /\
						confirmed (D, n, u) = false}
				v : { v : unit | true}  
				{\(h: heap),(v : unit),(h': heap).
						\(D : [nlrecord]), (D' : [nlrecord]).
							(dsel (h', d) = D' /\ 
							dsel (h, d) = D) => 
							(nlmem (D', n, u) = true /\
							subscribed (D', n, u) = true /\
							confirmed (D', n, u) = false)
				};
