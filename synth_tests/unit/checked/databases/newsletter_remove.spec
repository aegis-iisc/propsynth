D : [nlrecord];
D' : [nlrecord];
d : ref [nlrecord];











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
							subscribed (D', n, u) = true 		
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
confirmS :  (n  : { v : nl | true})-> 
		  (u : { v : user | true}) -> 
		State {\(h:heap).
				\(D : [nlrecord]).
				(dsel (h, d) = D =>  (subscribed (D, n, u) = false /\ confirmed (D, n, u) = false))}
			v : {v : unit | true}
			{ \(h: heap),(v : unit),(h': heap).
				\(D : [nlrecord]), (D' : [nlrecord]).
				dsel (h', d) = D'/\
				dsel (h, d) = D /\
				subscribed (D', n, u) = false /\ 		
				nlmem (D', n, u) = true /\
				confirmed (D', n, u) = true};




confirmU :  (n  : { v : nl | true}) -> 
		    (u : { v : user | true}) -> 
		State {\(h:heap).
				\(D : [nlrecord]).
				(dsel (h, d) = D =>  (
									nlmem (D , n , u) = true /\
									subscribed (D, n, u) = true /\ 
									confirmed (D, n, u) = false))}
			v : {v : unit | true}
			{ \(h: heap),(v : unit),(h': heap).
				\(D : [nlrecord]), (D' : [nlrecord]).
				dsel (h', d) = D'/\
				dsel (h, d) = D /\
				subscribed (D', n, u) = true /\ 		
				nlmem (D', n, u) = true /\
				confirmed (D', n, u) = true};



unsubscribe : (n  : { v : nl | true})-> 
			 (u : { v : user | true}) -> 
					State {\(h : heap). 
							\(D : [nlrecord]).
								dsel (h, d) = D => 
									(nlmem (D , n , u) = true /\ 
									confirmed (D, n, u) = true /\
									subscribed (D, n, u) = true)}
					v : { v : unit | true}  
						{\(h: heap),(v : unit),(h': heap).
							\(D : [nlrecord]), (D' : [nlrecord]).
							dsel (h', d) = D'/\
							dsel (h, d) = D /\
							nlmem (D', n, u) = true /\
							subscribed (D', n, u) = false 		
							};	


		 

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
		 

		 
goal : 	 (n  : { v : nl | true})-> 
		 (u : { v : user | true}) -> 
				State {\(h : heap). 
						\(D : [nlrecord]).
						dsel (h, d) = D /\
						nlmem (D , n , u) = true /\
						subscribed (D, n, u) = true /\
						confirmed (D, n, u) = false}
				v : { v : unit | true}  
				{\(h: heap),(v : unit),(h': heap).
						\(D : [nlrecord]), (D' : [nlrecord]).
							(dsel (h', d) = D' /\ 
							dsel (h, d) = D)
							=> (nlmem (D', n, u) = false) 
				};
		 
