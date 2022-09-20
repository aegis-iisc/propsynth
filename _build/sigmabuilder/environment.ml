module Syn = Lambdasyn 
open SpecLang 

exception NoMappingForVar of string
exception IllegalConstructorType of string    
(*A var to refinement type mapping typing environment*)
module TypingEnv = struct

module TypingEnvKey =
       struct
         type t = Var.t
         let equal(t1,t2)  =  Var.equal t1 t2
       end

module TypingEnvValue =
       struct
         (*Need to change later to scehema*)
         type t = RefinementType.t
         let equal (t1,t2) = RefinementType.compare_types t1 t2           
end

module TyMap   = Applicativemap.ApplicativeMap (TypingEnvKey) (TypingEnvValue) 

type t = TyMap.t
let empty = TyMap.empty
let mem = TyMap.mem
let find t var = 
    try (TyMap.find t var) 
  with 
  | (TyMap.KeyNotFound k) -> raise (NoMappingForVar k)

let add = fun t -> fun var rt -> TyMap.add t var rt
let remove = TyMap.remove
let append t binds = 
        t@binds

let toString t = 
    List.fold_left (fun accstr (vi, rti) -> (accstr^"\n "^(Var.toString vi)^" : "^(RefTy.toString rti))) " " t 

    

(*enumerate variables and find macthing types*)
let enumerateAndFind t (rt:TypingEnvValue.t) : ((TypingEnvKey.t*TypingEnvValue.t) list)   = 
        TyMap.enumerate t rt 

let lambdas4RetType t (rt:TypingEnvValue.t)  : ((TypingEnvKey.t*TypingEnvValue.t) list) =
   
   let rec loop gamma (filtered:(TypingEnvKey.t*TypingEnvValue.t) list) =
        match gamma with 
            [] -> filtered
            | (vi, rti) :: xs-> 
                    match rti with 
                        | RefinementType.Arrow ((arg, argty),_) -> 
                              let uncurried =   RefinementType.uncurry_Arrow rti in 
                                
                            let RefinementType.Uncurried (_, retty)= RefinementType.uncurry_Arrow rti in 
                        
                                
                            if (RefinementType.compare_types rt retty) then  
                                let filtered = filtered@[(vi, rti)] in 
                                loop xs  filtered
                            else 
                                loop xs  filtered
                        | _ ->  loop xs  filtered          
  in 
 loop t []


(*TODO :: Currently the filter directly returns the same gamma, needs updation later*)          
let filterOnEffectSet t eff = 
      t            

end 

(*The constructor environment Sigma*)
module Constructors = struct


module ConstructorEnvKey =
       struct
         type t = Var.t
         let equal(t1,t2)  =  Var.equal t1 t2
       end

module ConstructorEnvValue =
       struct
         (*Need to change later to scehema*)
         type t = RefinementType.t
         let equal (t1,t2) = RefinementType.compare_types t1 t2           

end

module ConsMap   = Applicativemap.ApplicativeMap (ConstructorEnvKey) (ConstructorEnvValue) 

type t = ConsMap.t
let empty = ConsMap.empty
let mem = ConsMap.mem
let find t tyd = 
    try (ConsMap.find t tyd) 
  with 
   (ConsMap.KeyNotFound k) -> raise (NoMappingForVar k)

let add = fun t -> fun tyd sort -> ConsMap.add t tyd sort 
let remove = ConsMap.remove

let findCons4retT t retT : ((Var.t*RefinementType.t)list ) = 
  let rec traversal gamma acc  =      
    (match gamma with 
        | [] -> acc
        | (vi, rti):: xs -> 
                match rti with 
                 | RefinementType.Arrow ((v,t1), t2) -> 
                        if (RefinementType.compare_types t2 retT) then 
                          let acc = (vi, rti) :: acc in 
                          traversal xs acc 
                        else
                          traversal xs acc
                 | _ -> raise (IllegalConstructorType "findCons4RetT")  
    )
  in 
 traversal t empty

end 


(*A map from component name a monExp*)
module Components = struct


module ComponentEnvKey =
       struct
         type t = Var.t
         let equal(t1,t2)  =  Var.equal t1 t2
       end

module ComponentEnvValue =
       struct
         (*Need to change later to scehema*)
         type t = RefinementType.t
         let equal (t1,t2) = true           

end

module CompMap   = Applicativemap.ApplicativeMap (ComponentEnvKey) (ComponentEnvValue) 

type t = CompMap.t
let empty = CompMap.empty
let mem = CompMap.mem
let find t name = 
    try (CompMap.find t name) 
  with 
  | (CompMap.KeyNotFound k) -> raise (NoMappingForVar k)

let add = fun t -> fun name comp -> CompMap.add t name comp 
let remove = CompMap.remove

end
(* 
(*To be populated later*)
module RelationalEnv = struct

module RelationId =
       struct
         type t = RelId.t
         let equal(t1,t2)  =  RelId.equal t1 t2
       end

module Relation =
       struct
         Need to change later to scehema
         type t = StructuralRelation.t
         let equal (t1,t2) = true           

end

module ConsMap   = Applicativemap.ApplicativeMap (ConstructorEnvKey) (ConstructorEnvValue) 





end
 *)
module ExploredTerms = struct 
  type t = Var.t list
  let equal t1 t2 = Var.equal t1 t2    
  let empty = []  
  let find t (e:Var.t) = List.find (fun e' -> (Var.equal e e')) t 
  let add t e = e::t
  let remove t e  =
        List.filter (fun e' -> not (Var.equal e e')) t 

  let mem t e = List.exists (fun e' -> equal e e') t 
let toString t = 
        List.fold_left (fun stracc ti -> (stracc^(Var.toString ti))) "Terms" t
end


module ExploredPaths = struct 
  type t = Syn.path list
  let equal t1 t2  =  
    try 
        List.fold_left2  (fun accBool ci cj -> accBool && Syn.equalPath ci cj) true t1 t2
    with 
        Invalid_argument e-> false  
  let empty = []  
  let find t (e : Syn.path) = List.find (fun e' -> (Syn.equalPath e e')) t 
  let add t e = e::t
  let remove t e  =
        List.filter (fun e' -> not (Syn.equalPath e e')) t 

  let mem t e = List.exists (fun ei -> Syn.equalPath e ei) t 
  let fromList ls = ls
  let toString t = 
        List.fold_left (fun stracc ti -> (stracc^"\n"^(Syn.pathToString ti))) "Paths" t
end




