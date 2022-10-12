module Syn = Lambdasyn
module VC = VerificationC   
open SpecLang 
module Gamma = Environment.TypingEnv 
module Sigma = Environment.Constructors
module Components = Environment.Components
module Explored = Environment.ExploredTerms                 
module ExploredPaths = Environment.ExploredPaths
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
  val visitedPaths : path list ref 
  val count_filter : int ref
  val count_chosen : int ref

  val typenames : ((Var.t) list) ref 
  val qualifiers : ((RelSpec.Qualifier.t) list) ref 

  type ('a, 'b) result = 
            Success of 'a 
            | Fail of 'b
            | Terminate


 val enumPureE : Explored.t -> Gamma.t -> Sigma.t -> Predicate.t -> RefTy.t ->  Syn.typedMonExp list 
 val enumerateEffAndFind : Explored.t -> VC.vctybinds -> Sigma.t -> VC.pred list ->  RefTy.t -> (Explored.t * Syn.typedMonExp option) 
 val esynthesizeScalar : int -> Gamma.t -> Sigma.t -> Predicate.t -> RefTy.t list -> Syn.typedMonExp list  

 
 val isynthesizeMatch : int -> VC.vctybinds -> Sigma.t -> Predicate.t -> (Var.t * RefTy.t) -> RefTy.t ->  Syn.typedMonExp option 
 val isynthesizeFun : int -> VC.vctybinds -> Sigma.t -> Predicate.t -> RefTy.t  -> Syn.typedMonExp option
 val toplevel :  VC.vctybinds -> Sigma.t -> Predicate.t-> (Var.t list) -> (RelSpec.Qualifier.t list) ->  RefTy.t -> bool -> bool -> int -> bool ->   Syn.typedMonExp option 
 val synthesize : int ->  VC.vctybinds -> Sigma.t -> Predicate.t-> RefTy.t -> Syn.typedMonExp option 


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
let tryCount = ref 0
let efilterOn = ref false
let learningOn = ref false 
let bidirectionalOn = ref false 
let max = ref 5


let   count_filter = ref 0
let   count_chosen = ref 0

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
    Message.show (" Enumeration for \n spec \n "^(RefTy.toString spec));            
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
                 Message.show ("\n Enumerating a Pure Term "^(Var.toString vi));
                 Message.show ("\n Type of the Pure Term "^(RefTy.toString rti));
                  
                 (** Skip the ghost Vars like [A-Z]**)
                 let  startCharvar = vi.[0] in 
                 let upper = Char.uppercase_ascii startCharvar in 
                 if (startCharvar = upper) then 
                    let _ = Message.show ("GHOST") in 
                    verifyFound xs potentialExps 
                 else
                    let isGhost = false
                        (*
                        if (String.length vi > 4) then 
                            let initial = String.sub vi 0 4 in 
                            Message.show ("\n Show ::  Initial "^(initial));
                            if (initial = "var_") then
                             true
                            else
                             false   
                        else
                         false  *)
                         
                    in
                    if (isGhost) then 
                      verifyFound xs potentialExps 
                    else                   
                        (* let () = Message.show ("\n Show ::  Associated Delta "^(Predicate.toString delta)) in *)
                        (*substitute, bound variables in both with the argument variable*)
                        let rti_bound_vi = RefTy.alphaRenameToVar rti vi in 
                        let spec_bound_vi = RefTy.alphaRenameToVar spec vi in 
                        let vc = VC.fromTypeCheck gamma [delta] (rti_bound_vi, spec_bound_vi) in 
                        (*make a direct call to the SMT solver*)
                        let vcStandard = VC.standardize vc in 
                        Message.show ("standardized VC "^(VC.string_for_vc_stt vcStandard));
                        let result = VCE.discharge vcStandard !typenames !qualifiers in 
                        match result with 
                        | VCE.Success -> 
                                let ei = {expMon = (Syn.Evar (vi)); 
                                            ofType = rti} in 
                                verifyFound xs (ei::potentialExps) 
                        | VCE.Failure -> 
                                Message.show ("\n FaileD the subtype check T_vi <: T_goal");
                                verifyFound xs potentialExps
                        | VCE.Undef -> raise (SynthesisException "Failing VC Check for pureEnum")  
                        
         in 
         verifyFound foundTypes []
      (* | RefTy.Arrow ((v, t1), t2) -> 
         (*this should be dead code * *)
         raise (SynthesisException "DEAD CODE");
         let foundTypes = Gamma.enumerateAndFind gamma spec in 
         let foundTypes = List.filter (fun (vi, _) -> not (Explored.mem explored vi)) foundTypes in 
         let rec verifyFound fs pote  = 
            match fs with
             | [] -> None 
             | (vi, rti) :: xs -> 
                (*filter on effects before actuall checking the hoare triples*) 
            
                let vc = VC.fromTypeCheck gamma VC.empty_delta (rti, spec) in 
                (*make a direct call to the SMT solver*)
                let vcStandard = VC.standardize vc in 
                let result = VCE.discharge vcStandard  in 
                match result with 
                | VCE.Success -> Some ({expMon=(Syn.Evar (vi)); ofType=rti}) 
                | VCE.Failure -> verifyFound xs
                | VCE.Undef -> raise (SynthesisException "Typechecking Did not terminate")  
                
         in 
         verifyFound foundTypes

     

      | RefTy.MArrow (eff, pre, (v, t), post) -> 
         let foundTypes = Gamma.enumerateAndFind gamma spec in 
          (*filter the explored*)
         let foundTypes = List.filter (fun (vi, _) -> not (Explored.mem explored vi)) foundTypes in  
                  
         let rec verifyFound fs  = 
            match fs with
             | [] -> None 
             | (vi, rti) :: xs -> 
                (*filter on effects before actuall checking the hoare triples*) 
                let effi = match rti with 
                    | RefTy.MArrow (eff, _,_,_) -> eff 
                    | _ -> raise (SynthesisException "Only Effectful Components allowed") 
                in 
                    

                if (not (Effect.isSubEffect effi eff))  
                        then verifyFound xs    
                else        
                        let vc = VC.fromTypeCheck gamma VC.empty_delta (rti, spec) in 
                        (*make a direct call to the SMT solver*)
                        let vcStandard = VC.standardize vc in 
                        let result = VCE.discharge vcStandard  in 
                        match result with 
                        | VCE.Success -> let retMonExp = Syn.Eret (Syn.Evar (vi)) in 
                                          Some {expMon = retMonExp; ofType=rti}
                        | VCE.Failure -> verifyFound xs
                        | VCE.Undef -> raise (SynthesisException "Typechecking Did not terminate")  
                        
         in 
         verifyFound foundTypes *)

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
                            | VCE.Undef -> raise (SynthesisException "Typechecking Did not terminate")  
                            
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


(*The standard hoare-pecondition check
ei is the expression to be added,
and rti is the type for the ei
    *)
