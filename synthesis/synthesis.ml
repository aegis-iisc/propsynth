module Syn = Lambdasyn
module VC = VerificationC   
open SpecLang 
module Gamma = Environment.TypingEnv 
module Sigma = Environment.Constructors
module Components = Environment.Components
module Explored = Environment.ExploredTerms                 
module ExploredPaths = Environment.ExploredPaths
module ExploredTerms = Environment.ExploredTerms

module VCE = Vcencode 
module DPred = Knowledge.DiffPredicate
module DMap = Knowledge.DistinguisherMap
module PTypeMap = Knowledge.PathTypeMap
module P = Predicate  
module BP = Predicate.BasePredicate
module SynTC = Syntypechecker
module WPP2CMap = Knowledge.WPPathChildrenMap
module PWPMap = Knowledge.PathWPMap
module Experiences = Knowledge.Experiences



exception SynthesisException of string 
exception Unhandled


module PGMap = Knowledge.PathGammaMap
exception LearningException of string 


open Syn

(* 
module Printf = struct 
  let printf d s = Printf.printf d ""
  let originalPrint = Printf.printf 
end   *)

module Message = struct 

  let show (s:string) = Printf.printf "%s" ("\n "^s)
  
  (* Printf.printf "%s" ("\n"^s)  *)


end


module Quals = Set.Make( 
  struct
    type t = RelId.t
    let equal t1 t2 = RelId.equal (t1, t2)
    let compare t1 t2 = RelId.order t1 t2 
   
  end )

module Bidirectional : sig
  val measurecount : int ref
  val itercount : int ref 
  val enumerated : Var.t list ref  
  val subprobplem : Var.t list ref 
  val learningOn :  bool ref 
  val efilterOn : bool ref
  val bidirectionalOn : bool ref 
  val max : int ref 
  val maxif_depth : int ref  
  val visitedPaths : path list ref 
  val count_filter : int ref
  val count_chosen : int ref
  val lbindings : Syn.bindingtuple list ref   
  val visited : ExploredTerms.t ref  

  val typenames : ((Var.t) list) ref 
  val qualifiers : ((RelSpec.Qualifier.t) list) ref 
  val currentApp : (Var.t list) ref
  val formals : (Var.t list) ref  

  type ('a, 'b) result = 
            Success of 'a 
            | Fail of 'b
            | Terminate


 val enumPureE : Explored.t -> Gamma.t -> Sigma.t -> Predicate.t -> RefTy.t ->  Syn.typedMonExp list 
 val enumerateEffAndFind : Explored.t -> VC.vctybinds -> Sigma.t -> VC.pred list ->  RefTy.t -> (Explored.t * Syn.typedMonExp option) 
 val esynthesizeScalar : int -> Gamma.t -> Sigma.t -> Predicate.t -> RefTy.t list -> (Gamma.t * Syn.typedMonExp list)  

 
 val isynthesizeMatch : int -> VC.vctybinds -> Sigma.t -> Predicate.t -> (Var.t * RefTy.t) -> RefTy.t ->  Syn.typedMonExp option 
 val isynthesizeFun : int -> VC.vctybinds -> Sigma.t -> Predicate.t -> RefTy.t  -> Syn.typedMonExp list
 val toplevel :  VC.vctybinds -> Sigma.t -> Predicate.t-> (Var.t list) -> (RelSpec.Qualifier.t list) ->  RefTy.t -> bool -> bool -> int -> bool ->   Syn.typedMonExp list  
 val synthesize : int ->  VC.vctybinds -> Sigma.t -> Predicate.t-> RefTy.t -> Syn.typedMonExp list 


val litercount : int ref   
  type exploredTree = Leaf 
                    | Node of exploredTree list 
  type choiceResult = 
        | Nothing of DMap.t * Predicate.t list 
        | Chosen of (DMap.t * Syn.monExp * path)

  type deduceResult = 
        | Success of path
        | Conflict of { env :DPred.gammaCap; 
                        dps:DMap.t ; 
                        conflictpath : path;
                        conflictpathtype : RefTy.t;
                        disjuncts : Predicate.t list
                        }

   
end = struct

let itercount = ref 0 
let measurecount = ref 0
let enumerated = ref [] 
let subprobplem = ref []
let visitedPaths = ref [[]]
let lbindings = ref []
let tryCount = ref 0
let efilterOn = ref false
let learningOn = ref false 
let bidirectionalOn = ref false 
let max = ref 5
let maxif_depth = ref 2
let visited = ref ExploredTerms.empty  
let currentApp = ref ["_"]
let formals = ref []
let count_filter = ref 0
let count_chosen = ref 0

let typenames = ref []
let qualifiers = ref []

let maxPathLength = ref 0
type ('a, 'b) result = 
            Success of 'a 
            | Fail of 'b
            | Terminate



let litercount = ref 0 

type exploredTree = Leaf 
                    | Node of exploredTree list 

type choiceResult = 
        | Nothing of DMap.t * Predicate.t list 
        | Chosen of (DMap.t *  Syn.monExp * path)

type deduceResult = 
        | Success of path
        | Conflict of { env :DPred.gammaCap; 
                        dps:DMap.t ; 
                        conflictpath : path;
                        conflictpathtype : RefTy.t;
                        disjuncts : Predicate.t list
                        }


let	split list	n =	
	let	rec	aux	i acc	=	function	
		|	[]	->	(List.rev acc,	[])	
		|	h	::	t	as	l	->	
                if	(i	=	0)	then	
                   (List.rev acc,l)	
				else aux (i-1) (h::acc) t		
    in	
	aux	n []	list	
			
let	rotate	list	n	=	
	let	len	=	List.length	list	in	
	let	n =	if	(len=0)	
                then 0	
                else (n	mod	len	+len) mod len in	
	if	n	=	0	then	
        list	
	else	
        let	(a,	b)	=	split list n in	
            b	@	a	

let rec n_cartesian_product = function
    | [] -> [[]]
    | x :: xs ->
        let rest = n_cartesian_product xs in
        List.concat (List.map (fun i -> List.map (fun rs -> i :: rs) rest) x) 


let rand_select list n =
    let rec extract acc n = function
      | [] -> raise Not_found
      | h :: t -> if n = 0 then (h, acc @ t) else extract (h::acc) (n-1) t
    in
    let extract_rand list len =
      extract [] (Random.int len) list
    in
    let rec aux n acc list len =
      if n = 0 then acc else
        let picked, rest = extract_rand list len in
        aux (n-1) (picked :: acc) rest (len-1)
    in
    let len = List.length list in
    aux (min n len) [] list len

let rec firstk k xs = match xs with
| [] -> failwith "firstk"
| x::xs -> if k=1 then [x] else x::firstk (k-1) xs;;

