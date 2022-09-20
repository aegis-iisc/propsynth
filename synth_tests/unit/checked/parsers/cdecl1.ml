Ty : [string];
Id : [string];
types : ref [string];
ids :  ref [string]; 
	
type decl = Typedecl of tdecl
			| ExternVar of externvar
			| ExternFun of externfun  
			


type tdecl = Tdecl of {typexp : typeexp; tname : string}			


type externvar = Evar of {typexp : typeexp; vname : string}

type externfun = Efun of {returnte : typeexp; fname : id; args : id list}


typeexp : State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    disjoint (Id, Ty) = true
                }
                    v : typeexpr
                {\(h : heap), (v : typeexpr), (h' : heap).
                    \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                    idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty'/\
                    disjoint (Id', Ty') = true
                    
                };    
            
rawident : State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    disjoint (Id, Ty) = true
                }
                    v : string
                {\(h : heap), (v : string), (h' : heap).
                    \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                    idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty'/\
                    disjoint (Id', Ty') = true
                    
                };
             

many_rawident : State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    disjoint (Id, Ty) = true
                }
                    v : [string]
                {\(h : heap), (v : [string]), (h' : heap).
                    \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                    idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty'/\
                    disjoint (Id', Ty') = true
                    
                };


mem_id : x : string -> { v : bool | 
                                \(h : heap), (v : string), (h' : heap).
                                   \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                                      idsel (h', ids) = Id' /\
                                      idsel (h, ids) = Id /\
                                      tysel (h, types) = Ty /\
                                      tysel (h', types) = Ty'/\
                                      Id' = Id /\ Ty' = Ty /\
                                      [v == true] <=> memid (Id', x) = true
									  [v == false] <=> memid (Id', x) = false
                        }; 


mem_types : x : string -> { v : bool | 
                                \(h : heap), (v : string), (h' : heap).
                                   \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                                      idsel (h', ids) = Id' /\
                                      idsel (h, ids) = Id /\
                                      tysel (h, types) = Ty /\
                                      tysel (h', types) = Ty'/\
                                      Id' = Id /\ Ty' = Ty /\
                                      [v == true] <=> memtypes (Ty', x) = true
									  [v == false] <=> memtypes (Ty', x) = false
                        }; 





append_Id : (ss : {v : [string] | true}) -> 
                 State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    memid (Id, s) = false
                }
                    v : unit
                {\(h : heap), (v : unit), (h' : heap).
                    \(Id : [string]),(Id' : [string]).
                    idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = tysel (h', types) = Ty'/\
                    memid (Id', s) = true /\
				    size (Id') == size (Id) + 1
				 };    


add_Id : (s : {v : string | true}) -> 
                 State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    memid (Id, s) = false
                }
                    v : unit
                {\(h : heap), (v : unit), (h' : heap).
                    \(Id : [string]),(Id' : [string]).
                    idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = tysel (h', types) = Ty'/\
                    memid (Id', s) = true /\
				    size (Id') == size (Id) + 1
				 };    



add_Type : (s : {v : string | true}) -> 
                 State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    memtypes (Ty, s) = false
                }
                    v : unit
                {\(h : heap), (v : unit), (h' : heap).
                    \(Ty : [string]),(Ty' : [string]).
                    idsel (h', ids) = idsel (h, ids) /\
                    tysel (h, types) = Ty
                    tysel (h', types) = Ty'/\
                    memtypes (Ty', s) = true /\
				    size (Ty') == size (Ty) + 1
				 };    


(*query1*)

type_declaration : 
				{\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    disjoint (Id, Ty) = true
                }
                v : tdecl 		
	 	 	    {   \(h : heap), (v : typeexpr), (h' : heap).
                    \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                    (idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty') => 
                 

	 	 	    	(disjoint (Id', Ty') = true /\ 
	 	 	    	 size (Ty') = size (Ty) + 1
	 	 	    	/\ size (Id') = size(Id))
	 	 	     \/ 
	 	 	    	 (disjoint (Id', Ty') = true /\ 
	 	 	    	 size (Ty') = size (Ty)
	 	 	    	/\ size (Id') = size(Id)
                      )
				};



type_declaration = 
                      (**correct *)  
			    	_ <- TYPEDEF;
			    	typeexp <- typeexp;
			    	id <- rawident;
			    	(*we cannot call the conrtuctor right away*)
			    	let b = mem_id id;
			    	if (!b) then 
				    	(*add identifier id has the same type but will be discarded*)
				    	add_Type id
				    	Tdecl {typeexp; id}
				    else 	
                        skip

                    (*incorrect : breaks the post condition size Ty' = size Ty +1 as well as disjoint in post-heap*)
                    let b = mem_id id;
			    	if (!b) then 
				    	add_Id  id
				    	Some Tdecl {typeexp; id}
				    else 	
                        skip
                    (*incorrect : breaks disjointness in post-heap *)
                    let b = mem_types id;
			    	if (!b) then 
				    	add_Type id
				    	Tdecl {typeexp; id}
				    else 	
                        skip

                    (*incorrect : breaks size on types in the post heap , but disjointness is implied*)
                    let b = mem_types id;
			    	if (!b) then 
				    	add_Id id
				    	Tdecl {typeexp; id}
				    else 	
                        skip





(*query2*)

externvar_declaration : 
				State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    disjoint (Id, Ty) = true
                }
                v : externvar 		
	 	 	    {   \(h : heap), (v : externvar), (h' : heap).
                    \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]).
                    (idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty') => 
                 

	 	 	    	(disjoint (Id', Ty') = true /\ 
	 	 	    	 size (Ty') = size (Ty)
	 	 	    	/\ size (Id') = size(Id) + 1)
	 	 	     \/ 
	 	 	    	 (disjoint (Id', Ty') = true /\ 
	 	 	    	 size (Ty') = size (Ty)
	 	 	    	/\ size (Id') = size(Id)
                      )
				};


externvar_declaration = 
                      (**correct *)  
			    	_ <- EXTERN;
			    	typeexp <- typeexp;
			    	id <- rawident;
			    	(*we cannot call the conrtuctor right away*)
			    	let b = mem_types id;
			    	if (!b) then 
				    	(*add identifier id has the same type but will be discarded*)
				    	add_Id id
				    	Evar {typeexp; id}
				    else 	
                        skip


(*extern <return_type> <function_name>(<parameter_list>);*)
(*query3*)
var extern_fun_decl : 
            State {\(h : heap).
				\(Id : [string]), (Ty : [string]).
                   (idsel (h, ids) = Id /\
                    tysel (h, types) = Ty) =>  
                    disjoint (Id, Ty) = true
                }
                v : externfun 		
	 	 	    {   \(h : heap), (v : externfun), (h' : heap).
                    \(Id : [string]), (Ty : [string]), (Id' : [string]), (Ty' : [string]), (Args : [string]).
                    (idsel (h', ids) = Id' /\
                    idsel (h, ids) = Id /\
                    tysel (h, types) = Ty /\
                    tysel (h', types) = Ty'
                    args (v) = Args 
                    ) => 


	 	 	    	(disjoint (Id', Ty') = true /\ 
	 	 	    	 size (Ty') = size (Ty)/\ 
                     size (Id') > size(Id)  /\
                     elems (Id') = elems (Id) u elems (Args) 
                    )
	 	 	     \/ 
	 	 	    	 (disjoint (Id', Ty') = true /\ 
	 	 	    	  size (Ty') = size (Ty)
	 	 	    	/\ size (Id') = size(Id)
                      )
				};



externfun_declaration = 
                      (**correct *)  
			    	_ <- EXTERN;
			    	typeexp <- typeexp;
			    	id <- rawident;
			    	args <- many_rawident;
                    (*we cannot call the constuctor right away*)
			    	let b <- mem_types id;
			    	if (!b) then 
				    	(*add identifier id has the same type but will be discarded*)
				    	add_Id id
				    	append_Id args;   
                        Efun {typeexp; id;args}
				    else 	
                        skip
