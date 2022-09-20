
dtab : ref [int];
cstab : ref [srpair];
D : [int];
CS : [srpair];
D' : [int];
CS' : [srpair];





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


add_connection : (s : { v : int | true}) 
					-> (r : { v : int | true}) -> 
									State {
										\(h : heap).
											\(D : [int]).
											didsel (h, dtab) = D =>	
											(device (D, s) = true /\ 
											device (D, r) = true /\
											not [s=r])	
											}
											v : {v : unit | true}
											{\(h: heap),(v : unit),(h': heap).
												\(D : [int]), (D' : [int]),(CS : [srpair]),(CS' : [srpair]).
												didsel (h', dtab) = didsel (h, dtab) /\
												dcssel (h', cstab) = CS' /\
												cansend (CS', s, r) = true 
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





delete_device : (d : { v : int | true}) -> 
								(x : { v : int | true}) -> 
								State {\(h : heap).
											\(D : [int]),(CS : [srpair]).
											(didsel (h, dtab) = D /\
											dcssel (h, cstab) = CS )=>	
												(device (D, d) = true /\ 
												device (D, x) = true /\ 
												central (CS, x) = true /\
												not [d=x]
												)}
									v : {v : unit | true}
								 { \(h: heap),(v : unit),(h': heap).
										\(D : [int]), (D' : [int]).
										 didsel (h', dtab) = D' /\
										 dcssel (h', cstab) = CS' /\
										 device (D', d) = false /\
										 central (CS', x) = true 
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




goal : (d : { v : int | true}) -> 
	   			State {\(h: heap).
								\(D : [int]), (CS : [srpair]).
								didsel (h, dtab) = D /\	
								device (D, d) = true /\
								dsize (D) > 0
								} 
								v : {v : unit | true} 
		 						
								 {\(h: heap),(v : unit),(h': heap).
		 							\(D' : [int]),(CS' : [srpair]),(y:int). 
		 							(
										didsel (h', dtab) = D' /\
										dcssel (h', cstab) = CS' 
									) =>  
									
									(
									not [y = d] /\	
									device (D', d) = false /\ 
									device (D', y) = true /\ 
									central (CS', y) = true
									) 
		 						};

