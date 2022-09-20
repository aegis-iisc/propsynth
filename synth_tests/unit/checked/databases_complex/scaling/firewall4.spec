q : ref queue;
num : ref int;
Q : queue;
Q' : queue;

fresh_el :  State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Q' : queue),(Q : queue).
				sel (h', num) == sel (h, num) + 1 /\
				qsel (h', q) = Q' /\  
				qsel (h, q) = Q /\
				qsize (Q') = qsize(Q) /\
				qmem (Q', v) = false};

add : (x : { v : int | true})   -> State {\(h : heap). 
									\(Q : queue).
									qsel (h, q) = Q => 
									qmem (Q, x) = false}
									v : {v : unit | true}
									{\(h : heap), (v : unit), (h' : heap).
									\(Q : queue), (Q' : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									qmem (Q', x) = true /\
									qsize (Q') == qsize (Q) + 1 /\
									sel (h', num) == sel (h, num)};


take : 	State {\(h : heap).	
				\(Q : queue).
									qsel (h, q) = Q => 
									qsize (Q) > 0}
									v : {v : int | true}
									{\(h : heap), (v : int), (h' : heap).
									\(Q : queue), (Q' : queue).
									qsel (h', q) = Q'/\
									qsel (h, q) = Q /\
									qmem (Q', v) = false /\
									qsize (Q') == qsize (Q) -- 1 /\
									sel (h', num) == sel (h, num)};



peek : State {\(h : heap). \(Q: queue). (qsel (h, q) = Q => qsize (Q) > 0)}
							  v : {v : int | true}
							 {\(h : heap), (v : int), (h' : heap).
							 \(Q : queue), (Q' : queue).
								qsel (h', q) = Q'/\
								qsel (h, q) = Q /\
								qmem (Q', v) = true /\
								sel (h', num) == sel (h, num) /\
								Q' = Q
							  };



clear :	State {\(h : heap). 
								\(Q: queue).
								(qsel (h, q) = Q
								 => qsize (Q) > 0)}
							  v : {v : unit | true}
							 {\(h : heap), (v : unit), (h' : heap).
							 	\(Q : queue), (Q' : queue).
								qsel (h', q) = Q' /\
								qsel (h, q) = Q /\
								sel (h', num) == sel (h, num) /\
								empty (Q') = true /\
								qsize (Q') == 0
							  };



tbl : ref [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;

create_pair : (p1 : {v : int | true}) -> 
				(p2 : {v : float | true}) -> { v : pair | true}; 

fresh_str : State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				ilssel (h', tbl) = Tbl' /\  
				ilssel (h', tbl) = ilssel (h, tbl) /\
				mem (Tbl', v) = false};



size : State 
			{\(h : heap). true} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]),(Tbl : [int]).
				ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl' /\  
				v == size (Tbl) /\
				ilssel (h', tbl) = ilssel (h, tbl)};


average_len : State  {\(h : heap).
					\(Tbl : [int]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				ilssel (h', tbl) = 	ilssel (h, tbl) 
				/\ 
				sel (h', num) == sel (h, num)
				};



add_tbl : (s : {v : int | true}) ->  
			State  {\(h : heap).
				\(Tbl : [int]). 
				ilssel (h, tbl) = Tbl =>  
				(mem (Tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				mem (Tbl', s) = true /\
				size (Tbl') == size (Tbl) + 1 /\
				sel (h', num) == sel (h, num) 
				};




D : [nlrecord];
D' : [nlrecord];
d : ref [nlrecord];





select : (n  : { v : string | true})
							-> (u : { v :string | true}) -> 
									 
									 State {\(h : heap).
									 	\(D : [nlrecord]).
									 	true									 	} 
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
							subscribed (D', n, u) = false 		
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




dtab : ref [int];
cstab : ref [srpair];
D : [int];
CS : [srpair];
D' : [int];
CS' : [srpair];


add_device : (d : { v : int | true}) -> State {
										\(h : heap).	
										\(D : [int]), (CS : [srpair]).
										didsel (h, dtab) = D =>		
										device (D, d) = false}
										v : {v : unit | true}
										{\(h: heap),(v : unit),(h': heap).
											\(D : [int]), (D' : [int]).
											dissel (h, dtab) = D /\		
											didsel (h', dtab) = D' /\
											dcssel (h', cstab) = dcssel (h, cstab) /\
											device (D', d) = true	/\
											dsize (D') == dsize (D) + 1 	
										};  




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
											device (D, r) = true)	
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
								(y : { v : int | not [v=d]}) -> 
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
										\(D : [int]), (D' : [int]).
										 didsel (h', dtab) = D' /\
										 dcssel (h', cstab) = CS' /\
										 device (D', d) = false /\
										 central (CS', y) = true 
								 };		 



fuel : ref int;
Len : int;
Tys : quad;
Con : [char];



createTriple  :  (x : { v : int | true}) ->  
				 (y : { v : quad | true}) -> 
				 (z : {v : [char] | true}) -> 
				 	{v : pngtriple | length (z) + 4 == x}; 	

getFuel : (u :{ v : unit | true})  -> 
				State {\(h : heap).true} 
				v : { v : int | true} 
				{\(h: heap),(v : int),(h': heap).
					sel (h', fuel) == sel (h, fuel) /\
					sel (h', fuel) == v};


putFuel : (x : { v : int | true})-> 
			State {\(h : heap).
				true} 
				v : { v : unit | true} 
				{\(h: heap),(v : unit),(h': heap).
					sel (h', fuel) == x};


natural : State {\(h : heap).
				true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					sel (h', fuel) == sel (h, fuel) /\
					asciinumber (v) = true};



length : State {\(h : heap).
				sel (h, fuel) == 0} 
				v : { v : int | true} 
			  	{\(h: heap),(v : int),(h': heap).
					sel (h', fuel) == v /\
                    [v > 4] };




content : State {\(h : heap).
				sel (h, fuel) > 0} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					sel (h', fuel) == sel (h, fuel) -- length (v)
					/\ sel (h', fuel) == 0};



typespec : State {\(h : heap).
				sel (h, fuel) > 4} 
				v : { v : quad | true} 
			  	{\(h: heap),(v : quad),(h': heap).
					sel (h',fuel) == sel (h, fuel) -- 4};




types : ref [string];
ids :  ref [string]; 

Ty : [string];
Id : [string];
Ty' : [string];
Id' : [string];



createFun : (rt : {v  : typeexpr| true}) -> (fn : {v : string | true}) -> 
                (args : {v  : [string]| true}) ->   {v : externfun | true};


typeexp : State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    ldisjoint (Id, Ty) = true
                }
                    v : {v : typeexpr  | true}
                 {\(h : heap), (v : typeexpr), (h' : heap).
                    \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                    idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty'/\
                    ldisjoint (Id', Ty') = true
                    
                };    
            
rawident : State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    ldisjoint (Id, Ty) = true
                }
                   v : { v : string | true}
                {\(h : heap), (v : string), (h' : heap).
                    \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                    idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty'/\
                    ldisjoint (Id', Ty') = true
                    
                };
             

 

many_rawident : State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    ldisjoint (Id, Ty) = true
                }
                    v : [string]
                {\(h : heap), (v : [string]), (h' : heap).
                    \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                    idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty'/\
                    ldisjoint (Id', Ty') = true
                    
                };



mem_id : (x : {v  : string | true}) -> 
                State {\(h:heap). true}
                    v : { v : bool | true} 
				{\(h: heap),(v : bool),(h': heap).
                    \(Id : [string]), (Id' : [string]).
                        idsel (h', ids) = Id' /\
                        idsel (h, ids) = Id /\
                        tysel (h, types) = tysel (h', types) /\
                        Id' = Id /\
                        ([v = true] <=> memids (Id', x) = true) /\
						([v = false] <=> memids (Id', x) = false)
                        }; 




mem_types : (x : {v  : string | true}) -> 
                State {\(h:heap). true}
                    v : { v : bool | true} 
				{\(h: heap),(v : bool),(h': heap).
                    \(Ty : [string]), (Ty' : [string]).
                    idsel (h', ids) =  idsel (h, ids) /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty'/\
                    Ty' = Ty /\
                    ([v = true] <=> memtypes (Ty', x) = true) /\
					([v = false] <=> memtypes (Ty', x) = false)
                    }; 





add_Id : (s : {v : string | true}) -> 
                 State {\(h : heap).
				\(Id : [string]).
                   (idsel (h, ids) = Id => 
                    memids (Id, s) = false)
                }
                    v : {v : unit | true}
                {\(h : heap), (v : unit), (h' : heap).
                    \(Id : [string]),(Id' : [string]).
                    idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = tysel (h', types)/\
                    memids (Id', s) = true /\
				    slsize (Id') == slsize (Id) + 1
				 };    





add_Type : (s : {v : string | true}) -> 
                 State {\(h : heap).
				\(Ty : [string]).
                    (tysel (h, types) = Ty =>  
                    memtypes (Ty, s) = false)
                }
                    v : { v : unit | true}
                {\(h : heap), (v : unit), (h' : heap).
                    \(Ty : [string]),(Ty' : [string]).
                    idsel (h', ids) = idsel (h, ids) /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty'/\
                    memtypes (Ty', s) = true /\
				   slsize (Ty') ==slsize (Ty) + 1
 
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