let effectGuidedFiltering potentialLibs goalPre goalPost = 
    
    let qualifier_spec_pre = Quals.of_list (Predicate.getRelation goalPre)  in 
    let qualifier_spec_post = Quals.of_list (Predicate.getRelation goalPost)  in 
    let qualifier_spec = Quals.union (qualifier_spec_pre) (qualifier_spec_post) in 
    let () = Quals.iter (fun e -> Printf.printf "%s" ("\n Show SPEC QUALS "^(RelId.toString e))) qualifier_spec in 
    let potentialLibs = 
        List.filter (fun (vi , ti) -> 
                 let () = Printf.printf "%s" ("\n Show Component "^(Var.toString vi)) in 
                   match ti with 
                    | RefTy.Arrow ((varg, argty), _) -> 
                        let uncurried = RefTy.uncurry_Arrow ti in 
                        let RefTy.Uncurried (args_ty_list, retty) = uncurried in 
                        let RefTy.MArrow (_, pre_lib, (_, _), post_lib) = retty in 
                        (* let  () = List.iter (fun e -> Printf.printf "%s" ("\n Lib Rels PRE "^(RelId.toString e))) (Predicate.getRelation pre_lib) in  *)
                        let qualifier_lib_pre = Quals.of_list(Predicate.getRelation pre_lib) in 
                        
                        (* let  () = List.iter (fun e -> Printf.printf "%s" ("\n Lib Rels POST "^(RelId.toString e))) (Predicate.getRelation post_lib) in  *)
                        
                        let qualifier_lib_post = Quals.of_list (Predicate.getRelation post_lib) in 
                        let qualifier_lib = Quals.union qualifier_lib_pre qualifier_lib_post in 
                        let () = Quals.iter (fun e -> Printf.printf "%s" ("\n Show Lib QUALS "^(RelId.toString e))) qualifier_lib in 
    
                        let qualifier_intersection = Quals.inter qualifier_spec qualifier_lib in 
                        let () = if (Quals.subset qualifier_lib qualifier_spec) then 
                            (Message.show ("Show :: Subset"))
                        else 
                            (Message.show ("Show :: Not Subset"))
                        in    
                        let () = Quals.iter (fun e -> Printf.printf "%s" ("\n Show  INTER "^(RelId.toString e))) qualifier_intersection in 
                        
                        (* can add more elements to {sel}*)
                        
                        let diff = Quals.diff qualifier_intersection (Quals.singleton "sel") in     
                        let () = Quals.iter (fun e -> Printf.printf "%s" ("\n Show DIFF "^(RelId.toString e))) diff in  
                        not (Quals.is_empty diff)
                            
                    | RefTy.MArrow (_,pre_lib,(_,_), post_lib) ->
                        let qualifier_lib_pre = Quals.of_list (Predicate.getRelation pre_lib) in 
                        let qualifier_lib_post = Quals.of_list (Predicate.getRelation post_lib) in 
                        let qualifier_lib = Quals.union qualifier_lib_pre qualifier_lib_post in 
                        (* let () = Quals.iter (fun e -> Printf.printf "%s" ("\n Lib QUALS "^(RelId.toString e))) qualifier_lib in  *)
    
                        let qualifier_intersection = Quals.inter qualifier_spec qualifier_lib in 
                       
                        (* let () = Quals.iter (fun e -> Printf.printf "%s" ("\n INTER "^(RelId.toString e))) qualifier_intersection in  *)
                        
                        (* can add more elements to {sel}*)
                        let diff = Quals.diff qualifier_intersection (Quals.singleton "sel") in     
                        (* let () = Quals.iter (fun e -> Printf.printf "%s" ("\n DIFF "^(RelId.toString e))) diff in  *)
                        not (Quals.is_empty diff)
                        
                    | RefTy.Base  (_,_, predicate_lib) -> 
                        true
                ) potentialLibs  

                in 
     potentialLibs   


let enumPureE explored gamma sigma delta (spec : RefTy.t) : (Syn.typedMonExp) list  = 
    (*can enumerate a variable of refined basetype, an arrow type or a effectful component*)
     (* Message.show ("\n Show ::  In enumPureE");         *)
    (* Message.show (" Enumeration for \n spec \n "^(RefTy.toString spec));             *)
    match spec with 
      (*Tvar case*)
      | RefTy.Base (v, t, pred) -> 
        let foundTypes = Gamma.enumerateAndFind gamma spec in 
         
         (*filter the explored*)
         
        let foundTypes = List.filter (fun (vi, _) -> not (Explored.mem explored vi)) foundTypes in  
         
       
                
        let rec verifyFound fs potentialExps = 
            match fs with
             | [] -> potentialExps 
             | (vi, rti) :: xs -> 
                 Message.show ("\n Enumerating a Scalar Term "^(Var.toString vi));
                 Message.show ("\n Type of the Scalar Term "^(RefTy.toString rti));
                 if (List.mem vi !formals) then 
                    let _ = Message.show ("################################################") in 
                    let _ = Message.show ("Skipping Variable "^(Var.toString vi)^" As this a  Formal Parameter to the current function Call") in 
                    let _ = Message.show ("################################################") in 
                    verifyFound xs potentialExps 
                            
                else
                    let expanded_vi = Syn.expand !lbindings (Syn.Evar vi) in 
                    (match expanded_vi with 
                    | Syn.Eapp (fname, _) -> 
                        if (Var.equal (Syn.componentNameForMonExp fname) (List.hd(!currentApp))) then 
                            
                            let _ = Message.show ("################################################") in 
                            let _ = Message.show ("Skipping Variable "^(Var.toString vi)^" As Outer Function Call is "^(Var.toString(List.hd(!currentApp)))) in 
                            
                            verifyFound xs potentialExps 
                        else
                            let rti_bound_vi = RefTy.alphaRenameToVar rti vi in 
                            let spec_bound_vi = RefTy.alphaRenameToVar spec vi in 
                            let vc = VC.fromTypeCheck gamma [delta] (rti_bound_vi, spec_bound_vi) in 
                            (* if (VC.is_empty_vc vc) then  (*trivial VC case *)
                                    (Message.show ("***************Selection Trivially Successful************"^(Var.toString vi));    
                                     let ei = {expMon = (Syn.Evar (vi)); ofType = rti} in 
                                    verifyFound xs (ei::potentialExps) 
                                    ) 
                            else 
                             *)
                                (*make a direct call to the SMT solver*)
                                let vcStandard = VC.standardize vc in 
                                
                                (* Message.show ("standardized VC "^(VC.string_for_vc_stt vcStandard));  *)
                                let result = VCE.discharge vcStandard !typenames !qualifiers in 
                                Message.show ("Returned Successfully");
                                
                                (match result with 
                                | VCE.Success -> 
                                        let ei = {expMon = (Syn.Evar (vi)); 
                                                    ofType = rti} in 
                                        verifyFound xs (ei::potentialExps) 
                                | VCE.Failure -> 
                                        Message.show ("\n FaileD the subtype check T_vi <: T_goal");
                                        verifyFound xs potentialExps
                                | VCE.Undef -> 
                                        Message.show ("\n Timedout the subtype check T_vi <: T_goal");
                                        verifyFound xs potentialExps

                                 )
                            
                            
                    | _ ->  
                        (*substitute, bound variables in both with the argument variable*)
                        let rti_bound_vi = RefTy.alphaRenameToVar rti vi in 
                        let spec_bound_vi = RefTy.alphaRenameToVar spec vi in 
                        let vc = VC.fromTypeCheck gamma [delta] (rti_bound_vi, spec_bound_vi) in 
                        (* if (VC.is_empty_vc vc) then  (*trivial VC case *)
                                (Message.show ("***************Selection Trivially Successful************"^(Var.toString vi));    
                                     let ei = {expMon = (Syn.Evar (vi)); ofType = rti} in 
                                    verifyFound xs (ei::potentialExps) 
                                )
                        else  *)
                            (*make a direct call to the SMT solver*)
                            let vcStandard = VC.standardize vc in 
                            (* Message.show ("standardized VC "^(VC.string_for_vc_stt vcStandard));  *)
                            let result = VCE.discharge vcStandard !typenames !qualifiers in 
                            (match result with 
                            | VCE.Success -> 
                                    let ei = {expMon = (Syn.Evar (vi)); 
                                                ofType = rti} in 
                                    verifyFound xs (ei::potentialExps) 
                            | VCE.Failure -> 
                                    Message.show ("\n FaileD the subtype check T_vi <: T_goal");
                                    verifyFound xs potentialExps
                            | VCE.Undef -> 
                            
                                    Message.show ("\n Timeout the subtype check T_vi <: T_goal");
                                    verifyFound xs potentialExps
                            
                            (* raise (SynthesisException "Failing VC Check for pureEnum")   *)
                            )
                 )          
                        
         in 
         verifyFound foundTypes []
      
      | RefTy.Arrow ((_,_),_) -> 
                    Message.show (" Show :: HOF argument required, unhanlded currently thus skipping");
                    [] 
      | _ -> raise (SynthesisException "Illegal/Unhandled elimination form for PureTerm")       




