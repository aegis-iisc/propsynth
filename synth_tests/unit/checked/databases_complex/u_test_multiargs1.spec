dtab : ref [int];
cstab : ref [srpair];
D : [int];
CS : [srpair];
D' : [int];
CS' : [srpair];



make_central : (d : { v : int | true}) -> State {
										\(h : heap).
											\(D : [int]), (CS : [srpair]).
											(didsel (h, dtab) = D /\ dcssel (h, cstab) = CS) =>	
											(device (D, d) = true /\ central (CS, d) = false)											}
											v :  { v : unit | true}
										 { \(h: heap),(v : unit),(h': heap).
												\(CS : [srpair]), (CS' : [srpair]).
										 		didsel (h', dtab) = didsel (h, dtab) /\
												dcssel (h', cstab) = CS' /\
												central (CS', d) = true
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
										 central (CS', y) = true 
								 };		 


goal : (d : { v : int | true}) -> 
	   (x : { v : int | not [v=d]}) -> 		
	 				State {\(h: heap).
								\(D : [int]),(CS : [srpair]).
								didsel (h, dtab) = D /\ 
								device (D, d) = true /\
								dcssel (h, cstab) = CS /\
                                device (D, x) = true /\
                                central (CS, d) = true /\
                                central (CS, x) = false} 
								v : {v : unit | true} 
		 						{\(h: heap),(v : unit),(h': heap).
		 							\(D: [int]),(D' : [int]),(CS' : [srpair]).
                                    (dcssel (h', cstab) = CS' /\   
		 							didsel (h', dtab) = D') =>	
									(device (D', d) = false /\ 
                                    device (D', x) = true /\ 
                                    central (CS', d) = false /\
                                    central (CS', x) = true)
		 						};