let hoarePre gamma ptypeMap spec path ei rti = 
    
    let () =Message.show ("Potential Component/Function  "^(Syn.monExp_toString ei)) in 
    let gammaMap = DPred.getGamma gamma in 
    let sigmaMap = DPred.getSigma gamma in 
    let deltaPred = DPred.getDelta gamma in 

    (*ideally there should be just one case Eapp ci args with possibly empty set of args
    mut we are treating Eapp vi () as vi ()*)    
    match ei with 
      | Eapp (ci, args) -> 
            let () =Message.show ("Show :: HoarePre Eapp case  "^(Syn.monExp_toString ei)) in 
  
            let uncurriedCompType = 
                match rti with 
                    | RefTy.Arrow ((_,_), _) -> 
                        RefTy.uncurry_Arrow rti
                    | RefTy.Uncurried(_,_) -> rti
                    | _ -> raise (SynthesisException "Illegal Type for Eapp") 
             in 
            

            let RefTy.Uncurried(formals, retty) =  uncurriedCompType in 
           
            (*Pre[ei/formali] Pre v:t Post[ei/foramli]*)             

            let RefTy.MArrow (_, ci_pre,  (vi,_), ci_post) = retty in 
            (*Pre[ei/formali]*)
            let subs = createSubts args formals in 
            let preWithActuals = Predicate.applySubsts subs ci_pre in 

            (*Post[ei/foramli]*)
            let postWithActuals = Predicate.applySubsts subs ci_post in 

            (* calculate the strongest post-condition SP (P, pi) *)    
            let vcStandard = 
                if (List.length path > 0) then 
                    
                    let (gammaMap, deltaPred, ptypeMap, prefixPathType) =
                                SynTC.typeForPath ptypeMap gammaMap sigmaMap deltaPred spec path in
                         
                 
                    let RefTy.MArrow (_,path_pre,(_,t), path_post) = prefixPathType in 
                        
                    (*hoarePre Query
                    given pre_path = \FA h. P
                          post_path = \FA h, v, h'. Q
                          ci_pre = \FA h. Pre_ci
                        -> 
                        \FA h0 v0 h0'.
                           P h0 /\ Q h0 v0 h0' => Pre_ci h0 
                       *)    
                    let h_var  = Var.get_fresh_var "h" in 
                    let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

                    let h'_var  = Var.get_fresh_var "h'" in 
                    let h'_type = RefTy.fromTyD (TyD.Ty_heap) in 

                    let x_var = Var.get_fresh_var "x" in 

                    let gammaMap = Gamma.add gammaMap h_var h_type in 
                    let gammaMap = Gamma.add gammaMap h'_var h'_type in 
                    let gammaMap = Gamma.add gammaMap x_var t in 

                    let pre_path_applied = VC.apply path_pre [(h_var, TyD.Ty_heap)] in 

                    let post_path_applied = VC.apply path_post 
                            [(h_var, TyD.Ty_heap);(x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in 
                    (*substitute current heap values for pre*)
                    let ci_pre_applied = VC.apply preWithActuals [(h'_var, TyD.Ty_heap)] in 
                   

                    let bvs = [(h_var, TyD.Ty_heap); (x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in  
                    let post_path_imp_pre_ci = Predicate.Forall (bvs, P.If (
                                                                        P.Conj (
                                                                        pre_path_applied, post_path_applied
                                                                        ), ci_pre_applied)) in   
                           
                    let vc1 = VC.VC(gammaMap, deltaPred, post_path_imp_pre_ci) in 
                    let vcStandard =  VC.standardize vc1 in 
                    vcStandard
                else
                    let RefTy.MArrow(_,goal_pre,(_,_), goal_post) = spec in 
                    let h_var  = Var.get_fresh_var "h" in 
                    let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

                    let gammaMap = Gamma.add gammaMap h_var h_type in 
                    
                    (*gaolpre => rti_pre*)
                    let goal_pre_applied = VC.apply goal_pre [(h_var, TyD.Ty_heap)] in 
                    let ci_pre_applied = VC.apply preWithActuals [(h_var, TyD.Ty_heap)] in 
                                    
                    let bvs = [(h_var, TyD.Ty_heap)] in                
                    let goal_pre_imp_ci_pre = Predicate.Forall (bvs, P.If (goal_pre_applied, ci_pre_applied)) in 
                    let vc1 = VC.VC(gammaMap, deltaPred, goal_pre_imp_ci_pre) in 
                    let vcStandard =  VC.standardize vc1 in 
                    vcStandard

                in                     
                let discharge_vc vcStandard = 
                try
                Message.show ("\n Printing VCs");
                Message.show ("\n"^(VC.string_for_vc_stt vcStandard));      
                let result = VCE.discharge vcStandard !typenames !qualifiers in 
                    match result with 
                    | VCE.Success -> 
                                    true
                    | VCE.Failure -> 
                                    false
                    | VCE.Undef -> raise (LearningException "Typechecking Did not terminate")  
                    
                 with
                    VerificationC.Error e -> raise (LearningException "Checking a distingushing predicate did not terminate")

            in      

            let allowed = discharge_vc vcStandard in  
            let gammaCap = DPred.T {gamma=gammaMap;sigma=sigmaMap;delta=deltaPred} in 
            
            (*return the gamma, the formula \phi_post => pre_ci, and result if the compoenent is allowed*)                   
            (*(gammaCap, post_path_imp_pre_ci, allowed)*)
            (*return the gamma, the formula pre_ci, and result if the compoenent is allowed*)                   
            (gammaCap, ptypeMap, ci_pre, allowed)

                




      | Evar _ -> 
            let () =Message.show ("Show :: HoarePre Evar case  "^(Syn.monExp_toString ei)) in 
  
            let RefTy.MArrow (_, ci_pre,  (_,_), c_post) = rti in  
                
            let vcStandard= 
             if (List.length path > 0) then 
                (*extract fields from gamma^*)
                (*but this should be typed in the output heap*)
                (*\Gamma |= post_path => pre*)
                
                (*a function generating strongest postcondition for a path*)

                let (gammaMap, deltaPred, ptypeMap, path_type) = SynTC.typeForPath ptypeMap gammaMap sigmaMap deltaPred spec path in 
                
                (* Message.show (">>>>>>>>>>>PATH TYPE "^RefTy.toString path_type);
                 *)
                let RefTy.MArrow (_,pre_path,(_,t), post_path) = path_type in 
                
                (*hoarePre Query
                    given pre_path = \FA h. P
                          post_path = \FA h, v, h'. Q
                          ci_pre = \FA h. Pre_ci
                        -> 
                        \FA h0 v0 h0'.
                           P h0 /\ Q h0 v0 h0' => Pre_ci h0 
                *)

                let h_var  = Var.get_fresh_var "h" in 
                let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

                let h'_var  = Var.get_fresh_var "h'" in 
                let h'_type = RefTy.fromTyD (TyD.Ty_heap) in 

                let x_var = Var.get_fresh_var "x" in 

                let gammaMap = Gamma.add gammaMap h_var h_type in 
                let gammaMap = Gamma.add gammaMap h'_var h'_type in 
                let gammaMap = Gamma.add gammaMap x_var t in 

                let pre_path_applied = VC.apply pre_path [(h_var, TyD.Ty_heap)] in 

                let post_path_applied = VC.apply post_path [(h_var, TyD.Ty_heap);(x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in 
                (*substitute current heap values for pre*)
                let ci_pre_applied = VC.apply ci_pre [(h'_var, TyD.Ty_heap)] in 
               

                let bvs = [(h_var, TyD.Ty_heap); (x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in  
                let post_path_imp_pre_ci = Predicate.Forall (bvs, P.If (
                                                                    P.Conj(
                                                                    pre_path_applied,
                                                                    post_path_applied
                                                                    ), ci_pre_applied)) in   
                       
                let vc1 = VC.VC(gammaMap, deltaPred, post_path_imp_pre_ci) in 
                let vcStandard =  VC.standardize vc1 in 
                vcStandard
             else 
                let RefTy.MArrow(_,goal_pre,(_,_), goal_post) = spec in 
                let h_var  = Var.get_fresh_var "h" in 
                let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

                let gammaMap = Gamma.add gammaMap h_var h_type in 
                
                (*gaolpre => rti_pre*)

                let goal_pre_applied = VC.apply goal_pre [(h_var, TyD.Ty_heap)] in 

                let ci_pre_applied = VC.apply ci_pre [(h_var, TyD.Ty_heap)] in 
                                
                let bvs = [(h_var, TyD.Ty_heap)] in                
                let goal_pre_imp_ci_pre = Predicate.Forall (bvs, P.If (goal_pre_applied, ci_pre_applied)) in 
                let vc1 = VC.VC(gammaMap, deltaPred, goal_pre_imp_ci_pre) in 
                let vcStandard =  VC.standardize vc1 in 
                vcStandard
            in         
            let discharge_vc vcStandard = 
                try
                Message.show ("\n Printing VCs");
                Message.show ("\n"^(VC.string_for_vc_stt vcStandard));      
                let result = VCE.discharge vcStandard !typenames !qualifiers in 
                    match result with 
                    | VCE.Success -> 
                                    true
                    | VCE.Failure -> 
                                    false
                    | VCE.Undef -> raise (LearningException "Typechecking Did not terminate")  
                    
                 with
                    VerificationC.Error e -> raise (LearningException "Checking a distingushing predicate did not terminate")

            in      

            let allowed = discharge_vc vcStandard in  
            let gammaCap = DPred.T {gamma=gammaMap;sigma=sigmaMap;delta=deltaPred} in 
            
            (*return the gamma, the formula \phi_post => pre_ci, and result if the compoenent is allowed*)                   
            (*(gammaCap, post_path_imp_pre_ci, allowed)*)
            (*return the gamma, the formula pre_ci, and result if the compoenent is allowed*)                   
            (gammaCap, ptypeMap, ci_pre, allowed)

        | _ -> raise (LearningException ("Hoare Pre Can be checked on Evar or Eapp, Incorrect Path element "^(Syn.monExp_toString ei)))    

    


(*a routine to verify that the choice ci, in the current gamma satisfies the distinguishing constraints*)
let distinguish gamma ptypeMap dps spec path ci rti= 
    
    let ci_name = Syn.componentNameForMonExp ci in 
    Message.show (" Show ***************Distinguish Call************"^(Var.toString ci_name));
    let gammaMap = DPred.getGamma gamma in 
    let sigmaMap = DPred.getSigma gamma in 
    let deltaPred = DPred.getDelta gamma in 
    let potential_path = path@[ci] in 

    (*inderSP (P, pi::ci)* *)
    let (gammaMap, deltaPred, ptypeMap,  potential_path_type) = 
                SynTC.typeForPath ptypeMap gammaMap sigmaMap deltaPred spec potential_path in 
    


    let RefTy.MArrow (_,potential_path_pre,(_,t), potential_path_post) = 
        potential_path_type in 
    

    
    
    let diffpred_ci = 
            try
                DMap.find dps ci_name 
            with 
                Knowledge.NoMappingForVar e -> DPred.empty
    in          


    
    let diffpred_ci_gammaCap = DPred.getGammaCap diffpred_ci in 
    let diffpred_ci_learntConj = DPred.getLearntConj diffpred_ci in 
    let diffpred_ci_learntDisj = DPred.getLearntDisj diffpred_ci in 

    (* previous is usef to find if there is a fixpoint we can use to break out of iterating paths ci* *)
    let previous = DPred.getPrevious diffpred_ci in 


    let gammaMap4vc2 = gammaMap@(DPred.getGamma diffpred_ci_gammaCap) in 
    let deltaPred4vc2 = Predicate.Conj(deltaPred, (DPred.getDelta diffpred_ci_gammaCap)) in  
   
     (* if (true) then (** hack for NO-CDCL numbers *)
           let () = Message.show ("Show-EXPLORED********* NO CDCL :: Trivial DiffPredicate ") in 
          
           let gammaCapPotential = DPred.T {gamma=gammaMap4vc2;sigma=sigmaMap;delta=deltaPred4vc2} in 
            (gammaCapPotential, potential_path_post, ptypeMap,  potential_path_post, true)
     
    (*till we have not seen ci in a conflict node, we try to discard cj.ck.ci**)
     else  *)
    if (diffpred_ci_learntConj == P.True) then
         (*Trivial case sp (pre, (path :: ci)) => True*)
          let () = Message.show ("Show ***********DiffPredicate "^(Predicate.toString diffpred_ci_learntConj)) in 
          Message.show (" Show ***************Checking ~ (D(ci).previous => sp (pre, (path :: ci))************"^(Var.toString ci_name));
          
         
          if (previous = P.True || List.length (path) < 2) then  (*first visit*) 
             let () = Message.show (" Show ************ D(ci).previous == True "^(Predicate.toString previous)) in 
             let gammaCapPotential = 
              DPred.T {gamma=gammaMap4vc2;sigma=sigmaMap;delta=deltaPred4vc2} in 
                    (gammaCapPotential, potential_path_post, ptypeMap,  potential_path_post, true)
          else 
                (*A Hack, tries to ignore paths of length greater than ci.ci, untill we have seen 
                ci in a conflicting node *)    
                (*Syn.pathLength >= 2*)
                (*The semantic apporach is not working, let us trying syntactic unrolling of depth 2.
                i.e. we only allow ci.ci.cj and never ci.ci.ci.cj*)
                
                (*get the last two components from the path*)
                let lastCMonExp = List.hd (List.rev path) in 
                let penultimateCMonExp = Syn.previousComponent path in
                match penultimateCMonExp with 
                    | None -> 
                        let gammaCapPotential = 
                        DPred.T {gamma=gammaMap4vc2;sigma=sigmaMap;delta=deltaPred4vc2} in 
                        (gammaCapPotential, potential_path_post, ptypeMap,  potential_path_post, true)
                    | Some mexp -> 
                        let ultimateCName = Syn.componentNameForMonExp lastCMonExp in 
                        let penultimateCName = Syn.componentNameForMonExp mexp in 
                        if (Var.equal (ci_name) ultimateCName && Var.equal (ci_name) penultimateCName) then 
                            let gammaCapPotential = 
                            DPred.T {gamma=gammaMap4vc2;sigma=sigmaMap;delta=deltaPred4vc2} in 
                            (gammaCapPotential, potential_path_post, ptypeMap,  potential_path_post, false)
                        else 
                            let gammaCapPotential = 
                            DPred.T {gamma=gammaMap4vc2;sigma=sigmaMap;delta=deltaPred4vc2} in 
                            (gammaCapPotential, potential_path_post, ptypeMap,  potential_path_post, true)
                                

              
                            
             

    else
        (*construct and check VCs sp (pre, (path :: ci)) => D(ci)*)
        let () =   Message.show (" Show ***************DISTINGUISH DiffPredicate != True ************"^(Predicate.toString diffpred_ci_learntConj)) in 
   

        let h_var  = Var.get_fresh_var "h" in 
        let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

        let h'_var  = Var.get_fresh_var "h'" in 
        let h'_type = RefTy.fromTyD (TyD.Ty_heap) in 

        let x_var = Var.get_fresh_var "x" in 

        let gammaMap  = Gamma.add gammaMap h_var h_type in 
        let gammaMap = Gamma.add gammaMap h'_var h'_type in 
        let gammaMap = Gamma.add gammaMap  x_var t in 

        (*sp (P, pi::ci) (h v h') *)    
        let pot_path_post_applied = VC.apply potential_path_post 
                                [(h_var, TyD.Ty_heap);(x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in 
        
              

        (*
         Calculate the following X.
        sp i+1 ← infer_SP (φ, t p i ; c i );
        sp i ← infer_SP (φ, t p i );
        (φ s , φ t ) ← D (c i );
        X = {¬ (φ s => sp i+1 )} ∨ {(sp i+1 => φ t ) ∧ 
        ¬(sp i => φ t )}; *)
        
        (*substitute current heap values for D(ci).learntConj*)
        let d_ci_conj_applied_h' = VC.apply diffpred_ci_learntConj [(h_var, TyD.Ty_heap);(x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in 
        let bvs = [(h_var, TyD.Ty_heap); (x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in  
        
        (**simpler check, We do not have the second check for k-bound-safety*)
        let dci_conj_imp_spi_plus1 = Predicate.Forall (bvs, P.Not (P.If (d_ci_conj_applied_h', pot_path_post_applied ))) in   

        (* Message.show (" \n $$$$$$$$$$$$$$$$$$$$$ "^(Predicate.toString dci_conj_imp_spi_plus1));     *)
        let d_ci_disj_applied_h' = VC.apply diffpred_ci_learntDisj [(h'_var, TyD.Ty_heap)] in 
        
        let sti_plus1_imp_d_ci_disj = Predicate.Forall (bvs, P.Not (P.If (pot_path_post_applied ,d_ci_disj_applied_h'))) in    

        (* Message.show (" \n >>>>>>>>>>>>>>>>>>>> "^(Predicate.toString sti_plus1_imp_d_ci_disj)); *)
        let x_check = Predicate.Disj (dci_conj_imp_spi_plus1, sti_plus1_imp_d_ci_disj) in 
        (* let x_check = dci_conj_imp_spi_plus1  in  *)
        let vc_x_check = VC.VC(gammaMap4vc2, deltaPred4vc2, x_check) in 


    (*     Message.show ("\n Predicate testsed "^(Predicate.toString pot_path_posti_imp_d_ci));
     *)
        let vcs = [vc_x_check] in 
            
            
        let vcsStandard = List.map (fun vc -> VC.standardize vc) vcs in 
        
        
        let discharge_vc vcStandard = 
            try
            Message.show ("\n Printing VCs");
            Message.show ("\n"^(VC.string_for_vc_stt vcStandard));      
            let result = VCE.discharge vcStandard !typenames !qualifiers in 
                match result with 
                | VCE.Success -> 
                                true
                | VCE.Failure -> 
                                false
                | VCE.Undef -> raise (LearningException "Typechecking Did not terminate")  
                
             with
                VerificationC.Error e -> raise (LearningException "Checking a distingushing predicate did not terminate")

        in      

        let isDistinguished = List.fold_left (fun failure svci -> failure && discharge_vc svci) true vcsStandard in  
        
         
        let () =  
        if (isDistinguished) then 
            Message.show (" Show ***************D (ci) Successful************"^(Var.toString ci_name))
        else 
            Message.show ("Show ***************Selection Failed************"^(Var.toString ci_name))
        
        in                   
        let gammaCapPotential = DPred.T {gamma=gammaMap4vc2;sigma=sigmaMap;delta=deltaPred4vc2} in 
        (gammaCapPotential, previous, ptypeMap,  potential_path_post, isDistinguished)



let createWP (gammaMap: VC.vctybinds) 
            (ciSpec : RefTy.t) (qPost : Predicate.t) 
            (subst : ((Var.t * TyD.t)* (Var.t * TyD.t)) list) : (VC.vctybinds * Predicate.t) = 
        let RefTy.Uncurried (formals, retty) = RefTy.uncurry_Arrow ciSpec in 
        let RefTy.MArrow (eff, pre, (vret, tret), post) = retty in 

        Message.show ("Show  :: Pre Initial "^(Predicate.toString pre)) ;
        Message.show ("Show  :: Post Initial "^(Predicate.toString pre)) ;
        
        
        let h = Var.get_fresh_var "h" in 
        let h' = Var.get_fresh_var "h'" in 
        let v = Var.get_fresh_var "v" in 

        let gammaMap = VC.extend_gamma (h, (RefTy.lift_base Ty_heap)) gammaMap in 
        let gammaMap = VC.extend_gamma (h', (RefTy.lift_base Ty_heap)) gammaMap in 
        let gammaMap = VC.extend_gamma (v, (tret)) gammaMap in 
    
        let pre_applied = VC.apply pre [(h, TyD.Ty_heap)] in
        let post_applied = VC.apply post [(h, TyD.Ty_heap); (v, RefTy.toTyD (tret));
                                                            (h', TyD.Ty_heap)] in 

        Message.show ("Show  :: Pre_applied "^(Predicate.toString pre_applied));
        Message.show ("Show  :: Post_applied "^(Predicate.toString post_applied));
                                                    
        (*wp = \forall Q h. Pre h /\ \forall v', h. Post h v h' => Q v h'*)
        Message.show ("Enter");
        let bvsQ = Predicate.getBVs qPost in 
        (*TODO Ugly for now, think of a funcamental way of distinguishing between the 
            goal post and other weakest-pres acting as post*)
         let qPost_applied = 
            if (List.length bvsQ = 1)
                then VC.apply qPost [(h', TyD.Ty_heap)]
            else if (List.length bvsQ = 3) then  
                VC.apply qPost [(h, TyD.Ty_heap); (v, RefTy.toTyD (tret));
                                                            (h', TyD.Ty_heap)]
            else 
                raise (SynthesisException "qPost should have form forall h v h. Q or forall h. Q")                                                            
        in 
        Message.show ("Exit");

        let pre_applied = VC.subst subst pre_applied in 
        let post_applied = VC.subst subst post_applied in 

        Message.show ("Show  :: Pre_actual2Foraml "^(Predicate.toString pre_applied));
        Message.show ("Show  :: Post_actual2Foraml "^(Predicate.toString post_applied));
                                                    
        let bvs_inner = [(v, RefTy.toTyD (tret));(h', TyD.Ty_heap)] in 
        let innerPred = Predicate.Forall (bvs_inner, Predicate.If (post_applied, qPost_applied)) in 
        let outerPred = Predicate.Forall ([(h, TyD.Ty_heap)], 
                                            Predicate.Conj(pre_applied, innerPred)) in 
        
         
        Message.show ("Show  :: Weakest Precondition "^(Predicate.toString outerPred)) ;

        (gammaMap, outerPred)


(* let wpForPath (gammaMap: VC.vctybinds) 
              (ciSpec : RefTy.t) 
              (qPost : Predicate.t) 
              (subst : ((Var.t * TyD.t)* (Var.t * TyD.t)) list) : (VC.vctybinds * Predicate.t) = 
 *)

type wpresult =   Continue 
                | Flip (*Change Direction with information for the forward pass and a lookahead decision*) 
                | Break (*Change Direction without any lookahead*)
                | Complete 

let wpPreCheck gamma sigma delta wp : wpresult =
    
    Message.show ("\n Printing WP "^(Predicate.toString wp));
             
    let wp_weaker = Predicate.weakenWP wp in 
    Message.show ("\n Printing WP_WEAKER "^(Predicate.toString wp_weaker));
    
    let wpVC = VC.VC(gamma, delta, wp_weaker) in 


    let wpStandard = VC.standardize wpVC  in 
    

    
    let discharge_vc vcStandard = 
        try
        Message.show ("\n Printing VCs");
        Message.show ("\n"^(VC.string_for_vc_stt vcStandard));      
        let result = VCE.discharge vcStandard !typenames !qualifiers in 
            match result with 
            | VCE.Success -> 
                            true
            | VCE.Failure -> 
                            false
            | VCE.Undef -> raise (LearningException "Typechecking Did not terminate")  
            
         with
            VerificationC.Error e -> raise (LearningException "Checking a distingushing predicate did not terminate")

    in      

      Message.show ("\n Printing VCs");
      Message.show ("\n"^(VC.string_for_vc_stt wpStandard));      
      
    
    let wpCheck = discharge_vc wpStandard in 
    
    if (wpCheck) then 
        
        Continue 
    else 
        (*TODO :: expand on FLIP and BREAK CASES*)
       Break   
    







let learnP gamma dps (path:Syn.path) path_type disjuncts = 
    (* Message.show ("**************Show :: LearnP For Conflict Path ********"^(pathToString path));
    Message.show ("**************Show :: LearnP Initial DPS ********"^(DMap.toString dps));
     *)                 
    match path with 
    | [] -> raise (LearningException "learning called on an empty path")
    | x :: xs -> 
        let gammaMap = DPred.getGamma gamma in 
        let sigmaMap = DPred.getSigma gamma in 
        let deltaPred = DPred.getDelta gamma in 
        
        let conflictNode = List.hd (List.rev (path)) in 
        let conflictNode_var = Syn.componentNameForMonExp conflictNode in 
        
        (*get the older D(conflict) *)
        let dp_conflictNode = 
                                try 
                                    DMap.find dps conflictNode_var 
                                with 
                                    Knowledge.NoMappingForVar e -> DPred.empty

        in 
                    
        
        (*updating the D(conflict)*)
        (*inferSP (P, path) *)
        let RefTy.MArrow (eff, phi_k, (v, t), phi_k') = path_type in 
        
        let phi_s = phi_k' in

        (*calculate disj*)
       
        let learntPredicteDisj = List.fold_left (fun d di -> Predicate.Disj (d, di)) (Predicate.False) disjuncts in 
        let learntPredicteConj = phi_s in 
        let learnt_dp = DPred.DP {gammacap = gamma;learntConj= learntPredicteConj;
                                    (*we are ignoring the disj @Note : see how disjunctions are passed *)
                                    learntDisj = learntPredicteDisj; 
                                    previous=DPred.getPrevious dp_conflictNode} in 
        (*@Note : Source of exploded Gamma *)
        (*TODO :: Update Gamma by only taking the difference *)

        let updated_dp_conflictingNode = DPred.conjunction dp_conflictNode learnt_dp in 
        let updated_dps = DMap.replace dps conflictNode_var updated_dp_conflictingNode in 
                                   
        (updated_dps)

    
(*as a side effect also updates the visitedPaths*)
let backtrackC gamma ptypeMap dps path p2gMap spec = 
    let gammaMap = DPred.getGamma gamma in 
    let sigmaMap = DPred.getSigma gamma in 
    let deltaPred = DPred.getDelta gamma in 
        
    visitedPaths := path :: (!visitedPaths); 
    let conflict_node = List.hd (List.rev path) in  
    let conflictNodeComponent = Syn.componentNameForMonExp conflict_node in 
        
    match previousPath path with 
        | None -> raise (LearningException "No possible backtracking")
        | Some p_kminus1 ->
            try 
                if (List.length p_kminus1 > 0) then 
                    let k_minus1 = List.hd (List.rev p_kminus1) in 
                    let gamma_kminus1 = PGMap.find p2gMap p_kminus1  in 

                    (*let gammaMap_km1 = DPred.getGamma gamma_kminus1 in 
                    let sigmaMap_km1 = DPred.getSigma gamma_kminus1 in 
                    let deltaPred_km1 = DPred.getDelta gamma_kminus1 in 
                    TODO :: This might lead to unsoundness as the two paths will have two different Gamma*)
                    
                    (* let (gammaMap_km1, deltaPred_km1, ptypeMap, type_pkminus1) = SynTC.typeForPath ptypeMap gammaMap_km1 sigmaMap_km1 deltaPred_km1 spec p_kminus1 in 
                    Message.show ("Show >>>>>>>>>>>>>>>"^(RefTy.toString type_pkminus1));
                    
                    let var_k_minus1 = Syn.componentNameForMonExp k_minus1 in 
                    (*get the older D (Terminal (pk-1)*)
                    let dp_kminus1 = 
                                    try 
                                        DMap.find dps var_k_minus1
                                    with 
                                        Knowledge.NoMappingForVar e -> DPred.empty

                    in 
                    
                    let RefTy.MArrow (_, _, (_,_), post_kminus1 ) = type_pkminus1 in 
                    
                    let ann_k_type = Gamma.find gammaMap_km1 conflictNodeComponent in
                    (*the type for the conflict node can be an Arrow*)
                    
                    let ann_k_computation_type = RefTy.findComputationType ann_k_type in 
                                        
                    let RefTy.MArrow (_, pre_k,(_,_),_) = ann_k_computation_type in 

                    let gamma_kminus1 = DPred.T{gamma=gammaMap_km1; sigma = sigmaMap_km1; delta= deltaPred_km1} in 
                    
                    let learnt_predicate = Predicate.Not (Predicate.If (post_kminus1, pre_k)) in 
                    let diffpred_kminus1_k = DPred.DP {gammacap = gamma_kminus1; learnt=learnt_predicate;
                                                        previous=DPred.getPrevious dp_kminus1} in 
                        
                    let updated_dp_kminus1 = DPred.conjunction dp_kminus1 diffpred_kminus1_k in 
                    let updated_dps = DMap.replace dps var_k_minus1 updated_dp_kminus1 in 
                    (gamma_kminus1, p_kminus1, updated_dps, p2gMap, ptypeMap) 
              *)
                   
                    (gamma_kminus1, p_kminus1, dps, p2gMap, ptypeMap)     
                else 
                    (gamma, p_kminus1, dps, p2gMap, ptypeMap)     
            with 
                e -> raise e
              (*e -> raise (LearningException ("No gamma for Path "^(pathToString p_kminus1)))*)            




let backtrackBaseLine gamma dps path p2gMap spec = 
	let gammaMap = DPred.getGamma gamma in 
	let sigmaMap = DPred.getSigma gamma in 
	let deltaPred = DPred.getDelta gamma in 
		

	let conflict_node = List.hd (List.rev path) in  
	match previousPath path with 
		| None -> raise (LearningException "No possible backtracking")
		| Some p_kminus1 ->
			 (gamma, p_kminus1, dps, p2gMap)		
			  (*e -> raise (LearningException ("No gamma for Path "^(pathToString p_kminus1)))*)			


          



(*The function application synthesis for pure componenent, 
we can try to replace this with say SYPET/Sunquid*)
let rec esynthesizePureApp depth gamma sigma delta specs_path : (Gamma.t * (Syn.typedMonExp) list) = 
    
    (*This is a simplified version of the return typed guided component synthesis as in SYPET*)

    Message.show (" Pure Fun Application: esynthesizePureApp ");
    if (depth >= !max) then 
       (gamma, [])
    else    
    let spec = List.hd specs_path in 
    (*Currently only looking for a single step functon: filter pure functions
    To find paths in the library, we need to revise this to any function which can be called
    EXTEND*)
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
                Message.show ("Show Pure Component "^(Var.toString vi));
             
                match rti with 
                    | RefTy.Arrow ((varg, argty), _) -> 
                        Message.show (" *************** Trying Arrow Component ************"^(Var.toString vi)^" : "^(RefTy.toString rti));
                        let uncurried = RefTy.uncurry_Arrow rti in 
                        let RefTy.Uncurried (args_ty_list, retty) = uncurried in 

                        (*Currently the argument is always a scalar/Base Refinement*)
                        Message.show (" *************** Synthesizing Args ei : ti for ************"^(Var.toString vi));
                        

                        (* lists of terms which can be used as argument *)    
                        (* let e_potential_args_list =  
                            List.map (fun (argi, argtyi) -> 
                                let scalars = esynthesizeScalar depth gamma sigma delta [argtyi;retty] in 
                                let (_, funapps) = esynthesizePureApp (depth + 1) gamma sigma delta [argtyi;retty] in 
                                List.concat [scalars;funapps]
                            ) args_ty_list  in  *)

                        let (gamma, e_potential_args_list) =  
                            List.fold_left (fun (_g, pot_arg_list) (argi, argtyi) -> 
                                let scalars = esynthesizeScalar depth _g sigma delta [argtyi;retty] in 
                                let (_g, funapps) = esynthesizePureApp (depth + 1) _g sigma delta [argtyi;retty] in 
                                let acc_of_list_of_pot_args = List.append (pot_arg_list) (List.concat [scalars;funapps]) in 
                                (_g, acc_of_list_of_pot_args)
                            ) (gamma, []) args_ty_list  in 


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
                                    Message.show (" Show *************** Synthesizing Args ei : Failed for some  arg");
                                    choice xs gamma sigma delta 
                            | Some es -> 
                                Message.show (" Show *************** Successfully Synthesized Args ei Forall i ");
                                (*A Hack for the examples, solving this in a more fundamental way will require 
                                solving this combinatorial problem
                                [a11, a12.....a1n] [a21,....a2m]
                                will give total mxn choices to try, f (a1i, a2j) in worst case which will 
                                be costly.
                                So for more practical pursposes, we try all the second arguments if there are two args,
                                *)

                                let rec n_cartesian_product = function
                                    | [] -> [[]]
                                    | x :: xs ->
                                        let rest = n_cartesian_product xs in
                                        List.concat (List.map (fun i -> List.map (fun rs -> i :: rs) rest) x)  in 


                                let chooseArgs (argsListEach : ((Syn.typedMonExp) list ) list)   : (Syn.typedMonExp list) list   = 
                                        n_cartesian_product argsListEach        
                                
                                in 

                                let possible_args_lists = chooseArgs es in 

                                Message.show ("# of Possible Argument Options for "^(vi)^" "^(string_of_int (List.length possible_args_lists))); 
                                                        
                                let () = List.iter (fun li -> 
                                                    let () = Printf.printf "%s" ("\n Possible Arg Options ") in 
                                                    List.iter (fun ei -> Printf.printf "%s" 
                                                                ("\n EI "^(Syn.monExp_toString ei.expMon) )) li) possible_args_lists in 
                                
                                
                                
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
                                                             let bvi = Evar (Var.fromString ("_bv"^(string_of_int (!bvarcount)))) in 
                                                             let _ = bvarcount := !bvarcount + 1 in 
                                                             (bvi,  ei.ofType)) ei_hds in 


                                                    let varExp4monExp_es = List.map (fun (vi, ti) -> vi) nbvsTypes_es in     

                                                    let gamma =  
                                                            List.fold_left (fun _g (vi, ti) -> 
                                                                    let variablei = 
                                                                        (match vi with 
                                                                            | Evar v -> v 
                                                                            | _ -> raise(SynthesisException "Illegal Variable") ) in
                                                                        VC.extend_gamma (variablei, ti) _g) gamma nbvsTypes_es  in                                  


                                                    let appliedMonExp = Syn.Eapp (Syn.Evar vi, varExp4monExp_es) in  (*apply vi e_arg*)
                                                    let synthesizedExp = appliedMonExp in 
                                                    (* let lbindingtuples = Syn.visitnode appliedMonExp in 
                                                    let synthesizedExp = if (List.length lbindingtuples > 2)
                                                                        then Syn.exp4tuples lbindingtuples 
                                                                        else appliedMonExp in         
                                                    Message.show ("Synthesized Exp to be Typechecked "^(Syn.monExp_toString synthesizedExp));
                                                            *)
                                                    let funAppType =  SynTC.typecheck gamma sigma delta !typenames !qualifiers synthesizedExp spec in 
                                                   (match funAppType with 
                                                        | Some type4AppliedMonExp -> 
                                                              Message.show (" Show *************** TypeChecking Succsessful "^(RefTy.toString type4AppliedMonExp));
                                                              let applicationExpressions =  {expMon= synthesizedExp; ofType=type4AppliedMonExp} :: applicationExpressions in 
                                                              let bvname = Var.fromString ("_lbv"^(string_of_int (!bvarcount))) in 
                                                              let _ = bvarcount := !bvarcount + 1 in 
                                                              let _g = VC.extend_gamma (bvname, type4AppliedMonExp) _g  in                                  
                                                     
                                                              loop ei_tails _g applicationExpressions                                                                
                                                        | None ->  
                                                           Message.show (" FAILED Typechecking PURE APP For "^(Syn.monExp_toString synthesizedExp));    
                                                            loop ei_tails _g applicationExpressions 
                                                   )
                                    in            
                                    let (gamma, correctExpressions) = loop possible_args_lists gamma [] in 
                                    (match correctExpressions with 
                                        | [] -> (* Nothing found for this function, look for other functions *) choice xs gamma sigma delta  
                                        | x :: xs -> (gamma, correctExpressions) (*EXT : Even in this case we need to look for all the terms, i.e. other function *)
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
                                
                                            let (gamma, synthesizedExp) = 
                                                (match monExps_es with 
                                                    | Evar v ->  
                                                        let appliedMonExp = Syn.Eapp (Syn.Evar vi, [(monExps_es)]) in  (*apply vi e_arg*)    
                                                        (_g, appliedMonExp)
                                                    

                                                    | _ -> 
                                                        
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
                                            let funAppType =  SynTC.typecheck gamma sigma delta !typenames !qualifiers synthesizedExp spec in 
                                                match funAppType with 
                                                | Some type4AppliedMonExp -> 
                                                     Message.show (" Show *************** TypeChecking Succsessful "^(RefTy.toString type4AppliedMonExp));
                                                     let bvname = Var.fromString ("_lbv"^(string_of_int (!bvarcount))) in 
                                                     let _ = bvarcount := !bvarcount + 1 in 
                                                     let _g = VC.extend_gamma (bvname, type4AppliedMonExp) _g  in                                  
                                                     let eis =  {expMon= synthesizedExp; ofType=type4AppliedMonExp} :: eis in 
                                                     loop es_xs _g eis                                  
                                                | None -> 
                                                    Message.show (" FAILED Typechecking PURE APP For "^(Syn.monExp_toString synthesizedExp));    
                                                    loop es_xs _g eis 
                                  in 
                                  let (gamma, pureappexps) = loop allowed_only_argument_choices gamma [] in 
                                  match pureappexps with 
                                    | [] -> (* Nothing found for this function, look for other functions *) choice xs gamma sigma delta  
                                    | _ :: _ -> (gamma, pureappexps) (*EXT : Even in this case we need to look for all the terms *)

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
                                                            let scalars = esynthesizeScalar depth gamma sigma delta (cargtyi::specs_path) in 
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
and esynthesizeScalar depth gamma sigma delta specs_path  : (Syn.typedMonExp) list  = 
     
    if (depth >= !max) then 
        []
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
                              foundbyEnum   
                   | [] ->
                           Message.show (">>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< "); 
                           let (gamma, appterms) = esynthesizePureApp (depth+1) gamma sigma delta specs_path in 
                            (match appterms with 
                                | [] -> 
                                    Message.show (">>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< "); 
                                    let consAppterm = esynthesizeConsApp (depth+1) gamma sigma delta specs_path in 
                                    (match consAppterm with 
                                      | Some t2 ->  [t2]
                                      | None -> []
                                    )  
                                | _::_ -> appterms
                            )

                 )           
            |  RefTy.Arrow ((_,_),_) -> []
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
                | Some exp_n -> 
    
                      Message.show ("Show :: Successfully Synthesisized Nil Branch \n Now Trying Cons");
                      let e_c = synthesize depth gamma_c sigma delta_c spec  in 
                      (match (e_c) with 
                       | (Some exp_c)-> 
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
                        | None ->
                                Message.show ("Show :: Failed Synthesisized Cons Branch ");
                       
                                None) 
                 | None -> 
                            Message.show ("Show :: Failed Synthesisized Nil Branch");
                            None )           
        else 
            None  
    | _ ->   
        Message.show "Show :: Non List Case";
        None
       (*  synthesize gamma sigma delta spec learnConst !bidirectional !maxPathLength
   *)
  
 and isynthesizeIf depth gamma sigma delta spec : Syn.typedMonExp option = 
    Message.show ("iSynthesize If-THEN-ELSE "^(RefTy.toString spec));
    
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
    Message.show ("iSynthesize Boolean "^(RefTy.toString boolSpec));
    
    let bi_list = esynthesizeScalar depth gamma sigma delta [boolSpec] in 
    (*EXT :: loop over all possible choices of the boolean *)
    let bi_list  =List.rev (bi_list) in 
    match bi_list with 
        | eb :: _ ->
            (*get the predicate \phi in the If-rule for synthesis*)   
             (*either a fun-application or *)
             let eb_expmon = eb.expMon in  
             (*type for the eb_expmon*)
             let eb_type = eb.ofType in 
             let refTy4bi = eb_type in 
             Message.show ("Show :: iSynthesize Boolean Successful "^(Syn.monExp_toString eb_expmon));
             Message.show ("Show :: iSynthesize Boolean Successful "^(RefTy.toString eb_type));
            (*create true predicate = \phi /\ [v= true] & false predicate = \phi /\ [v=false]*)
             
             let (gamma, true_pred4bi, false_pred4bi) = createGammai gamma refTy4bi in 
             let delta_true 
              = Predicate.Conj (delta, true_pred4bi) in 
             Message.show (" *********************Synthesizing the True branch*******************");
             Message.show ("Show :: True Predicate "^(Predicate.toString true_pred4bi));

           
             (*\Gamma, [v=true]\phi |- spec ~~~> t_true*)
                      
             let t_true = synthesize depth gamma sigma delta_true spec  in 
             

            (match t_true with 
                | Some exp_true -> 
                      Message.show ("True Branch :: Successfully Synthesisized");
                      Message.show ("*********************************************");
                      Message.show ("************If Else False Branch**************");
                      Message.show ("*********************************************");
                      
                      Message.show ("False Branch :: Trying False Branch");
                      let delta_false = Predicate.Conj (delta, false_pred4bi) in 
                      (*\Gamma, [v=false]\phi |- spec ~~~> t_false*)
                       Message.show ("Show :: Synthesizing the false branch");
                       Message.show ("Show :: False Predicate "^(Predicate.toString false_pred4bi));
             

                      let t_false = synthesize depth gamma sigma delta_false spec  in 
                      (match (t_false) with 
                       | (Some exp_false)-> 
                              Message.show ("Show :: Successfully Synthesisized False Branch ");
                              let monexp_t_true = exp_true.expMon in 
                              let monexp_t_false = exp_false.expMon in 
                              let eite_exp = Syn.Eite (eb_expmon, monexp_t_true, monexp_t_false) in 
                              Some {Syn.expMon = eite_exp; Syn.ofType = spec} 
                        | None ->
                                Message.show ("Show :: Failed Synthesis False Branch ");
                                None
                       ) 
                 | None -> 
                            Message.show ("Show :: Failed Synthesis True Branch");
                            None 
            )           
        | [] -> 
            Message.show (" Show :: Failed to find a Pure Boolean Function App, Now looking for Effectful Bool Function");
            
            let bv_h = Var.get_fresh_var "h" in 
            let bv_h' = Var.get_fresh_var "h'" in 
            
            let pre = Predicate.Forall ([bv_h, Ty_heap], Predicate.True) in 
            let post = Predicate.Forall ([(bv_h, Ty_heap);(v, TyD.Ty_bool);(bv_h', Ty_heap)], Predicate.True) in 

                   let effBoolSpec = RefTy.MArrow (Effect.State, pre, (v, boolSpec), post) in  
            Message.show (" Type Constructed "^(RefTy.toString effBoolSpec)); 
            (*It returns a term of the form Eapp f ai >>= eskip*)
            
            (* run the effectful synthesis in a forwardmode only *)
            let oldbidirectional = !bidirectionalOn in 
            let _ = 
                if (!bidirectionalOn) then 
                    bidirectionalOn := false
                else 
                    () 
            in 
            Message.show ("\n EXPLORED & Show Calling Synthesis for Effectful Bool Function, Clearning Bidirectional"); 
            let boolArgs = synthesize depth  gamma sigma delta effBoolSpec  in
            
            Message.show ("\n EXPLORED & Show Back from Boolean Search, Resetting Bidirectional"); 
            let _ = bidirectionalOn := oldbidirectional in     
            match boolArgs with 
                | None -> 
                    Message.show ("Show :: Failed EffBool"); 
                    None
                | Some eb -> 
                    Message.show ("Show :: Successful EffBool App Found");
                    Message.show ("Show ::  Found "^(Syn.typedMonExp_toString eb));
                                      
                    let eb_expmon = eb.expMon in 
                    match eb_expmon with 
                        (*Extract the Type of the boolean valued call*)
                        | Ebind (bv, fappExp, _)  ->
                            let Eapp (funVar, argslist) = fappExp in 
                            (*get the type of the function from the Gamma*)
                            let Evar fbool = funVar in 
                            let fboolType =
                                    try 
                                        Gamma.find gamma fbool
                                    with 
                                     | e -> raise (SynthesisException "DEAD CODE")
                            in 
                            let uncurriedFBoolType = RefTy.uncurry_Arrow fboolType in 
                            let RefTy.Uncurried (_, resRefTy4b) = uncurriedFBoolType in 
                            
                            Message.show ("Show :: IF/ELSE Branch Synthesis in Gamma_i");
                                
                                 
                          
                            let (gamma',delta',_,sp_pre_AppFbool) = SynTC.typeForPath PTypeMap.empty gamma sigma delta spec [Edo (bv, fappExp)] in
                                   Message.show ("Show :: SP (Pre, eb"^(RefTy.toString sp_pre_AppFbool));
                            
                            

                            (*This will always be a case where the resRefTy4b will be MArrow as the Base case is handled in the other match case above
                            * *)
                            let (true_Pre, false_Pre) = createPreSpeci  sp_pre_AppFbool in 
                            
                            (* Message.show ("\n True Spec "^(Predicate.toString true_Pre)); 
                            Message.show ("\n False Spec "^(Predicate.toString false_Pre));
                             *)
                            (**the two new queries should be : 
                            SP (Pre, eb) /\ [v= true] v : original goal {Original Post}
                            SP (Pre, eb) /\ [v= false] v : original goal {Original Post}*)
                            
                            (*create SpecTrue and Spec False *)
                            let (gamma_true, specTrue) = SynTC.createP'_Q gamma' spec true_Pre in 
                            let (gamma_false, specFalse) = SynTC.createP'_Q gamma' spec false_Pre in 
 
                            (* let () = Printf.printf "%s" ("\n $$$$$$$SPEC >>>>"^(RefTy.toString spec)) in
                            
                            let () = Printf.printf "%s" ("\n $$$$$$$>>>>"^(RefTy.toString specTrue)) in
                            let () = Printf.printf "%s" ("\n $$$$$$$>>>>"^(RefTy.toString specFalse)) in  *)

                           
                            let t_true = synthesize depth gamma_true sigma delta' specTrue  in 
                            
                            match t_true with 
                                | Some exp_true -> 

                                      Message.show ("Show :: Successfully Synthesisized the True Branch Now Trying False Branch");
                                     
                                      (*\Gamma, [v=false]\phi |- spec ~~~> t_false*)
                                      let t_false = synthesize depth gamma_false sigma delta' specFalse  in 
                                      (match (t_false) with 
                                       | (Some exp_false)-> 
                                              Message.show ("Show :: Successfully Synthesisized False Branch ");
                                              let monexp_t_true = exp_true.expMon in 
                                              let monexp_t_false = exp_false.expMon in 
                                              let eite_exp = Syn.Eite (eb_expmon, monexp_t_true, monexp_t_false) in 
                                              Some {Syn.expMon = eite_exp; Syn.ofType = spec} 
                                        | None ->
                                                Message.show ("Show :: Failed Synthesis False Branch ");
                                                None
                                       ) 
                                 | None -> 
                                            raise (SynthesisException "BP : NONE");
                               
                                            Message.show ("Show :: Failed Synthesis True Branch");
                                            None 
                       
                               | _ -> raise (SynthesisException "The bool Valued Call should be a f i >>= skip");
                   
                        
                                    


(*Top level syntheis goals for Lambda, same as the traditional syntehsis rules
calls the top-level macthing and application followed by if-rule and then the standard learning based rule *)
and isynthesizeFun depth gamma sigma delta spec : Syn.typedMonExp option= 
  
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
       Some e_match
    | None -> 
         Message.show ("Match-case failed :: Try Top-level If-then-else "); 
         let if_exp = isynthesizeIf depth gamma_extended sigma delta retT in 
         match if_exp with 
            | Some e ->
                Message.show (" Found a If Then Else solution"); 
                Some e
            | None ->
                Message.show (" If then else Failed :: Try CDCL without subdivision\n "); 
                None
                (* synthesize depth gamma_extended sigma delta retT  *)
              
    
    
(*The main entry for the synthesize*)
(*In some cases the input spec can be more than the RefinementType*)
(*synthesize : TypingEnv.t -> Constructors.t -> RefinementType.t -> Syn.typedMonExp option *)
and  synthesize depth gamma sigma delta spec : (Syn.typedMonExp option)=  
    
    
   match spec with 
      | RefTy.Base (v, t, pred) -> 
            Message.show "Show ***********Calling Scalar synthesize***************";
            let syn_basetype_res = esynthesizeScalar depth gamma sigma delta [spec] in 
            (match syn_basetype_res with 
                | [] -> None
                | x :: _ -> 
                    let _ = List.iter (fun tmi -> 
                               Message.show ("Solution "^(Syn.typedMonExp_toString tmi))) syn_basetype_res 
                    in 
                    Some x 
            ) 
      | RefTy.Arrow (rta, rtb) -> 
            Message.show "Show ***********Calling S-FUNC synthesize***************";
            isynthesizeFun depth gamma sigma delta spec  (*applies Tfix and Tabs one after the other*)
      | _ ->
      
       raise (SynthesisException ("Unhanlded Case synthesis  for query spec "^(RefTy.toString  spec))) 






let toplevel gamma sigma delta types quals spec learning bi maxVal efilter : (Syn.typedMonExp option) = 
     (*set the global parameters *)
     learningOn := learning;
     bidirectionalOn := bi;
     efilterOn := efilter; 
     max := maxVal; 
     maxPathLength := !max;
     typenames := types;
     qualifiers := quals;
     synthesize 0 gamma sigma delta spec  
    


end

