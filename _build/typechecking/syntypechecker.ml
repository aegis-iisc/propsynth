module Syn = Lambdasyn
module VC = VerificationC   
open SpecLang 
module Gamma = Environment.TypingEnv 
module Sigma = Environment.Constructors
module Components = Environment.Components
module Explored = Environment.ExploredTerms 
module DPred = Knowledge.DiffPredicate
module DMap = Knowledge.DistinguisherMap
module PTypeMap = Knowledge.PathTypeMap


module VCE = Vcencode 
module P = Predicate  
module RP = Predicate.RelPredicate
module BP = Predicate.BasePredicate
exception SynthesisException of string 
exception Unhandled
open Syn



(*TODO : 1. This needs to be generalized for different alfgebraic constructors 
        2. Currently mannualy generating nil and cons preds, this has to be populated 
        by parsing relations from the programmer*)       
let generateNilConstraints (macthedArg) = 
      (*len (ls) = 0*)
      let nil_length = 
        P.Rel(RP.NEq 
              ( RelLang.R (RelLang.instOfRel (RelId.fromString "len"), macthedArg),
                RelLang.relexpr_for_int 0
              )
              )  
      in 
      let () = Printf.printf "%s" ("Nil Length "^(Predicate.toString nil_length)) in 
      nil_length  




let generateConsConstraints (macthedArg : Var.t) (arg_x: Var.t) (arg_xs : Var.t) = 
    let cons_length =  P.Rel
      (RP.NEq( 
        R( (RelLang.instOfRel (RelId.fromString "len")), macthedArg),
                        
       ADD(
          R ( RelLang.instOfRel (RelId.fromString "len"), 
                arg_xs
              ),
          RelLang.relexpr_for_int 1))
        )  in 
     let cons_length_grt_0 = 
      P.Rel(RP.Grt 
              ( R (RelLang.instOfRel (RelId.fromString "len"), macthedArg),
                RelLang.relexpr_for_int 0
              )
              )
      in 
      let cons_length = Predicate.Conj (cons_length, cons_length_grt_0) in 
  let () = Printf.printf "%s" ("Cons Length "^(Predicate.toString cons_length)) in 
      
    cons_length


(*
  build a typechecker for the given monExp term in the language
  \Gamma |- t : spec
  Just the checking for the fun application
 *)
