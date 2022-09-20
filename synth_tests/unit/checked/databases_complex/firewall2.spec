dtab : ref [int];
cstab : ref [srpair];
D : [int];
CS : [srpair];
D' : [int];
CS' : [srpair];

qualifier consize : [srpair] :-> int :-> int;
qualifier uniquelist : [int] :-> bool;
qualifier bidirectional : [srpair] :-> int :-> int :-> bool;



diff_device : (d : { v : int | true}) -> State {
										\(h : heap).
											\(D : [int]), (CS : [srpair]).
											didsel (h, dtab) = D =>	
											dsize (D) > 1}
											v : {v : int | true}
											{\(h: heap),(v : int),(h': heap).
												\(D : [int]), (D' : [int]),(CS : [srpair]),(CS' : [srpair]).
												didsel (h', dtab) = didsel (h, dtab) /\
												dcssel (h', cstab) =  dcssel (h, cstab) /\
												device (D', v) = true /\ 
												not ([v = d])
											}; 



add_connection : (d : { v : int | true}) 
					-> (x : { v : int | not [v = d]}) -> 
									State {
										\(h : heap).
											\(D : [int]).
											didsel (h, dtab) = D =>	
											(device (D, d) = true /\ 
											device (D, x) = true)	
											}
											v : {v : unit | true}
											{\(h: heap),(v : unit),(h': heap).
												\(D : [int]), (D' : [int]),(CS : [srpair]),(CS' : [srpair]).
												didsel (h', dtab) = didsel (h, dtab) /\
												dcssel (h', cstab) = CS' /\
												cansend (CS', d, x) = true /\
												consize (CS', d) == consize (CS, d) + 1  /\
												((cansend (CS, x, d) = true) => 
													(bidirectional (CS', d, x) = true))
										
											}; 



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

make_central : (d : { v : int | true}) -> State {
								\(h : heap).
									\(D : [int]).
										didsel (h, dtab) = D =>	
										device (D, d) = true	
										}
											v :  { v : unit | true}
										 { \(h: heap),(v : unit),(h': heap).
												\(D : [int]), (CS : [srpair]), (CS' : [srpair]).
										 		didsel (h, dtab) = D /\
												 didsel (h', dtab) = didsel (h, dtab) /\
												dcssel (h', cstab) = CS' /\
												central (CS', d) = true /\
												consize (CS', d) == dsize (D) + 1  
										 };



delete_device : (d : { v : int | true}) -> 
				(y : { v : int | not [v = d]}) -> 
								State {\(h : heap).
											\(D : [int]),(CS : [srpair]).
											(didsel (h, dtab) = D /\
											dcssel (h, cstab) = CS )=>	
											(
												device (D, d) = true /\ 
												device (D, y) = true /\ 
												central (CS, y) = true 
                                          		)}
									v : {v : unit | true}
								 { \(h: heap),(v : unit),(h': heap).
										\(D : [int]), (D' : [int]),(CS' : [srpair]).
										 didsel (h', dtab) = D' /\
										 dcssel (h', cstab) = CS' /\
										 device (D', d) = false /\
                                         device (D', y) = true /\
                                         central (CS', d) = false /\
										 central (CS', y) = true /\
										 uniquelist (D') = true 
								 };		 


goal : (d : { v : int | true}) -> 
	   (x : { v : int | not [v = d]}) -> 		
	 				State {\(h: heap).
								\(D : [int]), (CS : [srpair]).
								didsel (h, dtab) = D /\	
								dcssel (h, cstab) = CS /\
                                device (D, d) = true /\
								device (D, x) = false /\
								uniquelist (D) = true   
								} 
								v : {v : unit | true} 
		 						{\(h: heap),(v : unit),(h': heap).
		 							\(D' : [int]),(CS' : [srpair]). 
		 							(didsel (h', dtab) = D' /\
									dcssel (h', cstab) = CS' ) =>  
									
									( 
									device (D', x) = true /\ 
									cansend (CS', d, x) = true) 
		 						};

