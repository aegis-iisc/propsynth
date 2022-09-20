(*The grammar for C-decl*)
(*consider a global state 
	types = ref [] : (string list) ref
	identifiers = ref [] : (string list) ref 
	*)
decl := "typedef" .typeexpr .
		id=rawident [¬ id ∈ (!identifiers)]
		{types.add id}
		| "extern" . typeexpr . id = rawident 
			(*this is erased*)
			[not id \in (identifiers) /\ not id in (types)] {identifiers.add id}
		| ..


typename := x = rawident [x ∈ (!types)]{return x}

typeexp := "int" | "bool"

expr := 	| 'ampersand' . expr
			| id=rawident []{identifiers.add id ; return id}

program := many decl . many expr

rawident := token_identifier


(* library

type decl = Typedecl of tdecl
			| ExternVar of externvar
			| ExternFun of externfun  
			| ...

type tdecl = Tdecl of {typexp : typeexp; tname : id}			

type externvar = Evar of {typexp : typeexp; vname : id}

type externfun = Efun of {returnte : typeexp; fname : id; args : id list}

val mem : l : id list ref -> x : id -> { v : bool | [v == true] <=> Mem (l, x) 
													[v == false] <=> not Mem (l, x)} 

val mem_weak : l : id list ref -> x : id -> { v : bool | [v == true] => Mem (l, x) 
													} 

val add_unique : l : id list ref -> x : id -> {not Mem (l, x)} v : unit {Mem (l, x)}



val add : l : id list ref -> x : id -> {true} v : unit {Mem (l, x)}

Disjoint l1 l2 = 
		 
		 _ [] = true
		 [], _ = true 
		 x :: xs , ys = Disjoint xs ys /\ 
		 					not Mem (ys, x)  

		 xs , y :: ys = Disjoint xs ys /\ 
		 					not Mem ( xs, y)  
					
*)