let rec enumerateEffAndFind explored gamma sigma delta (spec : RefTy.t)  : (Explored.t * Syn.typedMonExp option) = 
   match spec with 
       | RefTy.MArrow (eff, pre, (v, t), post) -> 
         Message.show ("Spec "^(RefTy.toString spec));
         let foundTypes = Gamma.enumerateAndFind gamma spec in 
         
          (*filter the explored*)
         let foundTypes = List.filter (fun (vi, _) -> not (Explored.mem explored vi)) foundTypes in  
         Message.show "FOUND COMPONENTS ";
         let () = List.iter (fun (vi,_) -> Message.show (Var.toString vi)) foundTypes in 

         (* let () = List.iter (fun (vi, rti) -> Printf.printf "%s" ("\n Gamma |- "^(Var.toString vi)^" : "^(RefTy.toString rti))) foundTypes in           
          *)

         let rec verifyFound explored fs  = 
            let () = Printf.printf "%s" ("\n *********************Enumeration Iteration*****************"^(string_of_int(!itercount))) in
            if (!itercount > 1000) then 
                (* let () = Message.show (List.fold_left (fun str vi -> (str^"::"^(Var.toString vi))) "ENUM " !enumerated) in  *)
                raise (SynthesisException "FORCED STOPPED") 
            else 
            let _ = itercount := !itercount + 1 in  
            match fs with
             | [] -> (explored, None) 
             | (vi, rti) :: xs -> 
                (*filter on effects before actuall checking the hoare triples*) 
                let effi = match rti with 
                    RefTy.MArrow (eff, _,_,_) -> eff
                    | _ -> raise (SynthesisException "Only Computation Types Allowed")
                in     
                if (not (Effect.isSubEffect effi eff))  
                        then verifyFound explored xs    
                else    
                        let _ = enumerated := (vi :: !enumerated) in     
                        let () =Message.show ("Found after Enumeration "^(RefTy.toString rti)) in 
                        let () =Message.show ("Compared Against Spec "^(RefTy.toString spec)) in 
                         try
                              let vc = VC.fromTypeCheck gamma delta (rti, spec) in  

                            (*make a direct call to the SMT solver*)
                            let vcStandard = VC.standardize vc in 
                             Message.show (VC.string_for_vc_stt vcStandard);  
                            let result = VCE.discharge vcStandard !typenames !qualifiers in 
                            match result with 
                            | VCE.Success -> 
                                            let explored = vi :: explored in 
                                            Message.show ("***************Selection Successful************"^(Var.toString vi));    
                                            let _ = count_chosen := !count_chosen + 1 in  
                                            let retMonExp = Syn.Eret (Syn.Evar (vi)) in 
                                            (explored, Some {expMon = retMonExp; ofType=rti})
                            | VCE.Failure -> 
                                            let _ = count_filter := !count_filter + 1 in 

                                            Message.show ("***************Selection Failed************"^(Var.toString vi));    
                                            verifyFound explored xs
                            | VCE.Undef -> 
                                            let _ = count_filter := !count_filter + 1 in 

                                            Message.show ("***************Selection Timeout************"^(Var.toString vi));    
                                            verifyFound explored xs
                            
                            
                            (* raise (SynthesisException "Typechecking Did not terminate")   *)
                            
                             with 
                        VerificationC.Error e -> verifyFound explored xs
          in 
         verifyFound explored foundTypes

      | _ -> raise (SynthesisException ("Effectful Enumeration for non MArrow Type"^(RefTy.toString spec)))  