let typecheck (gamma : Gamma.t) (sigma:Sigma.t) (delta : Predicate.t)
              (typenames : SpecLang.Var.t list) 
              (qualifiers : SpecLang.RelSpec.Qualifier.t list)
              (t : Syn.monExp) (spec : RefTy.t) : (RefTy.t option) = 
	  
    let () = Printf.printf "%s" ("\n Typechecking "^(Syn.monExp_toString t)) in 
    let () = Printf.printf "%s" ("\n Against "^(RefTy.toString spec)) in 
     match t with 
      | Eapp (funExp, argsList) (*Eapp foo [x1, x2, x3,...xn] *) -> 
          let Evar funName = funExp in 
          let funType = try 
                 Gamma.find gamma funName 
                 with 
                  | e -> raise (SynthesisException "EApp Typechecking : Function Type Missing")
          in 
          (match funType with 
              | RefTy.Arrow ((_,_), _) -> 
                (*Implements the pure-fun app rule *)
                let uncurried = RefTy.uncurry_Arrow funType in 
                let RefTy.Uncurried (formalsList, retTy) = uncurried in
                (*create substitution (actuals, foramls)*)
                let formals = List.map (fun (vi, ti) -> vi) formalsList in 
                (*each arg in argsList will actuall be of the foram Evar 
                from the restriction of normal-forms
                *)
                let actuals = List.map (fun (vi) -> Syn.componentNameForMonExp vi) argsList in 
                (*We DO NOT need to check types and lengths for actual and formal 
                as these are synthesized and we get it for free from the soundness of the synthesis
                *)
                let actualsTypes = 
                    List.map (fun vi -> 
                      let vi_var = Syn.componentNameForMonExp vi in 
                      let vi_type = 
                        try 
                          Gamma.find gamma (vi_var) 
                        with 
                          | e -> raise (SynthesisException "EApp Typechecking : Argument Missing")
                      in 
                      let RefTy.Base (nu, tb, phi_i) = vi_type in 
                      let phi_i_applied = Predicate.applySubst (vi_var, nu) phi_i in 
                      (vi_var, vi_type, phi_i_applied) 
                      ) argsList in 

                let () = List.iter(fun (vi, vi_type, phi_i) ->  
                          Printf.printf "%s" ("\n Argument "^(vi)^" :: "^(RefTy.toString vi_type)^" | "^(Predicate.toString phi_i) )) actualsTypes in 

                let delta_extended = List.map (fun (_, _, phi_i) -> phi_i) actualsTypes in 

                
                
                let subs = List.combine actuals formals in 
                (*create the type [actuals/foramls] retTy*)
                let appType = RefTy.applySubsts subs retTy in 

                 let () = Printf.printf "%s" ("\n AppType "^(RefTy.toString appType)) in 
   
                (*the subtyping check*)

                let vc = VC.fromTypeCheck gamma (delta::delta_extended) (appType, spec) in 
                let () = Printf.printf "%s" ("\n  VC "^VC.string_for_vc_t vc) in  
                
                (*make a direct call to the SMT solver*)
                let vcStandard = VC.standardize vc in 
                let () = Printf.printf "%s" ("\n Standardized VC "^VC.string_for_vc_stt vcStandard) in  
                let result = VCE.discharge vcStandard typenames qualifiers  in 
                let typechecks = 
                  match result with 
                  | VCE.Success -> true
                  | VCE.Failure -> false
                  | VCE.Undef -> raise (SynthesisException "Typechecking Did not terminate")  
                in 
                if (typechecks) then 
                  Some appType
                else 
                  None
              | _ -> raise (SynthesisException ("Funtype must be t1 -> t2, but found "^(RefTy.toString funType)))
             )        

      | _ -> raise (SynthesisException ("Unhandled typecheck :: "^(Syn.monExp_toString t)))
       
  
