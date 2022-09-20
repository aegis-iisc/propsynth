dtab : ref [int];
cstab : ref [srpair];
D : [int];
CS : [srpair];
D' : [int];
CS' : [srpair];

qualifier consize : [srpair] :-> int :-> int;
qualifier uniquelist : [int] :-> bool;
qualifier bidirectional : [srpair] :-> int :-> int :-> bool;



add_device : (d : { v : int | true}) -> State {
										\(h : heap).	
										\(D : [int]), (CS : [srpair]).
										didsel (h, dtab) = D =>		
										(device (D, d) = false /\
										uniquelist (D) = true)}
										v : {v : unit | true}
										{\(h: heap),(v : unit),(h': heap).
											\(D : [int]), (D' : [int]).
											didsel (h, dtab) = D /\		
											didsel (h', dtab) = D' /\
											dcssel (h', cstab) = dcssel (h, cstab) /\
											device (D', d) = true	/\
											dsize (D') == dsize (D) + 1 /\
											uniquelist (D') = true

										};  


diff_device : (d : { v : int | true}) -> State {
										\(h : heap).
											\(D : [int]), (CS : [srpair]).true}
											v : {v : int | true}
											{\(h: heap),(v : int),(h': heap).
												\(D : [int]), (D' : [int]),(CS : [srpair]),(CS' : [srpair]).
												didsel (h', dtab) = didsel (h, dtab) /\
												dcssel (h', cstab) =  dcssel (h, cstab) /\
												device (D', v) = true /\ 
												not ([v = d])
											}; 


add_connection : (s : { v : int | true}) 
					-> (r : { v : int | true}) -> 
									State {
										\(h : heap).
											\(D : [int]).
											didsel (h, dtab) = D =>	
											(device (D, s) = true /\ 
											device (D, r) = true)	
											}
											v : {v : unit | true}
											{\(h: heap),(v : unit),(h': heap).
												\(D : [int]), (D' : [int]),(CS : [srpair]),(CS' : [srpair]).
												didsel (h', dtab) = didsel (h, dtab) /\
												dcssel (h', cstab) = CS' /\
												cansend (CS', s, r) = true /\
												consize (CS', s) == consize (CS, s) + 1  /\
												((cansend (CS, r, s) = true) => 
													(bidirectional (CS', s, r) = true))
											}; 



make_central : (d : { v : int | true}) -> State {
								\(h : heap).
									\(D : [int]).
										didsel (h, dtab) = D =>	
										device (D, d) = true	
										}
											v :  { v : unit | true}
										 { \(h: heap),(v : unit),(h': heap).
												\(D : [int]), (CS : [srpair]), (CS' : [srpair]).
										 		didsel (h', dtab) = didsel (h, dtab) /\
												dcssel (h', cstab) = CS' /\
												central (CS', d) = true /\
												consize (CS', d) == dsize (D) + 1  
										 };


delete_device : (d : { v : int | true}) -> 
								(y : { v : int | not [v=d]}) -> 
								State {\(h : heap).
											\(D : [int]),(CS : [srpair]).
											(didsel (h, dtab) = D /\
											dcssel (h, cstab) = CS )=>	
											(
												not [d=y] /\
												device (D, d) = true /\ 
												device (D, y) = true /\ 
												central (CS, y) = true
												)}
									v : {v : unit | true}
								 { \(h: heap),(v : unit),(h': heap).
										\(D : [int]), (D' : [int]).
										 didsel (h', dtab) = D' /\
										 dcssel (h', cstab) = CS' /\
										 device (D', d) = false /\
										 central (CS', y) = true /\
										 uniquelist (D') = true 
								 };		 


goal : (d : { v : int | true}) -> 
	   (x : { v : int | not [v = d]}) -> 		
	 				State {\(h: heap).
								\(D : [int]).
								not [d=x] /\
 								didsel (h, dtab) = D /\ 
								device (D, d) = true /\
								device (D, x) = true } 
								v : {v : int | true} 
		 						{\(h: heap),(v : int),(h': heap).
		 							\(D: [int]),(D' : [int]). 
		 							didsel (h', dtab) = D' =>	
									device (D', d) = false
		 						};
