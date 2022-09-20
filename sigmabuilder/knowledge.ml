module Syn = Lambdasyn 
open SpecLang 
module Gamma = Environment.TypingEnv
module Sigma = Environment.Constructors 
module P = Predicate

exception NoMappingForVar of string
    
(*A var to refinement type mapping typing environment*)
(*TODO : In  order to improve performance , try using Map or HashTables*)
module DiffPredicate = struct
	type gammaCap =  T of {gamma : Gamma.t; sigma : Sigma.t; delta : P.t}
	(*NOTE : May be keeping separate predicates for conjunts and disjuncts will be a better idea *)
	type t = DP of {gammacap : gammaCap; learntConj : P.t ; 
							   learntDisj : P.t ;	previous : P.t}

	(*A very imprecise check 
	to see if we have learnt some D(ci) conjuncts*)
	let rec noConjuncts p = 
		match p with 
			| Predicate.Disj (p1, p2) -> 
					noConjuncts p1 && noConjuncts p2
			| Predicate.Conj (p1, p2) -> 
					  false
			| _ -> true

	let equalGammaCap g1 g2 = true 

	let emptyGammaCap = T {gamma= Gamma.empty; sigma = Sigma.empty; delta = P.True}

	let getGamma gcap = 
		let T {gamma ;sigma ;delta} = gcap in 
		gamma

	let getSigma gcap = 
		let T {gamma ;sigma ;delta} = gcap in 
		sigma
	let getDelta gcap = 
		let T {gamma ;sigma ;delta} = gcap in 
		delta 
			
	

	let addGamma t varbound rtibound = 
	
		let T {gamma ;sigma ;delta} = t in 
				
		let gamma = Gamma.add gamma varbound rtibound in 
		T {gamma=gamma;sigma =sigma;delta=delta}

    let updateGamma t g' = 
    	let T {gamma;sigma ;delta} = t in 
				
		let gamma =  g' in 
		T {gamma=gamma;sigma =sigma;delta=delta}
	


	let getGammaCap dpred = 
		let DP {gammacap;_} = dpred in 
		gammacap

	let getLearntConj dpred = 
		let DP {learntConj;_} = dpred in 
		learntConj
	

	let getLearntDisj dpred = 
		let DP {learntDisj;_} = dpred in 
		learntDisj

	let getPrevious dpred = 
		let DP {previous;_} = dpred in 
		previous
		
	let empty = DP {gammacap = emptyGammaCap; learntConj = P.True; learntDisj=P.False; previous = P.True}
	
	let gammaCapToString g = 
		(* let T {gamma;sigma;delta} = g in 
		 *)let str = 
			let gammaStr = "gamma TBU " (*Gamma.toString gamma*) in 
			let sigmaStr = "sigma TBU" in 
			let deltaStr = "delat TBU "(*Predicate.toString delta*) in 
			(" *******Gamma********** \n"^gammaStr^" \n *************Sigma**********\n  "^sigmaStr^"\n ************Delta ***********\n"^deltaStr) in 
		str	 

	let appendGammaCap gcap1 gcap2 = 
		let T {gamma= gamma1;sigma=sigma1;delta=delta1}  = gcap1 in 
		let T {gamma= gamma2;sigma=sigma2;delta=delta2}  = gcap2 in 
		(* let () = Printf.printf "%s" ("\n Gamma Before "^(Gamma.toString gamma2)) in 
		let () = Printf.printf "%s" ("\n Size Gamma Before "^(string_of_int (List.length (gamma2)))) in 
		 *)
		let nonOverlappingG2 = 
			List.filter (fun (vi, ti) -> not (Gamma.mem gamma1 vi)) gamma2 in 
		(* let () = Printf.printf "%s" ("\n Gamma After "^(Gamma.toString nonOverlappingG2)) in 
		let () = Printf.printf "%s" ("\n Size Gamma After "^(string_of_int (List.length (nonOverlappingG2)))) in  *)
		let nonOverlappingS2 =
			List.filter (fun (vi, ti) -> not (List.mem_assoc vi sigma1)) sigma2 in 
		T {gamma=gamma1@nonOverlappingG2 ; 
			sigma = sigma1@nonOverlappingS2 ; 
			delta= P.Conj (delta1, delta2)} 


	let toString t = 
	 let DP {gammacap;learntConj; learntDisj; previous} = t in 
	 let str = "\n -----------Gammacap-------------\n : "^(gammaCapToString gammacap) in 
	 let str = str^"\n --------------LearntConj-----------\n "^(Predicate.toString learntConj) in
	 let str = str^"\n --------------LearntDisj-----------\n "^(Predicate.toString learntDisj) in
	  let str = str^("\n -------------Previous--------\n" ^(Predicate.toString previous)) in 
	 str

	let equal t1 t2 = 
	 
	 (*TODO ??*)
	 true


	 let no_pollution t1 t2 = 
	 (*TODO ?? *)
	  true


	 let focusedUpdateGamma (dpred : t) (g : gammaCap) = 
		let DP {gammacap=gcap; learntConj=learntConj;
				learntDisj= learntDisj;
				previous= previous} = dpred in 
		assert (no_pollution  gcap g);
	    let gamma = appendGammaCap gcap g in 
	    DP {gammacap=gamma;
				learntConj=learntConj;
				learntDisj= learntDisj;
				previous=previous} 

	
	 let focusedUpdateLearntConj (dpred : t) (lConj : Predicate.t)= 
		let DP {gammacap=gcap; learntConj=learntConj;
				learntDisj= learntDisj;
				previous= previous} = dpred in 
		DP {gammacap=gcap; 
			learntConj=lConj;
			learntDisj= learntDisj;
			previous= previous}		


	 let focusedUpdateLearntDisj (dpred : t) (lDisj : Predicate.t)= 
		let DP {gammacap=gcap; learntConj=learntConj;
				learntDisj= learntDisj;
				previous= previous} = dpred in 
		DP {gammacap=gcap; 
			learntConj=learntConj;
			learntDisj= lDisj;
			previous= previous}		
		

	 let focusedUpdatePrevious (dpred : t) (p : Predicate.t) = 
		let DP {gammacap=gcap; 
				learntConj=learntConj;
				learntDisj= learntDisj;
				previous= previous} = dpred in 
		DP {gammacap=gcap; 
			learntConj=learntConj;
			learntDisj= learntDisj;
			previous= p}		
			
	(*gamma1, pred1 /\ gamma2, pred2 =  noOverlap(gamma1;gamma2), pred1/\ pred2*)
	let conjunction t1 t2 = 
		(*the pollution of gammas must be *)
		let DP {gammacap=gcap1; learntConj=learntConj1;
				learntDisj= learntDisj1;
				previous= previous1} = t1 in 
		let DP {gammacap=gcap2; 
				learntConj=learntConj2;
				learntDisj= learntDisj2;
				previous= previous2} = t2 in 
		assert (no_pollution  gcap1 gcap2);
		let gamma = appendGammaCap gcap1 gcap2 in 
		let learntConj = Predicate.Conj(learntConj1, learntConj2) in 
		let learntDisj = Predicate.Disj(learntDisj1, learntDisj2) in 
	
		let previous = Predicate.Conj (previous1, previous2) in 
		DP {gammacap=gamma;learntConj=learntConj;  learntDisj=learntDisj; 
		previous=previous} 


	let disjunction t1 t2 = 
		(*the pollution of gammas must be *)
		let DP {gammacap=gcap1; learntConj=learntConj1;
				learntDisj= learntDisj1;
				previous= previous1} = t1 in 
		let DP {gammacap=gcap2; 
				learntConj=learntConj2;
				learntDisj= learntDisj2;
				previous= previous2} = t2 in 
		assert (no_pollution  gcap1 gcap2);
		let gamma = appendGammaCap gcap1 gcap2 in 
		let learntConj = Predicate.Conj(learntConj1, learntConj2) in 
		let learntDisj = Predicate.Disj(learntDisj1, learntDisj2) in 
	
		let previous = Predicate.Conj (previous1, previous2) in 
		DP {gammacap=gamma;learntConj=learntConj;  learntDisj=learntDisj; 
		previous=previous} 