open VerificationC
open TyD    
(*ret : x : t -> M {true} v : t {\forall h v h'. h' = h /\ v = x}*)
let mon_ret   (delta : Predicate.t) 
              (_Gamma: VerificationC.vctybinds) 
              (var_x : Var.t)
              (x_ty : RefTy.t) = 



                let x_tyd = RefTy.toTyD x_ty in 
               (*Create Bounded new type*)
                (*no type inference so need to provide the type for the bound variable of a formula*)
                let bv_h = Var.get_fresh_var "h" in 
                (* let _Gamma = VC.extend_gamma (bv_h, (RefTy.lift_base Ty_heap)) _Gamma in  *)
                let bv_v = Var.get_fresh_var "v" in 
                (* let _Gamma = VC.extend_gamma (bv_v, x_ty ) _Gamma in  *)
                let bv_h' = Var.get_fresh_var "h'" in 
                (* let _Gamma = VC.extend_gamma (bv_h', (RefTy.lift_base Ty_heap)) _Gamma in  *)
               
                let pre =  P.Forall ([(bv_h, Ty_heap)], P.True) in 
                let post_conjunct1 = P.Base (BP.Eq (BP.Var bv_h, BP.Var bv_h')) in 
                let post_conjunct2 = P.Base (BP.Eq (BP.Var bv_v, BP.Var var_x)) in 
   
                
                let local_var_binds = [(bv_h, Ty_heap);(bv_v, x_tyd);(bv_h', Ty_heap) ] in 
                
                let post = P.Forall (local_var_binds, P.Conj (post_conjunct1, post_conjunct2)) in 

                let retType = RefTy.MArrow (Effect.Pure, 
                                    pre , (bv_v, x_ty), post) in

                 (_Gamma, delta, retType)   

(*The bind rule*)
let mon_bind  (acc_delta : Predicate.t) 
              (acc_gamma: VerificationC.vctybinds) 
              (acc_type: RefTy.t) 
              (ci_type :RefTy.t)
              (* bvi <- SP (SP (P , pi), ci_type) *)
              (bvi : Var.t) = 
     match (acc_type, ci_type) with 
      | (RefTy.MArrow (eff1, phi1, (v1,t1), phi1') , RefTy.MArrow (eff2,phi2, (v2, t2), phi2')) -> 
              
                let fresh_h_int = Var.get_fresh_var "h_int" in 
                let _Gamma = VC.extend_gamma (fresh_h_int, (RefTy.lift_base Ty_heap)) acc_gamma in 
      

                
               (*Create Bounded new type*)
                (*no type inference so need to provide the type for the bound variable of a formula*)
                let bv_h = Var.get_fresh_var "h" in 
                (* let _Gamma = VC.extend_gamma (bv_h, (RefTy.lift_base Ty_heap)) _Gamma in  *)
                let bv_x = Var.get_fresh_var "x" in 
                let _Gamma = VC.extend_gamma (bv_x,  t1) _Gamma in  
                let bv_h' = Var.get_fresh_var "h'" in 
                (* let _Gamma = VC.extend_gamma (bv_h', (RefTy.lift_base Ty_heap)) _Gamma in  *)
                
				      (*Following type is now created in this extended environment*)
                (*\forall x, h_int. ( \phi1') h x h_int => \phi2 h_int x)*)
                        
               
                 
                (*phi1 h*)
                let f1_pre = (VC.apply phi1 [(bv_h, Ty_heap)]) in 
                

                (* We do not SP (P, pi) => Pre as this is checked separately in hoarePre Check *)   
                (* let f2_pre =  P.If ((VC.apply phi1' [(bv_h, Ty_heap); (bv_x, RefTy.toTyD t1); (fresh_h_int, Ty_heap)]), 
                                    ((VC.apply phi2 [(fresh_h_int, Ty_heap)]))
                                                  ) *)
                                            
                                        
                                     

                
(* 
                let bind_pre (*create pre-condition*) =  P.Forall ([(bv_h, Ty_heap)], P.Conj (f1_pre, f2_pre))  in  *)
                  
               let bind_pre (*create pre-condition*) =  P.Forall ([(bv_h, Ty_heap)], (f1_pre))  in 
               
                (*creating post*)
                (*forall v h h' x h_int. phi1 x h h_int*)
                let (bv_v)= Var.get_fresh_var "v" in 
                (* let _Gamma = VC.extend_gamma (bv_v,  t2) _Gamma in  *)
                
                (*
                  This is an ungly hack, as we do not define a type for let x = e1 in e2
                  Add the the result var bvi in bv1 <- M2 .. to the env, if the second computation is
                  return x, then there is no bound var *)
                let _Gamma = 
                  if (Var.toString bvi = "skip") then 
                    _Gamma
                  else 
                    VC.extend_gamma (bvi, t2) _Gamma 

                  in 
                  
                (*Add h' to the Gamma*)

(*                 let () = 
                Printf.printf "%s" ("\n POST NON APPLIED "^(P.toString phi2')) in 
 *)               
                let local_var_binds = [(bv_h, Ty_heap);(bv_v, RefTy.toTyD t2);(bv_h', Ty_heap) ] in 
                let post_conjuntc1 = ( VC.apply phi1' [(bv_h, Ty_heap);(bv_x, RefTy.toTyD t1);(fresh_h_int,Ty_heap)]) in 
                (*binding of the variable and the return variable*)
                let post_conjuntc2 = (VC.apply phi2' [(fresh_h_int ,Ty_heap);(bv_v, RefTy.toTyD t2); (bv_h', Ty_heap)]) in 
                
                  (*\forall bind_post. we shoud also have [bv_i/bv_v]bind_post *)

               
                (* let bind_ret = P.applySubst (bvi, bv_v) post_conjuntc2 in 
                 *)
                  
                let bind_ret = 
                 if (Var.toString bvi = "skip") then 
                   P.True
                  else 
                    P.Base (BP.Eq (BP.Var bvi, BP.Var bv_v)) 
                  
                in 



                
               (*  let post_conjuntc3 = Predicate.reduce (bvi, bv_v) post_conjuntc2 in 
                *) 
               let bind_post (*create post-condition*) = 
                if (Var.toString bvi = "skip") then 
                  P.Forall (local_var_binds, P.Conj (post_conjuntc1, post_conjuntc2))
                else 
                    P.Forall (local_var_binds, P.Conj 
                      (P.Conj (post_conjuntc1, post_conjuntc2), bind_ret))
               in 

                (*least uppper bound*)
                let lubM = Effect.lub eff1 eff2  in                 
                let new_acc_ty = RefTy.MArrow (lubM, bind_pre , (bv_v,t2), bind_post) in
                
                
                
              (*clean up the gamma*)
                let bv_phi1 = List.map (fun (vi, ti) -> vi) (Predicate.getBVs phi1) in 
                let bv_phi1' = List.map (fun (vi, ti) -> vi) (Predicate.getBVs phi1') in
                let bv_phi2 = List.map (fun (vi, ti) -> vi) (Predicate.getBVs phi2) in
                let bv_phi2' = List.map (fun (vi, ti) -> vi) (Predicate.getBVs phi2') in

              
                let _Gamma = List.fold_left (fun _gamma vi -> VC.remove_from_gamma vi _gamma) _Gamma bv_phi1 in 
                let _Gamma = List.fold_left (fun _gamma vi -> VC.remove_from_gamma vi _gamma) _Gamma bv_phi1' in 
                let _Gamma = List.fold_left (fun _gamma vi -> VC.remove_from_gamma vi _gamma) _Gamma bv_phi2 in 
                let _Gamma = List.fold_left (fun _gamma vi -> VC.remove_from_gamma vi _gamma) _Gamma bv_phi2' in 

               (*  let () = Printf.printf "%s" (" \n \n \n >>>>>>>>>>>>>>>>>>>>>>>>>> GAMMA AFTER REMOVAL  "^(string_of_int (List.length _Gamma))^" = "^(string_gamma _Gamma)) in  
                *) 
                (_Gamma, acc_delta, new_acc_ty)
                        
                
      | (RefTy.MArrow (eff1, phi1, (v1,t1), phi1') , RefTy.Base (vbase, tbase, phibase)) -> 
            let _Gamma = acc_gamma in 
       


            let bv_h = Var.get_fresh_var "h" in 
            (* let _Gamma = VC.extend_gamma (bv_h, (RefTy.lift_base Ty_heap)) _Gamma in  *)
            let bv_x = Var.get_fresh_var "x" in 
            
            let ret_ty_subs = RefTy.applySubsts [(bv_x, vbase)] ci_type in 
            
            let _Gamma = VC.extend_gamma (bv_x, ret_ty_subs) _Gamma in 
            let bv_h' = Var.get_fresh_var "h'" in 
            (* let _Gamma = VC.extend_gamma (bv_h', (RefTy.lift_base Ty_heap)) _Gamma in  *)
            
            let res_pre = VC.apply phi1 [(bv_h, Ty_heap)] in 
            
            let res_phibase = P.reduce (bv_x, vbase) phibase in 
            
            let res_post  = VC.apply phi1' [(bv_h ,Ty_heap);(v1, RefTy.toTyD t1); (bv_h', Ty_heap)]  in 
            
            let res_post = P.Conj (res_post, res_phibase) in

            let bind_pre (*create pre-condition*) =  P.Forall ([(bv_h, Ty_heap)], res_pre)  in 
                
            let local_var_binds = [(bv_h, Ty_heap);(bv_x, tbase);(bv_h', Ty_heap) ] in 
                
            let bind_post (*create post-condition*) = 
                 P.Forall (local_var_binds, res_post)  in 

              let lubM = eff1  in                 
              let new_acc_ty = RefTy.MArrow (lubM, bind_pre , (bv_x, ci_type), bind_post) in
        
                (*clean up the gamma*)
                let bv_phi1 = List.map (fun (vi, ti) -> vi) (Predicate.getBVs phi1) in 
                let bv_phi1' = List.map (fun (vi, ti) -> vi) (Predicate.getBVs phi1') in
                
              
                let _Gamma = List.fold_left (fun _gamma vi -> VC.remove_from_gamma vi _gamma) _Gamma bv_phi1 in 
                let _Gamma = List.fold_left (fun _gamma vi -> VC.remove_from_gamma vi _gamma) _Gamma bv_phi1' in 
                


            (_Gamma, acc_delta, new_acc_ty)
                
    

      | (_, _) -> 
             
            raise (SynthesisException ("Mon-bind :: binding non copmputations "^(RefTy.toString acc_type)^(" >>= ")^(RefTy.toString ci_type)^" \n"))     



(*path is a list of variables
This is the implementation for the SP (P, e) = 
∃ h 0 .(∃ ν .(∀ h.((P )h 0 ∧ (((({y/x}Q 1 )h 0 )ν 0 )h)))) 

*)
let typeForPath ptypeMap gamma sigma delta spec  (path:Syn.path)   = 

  (*acc_type = SP (P, pi)
   remaining = ci+1... *)
let rec accumulatePathType remaining_path acc_gamma acc_delta acc_type = 
  match remaining_path with 
    [] -> (acc_gamma, acc_delta, acc_type) 
    | ei :: cs -> 
    	(*A path is a list of do expressions of the form do x1 <- e1; do x2 <- e2;...*)
      match ei with 
        | Edo (bvarMonExp, monExp) -> 
          let Syn.Evar bvar = bvarMonExp in 
          (*TODO :: HERE is the bug, we need to map the actual to the formal*)
          (*Note to future self , this breaks the u_fun_param1.spec *)
          (match monExp with 
            | Syn.Eapp (lambda, argsList) -> 
                  let Evar funName = lambda in
                  let funType = 
                    try  
                      Gamma.find gamma funName 
                     with 
                      | Environment.NoMappingForVar msg -> Sigma.find sigma funName
          
                   in 
                   (match funType with 
                     | RefTy.MArrow (_,_,(_,_),_) ->
                        let (acc_gamma, acc_delta, acc_type) = 
                          mon_bind acc_delta acc_gamma acc_type funType bvar in
                          accumulatePathType cs acc_gamma acc_delta acc_type
                     | RefTy.Arrow ((_,_), _) -> 
                          let uncurried = RefTy.uncurry_Arrow funType in 
                          let RefTy.Uncurried (formalsList, retTy) = uncurried in 
                           (*create substitution (actuals, foramls)*)
                          let formals = List.map (fun (vi, ti) -> vi) formalsList in 
                          let actuals = List.map (fun (vi) -> Syn.componentNameForMonExp vi) argsList in 
                          (*We DO NOT need to check types and lengths for actual and formal 
                          as these are synthesized and we get it for free from the soundness of the synthesis
                          *)
                          let subs = List.combine actuals formals in 
                          (*create the type [actuals/foramls] retTy*)
                         let () = Printf.printf "%s" "\n Actuals" in
                         let () = List.iter (fun vi -> 
                                Printf.printf "%s" (Var.toString vi)) actuals in 
                         let () = Printf.printf "%s" "\n Formals" in
                         let () = List.iter (fun vi -> 
                                Printf.printf "%s" (Var.toString vi)) formals in 
                          let appType = RefTy.applySubsts subs retTy in 
                          let RefTy.MArrow (eff, pre, (v,t), post) = appType in 
                          let predApplied = Predicate.applySubsts subs pre in 
                          
                          let postApplied = Predicate.applySubsts subs post in 
                          (*Some bug in the RefTy applySubs, missied the application, 
                          we do an explicit application here*)                               
                          let appType = RefTy.MArrow (eff, predApplied, (v,t), postApplied) in 
                  
                          let (acc_gamma, acc_delta, acc_type) = 
                          mon_bind acc_delta acc_gamma acc_type appType bvar in
                          accumulatePathType cs acc_gamma acc_delta acc_type
                     ) 
                                  
            
            | _ -> raise (SynthesisException "Illegal do , allowed only do x <- apply f (?args)")
          )  
      | Eret (retVarMonExp) ->
          (*two types of retrun expressions.
            return boundVar
            return Foo (boundVari)
          *)
          match retVarMonExp with 
            | Syn.Evar (v_ret) ->  
              (*implement the P v: t Q >>= return v_ret*)
              let type_v_ret = 
                 try  
                    Gamma.find gamma v_ret  
                  with 
                    Environment.NoMappingForVar msg -> 
                       raise (SynthesisException ("No Mapping for return Var "^(Var.toString v_ret)))
              in 
              
              let (acc_gamma, delta, liftedType) = mon_ret acc_delta acc_gamma v_ret type_v_ret    in 
              let () = Printf.printf "%s" ("\n Lifted Type"^ (RefTy.toString liftedType)) in 
              (*return will be the last monExp *)
              (*create a new variable to bind the result of the M >>= ret v*)
              let v_skip = Var.fromString "skip" in 
              mon_bind delta acc_gamma acc_type liftedType v_skip
            | Syn.Eapp (funName, args) -> 
                
                raise (SynthesisException ("return F (A) not Allowed "^(Syn.monExp_toString funName)));
          

    in               
    try 
      let foundpType = PTypeMap.find ptypeMap path in 
      let () = Printf.printf "%s" ("\n Found a type for the path in the PMap") in
      (* let () = Printf.printf "%s" (RefTy.toString foundpType) in *)
      (gamma, delta, ptypeMap, foundpType) 
       
    with 
      Knowledge.NoMappingForVar e ->     
          (*
          given a pre, create an init path type of length 0
          the case : for an skip term, SP (P, skip) = ∃ h 0 .(∃ ν .(∀ h.((P )h 0 ∧ (((({y/x}P )h 0 )ν 0 )h))))
          Pure pre v : Top {\forall h v h', [h = h'} 
          *)
          let RefTy.MArrow (_, pre,  (_,_), post) = spec in 
          let initial_effect = Effect.Pure in 
          let retResult = Var.get_fresh_var "v" in 
          let unKnownType = RefTy.Base (retResult, TyD.Ty_unknown , Predicate.True) in 
          let bv_h = Var.get_fresh_var "h" in 
          let gamma = VC.extend_gamma (bv_h, (RefTy.lift_base Ty_heap)) gamma in 
          let bv_x = Var.get_fresh_var "x" in 
          let  gamma  = VC.extend_gamma (retResult,  unKnownType) gamma in 
          let bv_h' = Var.get_fresh_var "h'" in 
          let gamma = VC.extend_gamma (bv_h', (RefTy.lift_base Ty_heap)) gamma in 

          let pre_h = VC.apply pre [(bv_h, Ty_heap)] in 
          let pre_h' = VC.substi pre (bv_h', Ty_heap) 1 in 
          
          let pre_h_v_h' = VC.apply pre_h' [(bv_h', Ty_heap)] in 
          
          
          let post = P.Base (BP.Eq (BP.Var bv_h, BP.Var bv_h')) in 
 
          let preInit = P.Forall ([(bv_h, Ty_heap)], pre_h) in 
          let postInit = P.Forall ([(bv_h, Ty_heap);(retResult, Ty_unknown);(bv_h', Ty_heap)], P.Conj (pre_h, post)) in 
          let initial_type = RefTy.MArrow (initial_effect, 
             										preInit, (retResult, unKnownType), 
             										postInit) in
             				
           let (gammaMap, deltPred, path_type) = 
              accumulatePathType path gamma delta initial_type   
           in 
           let ptypeMap = PTypeMap.add ptypeMap path path_type in 
           (gammaMap, deltPred, ptypeMap, path_type)


let typeCheckPath ptypeMap gammaMap sigmaMap deltaPred 
           (typenames : SpecLang.Var.t list) 
           (qualifiers : SpecLang.RelSpec.Qualifier.t list)
           (path : Syn.path) (spec : RefTy.t) = 
  	
    let (gammaMap, deltaPred, ptypeMap, path_type) = 
			   typeForPath ptypeMap gammaMap sigmaMap deltaPred spec path in 
	 (* let () = Printf.printf "%s" ("\n Show Type for path "^(Syn.pathToString path))  in 
   let () = Printf.printf "%s" ("\n "^(RefTy.toString path_type)) in  *)

	  let gammacap = DPred.T{gamma=gammaMap;
							sigma = sigmaMap;
							delta = deltaPred} in 
			 

	let RefTy.MArrow (eff, _,(vspecp, tspec),_) = spec in 
	let RefTy.MArrow (effi, _,(vpath, tpath),_) = path_type in 
	 
  let basePath = RefTy.toTyD tpath in 
  let baseSpec = RefTy.toTyD tspec in 
 
                 
    if ((not (Effect.isSubEffect effi eff))
      || (not (TyD.sametype  basePath baseSpec) && not (TyD.Ty_unknown == baseSpec)))  
            then (false , ptypeMap, gammacap, path_type)   
    
    else    

           
          let () = Printf.printf "%s" ("Found Path Type "^(RefTy.toString path_type)) in 
          let () = Printf.printf "%s" ("Compared Against Spec "^(RefTy.toString spec)) in 
	         
	       	let vc = VC.fromTypeCheck gammaMap [deltaPred] (path_type, spec) in  

	        (*make a direct call to the SMT solver*)
	        let vcStandard = VC.standardize vc in 
	        let () = Printf.printf "%s" (VC.string_for_vc_stt vcStandard) in  
	        let result = VCE.discharge vcStandard typenames qualifiers  in 
	        match result with 
	        | VCE.Success -> 
                          (true, ptypeMap, gammacap, path_type)
                        
	        | VCE.Failure ->

	                   (false,ptypeMap, gammacap, path_type) 
	        | VCE.Undef -> raise (SynthesisException "Typechecking Did not terminate")  
	 
let verifyWP gammacap 
      (typenames : SpecLang.Var.t list) 
      (qualifiers : SpecLang.RelSpec.Qualifier.t list)
       (pre : Predicate.t)
       (wp : Predicate.t) : bool =

    let () = Printf.printf "%s" (" Show :: VerifyWP for the WP Predicate \n "^(Predicate.toString wp)) in 
    let () = Printf.printf "%s" (" \n Show :: Given Pre "^(Predicate.toString pre)) in 
   
    let gammaMap = DPred.getGamma gammacap in 
    let sigmaMap = DPred.getSigma gammacap in 
    let deltaPred = DPred.getDelta gammacap in 

    let bvs = Predicate.getBVs wp in 
    if (List.length bvs = 3) then  (*If the initial post then return false, else 
        trivial synthesis *)
      (false)
    else 

      let bv_h = Var.get_fresh_var "h" in 
      let gammaMap = VC.extend_gamma (bv_h, (RefTy.lift_base Ty_heap)) gammaMap in 
             
      let pre_applied = VC.apply pre [(bv_h, TyD.Ty_heap)] in 
      let wp_applied = VC.apply wp [(bv_h, TyD.Ty_heap)] in 

      let pre_imp_wp = P.Forall ([(bv_h, Ty_heap)],
                     P.If (pre_applied, wp_applied)) in 

      let vc = VC.VC(gammaMap, deltaPred, pre_imp_wp) in 

      let vcStandard = VC.standardize vc in 
      let () = Printf.printf "%s" (VC.string_for_vc_stt vcStandard) in  
            let result = VCE.discharge vcStandard typenames qualifiers  in 
            (*May need to return*)
            match result with 
            | VCE.Success -> 
                            (true)
                          
            | VCE.Failure ->

                       (false) 
            | VCE.Undef -> raise (SynthesisException "Typechecking Did not terminate")  
      
(*  spec = forall h1... v1 : _ \forall h1, v1, h1'
    p' = \forall h2 v2 h2' phi_p'
    
    -> 
    \exists h2, v2. \forall phi_p' [h2' -> h1])
     *)            
let createP'_Q gamma (spec : RefTy.t) (p' : Predicate.t) = 
  match spec with 
    | MArrow (eff, pre_spec, (v, t), post_spec) -> 
        let P.Forall (bvs_p', p'_pred) = p' in 
        let (h2,_)  = List.nth bvs_p' 0 in 
        let (v2, t2) = List.nth bvs_p' 1 in 
        let (h2', t2') = List.nth bvs_p' 2 in 
        
        let gamma = VC.extend_gamma (h2, (RefTy.lift_base Ty_heap)) gamma in 
        let gamma = VC.extend_gamma (v2, (RefTy.lift_base t2)) gamma in 

        let P.Forall (bvs_prespec,_) = pre_spec in 
        let (h1, t1) = List.nth bvs_prespec 0 in 

        let p'_pred =  P.applySubst (h1, h2') p'_pred in 
        let out = P.Forall ([(h1, Ty_heap)], p'_pred) in 

        let p'_q = RefTy.MArrow (eff, out, (v, t), post_spec) in 

       (gamma, p'_q) 
       
    | _ -> raise (SynthesisException "SynTC :: Illegeal body Type");
                          