module TransTC = TransTypeChecker
exception ProgramTCError of string 
module Trans = TypedTransLang
module RefTy = SpecLang.RefTy

module VC = TransTC.VerificationC
open SpecLang
module P = Predicate
module BP = P.BasePredicate  
open TyD    
(*type gammaEnv = {binds : VC.vctybinds; preds : Predicate.t list}  *)
                
type gammaEnv = VC.vctybinds    





(*Main typing rules from the Paper implementingVC generation*)
(*TODO check if we need standardt or t is sufficient*)                 
let rec type_synthesize_program (env : gammaEnv) (p:Trans.program) : (gammaEnv* Trans.ty * ((VC.t) list) ) =  
  match p with 
        (*iota case*)
        | ST _ -> 
                 
                 let () = Printf.printf "%s" ("\n ********************************************************************\n") in 
                 let () = Printf.printf "%s" ("\n ****************Synthesizing Type for ST **************************\n") in 
                 let () = Printf.printf "%s" ("\n ******************************************************************\n") in 

                type_check_program env p     
        | Lambda (argt, argty, pbody) -> (*synthesize*)
   
                 let () = Printf.printf "%s" ("\n ********************************************************************\n") in 
                 let () = Printf.printf "%s" ("\n ****************Synthesizing Type for Lambda **************************\n") in 
                 let () = Printf.printf "%s" ("\n ******************************************************************\n") in 


               (match argt with 
                | T_var v ->
                   let env_plus = VC.extend_gamma (v, argty) env in 
                   (*Γ, x : τ ⊢ T : M φ  t1  φ' *)

                   let (env', ty_body, vcs_body) = type_synthesize_program env_plus pbody in 
                   
                    let () = Printf.printf "%s" ("\n Type Checking Successful body \n") in 
                    let () = Printf.printf "%s" ("\n Inferred type Ref-Type : "^(RefTy.toString ty_body)) in 

                   (*synthesize*)
                   let lambda_ty = RefTy.Arrow ((v, argty) , ty_body) in 
                   (env', lambda_ty, vcs_body) 
                | _ -> raise (ProgramTCError "Illegal Lambda structure")        
               )        
                        
        | Bind  (p1, p2) ->
                let () = Printf.printf "%s" ("\n ********************************************************************\n") in 
                let () = Printf.printf "%s" ("\n ****************Synthesizing Type for Bind **************************\n") in 
                let () = Printf.printf "%s" ("\n ******************************************************************\n") in 
                let () = Printf.printf "%s" ("#########################################################################
                                                \n ENV "^(VC.string_gamma env)) in 
          
                let (env', ty1, vcs_p1) = type_synthesize_program env p1 in

                let () = Printf.printf "%s" ("\n Type Checking Successful for p1 \n") in 
                let () = Printf.printf "%s" ("############################################################################
                                                \n ENV "^(VC.string_gamma env')) in 
                let () = Printf.printf "%s" ("\n Ref-Type>> : "^(RefTy.toString ty1)) in 
                                  
               (match p2 with   
                     | Lambda (argt, argty, pbody) -> 
                         
                              (match argt with 
                                | T_var v -> let 
                                  env_plus = VC.extend_gamma (v, ty1) env' in
                                  let (env', ty2, vcs_p2) = type_synthesize_program env_plus p2 in 
                                 (*get the effects M1 and M2 for ty1 and ty2*)
                                  
                                  let () = Printf.printf "%s" ("\n Type Successful for p2 \n") in 
                                  let () = Printf.printf "%s" ("\n Ref-Type>> : "^(RefTy.toString ty2)) in 
                                  let () = Printf.printf "%s" ("------------------------------------------------------------------------------
                                                \n ENV "^(VC.string_gamma env)) in 
 
                                  let m1 = RefTy.get_effect ty1 in 
                                  let m2 = RefTy.get_effect ty2 in 
                                  let () = Printf.printf "%s" ("\n Calculating lub  \n") in 

                                  let lubM = (*M*)RefTy.lub_effects ty1 ty2 in
                                 
                                  let () = Printf.printf  "%s" ("\n lubM "^(Effect.toString lubM)) in 
                                  (*will issue a warning of not all cases macthing*)
                                  let body_type_ty1 = RefTy.getBodyType ty1 in 
                                  let RefTy.MArrow (e1, phi1, t1, phi1') = body_type_ty1 in 
                                 
                                  let body_type = RefTy.getBodyType ty2 in     
                                  let RefTy.MArrow (e2, phi2, t2, phi2') = body_type  in 
                                  
                                  let fresh_h = Var.get_fresh_var "h" in 
                                  let fresh_x = Var.get_fresh_var "x" in 
                                  let fresh_h_int = Var.get_fresh_var "h_int" in 


                                  (*add x and h_int to gamma*)



                                  (*lift the constraint in the lower effect to one in the upper effect
                                   * This has to be defined for each value of lower and upper*)
                                  (*let m1_lift_M_phi1  = Effect.liftM m1 lubM phi1 in 
                                  let m1_lift_M_phi1' = Effect.liftM m1 lubM phi1' in 
                                  let m2_lift_M_phi2 = Effect.liftM m2 lubM phi2 in *)
                                   
                                  let lifted_ty1 = RefTy.liftM body_type_ty1 lubM in 
                                  let lifted_ty2 = RefTy.liftM body_type lubM in 
                                  (*what if the lifted is arrow*)      
                                  let RefTy.MArrow (e_lub, phi1_star, _, phi1'_star) = lifted_ty1 in 
                                  let RefTy.MArrow (e_lub, phi2_star, _, phi2'_star) = lifted_ty2 in 
                                        

                                   
                                  (*create bind pre*)
                                  
                                  (* 
                                   *
                                   * We assume that all the bound variable have the same naming structure h x h_int etc 
                                   * TODO :: Create a general substitution of bounded variables so that we can substitute one or more or all of the bound variables*)
                                  let pre_1 = VC.apply phi1_star [(fresh_h, TyD.Ty_heap)] in  
                                  let pre_2 = VC.apply phi1'_star [(fresh_h, TyD.Ty_heap);(fresh_x, t1);(fresh_h_int, TyD.Ty_heap)] in 
                                  let pre_3 = VC.apply phi2_star [(fresh_h_int, TyD.Ty_heap)] in 
                                  let pre_3 = P.reduce (fresh_x, v) pre_3 in 
                                  let p_2_imp_3 = P.If (pre_2 , pre_3) in 
                                  let p_1_conj_2_3 = P.Conj (pre_1, p_2_imp_3) in 
                                  let var_binds_pre = [(fresh_h, Ty_heap)] in    
                                 (*∀h, x, h int
                                  * phi* h 
                                  * ∧(φ1 ′∗ )(h x h int )) =⇒ (φ2 ∗ ) h int*)
                                  let pre_phi = P.Forall (var_binds_pre, p_1_conj_2_3) in 

                                
                                 (*create bind post
                                  * ∀h, x, h int , v, h ′ .(M1.li f t M φ1 ′ ) (h x h int ) ∧ (M2.li f t M φ2 ′ ) (h int v h ′ )*)
                                  let fresh_v = Var.get_fresh_var "v" in 
                                  let fresh_h' = Var.get_fresh_var "h'" in   
                                  let post_1 = VC.apply phi1'_star [(fresh_h, TyD.Ty_heap);(fresh_x, t1);(fresh_h_int, TyD.Ty_heap)] in 
                                  (*let post_1  = P.apply [(fresh_h, Var.fromString "h");(fresh_h_int, Var.fromString "h'");(fresh_x, Var.fromString "v")] phi1'_star in *)
                                  let post_2 = VC.apply phi2'_star [(fresh_h_int, TyD.Ty_heap);(fresh_v, t2);(fresh_h', TyD.Ty_heap)] in 
                                  let post_2 = P.reduce (fresh_x, v) post_2 in 
                                  let post_conj = P.Conj (post_1, post_2) in
                                  let env_extended = VC.extend_gamma (fresh_x, RefTy.fromTyD t1) env' in 
                                  let env_extended = VC.extend_gamma (fresh_h_int, RefTy.fromTyD Ty_heap) env_extended in   
                                  let env_extended = VC.extend_gamma (fresh_h, RefTy.fromTyD Ty_heap) env_extended in 

                                  let env_extended = VC.extend_gamma (fresh_h', RefTy.fromTyD Ty_heap) env_extended in 

                                  let env_extended = VC.extend_gamma (fresh_v, RefTy.fromTyD t1) env_extended in 

                                  let var_binds_post = [(fresh_h, Ty_heap);
                                                         (fresh_v, t2);
                                                         (fresh_h', Ty_heap)] in 
                                  let post_phi = P.Forall (var_binds_post, post_conj) in 

                                  let bind_type = RefTy.MArrow (lubM, pre_phi, t2, post_phi)in 
                                  let vcs_combine = [] (* List.append vcs_p1 vcs_p2 in *) in 
                                  let () = Printf.printf "%s" ("\n >>>>> Value of v "^(Var.toString v)) in  
                                  let () = Printf.printf "%s" ("\n \n Type Synthesized for Bind "^(RefTy.toString bind_type)) in
                                  (env_extended, bind_type, vcs_combine) 
                                  
                               | _ -> raise (ProgramTCError "Illegal Lambda")
                              )         
                     (*The non-monadic bind case T >> T *)                   
                     | _ -> let (env, t, vcs_p2) = type_check_program env p2 in       
                                (env, t, vcs_p2)
                )           
        | Dot  (p1, p2) -> (env, (RefTy.fromTyD TyD.Ty_unit), []) 
        | Alt (p1, p2) ->  
                (*Γ ⊢ T 1 : M1 {φ1} t1{φ1 ′ }
                 * Γ ⊢ T 2 : M2 {φ2} t2 {φ2 ′ }
                 * M = M1 ∪ M2 ∪ Nondet
                 * M {φ1 ∗ }t1{φ1 ′∗ } = M1.li f t M (T 1)
                 * M {φ2 ∗ }t2{φ2 ′∗ } = M2.li f t M (T 2)
                 * t = Σ t1 t2
                 *----------------------------------------------
                  Γ ⊢ T 1<|>T 2 : M {(φ1 ∗ /\ φ2 ∗ )} t {(φ1 ′∗ \/ (φ2 ′∗ )}
                 *
                 * *)
                let () = Printf.printf "%s" ("\n Synthesizing Type for Alt \n") in 
                let (env1, ty1, vcs_p1) = type_synthesize_program env p1 in
                let () = Printf.printf "%s" ("\n Type Successful for p1 \n") in 
                let () = Printf.printf "%s" ("\n Ref-Type T1  : "^(RefTy.toString ty1)) in 
                let (env2, ty2, vcs_p2) = type_synthesize_program env p2 in
                let () = Printf.printf "%s" ("\n Type Successful for p2 \n") in 
                let () = Printf.printf "%s" ("\n Ref-Type> T2 : "^(RefTy.toString ty1)) in 
                let m1 = RefTy.get_effect ty1 in 
                let m2 = RefTy.get_effect ty2 in 
                let () = Printf.printf "%s" ("\n Calculating lub  \n") in 

                let lubM = (*M*)RefTy.lub_effects ty1 ty2 in
                let env_extended = List.append env1 env in                   
                (*lift the calculated types*)
                (*lift the constraint in the lower effect to one in the upper effect
                 * This has to be defined for each value of lower and upper*)
                   
                let lifted_ty1 = RefTy.liftM ty1 lubM in 
                let lifted_ty2 = RefTy.liftM ty2 lubM in 
                (*what if the lifted is arrow*)      
                let RefTy.MArrow (e_lub, phi1_star, t1, phi1'_star) = lifted_ty1 in 
               (* let RefTy.MArrow (e_lub, phi2_star, t2, phi2'_star) = lifted_ty2 in *)
                
                let RefTy.MArrow (e_lub, phi2_star, t2, phi2'_star) = lifted_ty2 in 
                let unified_t = TyD.unify t1 t2 in 

                   (*create alt pre*)
                let fresh_h = Var.get_fresh_var "h" in 
                let fresh_v = Var.get_fresh_var "v" in 
                let fresh_h' = Var.get_fresh_var "h'" in 
                  
                let env_extended = VC.extend_gamma (fresh_h, RefTy.fromTyD Ty_heap) env_extended in 
                let env_extended = VC.extend_gamma (fresh_h', RefTy.fromTyD Ty_heap) env_extended in 
                let env_extended = VC.extend_gamma (fresh_v, RefTy.fromTyD unified_t) env_extended in 



                  (*\forall h x h' \phi -> forall h x h_int 
                   *
                   * We assume that all the bound variable have the same naming structure h x h_int etc 
                   * TODO :: Create a general substitution of bounded variables so that we can substitute one or more or all of the bound variables*)
                let pre_1 = VC.apply phi1_star [(fresh_h, TyD.Ty_heap)] in 
                let pre_2 = VC.apply phi2_star [(fresh_h, TyD.Ty_heap)] in 
                let p_1_conj_2 = P.Conj (pre_1, pre_2) in 
                let var_binds_pre = [(fresh_h, Ty_heap)] in    
                let pre_phi = P.Forall (var_binds_pre, p_1_conj_2) in 
                  
                (*create bind post
                  * ∀h, x, h int , v, h ′ .(M1.li f t M φ1 ′ ) (h x h int ) ∧ (M2.li f t M φ2 ′ ) (h int v h ′ )*)

                 let post_1 = VC.apply phi1'_star [(fresh_h, TyD.Ty_heap);(fresh_v, unified_t);(fresh_h', TyD.Ty_heap)] in 
                
                 let post_2 = VC.apply phi2'_star [(fresh_h, TyD.Ty_heap);(fresh_v, unified_t);(fresh_h', TyD.Ty_heap)] in 
                
                  let post_disj = P.Disj (post_1, post_2) in
                  let var_binds_post = [(fresh_h, Ty_heap);
                                         (fresh_v, unified_t);
                                         (fresh_h', Ty_heap)] in 
                  let post_phi = P.Forall (var_binds_post, post_disj) in 

                  let alt_type = RefTy.MArrow (lubM, pre_phi, unified_t, post_phi)in 
                  let vcs_combine = List.append vcs_p1 vcs_p2 in 
                  let () = Printf.printf "%s" ("\n Type Synthesized for Alt "^(RefTy.toString alt_type)) in
                  (env_extended, alt_type, vcs_combine) 
               
                        

        | (*variable binding*)
          Red (trm, p) ->  
                 
                let () = Printf.printf "%s" ("\n Synthesizing Type for Red \n") in 
                        (*Γ ⊢ (λx .T ) : (x : τ → M {φ1} t1 {φ1 ′ }
                         * Γ, v : T
                         * Γ ⊢ [T ]v : M[v/x]φ1 t1 [v/x]φ1′*)
                 
                let (env, ty1, vcs1) = type_synthesize_program env p in
                (match p  with 
                    | Lambda (argtrm, argty, _) -> 
                        let formal_var = (match argtrm with 
                                                | T_var v -> v 
                                                | _ -> raise (ProgramTCError "Illegal formal parameter in Lambda :: type_synthsize_program case Red")
                                         )
                        in    
                        let (env, new_eq_pred, actual_var) =  (match trm with 
                                                | T_var v -> (env, P.True , v) 
                                                | T_const l ->
                                                        (match l with 
                                                         | SLit s -> 
                                                                let fv = Var.get_fresh_var "loc" in 
                                                                 let env = VC.extend_gamma (fv, RefTy.fromTyD (Ty_string)) env in 
                                                                 let fv_eq_lit = BP.varStrEq (fv, s) in 
                                                                (env, P.Base (fv_eq_lit), fv)  
                                                         | _ ->  raise (ProgramTCError "Illegal actual parameter Literal in Lambda :: type_synthsize_program case Red")
                                                         )       
                                                |  _ -> raise (ProgramTCError "Illegal actual parameter in Lambda :: type_synthsize_program case Red")
                                         )
                        in 
                       (*TODO for now I am assuming this typechecks, later either take is from the*)
                        (*let (trm_ty) = type_synth_term env trm in  
                        let _vcs_from_parameter_check = VCE.fromTypeCheck trm_ty argty in *)
                        let _vcs_from_parameter_check = [] in 
                        let RefTy.Arrow ((_,_), RefTy.MArrow (m, phi1, t1, phi1')) = ty1 in 
                        let phi1 = P.Conj (phi1, new_eq_pred) in 
                        let phi1' = phi1' in 
                        let reduced_phi1 = P.applySubst (actual_var, formal_var) phi1 in 
                        let reduced_phi1' = P.applySubst (actual_var, formal_var) phi1' in 
                        let synthesized =  RefTy.MArrow (m, reduced_phi1, t1, reduced_phi1') in        
                        let () = Printf.printf "%s" ("\n Synthesized Type for Red "^(RefTy.toString synthesized)) in 
                        (env, synthesized, (List.append (vcs1) (_vcs_from_parameter_check))) 

                            
                    | _ -> raise (ProgramTCError "Illegal Reduction, for a non lambda program ")    
                        )      

        | Fold (p, f, g, base, inv, annotated) -> 
                (*pattern *)
                let () = Printf.printf "%s" ("\n ********************************************************************\n") in 
                let () = Printf.printf "%s" ("\n ****************Synthesizing Type for FoldT **************************\n") in 
                let () = Printf.printf "%s" ("\n ******************************************************************\n") in 


                let (f_trm, f_type) = f in 
                
                let (base_trm, base_type) = base in 
               let () = Printf.printf "%s" ("\n Accumulator Type = "^(RefTy.toString base_type)) in  
                let () = Printf.printf "%s" ("\n Accumulator Grounded Type = "^(TyD.toString (RefTy.toTyD base_type))) in  

                let Trans.T_var base_var = base_trm in 
                let RefTy.MArrow (meff, pp, tau1, qq) = annotated in 
                 (*create VCs for f_type*)
                let (vcs_f_typecheck, fphi) =  match f_type with 
                  | Arrow ((vac, tac), curr_body_type) -> 
                         let vc1 = VC.fromTypeCheck env (tac, base_type) in 
                         match curr_body_type with 
                           | Arrow ((vx, tx), body_type) -> 
                                let vc2 = VC.fromTypeCheck env (tx, tau1) in 
                                match body_type with 
                                | Base (v, vtype, predicate) -> (List.concat [[vc1];[vc2]], predicate)
                                | _ ->   raise ( ProgramTCError "Invalid folding body : Must be a Base")   
                               
                           | _ -> raise ( ProgramTCError "Invalid folding function type : Must be a function")   
                  | _ -> raise ( ProgramTCError "Invalid folding function type : Must be a curried function")   
                
                in 
                

                (*TODO we may have to add the constraint on base_type*)

                let () = Printf.printf "%s" ("\n Synthesizing Type for Fold transducer \n") in 
                let (env', type_p, vcs1) = type_check_program env p in 
               
                
                let () = Printf.printf "%s" ("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$") in  
                let  RefTy.MArrow (mp, phi, t, phi') = type_p in  
                
                let () = Printf.printf "%s" ("\n Type for folded Program "^RefTy.toString type_p) in  

                (*Assumption, we assume the types for f and accumulator to be correct.
                 * Checking their type will require integrating the ST type checking with type checking for L*)

                (*Create three invariant constraints*)
                

                let h = Var.get_fresh_var "h" in 
                let h' = Var.get_fresh_var "h'" in 
                
                let h_tyd = (h, TyD.Ty_heap) in 
                let h'_tyd = (h', TyD.Ty_heap) in 
                let base_tyd = (base_var, RefTy.toTyD base_type) in 
                

                let env_s = VC.extend_gamma (h, RefTy.fromTyD Ty_heap) env' in 
                let env_s = VC.extend_gamma (h', RefTy.fromTyD Ty_heap) env_s in 
                let env_s = VC.extend_gamma (base_var,  base_type) env_s in 
                 (*Inv_{start}
                 *Inv start = ∀ h. P h => (Inv h base)
                                 * *)
                  
                
                let () = Printf.printf "%s" ("\n Creating Inv_start ") in  
                let p_h =  VC.apply pp [(h, TyD.Ty_heap)] in
                let inv_h_base = VC.apply inv [h_tyd;base_tyd] in 
                let inv_start= P.Forall([h_tyd], P.If (p_h, inv_h_base))  in 
                
                
                
                (*Create a VC*)
                (**TODO *)
                
                let ante = [] in 
                let ante_conj = P.pred_conjunction ante in 

                let vc_start = VC.VC (env_s, ante_conj, inv_start) in 
                        
                (*Inv induction*)            
                let h = Var.get_fresh_var "h" in 
                let y = Var.get_fresh_var "y" in 
                let h' = Var.get_fresh_var "h'" in 
                let x = Var.get_fresh_var "x" in
                let y' = Var.get_fresh_var "y'" in 

                let h_tyd = (h, TyD.Ty_heap) in 
                let h'_tyd = (h', TyD.Ty_heap) in 
                let x_tyd = (x, t) in 
                let y_tyd = (y, RefTy.toTyD base_type) in 
                let y'_tyd = (y', RefTy.toTyD base_type) in 


                let env_i = VC.extend_gamma (h, RefTy.fromTyD Ty_heap) env' in 
                let env_i = VC.extend_gamma (h', RefTy.fromTyD Ty_heap) env_i in 
                let env_i = VC.extend_gamma (y, base_type) env_i in 
                let env_i = VC.extend_gamma (x, RefTy.fromTyD t) env_i in 
                let env_i = VC.extend_gamma (y, base_type) env_i in 

                let () = Printf.printf "%s" ("\n Creating Inv_ind ") in  
                (*Inv ind = ∀ h, x, y, y', h’. (((Inv h y) ∧ (g h acc = false)) => φ h) => (( φ' h x h’ /\ f_phi y' y x) => (Inv h1’ y'))
                 * inv_i_fst =  (((Inv h y) ∧ (g h acc = false)) => φ h) 
                 * in_i_snd =  (( φ' h x h’ /\ f_phi y' y x) => (Inv h’ y')) 
                 * *)
                let inv_h_y = VC.apply inv [h_tyd;y_tyd] in 
                let notg_acc = P.Not (VC.apply g  [h_tyd; y_tyd]) in 
                let phi_h =  VC.apply phi [h_tyd] in
                let inv_h_y_and_g_h_acc = (P.Conj (inv_h_y, notg_acc)) in 

                let inv_i_fst= P.If (P.Conj (inv_h_y, notg_acc), phi_h)  in 

                let phi'_h_x_h' =  VC.apply phi' [h_tyd;x_tyd;h'_tyd] in
                let () = Printf.printf "%s" ("\n Creating done phi'_h_x_h' ") in  

                let () = Printf.printf "%s" ("\n fphi "^P.toString fphi) in  


                let fphi_y'_y_x = VC.apply fphi [y'_tyd;y_tyd;x_tyd] in


                let () = Printf.printf "%s" ("\n Applied fphi "^P.toString fphi_y'_y_x) in  


                let inv_h'_y' = VC.apply inv [h'_tyd;y'_tyd] in 
                let inv_i_snd = P.If (P.Conj(phi'_h_x_h', fphi_y'_y_x), inv_h'_y') in 

                (*add the inv_i_fst pre_condition as a conjunct thus (p => p') => (q => r) is modeled as p/\q => r*)
                let inv_i_snd' =  P.If (P.Conj( inv_h_y_and_g_h_acc, P.Conj(phi'_h_x_h', fphi_y'_y_x)), inv_h'_y') in 

                let inv_i = P.Forall ([h_tyd;x_tyd;y_tyd;y'_tyd;h'_tyd], P.If (inv_i_fst, inv_i_snd')) in 
               
                (*VCs*)
                 
                let ante = [] in 
                let ante_conj = P.pred_conjunction ante in 

                let vc_ind = VC.VC (env_i, ante_conj, inv_i) in 
                
                

               (*  Inv break = ∀ h, y. ((g h y = false) ∧ Inv h y => Q h*) 

                  
                let h = Var.get_fresh_var "h" in 
                let y = Var.get_fresh_var "y" in 
                let h' = Var.get_fresh_var "h'" in 

                let h_tyd = (h, TyD.Ty_heap) in 
                let h'_tyd = (h', TyD.Ty_heap) in 
                let y_tyd = (y, RefTy.toTyD base_type) in 


                let env_b = VC.extend_gamma (h, RefTy.fromTyD Ty_heap) env' in 
                let env_b = VC.extend_gamma (h', RefTy.fromTyD Ty_heap) env_b in 
                let env_b = VC.extend_gamma (y,  base_type) env_b in 
                
                let () = Printf.printf "%s" ("\n Creating Inv_break ") in  


                let inv_h = VC.apply inv [h_tyd; y_tyd] in 
                let g_h_acc = VC.apply g [h_tyd;y_tyd] in 
                let q_h_acc = VC.apply qq [h_tyd;y_tyd;h'_tyd] in 
                let inv_b = P.If (P.Conj (inv_h, g_h_acc), q_h_acc) in 


                (*TODO, create VC*)


                let inv_b = P.Forall ([h_tyd;y_tyd;h'_tyd], inv_b) in 
               
                (*VCs*)
                 
                let ante = [] in 
                let ante_conj = P.pred_conjunction ante in 

                let vc_break = VC.VC (env_b, ante_conj, inv_b) in 
                let vci = [vc_start;vc_ind;vc_break] in 
                let vcs = vci in 
                (*let vcs = List.concat[vcs1;vci] in *)

                (env', annotated, vcs)  
         
and type_check_program (env : gammaEnv) (p:Trans.program) : (gammaEnv * Trans.ty * (VC.t) list)  = 
        let () = Printf.printf "%s" ("\n Checking Type for ST \n") in 
               
        match p with 
        | ST t -> 
                (*let Trans.Trans {annot;_} = t in  
                (env, annot, [])*)
                let (ty_trans, _vcs_list) = TransTC.generate_vcs env t in 
                (*update the environment with the environments of the checked transducer*)
                let env' = List.fold_left (fun accEnv vc -> VC.extend_gamma_from_vc vc accEnv) env _vcs_list in 

                (env', ty_trans, _vcs_list)
        | _ -> type_synthesize_program env p  

let rec program_subtyping (env:gammaEnv) (inferred : Trans.ty) (annotated : Trans.ty) : (VC.t list) = 
       let () = Printf.printf "%s" ("\n ++++++++++++Annot Type++++++++++++ "^(RefTy.toString annotated)) in 
       let () = Printf.printf "%s" ("\n ++++++++++++Inferred Type+++++++++ "^(RefTy.toString inferred)) in 
       match (inferred , annotated) with 
        | RefTy.Arrow((argt1, argty1), mt1), RefTy.Arrow ((argt_ann, argty_ann), mt_ann) -> 
                let vcs1 = VC.fromTypeCheck env (argty1, argty_ann) in
                let vcs2 = program_subtyping env mt1 mt_ann in 
                let vcs = List.append vcs1 vcs2 in 
                vcs 

        | RefTy.MArrow(eff1, phi1, t1, phi1'), RefTy.MArrow (eff_ann, phi_ann, t_ann, phi_ann') -> 

                let () = Printf.printf "%s" ("\n phi-inferred-pre "^(P.toString phi1)) in 

                let () = Printf.printf "%s" ("\n phi-annotated-pre "^(P.toString phi_ann)) in  


          
                let () = Printf.printf "%s" ("\n phi-inferred-post "^(P.toString phi1')) in 

                let () = Printf.printf "%s" ("\n phi-annotated-post "^(P.toString phi_ann')) in  

                (*let phi_annot_imp_pre = P.If (p2 , p1) in*)
                let temp_h = Var.get_fresh_var "_temp_h" in 
                let temp_v = Var.get_fresh_var "_temp_v" in 
                let temp_h' = Var.get_fresh_var "_temp_h'" in 

                (*new int heap variable*)
                let fresh_bvs = [(temp_h, TyD.Ty_heap);(temp_v, t_ann);(temp_h', TyD.Ty_heap)] in 
               (*_Gamma_ext, add to Gamma whenever existential*)
                let fresh_bvs_for_gamma = List.map (fun (v, t) -> (v, RefTy.lift_base t)) fresh_bvs in
                let env = List.fold_left (fun _g  (v,t) -> VC.extend_gamma (v,t) _g) env fresh_bvs_for_gamma in 
        

               (*both phi1, phi1', phi_ann and phi_ann' will be of the form \forall h v..
                 * assumption about the ordering of the bvs*)
                (*let bvs_phi1 = P.getBVs phi1 in 
                let bvs_phi1' = P.getBVs phi1' in 
                let bvs_phi_ann = P.getBVs phi_ann in 
                let bvs_phi_ann' = P.getBVs phi_ann' in 
                if (not (List.length bvs_phi1' = List.length bvs_phi_ann')) 
                  then 
                  raise (Error "Incorrect number of arguments in annotated post and inferred post")
                else    
                  let new_bvs_tyd_phi1 = List.map (fun (v,  tyd) -> ((Var.get_fresh_var "_temp"), tyd)) bvs_phi1 in
                  let new_bvs_tyd_phi1' = List.map (fun (v,  tyd) -> ((Var.get_fresh_var "_temp"), tyd)) bvs_phi1' in
                  let extended_gamma_with_instantiated_vars = List.fold_left (fun _g (v, tyd) -> VC.extend_gamma (v, (RefTy.lift_base tyd)) _g) env new_bvs_tyd_phi1 in 
                  let extended_gamma_with_instantiated_vars = List.fold_left (fun _g (v, tyd) -> VC.extend_gamma (v, (RefTy.lift_base tyd)) _g) env new_bvs_tyd_phi1' in

                  let applied_phi1' =  (VC.apply phi1' new_bvs_tyd_phi1') in 
                  let () = Printf.printf "%s" (" \n APP phi1' "^(P.toString applied_phi1')) in 
                  let applied_phi_ann' =  (VC.apply phi_ann' new_bvs_tyd_phi1') in

                  let () = Printf.printf "%s" (" \n APP phi_ann' "^(P.toString applied_phi_ann')) in 
                *)
                let () = Printf.printf "%s" ">>>>1" in       
                  let applied_phi1 = VC.apply phi1 [(temp_h, Ty_heap)] in 
                                let () = Printf.printf "%s" ">>>>2" in       
   
                let applied_phi1' = VC.apply phi1' [(temp_h, Ty_heap);(temp_v, t_ann);(temp_h', TyD.Ty_heap)] in 
                let () = Printf.printf "%s" ">>>>3" in       
 
                 let applied_phi_ann = VC.apply phi_ann [(temp_h, Ty_heap)] in 
                let () = Printf.printf "%s" ">>>>4" in       
 
                let applied_phi_ann' = VC.apply phi_ann' [(temp_h, Ty_heap);(temp_v, t_ann);(temp_h', TyD.Ty_heap)] in 

 
                
                 let phi_annot_imp_pre = P.If( applied_phi_ann, applied_phi1) in 
  
 
                  let phi_post_imp_anno = P.If ((applied_phi1'), (applied_phi_ann'))  in  
                  let () = Printf.printf "%s" (" POST => ANNO "^(P.toString phi_post_imp_anno)) in 
                 (*Add the inferred pre to the ANTECEDANT*)       
                  let ante = [applied_phi1] in  

                  let ante_conj = P. pred_conjunction ante in 
                  let gamma = env in
                  (*TODO DEBUG :not checking pre => inferred pre for now, *)      
                  
                let vc_for_path = VC.VC (env, ante_conj, P.Conj (phi_annot_imp_pre, phi_post_imp_anno)) in
                  [vc_for_path] 
                        
                
        | (_,_) -> 
                (*get body type for both *
                 * Check body subtyping in the environment
                 * 
                 *)
                
                raise ( ProgramTCError "Unhandled Program Subtyping")
                


(*explicit verification system*)
let verify (env:gammaEnv) (sub_vcs : VC.t list) (inferred : Trans.ty) (annotated : Trans.ty)  : (VC.t list) =
        let _vcs_subtyping = program_subtyping env (inferred) (annotated) in 
        let _full_vcs = List.append sub_vcs _vcs_subtyping in 
        _full_vcs




