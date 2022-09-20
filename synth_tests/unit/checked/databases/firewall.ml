(**)

dtab : ref [did];
cstab : ref [csend];
D : [did]
C : [csend]



type did = int

type csend = {senderid : int ; 
			 receiverid : int} 

type didTable = ref [did]

type csendTable = ref [csend]



predicate Invfirewall = ∃x (Device(x) ∧ ∀y(Device(y) → CanSend(y, x)))
predicate device : [did] :-> int :-> bool 
predicate dsize : [int] :-> int 
predicate cansend : int :-> int :-> bool 
predicate didsel : heap :-> didTable :-> [did] 
predicate csdsel : heap :-> csendTable : 

dtab : ref [did];
cstab : ref [csend];
D : [did];
CS : [csend];

add_device : (d : { v : int | true}) -> State {
										\(h : heap).	
										\(D : [did]).
										didsel (h, dtab) = D =>		
										device (D, d) = false
										}
										v : {v : unit | true}
										{\(h: heap),(v : unit),(h': heap).
											\(D : [did]), (D' : [did]).
											didsel (h, dtab) = D /\		
											didsel (h', dtab) = D' /\
											device (D', d) = true	/\
											dsize (D') == dsize (D) + 1 	
										};  


is_device : (d : { v : int | true}) -> State {
										\(h : heap).true}
										v : {v : bool | true}
										{\(h: heap),(v : unit),(h': heap).
											\(D : [did]), (D' : [did]).
										[v = true] <=> device (D, d) = true /\ 
										[v = false] <=> device (D, d) = false
										}; 




diff_device : (d : { v : int | true}) -> State {
										\(h : heap).
											\(D : [did]).
											didsel (h, dtab) = D =>	
											dsize (D) > 1	
											}
											v : {v : int | true}
											{\(h: heap),(v : unit),(h': heap).
												\(D : [did]), (D' : [did]).
												device (D, v) = true /\ 
												[v = d]
											}; 


add_connection : (s : { v : int | true}) 
					-> (r : { v : int | true}) -> 
									State {
										\(h : heap).
											\(D : [did]).
											didsel (h, dtab) = D =>	
											(device (D, s) = true /\ device (D, r) = true)	
											}
											v : {v : unit | true}
											{\(h: heap),(v : unit),(h': heap).
												\(D : [did]), (D' : [did]).
												cansend (D', s, r) = true
											}; 



add_senders  : (ss : { v : [int] | true}) 
					-> (r : { v : int | true}) -> 
									State {
										\(h : heap).
											\(D : [did]).
											didsel (h, dtab) = D =>	
											(device (D, r) = true)	
											}
											v : {v : unit | true}
											{\(h: heap),(v : unit),(h': heap).
												\(D : [did]), (D' : [did]), (y : int).
												 mem (y, ss) = true =>  
												 ( device (y) = true 
												 	/\ cansend (D', s, y) = true
												 	)
											}; 



make_central : (d : { v : int | true}) -> State {
										\(h : heap).
											\(D : [did]).
											didsel (h, dtab) = D =>	
											device (D, d) = true	
											}
										v :  { v : unit | true}
										 { \(h: heap),(v : unit),(h': heap).
												\(D : [did]), (D' : [did]), (y : int).
										 		device(D', y) = true => 
										 		cansend(D', y, d) = true
										 };



find_central : ( x : {v : unit | true})-> State {
										\(h : heap).
											 true
											}
										v :  { v : int  | true}
										 { \(h: heap),(v : int),(h': heap).
												\(D : [did]), (D' : [did]), (y : int).
										 		D' = D /\
										 		device (D', v) = true /\ 
										 		device(D', y) = true => 
										 		cansend(D', y, v) = true
										 };




delete_device : (d : { v : int | true}) -> 
								State {\(h : heap).
											\(D : [did]), (y : int).
											didsel (h, dtab) = D =>	
											device (D, d) = true /\
											 ( device (D, y) = true =>
													\(z : int). device (D, z) = true /\ 
													not [z = d]
											 ) 	
										 }
									v : {v : unit | true}
								 { \(h: heap),(v : unit),(h': heap).
										\(D : [did]), (D' : [did]), (y : int).
										 device (D', d) = false /\
								 		 device(D', y) = true => 
								 		 cansend(D', y, d) = false
								 };		 



goal : (d : { v : int | true}) -> 
		(s : {v : [int] | true}) ->  
						State {\(h: heap).true} 
									v : {v : int | true} 
		 							
		 						{\(h: heap),(v : int),(h': heap).true}
