(*define a configuration Map key: state , Value : conf*)
open Printf
open SpecLang
open TypedTransLang

module TyD = TyD
module RefTy = RefinementType
module P = Predicate
module BP = Predicate.BasePredicate
module RP = Predicate.RelPredicate
module Var = Var
module TyVar = TyVar 
exception Error of string 
exception Unimplemented of string     
exception CantDischargeVC
exception SolverTimeout  
(*aliases for some functions in SpecLang*)
let string_for_ty = RefTy.toString 
let string_pred = P.toString 
 
module Printf = struct 
  
  let sprintf d s = Printf.printf "%s" ("\n "^s)
  let printf d s  = Printf.printf "%s"( " \n "^s)
  let dprintf  d s = Printf.printf "%s" ("\n "^s)

end  
 



module VerificationC = struct 
        open Predicate
        type vctybind = Var.t * RefTy.t
        type vtydbind = Var.t * TyD.t 


        type vctybinds = vctybind list
        type vtybinds = vtydbind list 

        type simple_pred = True
                         | False
                         | Base of BP.t 
                         | Rel of RP.t

        type vc_pred =  Simple of simple_pred
                     |  If of vc_pred * vc_pred
                     |  Iff of vc_pred * vc_pred
                     |  Conj of vc_pred list
                     |  Disj of vc_pred list
                     |  Not of vc_pred
    
        let empty_gamma = 
          let _gamma = [] in 
          _gamma



        let spredToString sp = 
                match sp with 
                True -> "True"
              | False -> "False"
              | Base  bpt -> ("Base "^(BP.toString bpt)) 
              | Rel rpt -> ("Rel "^(RP.toString rpt))                 
                

        let rec vcpredToString vcp =
                match vcp with 
                        Simple sp -> spredToString sp 
                     |  If (vcp1 , vcp2) -> (vcpredToString vcp1)^" => \n \t "^(vcpredToString vcp2)
                     |  Iff  (vcp1 , vcp2) -> (vcpredToString vcp1)^" <=> "^(vcpredToString vcp2)
                     |  Conj vcpl ->List.fold_left (fun acc vcpi -> (acc^" AND \n \t "^(vcpredToString vcpi))) "Conj " vcpl 
                     |  Disj vcpl -> List.fold_left (fun acc vcpi -> (acc^" OR \n \t  "^(vcpredToString vcpi))) "Disj " vcpl 

                     |  Not vcp -> vcpredToString vcp
    


        type t = VC of vctybinds * P.t * P.t
        type standardt = T of vtybinds * vc_pred * vc_pred 

        (*getters*)
        let gammaVC (vc:t) = let VC (g,_,_) = vc in g 
        
        let anteVC (vc:t) = let VC (g,a,_) = vc in a
            
        let consVC (vc:t) = let VC (g,a,c) = vc in c
        
        

        (*path constraint, includes \Gamma *)
        type pc = {gamma: vctybinds; preds : pred list}
        type predicates = P.t list 
        
         
        let vectorAppend (vec,e) = List.concat [vec;[e]]
        let vectorPrepend (e,vec) = List.concat [[e];vec]
        let  vectorFoldrFoldr vec1 vec2 acc f = List.fold_right (fun el1 acc -> List.fold_right (fun el2 acc -> f el1 el2 acc) vec2 acc) vec1 acc 


        let vector_foldr_foldr (vec1,vec2,acc,f) = 
          List.fold_right2 f vec1 vec2 acc

              

        let conj (p1 ,p2 ) : vc_pred = 
          match (p1,p2) with 
            (Simple True,_) -> p2
          | (_, Simple True) -> p1
          | (Simple False,_) -> Simple False
          | (_, Simple False) -> Simple False
          | (Simple sp1,Conj spv) -> Conj ( vectorPrepend (p1,spv) )
          | (Conj spv,Simple sp2) -> Conj ( vectorAppend (spv,p2) )
          | (Conj spv1,Conj spv2) -> Conj ( Vector.concat [spv1;spv2] )
          | _ -> Conj ( Vector.new2 (p1,p2) )

        let disj(p1 ,p2 ) : vc_pred = 
          match (p1,p2) with 
            (Simple True,_) -> Simple True
          | (_, Simple True) -> Simple True
          | (Simple False,_) -> p2
          | (_, Simple False) -> p1
          | (Simple sp1,Disj spv) -> Disj ( vectorPrepend (p1,spv))
          | (Disj spv,Simple sp2) -> Disj ( vectorAppend (spv,p2))
          | (Disj spv1,Disj spv2) -> Disj ( Vector.concat [spv1;spv2])
          | _ -> Disj (Vector.new2 (p1,p2))

        let negate (p : vc_pred) : vc_pred = 
          match p with
            Simple True -> Simple False
          | Simple False -> Simple True
          | _ -> Not p

        (*A function to translate a non-qualified predicate in our speclang to predicate in the verification condition, returns a vc with a tybinds of the qualified variables*)
       let rec coercePTtoT (pt) = 
          match  pt with

            P.True -> Simple True
          | P.False -> Simple False
          | P.Base p -> Simple ( Base p)
          | P.Rel p -> Simple ( Rel p)
          | P.Not p -> negate ( coercePTtoT p)
          | P.If (p1,p2) -> If (coercePTtoT p1, coercePTtoT p2)
          | P.Iff (p1,p2) -> Iff (coercePTtoT p1, coercePTtoT p2)
          | P.Conj (p1,p2) -> 
              let t1 = coercePTtoT p1 in
              let t2 = coercePTtoT p2
              in conj (t1,t2)

          | P.Disj (p1,p2) -> disj (coercePTtoT p1, coercePTtoT p2)
         
          |  _ -> let () = Printf.printf "%s" ("Predicate "^(P.toString pt)) in   
                raise (Error "Cannot coerce PT to T")

        let truee () : vc_pred = Simple True
        let falsee () : vc_pred = Simple False


        (*A function to translate a predicate in our speclang to 
         * a predicate in the verification condition, 
         * returns a vc with a tybinds of the qualified variables
         * e.g. forall  x:a, y:b . phi x y => [(x:a);(y:b)], phi x y*)
        let rec havocPred (pred) : (vtybinds*vc_pred) =
          match pred with
            P.Exists (tyDB,p) -> 
              let mybinds =  tyDB in 
              let (binds,coerced) = havocPred p
              in (List.concat [mybinds;binds], coerced)
           | P.Forall (tyDB,p) -> 
              let mybinds =  tyDB in 
              let (binds, coerced) = havocPred p
               in (List.concat [mybinds;binds], coerced)

           | P.True -> ([],coercePTtoT pred)
           | P.False -> ([], coercePTtoT pred)
           | P.Base p -> ([], coercePTtoT pred)
           | P.Rel p -> ([], coercePTtoT pred) 
           | P.Not p -> let (binds, coerced) = havocPred p in 
                         (binds, negate coerced)
           | P.If (p1,p2) -> let (bindp1, coercedp1) = havocPred p1 in 
                           let (bindp2, coercedp2) = havocPred p2 in 
                            (List.concat[bindp1;bindp2],    
                                If (coercedp1, coercedp2))
           | P.Iff (p1,p2) -> let (bindp1, coercedp1) = havocPred p1 in 
                           let (bindp2, coercedp2) = havocPred p2 in 
                            (List.concat[bindp1;bindp2],    
                                Iff (coercedp1, coercedp2))
 
           | P.Conj (p1,p2) -> 
                           let (bindp1, coercedp1) = havocPred p1 in 
                           let (bindp2, coercedp2) = havocPred p2 in 
                            (List.concat[bindp1;bindp2],    
                                conj (coercedp1, coercedp2))
 
           | P.Disj (p1,p2) -> 
                  let (bindp1, coercedp1) = havocPred p1 in 
                           let (bindp2, coercedp2) = havocPred p2 in 
                            (List.concat[bindp1;bindp2],    
                                disj (coercedp1, coercedp2))
           | P.Dot (p1,p2) -> 
                  let (bindp1, coercedp1) = havocPred p1 in 
                           let (bindp2, coercedp2) = havocPred p2 in 
                            (List.concat[bindp1;bindp2],    
                                 conj (coercedp1, coercedp2))
 
           | _ -> 
                ([], coercePTtoT pred) (* May need havoc here.*)


        (*A very simplified version which lowers each RefTy to its base type
         * TODO - This might need to be extended to add the predicates of the types to the environment*)
        let rec havocGamma ( _glist) =
          let open RefTy in 
           List.map (fun (v , refty) -> (v, RefTy.toTyD refty)) _glist         

        let prepend_preds (preds : predicates) (p : P.t) = 
                List.concat [preds;[p]]


        let lookup_type (v : var) (_gamma : vctybind list) = 
            try 
                let _v_ty = List.assoc v _gamma in 
                _v_ty

            with 
             | Not_found -> raise (Error ("Type for var Not found in \Gamma "^v))


        let extend_gamma (v1, t1) (g: vctybinds) : vctybinds = 
          List.append g [(v1, t1)]


        let extend_gamma_from_vc (vc : t) (ing:vctybinds) : vctybinds = 
           let localg = gammaVC vc in 
           List.concat [ing;localg] 





        (*printing utilities*)
        let string_gamma (gs:vctybinds) = 
             List.fold_left (fun gamma_str_acc (v, t) -> (gamma_str_acc^(" \n "^(v)^" --->  "^(RefTy.toString t)^" "))) "Gamma MAP \n" gs

        let string_tybinds (gs:vtydbind list) = 
             List.fold_left (fun _str_acc (v, t) -> (_str_acc^(" \n "^(v)^" --->  "^(TyD.toString t)^" "))) "TyDBINDS  \n" gs


        let string_for_vc_t (vc : t) = 
          let VC(_gamma, ante, cons) = vc in 
          let str = ("VC_BEGIN "^(string_gamma _gamma)^" \n \t ANTE "^(string_pred ante)^"\n \t ------------------------------\n 
                \t CONS => "^(string_pred cons)^" \n 
                VC_END") in 
          str
 
        let string_for_vc_stt (vc : standardt) = 
          let T (_tybinds, antevc, consvc) = vc in  
        let str = ("STANDARD VC_BEGIN "^(string_tybinds _tybinds)^"\n \t ANTE "^(vcpredToString antevc)^" \n \t ------------------------\n
        \t CONS "^(vcpredToString consvc)^"\n 
        VC_END") in   
          str
        (*  let T(_gamma, ante, cons) = vc in 
          let str = ("T_BEGIN "^(string_gamma _gamma)^" \n \t ANTE "^(string_pred ante)^"\n \t CONS => "^(string_pred cons)^" VC_END") in 
          str*)
        
        let string_for_vcs (_vcs : pred list) = 
          let str_preds = List.fold_left (fun acc p -> (acc^(" :: ")^(string_pred p)^" ::") ) (" [ ") _vcs in 
          str_preds 

        let string_pc (pcv : pc) = 
          let str_gamma = " { gamma: "^(string_gamma pcv.gamma)^ " ;" in 
          let str_preds = List.fold_left (fun acc p -> (acc^" :: "^(string_pred p)^" ::") ) " [ "pcv.preds in 
          (str_gamma^str_preds^" ; END }")
          
       
        (*alias for Predicate.reduce *)
        let subs_pred  = Predicate.reduce
        
        let rec subst (subs_bindings : ((var* TyD.t)*(var * TyD.t)) list) (_phi : Predicate.t) = 
           match subs_bindings with 
             [] -> _phi 
            | x :: xs -> (*exact definition of [v/x]phi*)
                  let (var_old, t1 ), (var_new, t2) = x in 
                  (*compare types*)
                  let check_types = 
                     if (not (TyD.sametype t1 t2)) then 
                          raise (Error ("substitution type mismatch t1:  "^(TyD.toString t1)^" t2: "^(TyD.toString t2)))
                     else(*TODO for now TyD.sametype t1 t2 in *) true in 
                        let reduced_phi = Predicate.reduce (var_old, var_new) (_phi) in 
                        subst (xs) reduced_phi 
                          
                   


        (*substitution of variables to predicates *)
        let apply (_phi:pred) (binds : vtydbind list ) = 
           (*let () = Printf.printf "%s" ("\n In Apply  \n") in  *)
             match _phi with 
              | Forall (varbindall, phi_forall)-> 
                        (*size of arguments must match*)
                        (*example \forall x:t.y:t1 x > 2 && y > 2. [(z:t) ] -> \forall y:t1 z>2 && y > 2
                         * \phi (z1:t1, z2:t2) *
                         *
                         *)
                
                   if (not ((List.length binds) = (List.length varbindall))) then
                         raise (Error ("Illegal Substitution Provided argumenst "^(string_of_int (List.length binds))^" != Actual arguments"^(string_of_int (List.length varbindall))))
                   else
                        let subst_zip = List.combine binds varbindall in 
                      (subst subst_zip _phi)

                        
              | Exists (varbindall, phi_forall)->
                   let () = Printf.printf "%s" ("\n Exists Substitution") in      
                   if (not ((List.length binds) = (List.length varbindall))) then
                        if ((List.length binds) > (List.length varbindall)) then 
                         raise (Error ("Illegal Substitution "^(string_of_int (List.length binds))^" != "^(string_of_int (List.length varbindall))))
                        else 
                        (*partial substitution*)
                          let (partial_varbind, cnt)=   List.fold_left (fun (accls, len) a -> if (len < (List.length binds)) then ((a :: accls), (len+1)) else (accls, (len + 1))) 
                                                                                ([], 0) varbindall in
                          let () = Printf.printf "%s" ("\n Phi_original  "^Predicate.toString _phi) in 
                          let () = Printf.printf "%s" ("\n arguments "^(string_tybinds binds)) in 
                          let () = Printf.printf "%s" ("\n "^(string_of_int (List.length binds))^" != "^(string_of_int (List.length varbindall))) in 
                          let () = Printf.printf "%s" ("\n Length of filtered "^(string_of_int (List.length partial_varbind))) in 
                         let subst_zip = List.combine binds partial_varbind in 
                         (subst subst_zip _phi)


                   else
                          let () = Printf.printf "%s" "\n APPLY EQUALL ARGUMENTE CASE " in  
                          let () = Printf.printf "%s" ("\n Phi_original  "^Predicate.toString _phi) in 
                          let () = Printf.printf "%s" ("\n arguments "^(string_tybinds binds)) in 
                          let () = Printf.printf "%s" ("\n "^(string_of_int (List.length binds))^" = "^(string_of_int (List.length varbindall))) in 
                         
                      let subst_zip = List.combine binds varbindall in 
                      (subst subst_zip _phi)

 
              | _ -> (*Nothing to substitute*) 
                        _phi
           



   (*TODO A function to coerce predicates from the Predicate in Spec language to Predicates in VC*)     
   let standardize ( calculated_vc : t ) : (standardt) =  
        let () = Printf.printf "%s" ("\n Standardizing verification conditions ") in  
        let VC (_g, _ante, _cons) = calculated_vc in 
        let (_gfrom_ante,  standard_ante)  = havocPred _ante in 
        let (_gfrom_cons, standard_cons) = havocPred _cons in 
        T (List.concat [(havocGamma _g);_gfrom_ante;_gfrom_cons], standard_ante, standard_cons) 
        



  (*Computation subtyping= This is where we also elaborate from Predicates to VC.VC*)
   let trans_subtyping ({gamma;preds} as env : pc) (annotated : RefTy.t) (inferred:RefTy.t) : t = 
        
        let () = Printf.printf "%s" (">>>>>>>>Annot Type<<<<<<<<<< "^(RefTy.toString annotated)) in 
        let () = Printf.printf "%s" (">>>>>>>>>>>Inferred Type<<<<<<<<<<<<< "^(RefTy.toString inferred)) in 
        match (inferred , annotated) with
                (Base (v1, bt1, p1), Base (v2, bt2, p2))  -> raise (Error "Unimplemented subtyping") 
               | (Arrow ( t1, t1'), Arrow (t2, t2'))  ->  raise (Error "Unimplemented subtyping") 
               | (MArrow (eff1, p1 , t1 , p1'), MArrow (eff2, p2, t2, p2')) -> 
                        (*let phi_annot_imp_pre = P.If (p2 , p1) in*)
                        let temp_h = Var.get_fresh_var "_temp_h" in 
                        let temp_v = Var.get_fresh_var "_temp_v" in 
                        let temp_h' = Var.get_fresh_var "_temp_h'" in 
                        let temp_v_err = Var.get_fresh_var "_temp_v_err" in 
                        let t_err = TyD.fromString "error" in 
                        (*new int heap variable*)
                        let fresh_bvs = [(temp_h, TyD.Ty_heap);(temp_v, t2);(temp_h', TyD.Ty_heap);(temp_v_err, t_err)] in 
                        (*_Gamma_ext, add to Gamma whenever existential*)
                        let fresh_bvs_for_gamma = List.map (fun (v, t) -> (v, RefTy.lift_base t)) fresh_bvs in
                        let gamma = List.fold_left (fun _g  (v,t) -> extend_gamma (v,t) _g) gamma fresh_bvs_for_gamma in 
                

        
                        (*TODO Also add constraint for effs*)
                        let () = Printf.printf "%s" ("\n Original Inferred pre "^P.toString p1) in
                        let p1_temp = apply p1 [(temp_h, TyD.Ty_heap)] in 

                        let () = Printf.printf "%s" ("\n Applied Inferred pre "^P.toString p1_temp) in


                        let () = Printf.printf "%s" ("\n Original Annotatetd pre "^P.toString p2) in 
                        let p2_temp = apply p2 [(temp_h, TyD.Ty_heap)] in 

                        let () = Printf.printf "%s" ("\n Applied Annotated pre "^P.toString p2_temp) in



                        (*TODO Work on this one*) 
                        let phi_annot_imp_pre = P.If (p2_temp, p1_temp) in 
                        

                        if (t1 = t_err) then 
                             let () = Printf.printf "%s" ("\n Case : Exceptional : Original Inferred post "^P.toString p1') in 
                             match eff2 with 
                                | Effect.StExc -> 
                                     let p2'_err = (match p2' with 
                                        | P.Disj (_, p_err) -> p_err
                                        | _ -> p2') in 

                                     let p1'_err_temp = apply p1' [(temp_h, TyD.Ty_heap);(temp_v_err, t_err);(temp_h', TyD.Ty_heap)] in 
                                     let () = Printf.printf "%s" ("\n Applied Inferred post "^P.toString p1'_err_temp) in 
                                        
                                        (*update the initial heap for *)

                                        let () = Printf.printf "%s" ("\n Orginal Annotated post "^P.toString p2') in 
                                        let p2'_err_temp = apply p2'_err [(temp_h, TyD.Ty_heap);(temp_v, t2);(temp_h', TyD.Ty_heap)] in 

                                        let () = Printf.printf "%s" ("\n Applied Annotated post "^P.toString p2'_err_temp) in 
                                       (*add the pre to the ante*)

                                       let ante_conj = p1_temp in 


                                        let phi_post_imp_anno = P.If (p1'_err_temp, p2'_err_temp)  in  
                                        let () = Printf.sprintf "%s" (" \n POST => ANNO \n "^(P.toString phi_post_imp_anno)) in 
                                        let ante = env.preds in  
                                        let ante_conj = P.Conj( ante_conj, pred_conjunction ante) in
                                        let vc_for_path = VC (gamma, P.Conj(ante_conj, phi_annot_imp_pre), phi_post_imp_anno) in   
                                 (*let vc_for_path = VC (gamma, ante_conj, P.Conj (phi_annot_imp_pre, phi_post_imp_anno)) in*)
                                       vc_for_path 
         
                                | _ -> raise (Error ("Illegal Effect Ordering StExc !< "^(Effect.toString eff2)))
                        
                        (*instantiate the bv of p1' and p2' with a set of variables. and then generate imp*)
                         else   
                                let () = Printf.printf "%s" ("\n Case Non-Exceptional: Original Inferred post "^P.toString p1') in 
                                (*update the initial heap for *)
                                let p1'_temp = apply p1' [(temp_h, TyD.Ty_heap);(temp_v, t2);(temp_h', TyD.Ty_heap)] in 

                                let () = Printf.printf "%s" ("\n Applied Inferred post "^P.toString p1'_temp) in 
                                
                                (*update the initial heap for *)

                                let () = Printf.printf "%s" ("\n Orginal Annotated post "^P.toString p2') in 
                                let p2'_temp = apply p2' [(temp_h, TyD.Ty_heap);(temp_v, t2);(temp_h', TyD.Ty_heap)] in 

                                let () = Printf.printf "%s" ("\n Applied Annotated post "^P.toString p2'_temp) in 
                               (*add the pre to the ante*)

                               let ante_conj = p1_temp in 


                                let phi_post_imp_anno = P.If (p1'_temp, p2'_temp)  in  
                                let () = Printf.sprintf "%s" (" \n POST => ANNO \n "^(P.toString phi_post_imp_anno)) in

                               let ante = env.preds in  
                               let ante_conj = P.Conj( ante_conj, pred_conjunction ante) in
                               let vc_for_path = VC (gamma, P.Conj(ante_conj, phi_annot_imp_pre), phi_post_imp_anno) in   
                         (*let vc_for_path = VC (gamma, ante_conj, P.Conj (phi_annot_imp_pre, phi_post_imp_anno)) in*)
                              vc_for_path 
                       
               | (_,_) -> raise (Error ("\n SubTyping "^(RefTy.toString inferred)^(" MISMATCH ")^(RefTy.toString annotated)^" \n")) 

   (*TODO *)
  let rec fromTypeCheck (_gamma) (subTy, supTy) =
    let env = {gamma=_gamma;preds=[]} in 
    match (subTy, supTy) with 
     | (RefTy.Base (v1, t1, p1), RefTy.Base (v2, t2, p2)) ->
        let () = Printf.printf "%s" ("SubTy "^(RefTy.toString subTy)) in 
        let () = Printf.printf "%s" ("SuperTy "^(RefTy.toString supTy)) in 
        let _ = assert (TyD.sametype t1 t2) in 
        let p2 = P.applySubst (v1,v2) p2 in 
        let _gamma = extend_gamma (v1, subTy) _gamma in 
        VC (_gamma, p1, p2) 
        
     | (RefTy.MArrow (_,_,_,_), RefTy.MArrow (_,_,_,_)) ->     
         trans_subtyping env supTy subTy 
     | (_,_) -> 
       raise (Error "Unhandled Case Arrow or Tuple fromTypeCheck")

  
    
 end   
module VC = VerificationC 





(*create an existential predicate from a given type of a boolean function*)
let pred_from_guard (g:term) : pred = 
        (*TODO: implement a conversion of a boolean predicate guard to a pred*)
        True 
   
let filter_complete (listp : path list) (st: trans)  = 
   let Trans {final;_} = st in
   let filtered = List.filter (fun pi -> 
                                      match (terminal_node pi) with 
                                        | Some end_node ->
                                               ( try
                                                  if (end_node = "qe") then 
                                                    true 
                                                  else     
                                                   let found =  List.find (fun state -> if (state = end_node) then true else false) final in 
                                                   true
                                                with    
                                                | Not_found -> false
                                              )
                                        | None -> false
                                ) listp in
    filtered 


                                          


(*Type Checking*)

(*TODO 
 * for now assume that type of delta is given, 
 * if not synthesize the type*)
let type_synth_delta (_d_ty_pair : (delta * RefTy.t)) (_gamma : VerificationC.vctybinds) : (RefTy.t) = 
     
      (*if \delta is an error transition , apply T-delta error to update the type of delta
       * else just return the annotated type*)
      (* let (_d,_dty) = _d_ty_pair in 
     let Delta {src;tgt;_} = 
     if 
     else *)
       let (_d, _dty) = _d_ty_pair in
      _dty

        (*
        let Del {name;src;tgt;guard;step} = _d in 
        let f_ty = (match step with 
                   | T_lam (v,tr, t) -> t 
                   | _ -> raise (Error "Incorrect step type") )
        in                     
        let phi_ty = (match guard with 
                   | T_lam (v, tr, t) -> t 
                   | _ -> raise (Error "Incorrect guard type") )
        in 

        (*TODO change phi to a formaula*)
        let exists_phi = pred_from_guard guard in
        (*combine the phi with the step*)

        (*formula *)
        let extended_f_ty_phi = VerificationC.combine_step_guard_ty f_ty phi_ty in 
        let _d_ty_pair = (name, extended_f_ty_phi) in 
        (_d_ty_pair:: _gamma) 
          *)    




(*Apply T-delta synthesis for each \delta and return the updated environment \Gamma*)
let ty_chk_deltas (Trans {deltas;_} as st) (_inGamma)   = 
   let gamma_final = 
                List.fold_left (fun  gamma (_d :(delta*RefTy.t)) -> 
                
                        let (_del, _del_ty) = _d in 
                        let Del {name;_} = _del in 
                        let (_del_ty_synth) =   type_synth_delta _d gamma in 
                        (*singleton delta, ty binding*)
                        let _gamma' = [(name, _del_ty_synth)] in 
                        (List.concat  [gamma;_gamma'])
                ) (_inGamma) deltas in 
   (gamma_final)
(*Updates the envrionment _Gamma with the type for \delta_init
 * We can add synthesis for init, if a type is not provided*)
(*let ty_chk_init (Trans {init;_} as st) _inGamma _invcs = 
        let (trm, t) = init in
        (*given type*)
        let vcs = pred_from_ty t in 
        let out_Gamma = (trm, t) :: _inGamma in 
        (List.concat[[vcs];_invcs], _inGamma)
*)           

let create_phi tybs (phi:pred) = 
        let _phi  = VerificationC.VC (tybs, phi, True) in 
        _phi

let join vc vcs = (*define how we join a pred with tybinds \phi with a complete VC 
                   add \phi to the antecendents and tybinds to the tybinds of VC.*)

        List.append vc vcs 
                
(*synthesize the type for I, and populate the Gamma *)
let ty_synth_init _Gamma (st:trans) = 
    let Trans {init;_} = st  in 
    let (init_term, init_refty) = init in 
    
      
     let rec declared_heap_vars _init_statement : ((Var.t * TyD.t)  list ) =   
        match _init_statement with 
                
         | (*recursive case*)T_seq (t1, t2)-> List.append (declared_heap_vars t1) (declared_heap_vars t2)   
         | (*base case assignment*) T_assign (lhs, rhs) -> 
                (match rhs with 
                  | (*base case*)T_cref (t_value)  ->
                    (*infer the type locally*)
                    let inferred_ty = 
                        (match t_value with 
                           | T_const litt -> 
                                let litt_ty = Con.getType litt in 
                                litt_ty
                           | _ -> raise (Unimplemented "What if init value is not a const")  
                        
                        ) in
                    let inferred_ref_ty = TyD.Ty_ref (inferred_ty) in 
                    let heap_var = 
                     (match lhs with 
                        | T_var var -> var
                        | _ -> raise (Unimplemented "What if init T_cref is not a Var")                   
                     ) in
                    [(heap_var, inferred_ref_ty)]

                  | _ -> raise (Unimplemented "The case of the form ri = rj or r1 = value not handled, only case handled is r1 = ref value in initialization")
             )            
         | T_unit -> [] 
         | _ -> raise (Error "Init can be either a ref, skip or a seq or and initization of a ref ") 

     in
     let heap_var_ty_list = declared_heap_vars init_term in 
     let _Gamma = List.fold_left (fun _gamma (heap_v, heap_ty) -> 
                VerificationC.extend_gamma  (heap_v, RefTy.lift_base heap_ty) _gamma ) _Gamma heap_var_ty_list  in
     
    (_Gamma, init_refty) 


open Printf       
open VerificationC
open TyD    
(*framed version bind local*)

let bind_framed (phi_guard : Predicate.t) (acc_vc : Predicate.t list) (_Gamma : VerificationC.vctybinds) (m1_type : RefTy.t) (m2_type : RefTy.t) : 
                                                                                                        (VerificationC.vctybinds * (Predicate.t list) * RefTy.t )= 
      (match (m1_type, m2_type) with 
        | (RefTy.MArrow (eff1, phi1, t1, phi1') , RefTy.MArrow (eff2,phi2, t2, phi2')) -> 
                  
                (* \exists i : inp char*)
                
                let fresh_i = Var.get_fresh_var "i" in 
                
                let fresh_h_int = Var.get_fresh_var "h_int" in 
                
                let fresh_h = Var.get_fresh_var "h" in                     
                       
                let _bound_x = Var.get_fresh_var "x"  in
                
                let fresh_v = Var.get_fresh_var "v" in 
                (*instantiate predicates in the current delta with existentials and populate them in the Gamma*)
                
                let phi_guard_i = P.applySubst (fresh_i, Var.fromString "i") phi_guard in 

                let phi2 = P.applySubst (fresh_i, Var.fromString "i") phi2 in 
                let phi2' = P.applySubst (fresh_i, Var.fromString "i") phi2' in 
                
                let fresh_local_vars = [(fresh_i, Ty_int)] in 
                
                let fresh_locals_for_gamma = List.map (fun (v, t) -> (v, RefTy.lift_base t)) fresh_local_vars in
                let _Gamma = List.fold_left (fun _g  (v,t) -> extend_gamma (v,t) _g) _Gamma fresh_locals_for_gamma in 
                
                (*No fancy rule for finding non-interferece*)
                (*Ex : The thing we want is framing : 
                 *      let h = {sel h cnt > 0 /\ sel h res > 0}  
                 *              
                 *              T1 {true} _ { sel h' res = sel h res +1 }
                 *                 
                 *                 T2 {sel h cnt > 0 /\ .... } _ { _ } *) 
                (* The model of our memory allows us to resolve the exists
                 * *                Γ ⊢ T 1 : M {φ1} t1{φ1 ′ }
                 *              \forall. φ2. fp (φ2) n fp (φ1) = {} 
                 *T-frame------------------------------------------------------------------------------
                                   
                 * *                   Γ ⊢ T 1 : M {φ1/\ φ2} t1{φ1 ′ /\ φ2}
        
                 
                                        *
                 *****************************************************************
                 *            auxiliary pred:
                 *              preserve = \h1 h h'. \forall x \in dom (h1). sel h' x = sel h x 
                 *              dom = \h : heap. {(v)} 
                 *
                 *               Γ ⊢ T 1 : M {φ1} t1{φ1 ′ }
                 *               Γ, x : t1 ⊢ T 2 : M {φ2} t2 {φ2 ′ }
                 *T-bind-frame ------------------------------------------------------------------------------
                              Γ, {\Exists x : t1,  (h1 h2 h1' h2' h_int h1_int : heap)}
                              ⊢ T1»=λx .T2 : 
                                M {∀h. dom (h1) = fp \phi1
                                    dom h2 = dom h - dom h1
                                    h = h1 # h2 (*this is an axiom and true by definition *)
                                    dom h1_int = dom h1 
                                    h_int = h1_int * h2 (*by definition*)
                                   .(φ1 h1) ∧ (φ1' h1 x h1_int /\ preserve h2 h h_int) =>  (φ2  h_int) }
                                   t2
                                 { ∀h, v, h ′.
                                  dom h1' = dom h1 U fp phi2 
                                    dom h2' = dom h2 - fp phi2 
                                     dom h1_int' = dom h1_int - fp phi2 
                                       h' = h1' * h2' (*true by definition*)
                                      (φ1' h1 x h1_int)  ∧ (φ2' h_int v h1')/\ ( preserve h2' h h') /\ 
                                      ( preserve h1_int' h1_int h')
                                }
                
                *)   
                (*calculate h = h1 # h2 
                calculate h1: the small-footprint for m1 *)
                let phi1_fp_list = Predicate.footprint phi1 in
                let list_elems = List.map (fun v -> RelLang.Var (Var.toString v)) phi1_fp_list in 
                let phi1_fp_tuple = RelLang.T list_elems in 

                let h1_ident = Var.get_fresh_var "h1" in      
                let h2_ident = Var.get_fresh_var "h2" in 
                let h1_int_ident = Var.get_fresh_var "h1_int" in  

                (*dom h1 = fp phi1*)
                
                
               let _dom_h1 =  RelLang.MultiR ( (RelLang.instOfRel (RelId.fromString "dom")), [(h1_ident)]) in
               let _dom_h1_eq_fp_phi1 = RP.Eq (_dom_h1, phi1_fp_tuple ) in  
                
                (* dom h = dom h1 \union dom h2
                 * dom h1 \intersection dom h2 = {}
                 *
                 **)
                (*    dom h2 = dom h - dom h1*)

               let _dom_h2 =  RelLang.MultiR ( (RelLang.instOfRel (RelId.fromString "dom")), [(h2_ident)]) in
               let _dom_h =  RelLang.MultiR ( (RelLang.instOfRel (RelId.fromString "dom")), [(fresh_h)]) in

               let _dom_h1_int =  RelLang.MultiR ( (RelLang.instOfRel (RelId.fromString "dom")), [(h1_int_ident)]) in

               let _dom_h =  RelLang.MultiR ( (RelLang.instOfRel (RelId.fromString "dom")), [(fresh_h)]) in
               let _dom_h_minus_h1 = RelLang.D (_dom_h, _dom_h1)  in 
               let _dom_h2_eq_h_minus_h1 = RP.Eq (_dom_h1, _dom_h_minus_h1) in  
              
               let _splits_h_h1_h2 = P.heap_splits_predicate fresh_h h1_ident h2_ident in 
              
                (*dom h1_int = dom h1 *)
                let _dom_h1_int_eq_h1 = RP.Eq (_dom_h1_int, _dom_h1) in  
                
                (*h_int = h1_int # h2*)
                let  _splits_h_int_h1_int_h2 = P.heap_splits_predicate fresh_h_int h1_int_ident h2_ident in 

                (*.(φ1) h1 *)

                let phi1_h1 = VerificationC.apply phi1 [(h1_ident, Ty_heap)]  in 
                
                let phi1'_h1_x_h1_int = VerificationC.apply phi1' [(h1_ident,Ty_heap); (_bound_x, t1);(h1_int_ident, Ty_heap)] in 
                let phi2_hint = VerificationC.apply phi2 [(fresh_h_int, Ty_heap)] in 

                (*presrve h2 h h_int*)
                let _preserve_h2_h_hint = Predicate.heap_preserve h2_ident fresh_h fresh_h_int in  

                (*(φ1 h1) ∧ (φ1'h1 x h1_int /\ preserve h2 h h_int) =>  (φ2  h_int) }*)
                let pre2 = P.If ( P.Conj( phi1'_h1_x_h1_int, _preserve_h2_h_hint), phi2_hint) in  
                let pre = P.Forall ([(fresh_h, Ty_heap)], P.Conj (P.Conj (phi1_h1, pre2),
                                                                        P.Conj(_splits_h_h1_h2,  _splits_h_int_h1_int_h2)))    in 


                (*create post*)
                let phi2_fp_list = Predicate.footprint phi2 in
                let list_elems = List.map (fun v -> RelLang.Var (Var.toString v)) phi2_fp_list in 
                let phi2_fp_tuple = RelLang.T list_elems in 
              
                (*phi1' h1 x h_int *)
                let h1'_ident = Var.get_fresh_var "h1'" in 
                let h2'_ident = Var.get_fresh_var "h2'" in 
                let h'_ident = Var.get_fresh_var "h'" in 
   

                (*dom h1' = dom h1 U fp phi2*)
                 
               let _dom_h1' =  RelLang.MultiR ( (RelLang.instOfRel (RelId.fromString "dom")), [(h1'_ident)]) in
               let _dom_h1_union_fp_phi2 = RelLang.U (_dom_h1, phi2_fp_tuple)  in 
               let _dom_h1'_eq_h1_union_fp_phi2 = RP.Eq (_dom_h1', _dom_h1_union_fp_phi2) in  
                
               (*dom h2' = dom h2 - fp phi2*)
               let _dom_h2' =  RelLang.MultiR ( (RelLang.instOfRel (RelId.fromString "dom")), [(h2'_ident)]) in
               let _dom_h2_minus_fp_phi2 = RelLang.D (_dom_h2, phi2_fp_tuple)  in 
               let _dom_h2'_eq_h2_minus_fp_phi2 = RP.Eq (_dom_h2', _dom_h2_minus_fp_phi2) in  
             
                (* h' = h1' # h2#
                 * define splits h' h1' h2'*)
                let  _splits_h'_h1'_h2' = P.heap_splits_predicate h'_ident h1'_ident h2'_ident in 

 

                (*presrve h2' h h'*)
                let _preserve_h2'_h_h' = Predicate.heap_preserve h2'_ident fresh_h h'_ident in  


                let phi1'_h1_x_h1_int = VerificationC.apply phi1' [(h1_ident, Ty_heap);(_bound_x, t1); (h1_int_ident, Ty_heap)]  in 
                let phi2'_h_int_v_h1' = VerificationC.apply phi2'  [(fresh_h_int, Ty_heap);(fresh_v, t2);(h1'_ident , Ty_heap)]  in 

         
             
                let post = P.Forall ([(fresh_h, Ty_heap);(fresh_v, t2); (h'_ident, Ty_heap )], P.Conj(
                                                                                                P.Conj (P.Conj (phi1'_h1_x_h1_int, phi2'_h_int_v_h1'), 
                                                                                                _splits_h'_h1'_h2'),
                                                                                                _preserve_h2'_h_h')) in 
                 (*least uppper bound*)
                let lubM = Effect.lub eff1 eff2  in                 
                let new_acc_ty = RefTy.MArrow (lubM, pre , t2, post) in
                (_Gamma, acc_vc, m1_type) 
               

      | (_,_) -> raise (Error ("binding non computations"))
    )


(* T-P-Ind rule
 * Γ 1 ⊢ p k−1 (p,q) : (eff {φ 1 } τ 1 {φ 1 ′ }) term(p k−1 ) = start(p 1 )
 * Γ 2 ⊢ p 1 (q,r ) : (eff {φ 2 } τ 2 {φ 2 ′ })
 * Γ = Γ 1 @Γ 2
 * Γ ⊢ p k (p,r ) : eff 
 * {∀h, x, h i .φ1 h ∧ φ1 ′ (h, x, h i ) ⇒ φ2 h i }
 * τ 2 
 * {∀h, x, h i , y, h ′ .φ1 ′ (h, x, h i ) ∧ φ2 ′ (h i , y, h ′ )}
 *
 * *)

open Printf       
open VerificationC
open TyD    
(*phi is the extended environment in which new \delta is to be checked*)    
let bind ((*guard for \del_2 is provided separately*) phi_guard:Predicate.t) (acc_vc: Predicate.t list ) (_Gamma: VerificationC.vctybinds) (m1_type: RefTy.t) (m2_type :RefTy.t) = 
     match (m1_type, m2_type) with 
      | (RefTy.MArrow (eff1, phi1, t1, phi1') , RefTy.MArrow (eff2,phi2, t2, phi2')) -> 
              
                let () = Printf.printf "%s" ("\n Type t1 "^(TyD.toString t1)) in
  
                let () = Printf.printf "%s" ("\n Type t2 "^(TyD.toString t1)) in
  
                let fresh_i = Var.get_fresh_var "i" in 
                let fresh_h_int = Var.get_fresh_var "h_int" in 
                let _Gamma = extend_gamma (fresh_h_int, (RefTy.lift_base Ty_heap)) _Gamma in 
      

                (*instantiate predicates in the current delta with existentials and populate them in the Gamma*)
                (*φ1 h*)               
                let phi_guard = P.applySubst (fresh_i, Var.fromString "i") phi_guard in 

                (*substitute φ2 h i *) 
                let phi2 = P.applySubst (fresh_i, Var.fromString "i") phi2 in 
               

                let phi2' = P.applySubst (fresh_i, Var.fromString "i") phi2' in 
               

                (*poulate Gamma \exists i : int*)
                let fresh_local_vars = [(fresh_i, Ty_int)] in 
                let fresh_locals_for_gamma = List.map (fun (v, t) -> (v, RefTy.lift_base t)) fresh_local_vars in
                let _Gamma = List.fold_left (fun _g  (v,t) -> extend_gamma (v,t) _g) _Gamma fresh_locals_for_gamma in 
                
                 
                (*extend vc with guard*)
                let fresh_bvs = [(fresh_h_int, Ty_heap)] in 
                (*\phi_guard h*)
                let phi_guard_applied = apply phi_guard fresh_bvs in
                let acc_vc' = VerificationC.prepend_preds acc_vc phi_guard_applied in         
               




                
               (*Create Bounded new type*)
                (*no type inference so need to provide the type for the bound variable of a formula*)
                let bv_h = Var.get_fresh_var "h" in 
                let _Gamma = extend_gamma (bv_h, (RefTy.lift_base Ty_heap)) _Gamma in 
                let bv_x = Var.get_fresh_var "x" in 
                let _Gamma = extend_gamma (bv_x, (RefTy.lift_base t1)) _Gamma in 
                let bv_h' = Var.get_fresh_var "h'" in 
                let _Gamma = extend_gamma (bv_h', (RefTy.lift_base Ty_heap)) _Gamma in 
                

                (*extend these variables with types in the _Gamma*)

                 
                (*phi1 h*)
                let f1_pre = (apply phi1 [(bv_h, Ty_heap)]) in 
                

                
                (*Following type is now created in this extended environment*)
                (*\forall x, h_int. ( \phi1') h x h_int => \phi2 h_int x)*)
                        
                let () = printf "%s" "\n Generating The Path Induction pre " in 
               
                
                let f2_pre =  P.If ((apply phi1' [(bv_h, Ty_heap); (bv_x, t1); (fresh_h_int, Ty_heap)]), 
                                    ((apply phi2 [(fresh_h_int, Ty_heap)]))
                                                  )
                                            
                                        
                                     

                in

                let bind_pre (*create pre-condition*) =  P.Forall ([(bv_h, Ty_heap)], P.Conj (f1_pre, f2_pre))  in 
                let () = printf "%s" ("\n PRE \n "^(Predicate.toString bind_pre)) in  
             
                let () = printf "%s" "\n Generating The Path Induction post " in 
                
                (*creating post*)
                (*forall v h h' x h_int. phi1 x h h_int*)
                
                let (bv_v)= Var.get_fresh_var "v" in 
                let _Gamma = extend_gamma (bv_v, (RefTy.lift_base t2)) _Gamma in 
                
                 
                (*Add h' to the Gamma*)

                let local_var_binds = [(bv_h, Ty_heap);(bv_v, t2);(bv_h', Ty_heap) ] in 
                
                let bind_post (*create post-condition*) = 
                 P.Forall (local_var_binds, P.Conj (( apply phi1' [(bv_h, Ty_heap);(bv_x, t1);(fresh_h_int,Ty_heap)]),
                                                (apply phi2' [(fresh_h_int ,Ty_heap);(bv_v, t2); (bv_h', Ty_heap)])))
                               in 

 
                let () = printf "%s" ("\n POST \n "^(Predicate.toString bind_post)) in  
                                       
               
                (*least uppper bound*)
                let lubM = Effect.lub eff1 eff2  in                 
                let new_acc_ty = RefTy.MArrow (lubM, bind_pre , t2, bind_post) in
                
                (*
                let () = Printf.printf "%s"  (" \n \n \n >>>>>>>>>>><<<<<<<<<<<<<<<<< Gamma AFTER BIND "^(string_gamma _Gamma)) in  
                let () = Printf.printf "%s" (" \n \n \n >>>>>>>>>>>>>>>>>>>>>>>>>> VCS AFTER BIND "^(string_for_vcs acc_vc')) in  
                let () = Printf.printf "%s"  (" \n  >>>>>>>>>>><<<<<<<<<<<<<<<<< Accumulated Type "^(RefTy.toString  new_acc_ty)) in  *)
                (_Gamma, acc_vc', new_acc_ty)
                        
                
      | (_, _) -> raise (Error ("binding non copmputations "^(RefTy.toString m1_type)^(" >>= ")^(RefTy.toString m2_type)^" \n"))     

(*bind rule with looping delta
 *TODO :: This can be simplified by applying a pre pass to get the type for looping deltas using the type checking rule similar to while with an invariant
   and then simply using the calculated typing 
  For now this also works
 *
 * *)
open Printf 
open VerificationC
open TyD    
(*
 *loop pre = { ∀ h . φ1 h ∧ (φ1' h i => Inv h i )
   loop post = { ∀ h v h'. Inv h' ∧ ¬φg h′ ∧ φ inv } where 
   φ inv = { ∀ h x h'. (Inv h ∧ φ д h => φ2 h) => (φ2 ′ h x h' => Inv h') }
 * *)
let bind_loop (phi_inv : P.t) (phi_guard: P.t) (acc_vc : P.t list ) (_Gamma : vctybinds) (m1_type : RefTy.t) (m2_type: RefTy.t) = 
    let () = printf "%s" ("\n \n \n \t RUNNING LOOP ") in 
    match (m1_type, m2_type) with 
      | (RefTy.MArrow (eff1, phi1, t1, phi1') , RefTy.MArrow (eff2, phi2, t2, phi2')) -> 
        
                let fresh_i = Var.get_fresh_var "i" in 
                let fresh_h_int = Var.get_fresh_var "h_int" in 
                 
                let phi_guard = P.applySubst (fresh_i, Var.fromString "i") phi_guard in 
                
                let not_phi_guard = P.Not phi_guard in  
                
                let () = Printf.dprintf "%s" ("\n@@@@@@@@@@@@@@@@ Updated \Phi_guard "^(P.toString phi_guard)) in  
                let () = Printf.dprintf "%s" ("\n@@@@@@@@@@@@@@@@\Phi2 "^(P.toString phi2)) in  
                
                let phi2 = P.applySubst (fresh_i, Var.fromString "i") phi2 in 
               

                let () = Printf.dprintf "%s" ("\n@@@@@@@@@@@@@@@@Updated \Phi2 "^(P.toString phi2)) in  
                let () = Printf.dprintf "%s" ("\n@@@@@@@@@@@@@@@@\Phi2' "^(P.toString phi2')) in  
                
                let phi2' = P.applySubst (fresh_i, Var.fromString "i") phi2' in 
               
                let fresh_local_vars = [(fresh_i, Ty_int)] in 
                
                let fresh_locals_for_gamma = List.map (fun (v, t) -> (v, RefTy.lift_base t)) fresh_local_vars in
                let _Gamma = List.fold_left (fun _g  (v,t) -> extend_gamma (v,t) _g) _Gamma fresh_locals_for_gamma in 
                
                (*new int heap variable*)
                let fresh_bvs = [(fresh_h_int, Ty_heap)] in 

                (*_Gamma_ext, add to Gamma whenever existential*)
                let fresh_bvs_for_gamma = List.map (fun (v, t) -> (v, RefTy.lift_base t)) fresh_bvs in

               let _Gamma = List.fold_left (fun _g  (v,t) -> extend_gamma (v,t) _g) _Gamma fresh_bvs_for_gamma in 
                


                (*apply the phi guard to the out heap of the first computation*)
                let () = Printf.dprintf "%s" "\n >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>1" in 
                let () = Printf.dprintf "%s" ("Formula "^(P.toString phi_guard)) in 
                let phi_guard_applied = apply phi_guard fresh_bvs in
                (*add this to the environment to get the extended environment*)
                let acc_vc' = VerificationC.prepend_preds acc_vc phi_guard_applied in         
                



                (*Create Bounded new type*)
                (*no type inference so need to provide the type for the bound variable of a formula*)
                let bv_h = Var.get_fresh_var "h" in 
                let _Gamma = extend_gamma (bv_h, (RefTy.lift_base Ty_heap)) _Gamma in 
                let bv_x = Var.get_fresh_var "x" in 
                let _Gamma = extend_gamma (bv_x, (RefTy.lift_base t1)) _Gamma in 
                let bv_h' = Var.get_fresh_var "h'" in 
                let _Gamma = extend_gamma (bv_h', (RefTy.lift_base Ty_heap)) _Gamma in 
                

  

                (*no type inference so need to provide the type for the bound variable of a formula*)

                let () = Printf.dprintf "%s" "\n first part of pre" in 
                let f1_pre =  apply phi1 [(bv_h,  Ty_heap)] in  

                
              
                               (*Following type is now created in this extended environment*)

                let () = Printf.dprintf "%s" "\n calculating second part of pre" in 
                let pred_inv_h_int = apply (phi_inv) [(fresh_h_int, Ty_heap)] in  
                (*\forall x, h_int.  \phi1' h x  h_int => \phi_inv h_int*)

                let f2_pre =   P.If (apply phi1' ([(bv_h, Ty_heap); (bv_x, t1);(fresh_h_int,  Ty_heap)]), 
                                                   ( pred_inv_h_int))
                                                 
                                        
                                      

                in

                let loop_pre (*create pre-condition*) =   P.Forall ([(bv_h, Ty_heap)], P.Conj (f1_pre, f2_pre))  in 
                (*creating post*)
                
                
                let (bv_v)= Var.get_fresh_var "v" in 
                let _Gamma = extend_gamma (bv_v, (RefTy.lift_base t2)) _Gamma in 
                

                 (*create predicates for inv*)
                (*inv h_int*)

                (*\phi_g h_int*)
                let pred_phi_guard_h_int = phi_guard_applied in 
                
                let pred_phi_guard_h' = apply phi_guard [(bv_h', Ty_heap)] in 


                (*let pred_phi_guard_h' = phi_guard_applied in *)
                (*\phi2' h_int v h'*)

                let pred_phi2'_h_int_h' = (apply phi2' [(fresh_h_int ,Ty_heap);  (bv_v, t2); (bv_h', Ty_heap)]) in 

                (*inv h'*)
                let pred_inv_h' =  apply (phi_inv) [(bv_h',Ty_heap)] in  


                (*\phi_inv = \forall h0 x0 h0'. 
                 *              (inv h0 && \phi_g h0 => \phi2 h0) => (\phi2' h0 x0 h0' => inv h0'*)
                let h0 = Var.get_fresh_var "h" in 
                let _Gamma = extend_gamma (h0, (RefTy.lift_base Ty_heap)) _Gamma in 
                let x0 = Var.get_fresh_var "x" in 
                let _Gamma = extend_gamma (x0, (RefTy.lift_base t2)) _Gamma in 
                let h0' = Var.get_fresh_var "h'" in 
                let _Gamma = extend_gamma (h0', (RefTy.lift_base Ty_heap)) _Gamma in 
               
                let inv_h0 = apply (phi_inv) [(h0, Ty_heap)] in 
                let phi_g_h0 = apply phi_guard [(h0, Ty_heap)] in 
                let phi2_h0 = apply phi2 [(h0, Ty_heap)] in 
                 
                let phi2'_h0_x0_h0' = (apply phi2' [(h0 ,Ty_heap);  (x0, t2); (h0', Ty_heap)]) in 

                let inv_h0' = apply (phi_inv) [(h0', Ty_heap)] in 
        

                let inv_extension_true = 
                                P.If (
                                        (P.Conj (inv_h0,  
                                                 P.If( phi_g_h0, phi2_h0 )
                                                )
                                        )   
                                        ,
                                        (P.If( 
                                                (phi2'_h0_x0_h0'),
                                                (inv_h0')
                                             )
                                        )
                                     ) 

                in 
                let phi_inv = P.Forall ([(h0, Ty_heap);(x0, t2);(h0', Ty_heap)], inv_extension_true) in   
        
                let acc_vc' = VerificationC.prepend_preds acc_vc' phi_inv in         
                
                let loop_post = P.Forall ([(bv_h, Ty_heap);(bv_v, t2);(bv_h', Ty_heap)], P.Conj (pred_inv_h', (Not (pred_phi_guard_h')))) in 


            
                let lubM = Effect.lub eff1 eff2 in 
                               
                let new_acc_ty = RefTy.MArrow (lubM, loop_pre , t2, loop_post) in 
               
                (_Gamma, acc_vc', new_acc_ty)
                        
                
      | (_, _) -> (raise (Error "binding non copmputations"))     


 








(*generate VC for a path 
 * Assume all paths are filtered before being passed here
 * Actual implementation for the >>= and ret *)
let ty_chk_path (st: trans) (pi : path) _vcs _Gamma :(pc*RefTy.t) = 
  let () = Printf.printf "%s" ("\n***** Type Inference for path : "^(string_for_path pi)^"********\n") in   
  let Trans {start;finalizer;final;_} = st in 
  let Seq _dlist = pi in 

  let rec vc_deltas del_list _acc_gamma acc_vcs acc_type = 
         match del_list with 
         [] -> ({gamma = _acc_gamma; preds=acc_vcs}, acc_type) 
         | _di :: _ds -> 
          let Del {name;guard;inv;_} = _di in      
          if ((not (is_selfloop _di)) || (name = "_d_init")) then 
                   let () = Printf.printf "%s" ("\n CASE : NON LOOP TRANSITION \n "^name) in 
                  (*simple transitions*) 
                  (*let the type of _di = M {\phi} t:T {\phi'}*)
                   let ty_di = lookup_type name _acc_gamma in 
                   (*get the formula \phi_di from the type*)
                   let phi_di =  guard in
                   let (_acc_gamma', acc_vcs', acc_type') = bind phi_di acc_vcs _acc_gamma  acc_type ty_di in
                   vc_deltas _ds _acc_gamma' acc_vcs' acc_type'
         else 
                   
                   let () = Printf.printf "%s" ("\n CASE : LOOP TRANSITION \n "^name) in 
                  (*simple transitions*) 
                   let ty_di = lookup_type name _acc_gamma in
                   let inv_di = inv in 
                   let phi_di = guard in 
                   let (_acc_gamma', acc_vcs', acc_type') = bind_loop (inv_di) (phi_di) (acc_vcs) (_acc_gamma) (acc_type) (ty_di) in
                   vc_deltas _ds _acc_gamma' acc_vcs' acc_type'


  in 
  let initial_effect = Effect.Pure in 
  
  let initial_type = RefTy.MArrow (initial_effect, (P.getForAllTrue [(Var.fromString "h", TyD.Ty_heap)]),
                                        (Ty_unit), 
                                         P.Forall ([(Var.fromString "h", TyD.Ty_heap);(Var.fromString "v", TyD.Ty_unit); 
                                                         (Var.fromString "h'", TyD.Ty_heap)], 
                                                P.Base ( BP.varEq(Var.fromString "h'" , Var.fromString "h"))))
                                        in 
  let (path_pc_wo_final(*includes gamma and vc*), path_ty_wo_final) =  vc_deltas _dlist _Gamma  _vcs initial_type  in 
  
  let () = Printf.printf "%s" ("\n Type For PATH without A (qf) \n "^(string_for_ty path_ty_wo_final)) in 
  
  (*Add the finalizer sequencing*)
  let terminal_pi = terminal_node pi in 
  let (path_pc_final, path_ty_final) = 
          (match terminal_pi with 
          | None -> raise (Error ("Type checking path with no termina node"))
                     
          | Some terminal_i -> 
                  if (List.mem terminal_i final) then 
                      (*Adding the finalizer call*)
                      let Final {fin} = finalizer in 
                      let finalizer_for_terminal = fin terminal_i  in
                      let (finalizer_term , finalizer_ty) = finalizer_for_terminal in 
                      let (_gamma_with_final, _vcs_with_final, _ty_with_final) = bind (Predicate.True) (path_pc_wo_final.preds) (path_pc_wo_final.gamma) (path_ty_wo_final) (finalizer_ty) in 
                      ({gamma= _gamma_with_final; preds= _vcs_with_final}, _ty_with_final)

                   else 
                     
                     (path_pc_wo_final(*includes gamma and vc*), path_ty_wo_final) 
          ) in
         
  let () = Printf.printf "%s" ("\n Type For PATH with A(qf) \n "^(string_for_ty path_ty_final)) in 
  (path_pc_final, path_ty_final) 
  

  

(*Generate VCs from full paths it is analogous to generating strings from a given transducer*)
let ty_chk_static_paths (st:trans) (paths) (_vcs) (_Gamma) : ((pc*RefTy.t) list)  = 
 
  let pc_refty_list = 
    List.map (fun pi -> 
               let () = Printf.printf "%s" ("\n Type checking a path "^(string_for_path pi)) in   
               let pc_plus_ty_for_path = ty_chk_path st pi _vcs _Gamma in 
               pc_plus_ty_for_path                 
             ) paths 
  in 
  pc_refty_list
 



(*Finds if the passed \delta is a valid candidate for path extension and updates the visited set if loop*)
let valid_follow visited terminal_st _di = 
  let  Del  {src;_} = _di in 
  (*self loop or not*)
  
       
  let (tt, vis) = 
        if ((is_selfloop _di) && (src = terminal_st)) then 
   (*if it is a self loop and it is a valid transition then mark *)  
           let already_visited =
                try 
                       Some ( List.find (fun x -> if (x = src) then true else false) visited) 
                with 
                  |  Not_found -> None
           in 
        match already_visited with 
              | Some _ ->  (false, visited) 
              | None ->  (true, (src::visited)) 
         else   
           if (src = terminal_st) then 
             (true, visited) else 
               (false, visited)
  in 
  (tt, vis)

(*synthesize an initial delta from init *)
let synth_delta_init st = 
  let Trans{start;init;_} = st in 
  let (init_term , init_ty) = init in 
  let init_delta = Del {name="_d_init";src=start; tgt=start; guard=(True) ; step= init_term; inv= True} in (*guard and step have to be typed term*)
  init_delta


(*gives a list of static paths*)
(*type calculate_static_paths (st:trans) : path list
 * Nothing shoould change here by changing the spec language*)
let calculate_static_paths st  = 
  let Trans {start;final;deltas;_} = st in  
  
  (*dummy transition for $init*)
  let start_delta = synth_delta_init st in 
  (*dummy transitions for each of $final*)
  (*let final_deltas = synth_deltas_final st in*) 
  let start_path  = Seq ([start_delta]) in 

  (*list of calculated paths*)
  let worklist = [start_path] in
  let paths = [start_path] in 
  (*recursive updation of worklist*)      
  let rec update_worklist worklist visited paths = 
    match worklist with 
      [] -> paths 
    | (x :: xs) ->
           let Seq pi = x in  
           let term_node_res = terminal_node x in
           match term_node_res with 
           | Some terminali -> 
                   let (worklist'', paths'', visited'') =  List.fold_left (fun (worklist', paths', visited) (_dj, _djty) -> 
                                                                                let (valid, visited') = (valid_follow visited terminali _dj) in   
                                                                                 if (valid) then 
                                                                                   let appended_path = append_path x _dj in 
                                                                                  ((List.append worklist' [appended_path]), List.append paths' [appended_path],  visited') 
                                                                                else (worklist', paths', visited')) (xs, paths, visited) deltas in 
                   update_worklist worklist''  visited'' paths'' 
           | None  -> paths 
     in
   let static_paths_calculated = update_worklist worklist [] paths in 
   (*let () = List.iter (fun pi -> Printf.printf "%s"  ("\n Path >> "^(string_for_path pi))) static_paths_calculated in *)
   
  static_paths_calculated  

      




(*Add the register variables (variables in S in the paper)
 * to the environment Gamma*)
let add_regs in_gamma (regs : (term * ty) list) : VerificationC.vctybinds =
  let extract_var_type_binding reg  = 
        let (trm, giventype) = reg in 
        (match trm with 
          | T_var v -> (v, giventype) 
          | _ -> raise (Unimplemented "Transducer Local register must be a Variable"))
  in 
  let out_gamma = List.fold_left (fun acc reg -> 
                                                let binding = extract_var_type_binding reg  
                                                in extend_gamma binding acc) in_gamma regs in 
  out_gamma
  

 




open Printf 
open VerificationC 
        

(*It returns an updated Gamma, 
 * inferred types for st, and 
 * a VC list from the VCs generated intermidiately 
 **)
let generate_vcs (in_gamma) (st : trans) : (ty * (VerificationC.t) list) = 
  let Trans {annot;regs;_} = st in
  let _Gamma : VerificationC.vctybinds = in_gamma in 
  let empty_vcs: pred list = [] in (*this could just be tybinds, pred => true*) 

  let _Gamma = add_regs _Gamma regs in       

  (*Create a dummy _d_init*)
  let init_delta = synth_delta_init st in 
 
  (*Update _Gamma with the type for _init_delta*)
  let (_Gamma,_init_delta_ty) = ty_synth_init _Gamma st  in 

  let () = Printf.printf "%s" ("\n Initial Delta Type "^(RefTy.toString _init_delta_ty)) in  
  (*Update gamma*)
  let Del {name;_} = init_delta in 
  let _Gamma = extend_gamma (name, _init_delta_ty ) _Gamma in 
 
  let () = printf "%s" ("\n Updated Gamma after init checking"^(string_gamma _Gamma )) in 

  (*Synthesize and populate _Gamma with the types for all the _deltas*)
  
  let () = printf "%s" "\n Calculating \deltas Type" in 
  let (_Gamma) = ty_chk_deltas st _Gamma in 
  (*apply T-init each of the vcs are a list of preds *)
  (*let (_vcs, _Gamma) = ty_chk_init st _Gamma empty_vcs in *)

  let () = printf "%s" ("\n Updated Gamma after ty_checking Delta "^(string_gamma _Gamma)) in 
  
  let () = printf "%s" "\n Calculate static paths" in 
  let paths = calculate_static_paths st in 

  (*paths from start--->* err or start --->* f \in final*)

  let complete_paths = filter_complete paths st  in 

  let () = printf "%s" ("\n Type checking paths, Number complete paths "^(string_of_int(List.length complete_paths)))  in 
 
  (*returns list of (pc*refty*)
  let (path_pc_ty_list) = ty_chk_static_paths st complete_paths empty_vcs _Gamma in 

   

  let () = printf "%s" "\n Subtyping Rules" in 
  let (path_vcs_final) = List.map (fun (pc, t) -> trans_subtyping pc annot t) path_pc_ty_list in 
  

  (*let path_standard_vcs_final = List.map (fun (pc) -> (VC.standardize pc)) path_vcs_final in*)    
 (* 
  * let () = printf "%s" "\n Final VCs" in 
  * let () = List.iter (fun vc -> printf "%s" ("\n"^(string_for_vc_stt vc))) path_vcs_final in      
  *)
  (annot, path_vcs_final) 
     




let type_check_trans (env : VC.vctybinds) (t : trans) : (ty * (VC.t) list) = 
  let (type_for_t, vcs_for_t) = generate_vcs env t in 
  (type_for_t, vcs_for_t)