let createSubts (args : Syn.monExp list) (formals : (Var.t * RefTy.t) list) : (Var.t * Var.t) list =
     if (not (List.length args = List.length formals)) then 
        raise (SynthesisException "The formals and actual arguments size Mismacth") 
     else
        let formalVars = List.map (fun (vi, ti) -> vi) formals in 
        let actualVars = List.map (fun (mei) -> 
                                        match mei with 
                                            | Syn.Evar vi -> vi 
                                            | _ -> raise (SynthesisException "The Normal Form requires applications c
                                                    of the form F (xi, x2,...xn)")
                                        ) args in 
       List.combine (actualVars) (formalVars)                                    


let checkFromExperience (h'_wp : Predicate.t) (h_wp : Predicate.t) (gammacap : DPred.gammaCap) : bool = 
    (*TODO*)
    true




          



(*The function application synthesis for pure componenent, 
we can try to replace this with say SYPET/Sunquid*)
(*Randomize the selection of each choice *)

let rec esynthesizePureApp depth gamma sigma delta specs_path : (Gamma.t * (Syn.typedMonExp) list) = 
    
    (*This is a simplified version of the return typed guided component synthesis as in SYPET*)

    Message.show (" Entering Pure Fun Application: esynthesizePureApp ");
    if (depth >= !max) then 
        let _ = Message.show ("############################################################") in 
        Message.show ("Max depth reached");
        Message.show ("############################################################");
       
       (gamma, [])
    else    
    let spec = List.hd specs_path in 
   
    let potentialChoices = Gamma.lambdas4RetType gamma spec in 
    
    
    (*Add pure functions and constructors as well in the choice*)
    (* let c_es = c_es@c_wellRetTypeLambda in  *)
    Message.show ("Show Potential Functions");
    Message.show (List.fold_left (fun acc (vi, _) -> acc^", \n "^Var.toString vi) " " potentialChoices);
   

    let rec choice potentialChoices gamma sigma delta = 
        match potentialChoices with 
          | [] -> (gamma, []) 
             (*no more effectful components try pure function/constructor application*)
          | (vi, rti) :: xs ->
                Message.show ("############################################################");
                Message.show (" Synthesizing the Function application Pure Component "^(Var.toString vi));
                Message.show ("############################################################");
                if (Var.equal (List.hd (!currentApp)) vi) then 
                    choice xs gamma sigma delta 
                else
                let _ = currentApp :=  vi::!currentApp in 
                (* if (ExploredTerms.mem !visited vi) then 
                    let _ = Message.show ("############################################################") in 
                    Message.show (" Skipping Already visited so must be in Scalar ");
                    choice xs gamma sigma delta
                else  *)
                match rti with 
                    | RefTy.Arrow ((varg, argty), _) -> 
                        Message.show (" *************** Trying Arrow Component ************"^(Var.toString vi)^" : "^(RefTy.toString rti));
                        let uncurried = RefTy.uncurry_Arrow rti in 
                        let RefTy.Uncurried (args_ty_list, retty) = uncurried in 
                        let formal_args =  List.map (fun (ai,_) -> ai) args_ty_list in 
                        let outer_formals = !formals in 
                        let _ = formals := formal_args in    
                        (*Currently the argument is always a scalar/Base Refinement*)
                        Message.show (" *************** Synthesizing Args ei : ti for ************"^(Var.toString vi));
                        

                        (* lists of terms which can be used as argument *)    
                        (* let e_potential_args_list =  
                            List.map (fun (argi, argtyi) -> 
                                let scalars = esynthesizeScalar depth gamma sigma delta [argtyi;retty] in 
                                let (_, funapps) = esynthesizePureApp (depth + 1) gamma sigma delta [argtyi;retty] in 
                                List.concat [scalars;funapps]
                            ) args_ty_list  in  *)

                        let (gamma, _, e_potential_args_list) =  
                            List.fold_left (fun (_g, i, pot_arg_list) (argi, argtyi) -> 
                                Message.show ("##################################################################################");
                                Message.show (" Synthesizing the "^(string_of_int i)^"th argument for Function "^(Var.toString vi));
                                Message.show (" Trying Arguments in Scalars ");
                                let (_g, scalars) = esynthesizeScalar depth _g sigma delta [argtyi;retty] in 
                                Message.show ("##################################################################################");
                                Message.show (" Next Trying Arguments of the form f (ei...) ");
                                Message.show ("##################################################################################");
                                
                                (* let (_g, funapps) = esynthesizePureApp (depth + 1) _g sigma delta [argtyi;retty] in  *)
                                let (_g, funapps) = esynthesizePureApp (depth + 1) _g sigma delta [argtyi;retty] in 
                                
                                let acc_of_list_of_pot_args =  ((List.concat [scalars;funapps])::(pot_arg_list))  in 
                                let _ = 
                                List.iter 
                                (fun ei -> Printf.printf "%s" 
                                ("\n >>>>>>>>>>>>>>>>>>> "^(string_of_int i)^"th Args option for "^(Var.toString vi)^" : "^(Syn.monExp_toString (Syn.expand (!lbindings) (ei.expMon) )))) (List.concat [scalars;funapps]) in 
                                let _ = Message.show (" DEPTH vs MAX  "^(string_of_int depth)^" vs "^(string_of_int !max)) in 
                                
                                let _g = VC.extend_gamma (argi, argtyi) _g  in  
                                (_g, (i+1), acc_of_list_of_pot_args)
                            ) (gamma, 1, []) args_ty_list  in 
                            
                        Message.show ("##################################################################################");
                        
                        let _ = formals := outer_formals in   
                        let e_potential_args_list = List.rev (e_potential_args_list) in 
                                
                        
                        (* Message.show ("Gamma "^(VC.string_gamma gamma));     *)
                        (*
                        e_potential_args_list returns a list of lists
                        If \forall argi, we can synthesize a term ei, return success *)
                        let all_successful = List.filter (fun e_argi -> match e_argi with 
                                                            | x :: xs -> true
                                                            | [] -> false) e_potential_args_list in 
                        
                        
                        (* for each arg_i we have a list of potential args [pi1;pi2;pi3] *)
                        (*length of synthesized args match with the formal parameter*)
                        let e_allsuccessful = (if ((List.length all_successful) = (List.length args_ty_list)) 
                                                then Some all_successful
                                                else None) in 

                        
                        (match e_allsuccessful with (*BEGIN1*)
                            | None -> (*Atleast one required argument cannot be synthesized thus cannot make the call*)
                                    Message.show (" *************** Synthesizing Args ei : Failed for some  arg");
                                    choice xs gamma sigma delta 
                            | Some es -> 
                                Message.show (" *************** Successfully Synthesized Args ei Forall i ");
                                (*A Hack for the examples, solving this in a more fundamental way will require 
                                solving this combinatorial problem
                                [a11, a12.....a1n] [a21,....a2m]
                                will give total mxn choices to try, f (a1i, a2j) in worst case which will 
                                be costly.
                                So for more practical pursposes, we try all the second arguments if there are two args,
                                *)

                                let () = List.iter (fun li -> 
                                                    let () = Printf.printf "%s" ("\n Ith Argument Options for "^(vi)) in 
                                                    List.iter (fun ei -> Printf.printf "%s" 
                                                                ("\n EI "^(Syn.monExp_toString 
                                                                            (Syn.expand (!lbindings) (ei.expMon) )))) li) es in 
                                

                                let chooseArgs (argsListEach : ((Syn.typedMonExp) list ) list) : (Syn.typedMonExp list) list   = 
                                    n_cartesian_product argsListEach        
                                
                                in 

                                let possible_args_lists = chooseArgs es in 

                                Message.show ("# of Possible Argument Options for "^(vi)^" "^(string_of_int (List.length possible_args_lists))); 


                                (*Randomize the choices of the argument  *)  
                                (* let possible_args_lists = 
                                    if (List.length possible_args_lists > 5) then 
                                        (* rand_select possible_args_lists 10  *)
                                        firstk 5 possible_args_lists
                                    else possible_args_lists     
                                in                         *)
                               
                              


                                let () = List.iter (fun li -> 
                                                    let () = Printf.printf "%s" ("\n Possible Arg Options ") in 
                                                    List.iter (fun ei -> Printf.printf "%s" 
                                                                ("\n EI "^(Syn.monExp_toString 
                                                                            (Syn.expand (!lbindings) (ei.expMon) )))) li) possible_args_lists in 
                                
                                
                                
                                if (List.length es > 1) then 
                                    let () = Message.show ("Show f (ei, e2, ....en) Case") in 
                                    (* all args list have atleast one element, so we can call List.hd on these and 
                                    run our regular incomplete version for funs (x1, x2,...) *)
                                    
                                    let rec loop possible_args_combinations _g applicationExpressions : (Gamma.t * Syn.typedMonExp list) =
                                        match possible_args_combinations with 
                                            | [] -> (_g, applicationExpressions) 
                                            | ei_hds :: ei_tails ->  
                                                   
                                                (* let ei_hds = List.map (fun ei_list -> List.hd (ei_list)) es  in  *)
                                                let monExps_es = List.map (fun ei ->
                                                                                    ei.expMon) ei_hds in 
                                                let nbvsTypes_es = 
                                                    List.map (fun ei -> 
                                                     (*If the argument is an expression other than Evar, create a binding 
                                                     for the expression in the environment, else 
                                                     keep the variable *)
                                                     match ei.expMon with 
                                                         | Evar v -> (ei.expMon, ei.ofType)
                                                         | _ -> 
                                                            raise (SynthesisException "Dead 0");
                                                        
                                                             let bvi = Evar (Var.fromString ("_bv"^(string_of_int (!bvarcount)))) in 
                                                             let _ = bvarcount := !bvarcount + 1 in 
                                                             (bvi,  ei.ofType)) ei_hds in 


                                                    let varExp4monExp_es = List.map (fun (vi, ti) -> vi) nbvsTypes_es in     
                                                    (*add to gamma *)
                                                    (* let _g =  
                                                            List.fold_left (fun _gl (vi, ti) -> 
                                                                    let variablei = 
                                                                        (match vi with 
                                                                            | Evar v -> v 
                                                                            | _ -> raise(SynthesisException "Illegal Variable") ) in
                                                                        VC.extend_gamma (variablei, ti) _gl) _g nbvsTypes_es  in                                   *)


                                                    let appliedMonExp = Syn.Eapp (Syn.Evar vi, varExp4monExp_es) in  (*apply vi e_arg*)
                                                    let synthesizedExp = appliedMonExp in 
                                                    (* let lbindingtuples = Syn.visitnode appliedMonExp in 
                                                    let synthesizedExp = if (List.length lbindingtuples > 2)
                                                                        then Syn.exp4tuples lbindingtuples 
                                                                        else appliedMonExp in         
                                                    Message.show ("Synthesized Exp to be Typechecked "^(Syn.monExp_toString synthesizedExp));
                                                    *)
                                                    (*If there is already a _lbv eqvivalent to this then return that and skip*)
                                                    Message.show ("Finding Already seen tree for "^(Syn.monExp_toString synthesizedExp));
                                           
                                                    (match (Syn.findInBindings synthesizedExp !lbindings) with 
                                                        | Some (lbv,_) ->   
                                                             Message.show ("Found "^(Syn.monExp_toString lbv));
                                                    
                                                             let applicationExpressions =  {expMon= lbv; ofType=spec} :: applicationExpressions in 
                                                             (*If the gamma does not contain the type for lbv, add it 
                                                              *)
                                                            let Evar bvname = lbv in 
                                                            let bvnameType = 
                                                                    try 
                                                                        Some (Gamma.find _g bvname) 
                                                                    with 
                                                                     | e -> None
                                                             in  
                                                             let _g = 
                                                                match bvnameType with 
                                                                    | Some _ -> _g
                                                                    | None  ->  VC.extend_gamma (bvname, spec) _g  
                                                             in                                  
                                                             loop ei_tails _g applicationExpressions                                                                
                                                             
                                                        | None ->   
                                                            let () = Printf.printf "%s" ("\n Typechecking "^(Syn.monExp_toString (Syn.expand (!lbindings) synthesizedExp))) in 
                                                            let () = Printf.printf "%s" ("\n Against "^(RefTy.toString spec)) in 
    
                                                            let funAppType =  SynTC.typecheck _g sigma delta !typenames !qualifiers synthesizedExp spec in 
                                                            (match funAppType with 
                                                                 | Some type4AppliedMonExp -> 
                                                                       Message.show (" Show *************** TypeChecking Succsessful "^(RefTy.toString type4AppliedMonExp));
                                                                       let bvname = Var.fromString ("_lbv"^(string_of_int (!bvarcount))) in 
                                                                       let _ = bvarcount := !bvarcount + 1 in 
                                                                       let bvExp = Evar (bvname) in 
                                                              
                                                                       let _g = VC.extend_gamma (bvname, type4AppliedMonExp) _g  in                                  
                                                                       Message.show ("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                                                                       Message.show ("let "^(bvname)^" = "^(monExp_toString synthesizedExp));
                                                                       let _ = lbindings := ((bvExp, synthesizedExp) :: !lbindings) in  
                                                                       Message.show ("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                                                                       
            
                                                                       let applicationExpressions =  {expMon= bvExp; ofType=type4AppliedMonExp} :: applicationExpressions in 
                                                                         
                                                                       loop ei_tails _g applicationExpressions                                                                
                                                                 | None ->  
                                                                    Message.show (" FAILED Typechecking PURE APP For "^(Syn.monExp_toString synthesizedExp));    
                                                                     loop ei_tails _g applicationExpressions 
                                                            )
                                                    )
                                    in            
                                    let (gamma, correctExpressions) = loop possible_args_lists gamma [] in 
                                    (match correctExpressions with 
                                        | [] -> (* Nothing found for this function, look for other functions *) 
                                            Message.show (" ###################################################");    
                                            
                                            Message.show (" The Choice of Function "^(Var.toString vi)^" Was Ill Fated Try Next Choice of function");    
                                                                    
                                            choice xs gamma sigma delta  
                                        | x :: xs -> 
                                            let _ = visited := ExploredTerms.add !visited vi in
                                            (gamma, correctExpressions) (*EXT : Even in this case we need to look for all the terms, i.e. other function *)
                                    )                         
                                    
                                else
                                  (*internal loop trying more than one choice for args*)  
                                  let () = Message.show ("Apply Single Argument Case : f (ei) Case "^(Var.toString vi)) in 
                                  let allowed_only_argument_choices = List.hd (es) in 
                                  
                                  let rec loop argsList _g eis : (Gamma.t * Syn.typedMonExp list)  = 
                                    match argsList with 
                                        | [] -> (_g, eis)
                                        | es_x :: es_xs -> 
                                            let monExps_es = es_x.expMon in 
                                            let () = Message.show (" Case : f (ei) Case "^(Var.toString vi)^" "^(Syn.monExp_toString monExps_es)) in 
                                
                                            let (_g, synthesizedExp) = 
                                                (match monExps_es with 
                                                    | Evar v ->  
                                                        let appliedMonExp = Syn.Eapp (Syn.Evar vi, [(monExps_es)]) in  (*apply vi e_arg*)    
                                                        (_g, appliedMonExp)
                                                    

                                                    | _ -> 
                                                        raise (SynthesisException "Dead");
                                                        let _ = Message.show ("Other case Type "^(Syn.RefTy.toString es_x.ofType)) in 
                                                        let monExpType_es = es_x.ofType in 
                                                        let bvname = Var.fromString ("_bv"^(string_of_int (!bvarcount))) in 
                                                        let _ = bvarcount := !bvarcount + 1 in 
                                                        let bvExp_es = Evar (bvname) in 
                                                        let _g = VC.extend_gamma (bvname, monExpType_es) _g  in                                  
                                                        let appliedMonExp = Syn.Eapp (Syn.Evar vi, [bvExp_es]) in  (*apply vi e_arg*)
                                                        let synthesizedExp = appliedMonExp in
                                                        (_g, synthesizedExp)
                                                )       
                                            in              
                                            (* let lbindingtuples = Syn.visitnode appliedMonExp in 
                                            let synthesizedExp = if (List.length lbindingtuples > 2)
                                                        then Syn.exp4tuples lbindingtuples 
                                                        else appliedMonExp in          
                                            Message.show ("Synthesized Exp to be Typechecked "^(Syn.monExp_toString synthesizedExp)); *)
                                            Message.show ("Finding Already seen tree for "^(Syn.monExp_toString synthesizedExp));
                                            (match (Syn.findInBindings synthesizedExp !lbindings) with 
                                                | Some (lbv, _) ->   
                                                    Message.show ("Found "^(Syn.monExp_toString lbv));
                                                    let eis =  {expMon=lbv; ofType=spec} :: eis in  
                                                    let Evar bvname = lbv in 
                                                    let bvnameType = 
                                                           try 
                                                               Some (Gamma.find _g bvname) 
                                                           with 
                                                            | e -> None
                                                    in  
                                                    let _g = 
                                                       match bvnameType with 
                                                           | Some _ -> _g
                                                           | None  ->  VC.extend_gamma (bvname, spec) _g  
                                                    in                                  
                                                    loop es_xs _g eis                                                                
                                                             
                                                | None ->     
                                                    let () = Printf.printf "%s" ("\n Typechecking "^(Syn.monExp_toString (Syn.expand (!lbindings) synthesizedExp))) in 
                                                    let () = Printf.printf "%s" ("\n Against "^(RefTy.toString spec)) in 
                                                    let funAppType =  SynTC.typecheck _g sigma delta !typenames !qualifiers synthesizedExp spec in 
                                                    (match funAppType with 
                                                        | Some type4AppliedMonExp -> 
                                                             Message.show (" Show *************** TypeChecking Succsessful "^(RefTy.toString type4AppliedMonExp));
                                                             
                                                             let bvname = Var.fromString ("_lbv"^(string_of_int (!bvarcount))) in 
                                                             let _ = bvarcount := !bvarcount + 1 in 
                                                             (* create let lbvi = f (ei) *)
                                                             let bvExp = Evar (bvname) in 
                                                             let _g = VC.extend_gamma (bvname, type4AppliedMonExp) _g  in                                  

                                                             let eis =  {expMon= bvExp; ofType=type4AppliedMonExp} :: eis in 
                                                               Message.show ("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                                                                Message.show ("let "^(bvname)^" = "^(monExp_toString synthesizedExp));
                                                                let _ = lbindings := ((bvExp, synthesizedExp) :: !lbindings) in  

                                                                Message.show ("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

                                                             loop es_xs _g eis                                  
                                                        | None -> 
                                                            Message.show (" FAILED Typechecking PURE APP For "^(Syn.monExp_toString synthesizedExp));    
                                                            loop es_xs _g eis 
                                                    )       
                                            )               
                                  in 
                                  let (gamma, pureappexps) = loop allowed_only_argument_choices gamma [] in 
                                  match pureappexps with 
                                    | [] -> (* Nothing found for this function, look for other functions *) 
                                        Message.show (" ###################################################");    
                                            
                                        Message.show (" The Choice of Function "^(Var.toString vi)^" Was Ill Fated Try Next Choice of function");    
                                            
                                        choice xs gamma sigma delta  
                                    | _ :: _ -> 
                                        let _ = visited := ExploredTerms.add !visited vi in
                                        (gamma, pureappexps) (*EXT : Even in this case we need to look for all the terms *)

                        ) (*END1*)  
                     | _ -> raise (SynthesisException  "Illegeal choice for Pure Application")   


       in 
       choice potentialChoices gamma sigma delta 
       

and esynthesizeConsApp depth gamma sigma delta specs_path : Syn.typedMonExp option  = 

    (*This is a simplified version of the return typed guided component synthesis as in SYPET*)
    if (depth >= !max) then 
       None
    else    
    
    let spec = List.hd specs_path in 
    let RefTy.Base (v, t, pred) = spec in 
    let exploredCons = Sigma.empty in 
    (*find a C \in Sigma with shape C : (xi:\tau:i) -> t *)
        (*find a C \in Sigma with shape C : (xi:\tau:i) -> t *)
    let potentialChoices = Sigma.findCons4retT sigma spec in 
    Message.show "Found Constructors with required return type";
    Message.show (List.fold_left (fun acc (consName, _) -> acc^", \n Show Constructors found "^Var.toString consName) " " potentialChoices);
   

    let rec choice potentialChoices gamma sigma delta = 
        match potentialChoices with 
            | [] -> 
                Message.show ("Show No more choices for ConsApp");
                
                None 
             (*no more effectful components try pure function/constructor application*)
            | (vi, rti) :: xs ->
                Message.show (" Trying Construtor "^(Var.toString vi));
                
                match rti with 
                    | RefTy.Base (_,_,_) -> 
                        let appliedConsMonExp = Syn.Ecapp (vi, []) in  (*apply vi e_arg*)
                        let consAppType =  SynTC.typecheck gamma sigma delta !typenames !qualifiers appliedConsMonExp spec in 
                        (match consAppType with 
                            | Some type4AppliedMonExp -> 
                                    Message.show (" Show *************** TypeChecking Nullay Cosntructor Succsessful "^(RefTy.toString type4AppliedMonExp));
                                Some {expMon= appliedConsMonExp; ofType=spec}                                  
                            | None ->  
                              choice xs gamma sigma delta)
                    | RefTy.Arrow ((_,_),_) ->     
                        let RefTy.Uncurried (consargs,consret) = RefTy.uncurry_Arrow rti in 
                        
                        let consArgs = List.map (fun (_,ti) -> ti) consargs in 
                        Message.show (" Show *************** Synthesizing Arguments ei for the Constructor Application for ************"^(Var.toString vi));


                           let e_potential_args_list =  List.map (fun (cargtyi) -> 
                                                            let (_, scalars) = esynthesizeScalar depth gamma sigma delta (cargtyi::specs_path) in 
                                                            let (_, apps) = esynthesizePureApp (depth+1) gamma sigma delta (cargtyi::specs_path) in 
                                                            List.concat [scalars;apps] 
                                                        ) consArgs  in 

                           let all_successful = List.filter (fun e_argi -> match e_argi with 
                                                                       | x :: xs -> true
                                                                       | [] -> false) e_potential_args_list in 
                           (* for each arg_i we have a list of potential args [pi1;pi2;pi3] *)
                           (*length of synthesized args match with the formal parameter*)
                           let e_allsuccessful = (if ((List.length all_successful) = (List.length consArgs)) 
                                                           then Some all_successful
                                                           else None) in 


                           (match e_allsuccessful with (*BEGIN1*)
                               | None -> (*Atleast one required argument cannot be synthesized thus cannot make the call*)
                                               Message.show (" Show *************** Synthesizing Args ei : Failed for some  arg");
                                               choice xs gamma sigma delta 
                               | Some es -> 
                                           Message.show (" Show *************** Successfully Synthesized Args ei Forall i ");

                                               (* all args list have atleast one element, so we can call List.hd on these and 
                                                   run our regular incomplete version for funs (x1, x2,...) *)
                                               let ei_hds = List.map (fun ei_list -> List.hd (ei_list)) es  in 
                                               let monExps_es = List.map (fun ei -> ei.expMon) ei_hds in 
                                               let appliedConsMonExp = Syn.Ecapp (vi, monExps_es) in  (*apply vi e_arg*)
                                               let consAppType =  SynTC.typecheck gamma sigma delta !typenames !qualifiers appliedConsMonExp spec in 
                                               match consAppType with 
                                                   | Some type4AppliedMonExp -> 
                                                        Message.show (" Show *************** TypeChecking Cons App Succsessful "^(RefTy.toString type4AppliedMonExp));
                                                        Some {expMon= appliedConsMonExp; ofType=spec}                                  
                                                   | None ->  
                                                      choice xs gamma sigma delta 
                           ) (*END1*)
                    | _ -> raise (SynthesisException "Invalid Constror Type ")       

       in 
       Message.show ("********************** HERE BEFORE ");
       
       choice potentialChoices gamma sigma delta 





(*Top lvel goal synthesis for scalar Types*)
and esynthesizeScalar depth gamma sigma delta specs_path  : (Gamma.t * (Syn.typedMonExp) list)  = 
     
    if (depth >= !max) then 
        (gamma, [])
    else   
     if (List.length specs_path < 1) then 
        raise (SynthesisException "Scalar synthesis Call without spec")
     else   
         let explored = Explored.empty in
         let leaf_spec = List.hd specs_path in 

        Message.show ("esynthesizeScalar for "^(RefTy.toString leaf_spec)); 

        match leaf_spec with 
            |  RefTy.Base (_,_,_) -> 
                let foundbyEnum = enumPureE explored gamma sigma delta leaf_spec in 
                (match foundbyEnum with 
                   | x :: xs -> 
                              Message.show ("Show :: Found a Few Macthing Scalars "); 
                              (gamma, foundbyEnum)   
                   | [] ->
                           Message.show (">>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< "); 
                           let (gamma, appterms) = esynthesizePureApp (depth+1) gamma sigma delta specs_path in 
                            (match appterms with 
                                | [] -> 
                                    Message.show (">>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< "); 
                                    let consAppterm = esynthesizeConsApp (depth+1) gamma sigma delta specs_path in 
                                    (match consAppterm with 
                                      | Some t2 ->  (gamma, [t2])
                                      | None -> (gamma, [])
                                    )  
                                | _::_ -> (gamma, appterms)
                            )

                 )           
            |  RefTy.Arrow ((_,_),_) -> (gamma, [])
            | _ -> raise (SynthesisException "Synthesizing Scalar of Unhandled Shape")



(* TODO ::This is a first implementation  of a special rule for list, then generalize it to any algebraic type, say tree*)
and isynthesizeMatch depth gamma sigma delta argToMatch spec : Syn.typedMonExp option = 
    Message.show ("Show :: Synthesize Match "^(RefTy.toString spec));
    
    let (matchingArg, matchingArgType) = argToMatch in 
    let RefTy.Base(_, argBase, argBasePhi) = matchingArgType in 
     
    Message.show ("Show :: List "^(TyD.toString argBase));
           
    (*list constructor case, work on the genaral case later*)   
  match argBase with 
    | Ty_list _ 
    | Ty_alpha _ -> 
          
         if (TyD.isList argBase) then      
              
              let () = 
                Message.show ("Show LIST CASE ??"^(TyD.toString argBase)^" PHI "^(Predicate.toString argBasePhi)) in
              let x_var = Var.get_fresh_var "x" in 
              let xs_var = Var.get_fresh_var "xs" in 
              
              let gamma_c= Gamma.add gamma x_var (RefTy.fromTyD (TyD.Ty_int)) in 
              let gamma_c = Gamma.add gamma_c xs_var ((RefTy.fromTyD (TyD.Ty_alpha ("list")))) in 
    
    
              let phi_c = SynTC.generateConsConstraints  matchingArg x_var xs_var in 
              let phi_n = SynTC.generateNilConstraints   matchingArg in 
              Message.show ("Show Predicate Cons branch :: "^(Predicate.toString phi_c));
              Message.show ("Show Predicate Nil branch :: "^(Predicate.toString phi_n));
    
    
              let delta_n = Predicate.Conj (delta, phi_n) in 
              let delta_c = Predicate.Conj (delta, phi_c) in 
    
    
              let gamma_n = gamma in 
              let e_n = synthesize depth gamma_n sigma delta_n spec  in 
              
              (match e_n with 
                | [] -> Message.show ("Show :: Failed Synthesisized Nil Branch");
                        None  
                | exp_n :: exp_n_xs_-> 
                    Message.show ("Show :: Successfully Synthesisized Nil Branch \n Now Trying Cons");
                    let e_c = synthesize depth gamma_c sigma delta_c spec  in 
                      (match (e_c) with 
                       | [] ->
                                Message.show ("Show :: Failed Synthesisized Cons Branch ");
                       
                                None
                       | exp_c :: exp_c_xs-> 
                              Message.show ("Show :: Successfully Synthesized Cons Branch ");
                              let caseExps = [exp_n; exp_c] in 
                              let consArgs = [[];[x_var;xs_var]] in
                              (*General Case : we will have the constructor name in the Sigma*)
                              let cons = [Var.fromString "Nil"; Var.fromString "Cons"] in 
                              let matchingArg = {Syn.expMon = Syn.Evar matchingArg; 
                                                    Syn.ofType = matchingArgType} in  
                              let matchExp = Syn.merge matchingArg cons consArgs caseExps in
    
                              Some {Syn.expMon = matchExp;
                                    Syn.ofType = spec} 
                      ) 
              )          
        else 
            None  
    | _ ->   
        Message.show "Show :: Non List Case";
        None
       (*  synthesize gamma sigma delta spec learnConst !bidirectional !maxPathLength
   *)
  
 and isynthesizeIf depth gamma sigma delta spec : Syn.typedMonExp list = 
    Message.show ("**********************************************");
    Message.show ("iSynthesize If-THEN-ELSE "^(RefTy.toString spec));
    Message.show ("**********************************************");
    
    (*val createGammai Gamma, t : (Gamma *ptrue * pfalse)*)
    let createGammai gamma t  = 
        match t with 
            | RefTy.Base (vn, _, pn) ->

                        (*create a new var newvar for vn.
                        generate truepredicate [newvar/vn]pn /\ [newvar = true]
                        generate falsepredicate [newvar/vn]pn /\ [newvar = false]
                        add newvar to Gamma
                        
                        *)    
                        let newvar = Var.get_fresh_var "v" in 
                        let newvarString =Var.toString newvar in 
                        let truep = Predicate.Conj (Predicate.Base (BP.Eq (BP.Var newvarString, (BP.Bool true))), 
                                        Predicate.applySubst (newvar, vn) pn) in 
                        let falsep = Predicate.Conj(Predicate.Base (BP.Eq (BP.Var newvarString, (BP.Bool false))), 
                                        Predicate.applySubst (newvar, vn) pn) in 
                        let gamma = VC.extend_gamma (newvar, t) gamma  in 
                        (gamma, truep, falsep)
                        

            
             | MArrow (_, _, (vn, tn), postBool) -> 
                        let Predicate.Forall (bvs, predBool) = postBool in     
                        Message.show ("RefTy "^(RefTy.toString t));
                        Message.show ("Post "^(Predicate.toString postBool));
                        let newvar = Var.get_fresh_var "v" in 
                        let newvarString =Var.toString newvar in 
                       
                        let truep = Predicate.Conj (Predicate.Base (BP.Eq (BP.Var newvarString, (BP.Bool true))), 
                                       Predicate.applySubst (newvar, vn) predBool) in 
                        let falsep = Predicate.Conj(Predicate.Base (BP.Eq (BP.Var newvarString, (BP.Bool false))), 
                                        Predicate.applySubst (newvar, vn)  predBool) in 
                        let gamma = VC.extend_gamma (newvar, tn) gamma  in 
                      
                        (gamma, truep, falsep)
                        
                       
                                    
             | _ -> raise (SynthesisException "Case must be handled in Pure Effect");   

    in          


     (*val createGammai Gamma, t : (Gamma *ptrue * pfalse)*)
    let createPreSpeci (spType : RefTy.t)  = 
        match spType with  
            | MArrow (_, _, (_, _), sp) -> 
             
                match sp with 
                | Forall (bvs, sp_Pred) -> 
                    (*Assumption bvs = [h, v, h'] *)
                    let (bv1, _) = List.nth bvs 1 in 
                    Message.show ("SP "^(Predicate.toString sp_Pred));
                    let trueSpec = 
                                    let trueNonquantified = Predicate.Conj (Predicate.Base (BP.Eq ((BP.Var bv1), (BP.Bool true))), sp_Pred) in
                                    Predicate.Forall (bvs, trueNonquantified)  in 
                    let falseSpec = let falseNonquantified = Predicate.Conj (Predicate.Base (BP.Eq ((BP.Var bv1), (BP.Bool false))), sp_Pred) in
                                    Predicate.Forall (bvs, falseNonquantified) in 
                            
                    (trueSpec, falseSpec)
                | _ -> raise (SynthesisException "Only Allowed Types Shape is {\forall h v h'}}}")                
                        
                                    
            | _ -> raise (SynthesisException "Case must be handled in Pure Effect");   

    in          


    (*synthesize a boolean / rather we need to synthesize all the booleans
    now we synthesize a list of boolean scalars*) 
    let v = Var.get_fresh_var "v" in 
    let boolSpec = RefTy.Base (v, 
                                TyD.Ty_bool, 
                                Predicate.True) in 
    Message.show (" *********************Synthesizing the Guard*******************");
    Message.show ("iSynthesize Boolean Guard "^(RefTy.toString boolSpec));
    Message.show (" *********************Synthesizing the Guard*******************");
    
    let (gamma, bi_list) = esynthesizeScalar depth gamma sigma delta [boolSpec] in 
    (*EXT :: loop over all possible choices of the boolean *)
    (*for each option synthesize a list of terms and return all possible expressions *)
    (* let bi_list = List.rev (bi_list) in  *)
    
    let rec loop guardlist gamma explist : (Gamma.t * Syn.typedMonExp list) =   
        match guardlist with 
            | [] -> (gamma, explist)
            | eb :: eb_xs ->
                 (* Look for guards of size max 2 *)
                if (Syn.size (Syn.expand !lbindings eb.expMon) > 2) then 
                    loop eb_xs gamma explist
                else
                (*get the predicate \phi in the If-rule for synthesis*)   
                 (*either a fun-application or *)
                 let eb_expmon = eb.expMon in  
                 (*type for the eb_expmon*)
                 let eb_type = eb.ofType in 
                 let refTy4bi = eb_type in 
                 Message.show ("Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard "^(Syn.monExp_toString (Syn.expand !lbindings eb_expmon)));
                 (* Message.show ("Show :: iSynthesize Boolean Successful "^(RefTy.toString eb_type)); *)
                (*create true predicate = \phi /\ [v= true] & false predicate = \phi /\ [v=false]*)

                 let (gamma, true_pred4bi, false_pred4bi) = createGammai gamma refTy4bi in 
                 let delta_true 
                  = Predicate.Conj (delta, true_pred4bi) in 
                 Message.show (" *********************Synthesizing the True branch*******************");
                 Message.show ("Show :: True Predicate "^(Predicate.toString true_pred4bi));


                 (*\Gamma, [v=true]\phi |- spec ~~~> t_true*)

                 let t_true = synthesize (depth) gamma sigma delta_true spec  in 

                (*still incomplete, forall true. forall false *)
                (match t_true with 
                    | [] -> Message.show ("Failed Synthesizing any True Branch exp for the selected guard"^(Syn.monExp_toString eb_expmon)^"\n Try Next guard");
                            loop eb_xs gamma explist 
                    | exp_true :: exp_true_xs -> 
                          let _ = currentApp := [""] in 
                          Message.show ("*********************************************");
                          Message.show ("True Branch :: Successfully Synthesisized");
                          Message.show ("*********************************************");
                          Message.show ("if "^(Syn.monExp_toString (Syn.expand (!lbindings) eb_expmon))^"\n \t then ");
                          let _ = List.iter(fun tmi -> let tmi = Syn.expand (!lbindings) tmi.expMon in 
                                    Message.show ("***********\n "^(Syn.monExp_toString tmi))) t_true in 
     
                          Message.show ("*********************************************");
                          Message.show ("************ Synthesize False Branch**************");
                          Message.show ("*********************************************");

                          Message.show ("False Branch :: Trying False Branch");
                          let delta_false = Predicate.Conj (delta, false_pred4bi) in 
                          (*\Gamma, [v=false]\phi |- spec ~~~> t_false*)
                           Message.show ("Show :: Synthesizing the false branch");
                           Message.show ("Show :: False Predicate "^(Predicate.toString false_pred4bi));

                          let t_false = synthesize (depth) gamma sigma delta_false spec  in 
                          (match (t_false) with 
                           | [] -> Message.show ("Show :: Failed Synthesis of any False Branch ");
                                   loop eb_xs gamma explist

                           | exp_false :: exp_false_xs -> 
                                  Message.show ("Show :: Successfully Synthesisized False Branch ");
                                  let monexp_t_true = exp_true.expMon in 
                                  let monexp_t_false = exp_false.expMon in 
                                  let eite_exp = Syn.Eite (eb_expmon, monexp_t_true, monexp_t_false) in 
                                  (* (e_true, e_false) list *)
                                  let m_n_binarylist_list = n_cartesian_product [t_true;t_false] in 
                                  let m_n_pair_list = List.map (fun l -> 
                                                        assert (List.length l == 2);
                                                        let f = List.hd (l) in 
                                                        let s = List.hd (List.rev l) in 
                                                        (f, s)
                                                        ) m_n_binarylist_list in 
                                  let m_n_ite_typed_mon_exps = 
                                    List.map (fun (e_true, e_false) -> 
                                                {Syn.expMon = Syn.Eite (eb_expmon, e_true.expMon, e_false.expMon);
                                                 Syn.ofType = spec}
                                             ) m_n_pair_list in 
                                  assert (List.length m_n_ite_typed_mon_exps == ((List.length t_true) * (List.length t_false)));           
                                  let explist = List.append explist m_n_ite_typed_mon_exps in   
                                  loop eb_xs gamma explist
                            )        
                ) 
                
    in 
    
    let (_,ifsols) = loop bi_list gamma [] in 
    ifsols            
               

(*Top level syntheis goals for Lambda, same as the traditional syntehsis rules
calls the top-level macthing and application followed by if-rule and then the standard learning based rule *)
and isynthesizeFun depth gamma sigma delta spec : Syn.typedMonExp list= 
  
  let uncurried_spec = RefTy.uncurry_Arrow spec in 
  let RefTy.Uncurried ( fargs_type_list, retT) = uncurried_spec  in
  Message.show ("Show "^RefTy.toString uncurried_spec); 
  (*extend gamma*)
  (*first try a match case, if it does not succeed, try the non-matching case*)
  let gamma_extended = Gamma.append  gamma fargs_type_list in 
  
  (*create a new type spec for the goal reifying the measure 
    Assume for now that the measure is defined over the first argument.
    and it is captured by the length predicate.
    We can require the user to give the measure qualifier separately
   *)
   
  (*ASSUMPTION, the argumnet to deconstruct will be at the head*)
  let argToMatch = List.hd (fargs_type_list) in 
  
  let (decreasing_Var, decreasing_Type) = argToMatch in 
  
  Message.show (("Decreasing Measure "^(Var.toString decreasing_Var)));
  Message.show (("Decreasing Type "^(RefTy.toString decreasing_Type)) );
  let baseType4DecType = RefTy.toTyD decreasing_Type in 
  let gamma_extended =  match baseType4DecType with 
    | TyD.Ty_list _ 
    | TyD.Ty_alpha _-> 
        let new_decreasing_Var = Var.fromString ( (Var.toString decreasing_Var)^(string_of_int(!measurecount+1))) in 
        measurecount := !measurecount + 1;

        (* get the predicate capturing the measure, currently just len *)
        (*let measure_predicate = getMeasurePredicate decreasing_Type in *)

        let decreased_Arg = 
              let RefTy.Base (v0, td0, pred0) = decreasing_Type in 
              let decreasing_pred = (*len (decreasing_Var) > len (v0) *)
                              let instExpression = 
                                      RelLang.RInst { sargs = []; 
                                              targs = []; 
                                              args = []; 
                                              rel = RelId.fromString "slen"} in 
                              let measure_old_var = RelLang.R (instExpression, decreasing_Var) in 
                              let measure_new_var = RelLang.R (instExpression, v0) in                
                              Predicate.Rel (P.RelPredicate.Grt ( measure_old_var, measure_new_var)) in 
              Message.show ("Calculated Decreasing Predicate "^(Predicate.toString decreasing_pred)) ;
              (new_decreasing_Var, RefTy.Base (v0, td0, Predicate.Conj (pred0, decreasing_pred))) 
        in   

        (* let subs_uncurried_tail = List.map 
                                (fun (vi, ti) -> 
                                (vi, RefTy.applySubsts [(new_decreasing_Var, decreasing_Var)] ti)) (List.tl fargs_type_list) in   *)
        (* let decreased_fargs_type_list = decreased_Arg :: subs_uncurried_tail in  *)
        let decreased_fargs_type_list = decreased_Arg :: (List.tl fargs_type_list) in 
        let decreased_goal_type = RefTy.curry_Arrow (RefTy.Uncurried (decreased_fargs_type_list, retT )) in 

        Message.show ("Calculated Decreased Goal Type "^(RefTy.toString decreased_goal_type)) ;

        (*update _gamma *)

        let gamma_extended = Gamma.remove gamma_extended (Var.fromString "goal") in 
        let gamma_extended = Gamma.add gamma_extended (Var.fromString "goal")  (decreased_goal_type) in
        gamma_extended

    | TyD.Ty_int -> 
         let new_decreasing_Var = Var.fromString ( (Var.toString decreasing_Var)^(string_of_int(!measurecount+1))) in 
        measurecount := !measurecount + 1;

        (* get the predicate capturing the measure, currently just len *)
        (*let measure_predicate = getMeasurePredicate decreasing_Type in *)

        let decreased_Arg = 
              let RefTy.Base (v0, td0, pred0) = decreasing_Type in 
              let decreasing_pred = (*len (decreasing_Var) > len (v0) *)
                              Predicate.Base (P.BasePredicate.Gt ( P.BasePredicate.Var (decreasing_Var), 
                                                                   P.BasePredicate.Var (v0))) in 
              Message.show ("Calculated Decreasing Predicate "^(Predicate.toString decreasing_pred)) ;
              (new_decreasing_Var, RefTy.Base (v0, td0, Predicate.Conj (pred0, decreasing_pred))) 
        in   

         let subs_uncurried_tail = List.map 
                                (fun (vi, ti) -> 
                                (vi, RefTy.applySubsts [(new_decreasing_Var, decreasing_Var)] ti)) (List.tl fargs_type_list) in   
        let decreased_fargs_type_list = decreased_Arg :: subs_uncurried_tail in 
        let subs_retT = RefTy.applySubsts [(new_decreasing_Var, decreasing_Var)] retT in 
        (* let decreased_fargs_type_list = decreased_Arg :: (List.tl fargs_type_list) in  *)
        let decreased_goal_type = RefTy.curry_Arrow (RefTy.Uncurried (decreased_fargs_type_list, subs_retT )) in 

        Message.show ("Calculated Decreased Goal Type "^(RefTy.toString decreased_goal_type)) ;
        (*update _gamma *)

        let gamma_extended = Gamma.remove gamma_extended (Var.fromString "goal") in 
        let gamma_extended = Gamma.add gamma_extended (Var.fromString "goal")  (decreased_goal_type) in
        gamma_extended

    | _ -> raise (SynthesisException ("The Hack for recursive call not handled "^(RefTy.toString decreasing_Type)));
  in   
  (*Given disjunctions in the spec we can directly try match*)
  Message.show ("Show Trying :: Top-level Match"); 
  let match_expression = isynthesizeMatch depth gamma_extended sigma delta argToMatch retT in 
  match match_expression with 
    | Some e_match -> 
       Message.show ("EXPLORED :: Show Found Match match x with ... solution"); 
       [e_match]
    | None -> 
         Message.show ("Match-case failed :: Try Top-level If-then-else "); 
         let if_exp = isynthesizeIf depth gamma_extended sigma delta retT in 
         match if_exp with 
            | [] ->
                Message.show (" If then else Failed :: Try CDCL without subdivision\n "); 
                []
            | e :: e_xs ->
                Message.show (" Found a If Then Else solution"); 
                if_exp
            
              
    
    
(*The main entry for the synthesize*)
(*In some cases the input spec can be more than the RefinementType*)
(*synthesize : TypingEnv.t -> Constructors.t -> RefinementType.t -> Syn.typedMonExp option *)
and  synthesize depth gamma sigma delta spec : Syn.typedMonExp list =  
    match spec with 
      | RefTy.Base (v, t, pred) -> 
            Message.show "Show ***********Calling Scalar synthesize***************";
            let (gamma, syn_basetype_res) = esynthesizeScalar depth gamma sigma delta [spec] in 
            (match syn_basetype_res with 
                | [] -> []
                | x :: _ -> syn_basetype_res 
            ) 
      | RefTy.Arrow (rta, rtb) -> 
            Message.show "Show ***********Calling S-FUNC synthesize***************";
            isynthesizeFun depth gamma sigma delta spec  (*applies Tfix and Tabs one after the other*)
      | _ -> raise (SynthesisException ("Unhanlded Case synthesis  for query spec "^(RefTy.toString  spec))) 






let toplevel gamma sigma delta types quals spec learning bi maxVal efilter : (Syn.typedMonExp list) = 
     (*set the global parameters *)
     learningOn := learning;
     bidirectionalOn := bi;
     efilterOn := efilter; 
     max := maxVal; 
     maxPathLength := !max;
     typenames := types;
     qualifiers := quals;
     lbindings := [];
     let sols = synthesize 0 gamma sigma delta spec  in 
     let bindingExp = Syn.exp4tuples (List.rev (!lbindings)) in 
     Message.show (Syn.rewrite bindingExp);
     let _ = List.iter 
            (fun tmi -> 

                let tmi = Syn.expand (!lbindings) tmi.expMon in 
                Message.show ("***********\n "^(Syn.rewrite tmi))) sols in 
     sols       
        
    


end