end

module DistinguisherMap = struct

module Component =
       struct
         type t = Var.t (*a variable capturing the  name*)
         let equal(t1,t2)  =  Var.equal t1 t2
       end

module Disntinguisher =
       struct
         (*Need to change later to scehema*)
         type t = DiffPredicate.t
         let equal (t1,t2) = DiffPredicate.equal t1 t2           
end

module Map   = Applicativemap.ApplicativeMap (Component) (Disntinguisher) 

type t = Map.t
let empty = Map.empty
let mem =  Map.mem
let find t var = 
    try (Map.find t var) 
  with 
  | (Map.KeyNotFound k) -> raise (NoMappingForVar k)

let add = fun t -> fun var rt -> Map.add t var rt
let remove = Map.remove
let replace = Map.replace 
let toString t =
List.fold_left (fun accstr (ci, dpi) -> (accstr^"\n "^(Var.toString ci)^" |-> "^(DiffPredicate.toString dpi))) " " t  

end 

module PathGammaMap = struct

	module ProgramPath =
       struct
         type t = Syn.path(*a variable capturing the  name*)
         let equal (t1,t2)  =  Syn.equalPath t1 t2 
         						
       end

	module Value =
       struct
         (*Need to change later to scehema*)
         type t = DiffPredicate.gammaCap
         let equal (t1,t2) = DiffPredicate.equalGammaCap t1 t2           
	end

module Map   = Applicativemap.ApplicativeMap (ProgramPath) (Value) 

type t = Map.t
let empty = Map.empty
let mem =  Map.mem
let find t var = 
    try (Map.find t var) 
  with 
  | (Map.KeyNotFound k) -> raise (NoMappingForVar (Syn.pathToString k))

let add = fun t -> fun var rt -> Map.add t var rt
let remove = Map.remove
let replace = Map.replace 