(*query1*)
type_declaration : 
				{
				disjoint (Types, Identifiers) = true /\ (empty (Inp) = false 
	 	 	 	 v : tdecl 		
	 	 	    { 
	 	 	    	Elems (y) C= Elems (inp) /\
	 	 	    	Disjoint (types', identifiers') 
	 	 	    	/\ len (types') = len (types) + 1
	 	 	    	/\ len (identifiers') = len (identifiers)
	 	 	    	/\ len (inp') < len (inp)
	 	 	    \/ 
	 	 	    	 Disjoint (types', identifiers')
	 	 	    	 len (types') = len (types) 
	 	 	    	/\ len (identifiers') = len (identifiers)
	 	 	    	/\ len (inp') <= len (inp)
				}

type_declaration = 
			    [[
			    	_ <- TYPEDEF;
			    	typeexp <- typeexp;
			    	id <- rawident;
			    	(*we cannot call the conrtuctor right away*)
			    	(*mem id types has the same shape but will be discared*)
			    	let b = mem id identifiers;
			    	if (!b) then 
				    	(*add identifier id has the same type but will be discarded*)
				    	add types id
				    	Some Tdecl {typeexp; id}
				    else 	
				    
				    	None	


				    (*
				    Multiple incorrect programs	
				    1.
				    let b = mem id types;
			    	if (!b) then 
				    	(*add identifier id has the same type but will be discarded*)
				    	add types id
				    	Some Tdecl {typeexp; id}
				    else 	
				    	None
				    
				    2. 
				    let b = mem id types;
			    	if (!b) then 
				    	(*add identifier id has the same type but will be discarded*)
				    	add identifiers id
				    	Some Tdecl {typeexp; id}
				    else 	
				    	None
				    
				    3.let b = mem id identifiers;
			    	if (b) then 
				    	(*add identifier id has the same type but will be discarded*)
				    	add types id
				    	Some Tdecl {typeexp; id}
				    else 	
				    	None
				    
				    ...
				    
				    *)	
	
				    ]]	 	


(*query2*)
extern_var_decl :
				{Disjoint (types, identifiers) /\ not Empty inp 
	 	 	 	 v : externvar option		
	 	 	    { 
	 	 	    match v with 
	 	 	     | Some y =>
	 	 	    	Elems (y) C= Elems (inp) /\
	 	 	    	Disjoint (types', identifiers') 
	 	 	    	Unique (identifiers) /\
	 	 	    	/\ len (types') = len (types)
	 	 	    	/\ len (identifiers') = len (identifiers) + 1
	 	 	    	/\ len (inp') < len (inp)
	 	 	    | None => 
	 	 	    	 Disjoint (types', identifiers') /\
	 	 	    	 len (types') = len (types) 
	 	 	    	/\ len (identifiers') = len (identifiers)
	 	 	    	/\ len (inp') <= len (inp)}

extern_var_decl = 

				 [[
			    	_ <- EXTERN;
			    	typeexp <- typeexp;
			    	id <- rawident;
			    	(*we cannot call the conrtuctor right away*)
			    	(*mem id types has the same shape but will be discared*)
			    	let b = mem id types;
			    	if (!b) then 
				    	(*add identifier id has the same type but will be discarded*)
				    	let b1 = mem id identifiers in 
				    	if (!b1) then 
				    		add_unique identifiers id
				    		Some Evar {typeexp; id}
				    	else 
				    		None 	
				    else 	
				    	None
				    


				    ]]	 	

(*extern <return_type> <function_name>(<parameter_list>);*)
(*query3*)
var extern_fun_decl : 
					{Disjoint (types, identifiers) /\ not Empty inp 
	 	 	 	 v : externfun option		
	 	 	    { 
	 	 	    match v with 
	 	 	     | Some y =>
	 	 	    	Elems (y) C= Elems (inp) /\
	 	 	    	/\ len (types') = len (types)
	 	 	    	/\ len (identifiers') > len (identifiers) 
	 	 	    	/\ len (inp') < len (inp)
	 	 	    | None => 
	 	 	    	 Disjoint (types', identifiers') /\
	 	 	    	 len (types') = len (types) 
	 	 	    	/\ len (identifiers') = len (identifiers)
	 	 	    	/\ len (inp') <= len (inp)}

(*query4*)
var extern_fun_decl_strong : 
					{Disjoint (types, identifiers) /\ not Empty inp 
	 	 	 	 v : externfun option		
	 	 	    { 
	 	 	    match v with 
	 	 	     | Some y =>
	 	 	    	Disjoint (types', identifiers')
	 	 	    	Elems (y) C= Elems (inp) /\
	 	 	    	/\ len (types') = len (types)
	 	 	    	/\ len (identifiers') > len (identifiers) 
	 	 	    	/\ len (inp') < len (inp)
	 	 	    | None => 
	 	 	    	 Disjoint (types', identifiers') /\
	 	 	    	 len (types') = len (types) 
	 	 	    	/\ len (identifiers') = len (identifiers)
	 	 	    	/\ len (inp') <= len (inp)}


(*query5*)
val decl :
				{Disjoint (types, identifiers) /\ not Empty inp 
	 	 	 	 v : decl option		
	 	 	    { 
	 	 	    match v with 
	 	 	     | Some y =>
	 	 	    	Disjoint (types', identifiers')
	 	 	    	Elems (y) C= Elems (inp) /\
	 	 	    	/\ len (types') >= len (types)
	 	 	    	/\ len (identifiers') >= len (identifiers) 
	 	 	    	/\ len (inp') < len (inp)
	 	 	    
	 	 	    | None => 
	 	 	    	 Disjoint (types', identifiers') /\
	 	 	    	 len (inp') <= len (inp)}


decl = 	 (*incorrect*)
		type_declaration 
			<|> (*we need to define the semantics of <|> in the synthesis algorithm*) 
		extern_var_decl 
			<|> 
		extern_fun_decl 	 	    	 
		(*correct*)
		type_declaration <|> extern_var_decl <|> extern_fun_decl_strong 	 	    	 
		