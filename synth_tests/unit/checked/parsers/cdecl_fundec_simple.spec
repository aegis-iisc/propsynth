
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
				 };    


goal :          
			State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\  
                    ldisjoint (Id, Ty) = true)
                }
                v : {v : externfun | true}		
	 	 	    {   \(h : heap), (v : externfun), (h' : heap).
                    \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                    (idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty') => 
                 

	 	 	    	(ldisjoint (Id', Ty') = true)
	 	 	     				};

            