let toString t =
List.fold_left (fun accstr (pi, gammai) -> (accstr^"\n "^(Syn.pathToString pi)^" |-> "^(DiffPredicate.gammaCapToString gammai))) " " t  


end 


module PathChildrenMap = struct

module Key =
       struct
         type t = Syn.path(*a variable capturing the  name*)
         let equal (t1,t2)  =  Syn.equalPath t1 t2
end

module Value =
       struct
         (*a list of visited components*)
         type t = Var.t list
         let equal (t1, t2)  =  
   	 	  try 
        	List.fold_left2  
        	(fun accBool ci cj -> accBool && 
            	Var.equal ci cj) true t1 t2
    	  with 
        	Invalid_argument e-> false  

         let toString t = 
         	List.fold_left 
         	(fun accStr ci -> (accStr^" : "^(Var.toString ci))) "[ " t
        	
             
end

module Map   = Applicativemap.ApplicativeMap (Key) (Value) 

type t = Map.t
let empty = Map.empty
let mem =  Map.mem
let find t var = 
    try (Map.find t var) 
  with 
  | (Map.KeyNotFound k) -> raise (NoMappingForVar (Syn.pathToString k))

let add = fun t -> fun var rt -> Map.add t var rt
let remove = Map.remove
let replace = Map.replace 

let toString t =
List.fold_left (fun accstr (pi, childreni) -> (accstr^"\n "^(Syn.pathToString pi)^" |-> "^(Value.toString childreni))) " " t  


end 



module WPPathChildrenMap = struct

module Key =
       struct
         type t = Syn.path(*a variable capturing the  name*)
         let equal (t1,t2)  =  Syn.equalPath t1 t2
       end

module Value =
       struct
         (*a list of visited components*)
         type t = Var.t list
         let equal (t1, t2)  =  
   	 	  try 
        	List.fold_left2  
        	(fun accBool ci cj -> accBool && 
            	Var.equal ci cj) true t1 t2
    	  with 
        	Invalid_argument e-> false  

         let toString t = 
         	List.fold_left 
         	(fun accStr ci -> (accStr^" : "^(Var.toString ci))) "[ " t
        	
             
end

module Map   = Applicativemap.ApplicativeMap (Key) (Value) 

type t = Map.t
let empty = Map.empty
let mem =  Map.mem
let find t var = 
    try (Map.find t var) 
  with 
  | (Map.KeyNotFound k) -> raise (NoMappingForVar (Syn.pathToString k))

let add = fun t -> fun var rt -> Map.add t var rt
let remove = Map.remove
let replace = Map.replace 

let toString t =
List.fold_left (fun accstr (pi, childreni) -> (accstr^"\n "^(Syn.pathToString pi)^" |-> "^(Value.toString childreni))) " " t  


end 








module PathTypeMap = struct

module ProgramPath =
       struct
         type t = Syn.path(*a variable capturing the  name*)
         let equal (t1,t2)  =  Syn.equalPath t1 t2 
         						
       end

	module PathTypeValue =
       struct
         (*Need to change later to scehema*)
         type t = RefinementType.t
         let equal (t1,t2) = RefinementType.compare_types t1 t2           
end

module TyMap   = Applicativemap.ApplicativeMap (ProgramPath) (PathTypeValue) 

type t = TyMap.t
let empty = TyMap.empty
let mem = TyMap.mem
let find t var = 
    try (TyMap.find t var) 
  with 
  | (TyMap.KeyNotFound k) -> raise (NoMappingForVar (Syn.pathToString k))

let add = fun t -> fun var rt -> TyMap.add t var rt
let remove = TyMap.remove

let toString t = 
    List.fold_left (fun accstr (vi, rti) -> (accstr^"\n "^(Syn.pathToString vi)^" : "^(RefTy.toString rti))) " " t 




end 


module PathWPMap = struct

module ProgramPath =
       struct
         type t = Syn.path(*a variable capturing the  name*)
         let equal (t1,t2)  =  Syn.equalPath t1 t2 
         						
       end

	module PathTypeValue =
       struct
         (*Need to change later to scehema*)
         type t = Predicate.t
         let equal (t1,t2) = false           
end

module TyMap   = Applicativemap.ApplicativeMap (ProgramPath) (PathTypeValue) 

type t = TyMap.t
let empty = TyMap.empty
let mem = TyMap.mem
let find t var = 
    try (TyMap.find t var) 
  with 
  | (TyMap.KeyNotFound k) -> raise (NoMappingForVar (Syn.pathToString k))

let add = fun t -> fun var rt -> TyMap.add t var rt
let remove = TyMap.remove

let toString t = 
    List.fold_left (fun accstr (vi, pi) -> (accstr^"\n "^(Syn.pathToString vi)^" : "^(Predicate.toString pi))) " " t 




end 


module Experiences = struct 

type t = Syn.path list 
let naive = [] 
let mem p t = List.mem p t 
let add p t = p :: t
let remove p t = 
		List.filter (fun a -> Syn.equalPath p a) t


let toString t = 
    List.fold_left (fun accstr (pi) -> 
    		(accstr^"\n "^(Syn.pathToString pi))) " " t 





end