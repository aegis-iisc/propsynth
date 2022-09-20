D : [nlrecord];
D' : [nlrecord];
d : ref [nlrecord];



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
							confirmed (D', n, u) = false		
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
							confirmed (D', n, u) = false		
									
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
				confirmed (D', n, u) = true};



read :  (n  : { v : nl | true})-> 
		(u : { v : user | true}) -> 
		State {\(h : heap). 
				\(D : [nlrecord]).
					dsel (h, d) = D =>
						(nlmem (D , n , u) = true /\ 
						subscribed (D, n, u) = true /\
						confirmed (D, n, u) = false 
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


		 
goal : 	 (n  : { v : nl | true})-> 
		 (u : { v : user | true}) -> 
				State {\(h : heap). 
						\(D : [nlrecord]).
						dsel (h, d) = D /\
						nlmem (D , n , u) = true /\
						subscribed (D, n, u) = false /\
						confirmed (D, n, u) = false}
				v : { v : [string] | true}  
				{\(h: heap),(v : [string]),(h': heap).
						\(D : [nlrecord]), (D' : [nlrecord]).
							(dsel (h', d) = D' /\ 
							dsel (h, d) = D ) => 
							(nlmem (D', n, u) = false /\
							v = articles (D'))};
		 


(*

x<- confirmedS 
y <- subscribe 
z< -read
_ <- confirmU 
_ <- unsubscribe 
remove 

ret z

*)		 		 

(*
if (subscribed n u) then 
	z< -read
	_ <- confirmU 
	_ <- unsubscribe 
	remove 
	ret z
else
	
x<- confirmedS 
y <- subscribe 
z< -read
_ <- confirmU 
_ <- unsubscribe 
remove 

ret z



x<- confirmedS 
y <- subscribe 
z< -read
_ <- confirmU 
_ <- unsubscribe 
remove 

ret z

*)		 		 