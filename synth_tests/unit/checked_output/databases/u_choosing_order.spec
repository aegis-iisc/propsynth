dtab : ref [int];
cstab : ref [srpair];
D : [int];
CS : [srpair];
D' : [int];
CS' : [srpair];





add_connection : (d : { v : int | true}) 
					-> (x : { v : int | not [v = d]}) -> 
									State {
										\(h : heap).
											\(D : [int]).
											didsel (h, dtab) = D =>	
											(device (D, d) = true /\ 
											device (D, x) = true )	
											}
											v : {v : unit | true}
											{\(h: heap),(v : unit),(h': heap).
												\(D : [int]), (D' : [int]),(CS : [srpair]),(CS' : [srpair]).
												didsel (h', dtab) = didsel (h, dtab) /\
												dcssel (h', cstab) = CS' /\
												cansend (CS', d, x) = true 
											}; 



add_device : (d : { v : int | true}) -> State {
										\(h : heap).	
										\(D : [int]), (CS : [srpair]).
										didsel (h, dtab) = D =>		
										device (D, d) = false}
										v : {v : unit | true}
										{\(h: heap),(v : unit),(h': heap).
											\(D : [int]), (D' : [int]).
											didsel (h, dtab) = D /\		
											didsel (h', dtab) = D' /\
											dcssel (h', cstab) = dcssel (h, cstab) /\
											device (D', d) = true	/\
											dsize (D') == dsize (D) + 1 	
										};  


make_central : (d : { v : int | true}) -> State {
										\(h : heap).
											\(D : [int]).
											didsel (h, dtab) = D =>	
											device (D, d) = true	
											}
											v :  { v : unit | true}
										 { \(h: heap),(v : unit),(h': heap).
												\(CS : [srpair]), (CS' : [srpair]).
										 		didsel (h', dtab) = didsel (h, dtab) /\
												dcssel (h', cstab) = CS' /\
												central (CS', d) = true
										 };






goal : (d : { v : int | true}) -> 
	   (x : { v : int | not [v = d]}) -> 		
	 				State {\(h: heap).
								\(D : [int]), (CS : [srpair]).
								didsel (h, dtab) = D /\	
								dcssel (h, cstab) = CS /\
                                device (D, d) = true /\
								device (D, x) = false   
								} 
								v : {v : unit | true} 
		 						{\(h: heap),(v : unit),(h': heap).
		 							\(D' : [int]),(CS' : [srpair]). 
		 							(didsel (h', dtab) = D' /\
									dcssel (h', cstab) = CS' ) =>  
									
									(device (D', d) = true /\ 
									device (D', x) = true /\ 
									cansend (CS', d, x) = true) 
		 						};

