(*define a configuration Map key: state , Value : conf*)
open Printf
open SpecLang

module TyD = TyD
module RefTy = RefinementType
module P = Predicate
module BP = Predicate.BasePredicate
module RP = Predicate.RelPredicate
module Var = Var
exception Error of string 
exception Unimplemented of string     
exception CantDischargeVC
exception SolverTimeout  

module Printf = struct 
  let printf d s = Printf.printf d ""
  let originalPrint = Printf.printf 
end  
(*aliases for some functions in SpecLang*)
let string_for_ty = RefTy.toString 
let string_pred = P.toString 
 
open Predicate
type vctybind = Var.t * RefTy.t
type vtydbind = Var.t * TyD.t 
type pred = P.t

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


(*Only two kind of formulas. 
  P
  \Forall \Forall .... (x1....xn). P1*)            
type q_vc_pred = Qf of vc_pred  (*qunatifier free formulas* *)
               | Q of (vtydbind list) * vc_pred (*Quantified formulas *)



let empty_gamma = 
  let _gamma = [] in 
  _gamma


(*printing utilities*)
let string_gamma (gs:vctybinds) = 
  List.fold_left (fun gamma_str_acc (v, t) -> (gamma_str_acc^(" \n "^(v)^" --->  "^(RefTy.toString t)^" "))) "Gamma MAP \n" gs

let string_tybinds (gs:vtydbind list) = 
  List.fold_left (fun _str_acc (v, t) -> (_str_acc^(" \n "^(v)^" --->  "^(TyD.toString t)^" "))) "TyDBINDS  \n" gs



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

             |  Not vcp -> ("Not "^vcpredToString vcp)

let rec q_vc_predToString qvcp =
      match qvcp with 
          | Qf vcp -> vcpredToString vcp 
          | Q (bindings, vcp) -> "\Forall ("^(string_tybinds bindings)^")."^(vcpredToString vcp)


(*predicate in the Specification World *)
type t = VC of vctybinds * P.t * P.t

(*Translated Predicate to be mapped to Z3 *)
type standardt = T of vtybinds * q_vc_pred * q_vc_pred 


(*getters*)
let gammaVC (vc:t) = let VC (g,_,_) = vc in g 

let anteVC (vc:t) = let VC (g,a,_) = vc in a
    
let consVC (vc:t) = let VC (g,a,c) = vc in c



(*path constraint, includes \Gamma *)
type pc = {gamma: vctybinds; preds : pred list}
type predicates = P.t list 

let empty_delta = ([] : pred list)  
let empty_vc = VC ([], P.False, P.True)
let is_empty_vc t = 
    let VC (_,p,q) = t in 
    if (Predicate.isTrue q && Predicate.isFalse p) then true 
    else 
      false 

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


(* Seach in Gamma *)
let find_all_vars (g:vctybinds) (td: TyD.t) : ((Var.t * TyD.t) list) = 
    let well_typed_pairs = List.filter(fun (vi, ti) -> 
                  let b_ti = RefTy.toTyD ti in 
                  TyD.sametype td b_ti) g in 
    List.map (fun (vi, ti) -> (vi, RefTy.toTyD ti)) well_typed_pairs             

(* Seach in Gamma *)
let find_type (g:vctybinds) (v : Var.t ) : RefTy.t option = 
    try 
      Some (
          let (_, t) = 
              List.find (fun (vi, ti) -> 
                 Var.equal vi v) g  in 
                 t)
               
    with 
      | Not_found -> None            

  
(* Gamma append/remove/print operations *)

let extend_gamma (v1, t1) (g: vctybinds) : vctybinds = 
  let g = List.remove_assoc v1 g in 
  List.append g [(v1, t1)]


let remove_from_gamma (vi) (g: vctybinds) : vctybinds = 
    List.remove_assoc vi g 



let append_gamma binds (g: vctybinds) : vctybinds = 
  let g = List.fold_left (fun _g (vi, ti) -> List.remove_assoc vi _g) g binds in 
  List.append g binds 


let extend_gamma_from_vc (vc : t) (ing:vctybinds) : vctybinds = 
   let localg = gammaVC vc in 
   List.concat [ing;localg] 






let string_for_vc_t (vc : t) = 
  let VC(_gamma, ante, cons) = vc in 
  let str = ("VC_BEGIN "^(string_gamma _gamma)^" \n \t ANTE "^(string_pred ante)^"\n \t ------------------------------\n 
        \t CONS => "^(string_pred cons)^" \n 
        VC_END") in 
  str

let string_for_vc_stt (vc : standardt) =
  
  let T (_tybinds, antevc, consvc) = vc in  
let str = ("STANDARD VC_BEGIN "^(string_tybinds _tybinds)^"\n \t ANTE "^(q_vc_predToString antevc)^" \n \t ------------------------\n
\t CONS "^(q_vc_predToString consvc)^"\n 
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
(* actual subtitution function 
  subst ([(vn, t1), (vo, t1)]) P -> [vn/vo]P*)
let rec subst (subs_bindings : ((Var.t* TyD.t)*(Var.t * TyD.t)) list) 
        (_phi : Predicate.t) = 
   
   match subs_bindings with 
     [] -> _phi 
     | x :: xs -> (*exact definition of [v/x]phi*)
          let (var_new, t2), (var_old, t1 )  = x in 
          if (not (TyD.sametype t1 t2) && not (t2 = TyD.Ty_unknown || t1 = TyD.Ty_unknown)) 
            then 
              raise (Error ("substitution type mismatch t1:  "^(TyD.toString t1)^" t2: "^(TyD.toString t2)))
          else(*TODO for now TyD.sametype t1 t2 in *)   
            let subs_phi_i = Predicate.applySubst (var_new, var_old) (_phi) in 
            subst (xs) subs_phi_i 
              
 let rec replaceelem ls i elem =
  match ls with
  | [] -> ls
  | h::t -> if (i=0) then
              elem::t
            else
              h::(replaceelem t (i-1) elem)                 
 (*substitutes as position i
  substi (\forall x , y. P) (nw_x) 1 -> forall nw_x, y. 
                                      [nw_x/x] P  
  *)
 let substi (_phi:pred) (bind_new : vtydbind) (i : int) : (Predicate.t) = 
    match _phi with 
        | Forall (varbindall, phi_forall) -> 
            let len_varbindall = List.length varbindall in 
            assert (i <= len_varbindall);
            
            let ith_bind_old = List.nth varbindall (i-1) in 
            let phi_forall' = 
                subst [(bind_new,ith_bind_old)] phi_forall in
            let varbindall' = replaceelem varbindall (i-1) bind_new in 
            Predicate.Forall (varbindall', phi_forall' )

        | _ -> raise (Error "Illegal Substitution: non-quantified Formula")    

(* 
 Predicate function application 
 apply \forall x, y. P (x, y) [(x1, x);(y1, y)] -> [x1/x, y1/y] P 
*)
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
              (subst subst_zip phi_forall)

                
      | Exists (varbindall, phi_forall)->
           let () = Printf.printf "%s" ("\n Exists Substitution") in      
           if (not ((List.length binds) = (List.length varbindall))) then
                if ((List.length binds) > (List.length varbindall)) then 
                 raise (Error ("Illegal Substitution "^(string_of_int (List.length binds))^" != "^(string_of_int (List.length varbindall))))
                else 
                (*partial substitution*)
                  let (partial_varbind, cnt)=   List.fold_left (fun (accls, len) a -> if (len < (List.length binds)) then ((a :: accls), (len+1)) else (accls, (len + 1))) 
                                                                        ([], 0) varbindall in
                (*   let () = Printf.printf "%s" ("\n Phi_original  "^Predicate.toString _phi) in 
                 *)  let () = Printf.printf "%s" ("\n arguments "^(string_tybinds binds)) in 
                  let () = Printf.printf "%s" ("\n "^(string_of_int (List.length binds))^" != "^(string_of_int (List.length varbindall))) in 
                  let () = Printf.printf "%s" ("\n Length of filtered "^(string_of_int (List.length partial_varbind))) in 
                 let subst_zip = List.combine binds partial_varbind in 
                 (subst subst_zip _phi)


           else
                  let () = Printf.printf "%s" "\n APPLY EQUALL ARGUMENTE CASE " in  
                (*   let () = Printf.printf "%s" ("\n Phi_original  "^Predicate.toString _phi) in 
                 *)  let () = Printf.printf "%s" ("\n arguments "^(string_tybinds binds)) in 
                  let () = Printf.printf "%s" ("\n "^(string_of_int (List.length binds))^" = "^(string_of_int (List.length varbindall))) in 
                 
              let subst_zip = List.combine binds varbindall in 
              (subst subst_zip _phi)


      | _ -> (*Nothing to substitute*) 
                _phi
   



let rec n_cartesian_product = function
  | [] -> [[]]
  | x :: xs ->
      let rest = n_cartesian_product xs in
      List.concat (List.map (fun i -> List.map (fun rs -> i :: rs) rest) x)
  

let rec telescope qvcp = 
    match qvcp with 
      | Qf (coerced_free) ->  coerced_free
      | Q (bindings, qfree) -> raise (Error "Telescoping on a Qunatified Formula")     



let rec havocPred (_gamma : vctybind list) (pred : P.t) : (vtybinds*q_vc_pred) =
  match pred with
    P.Exists (tyDB,p) -> 
      let newBinds = List.map (fun (vi, ti) -> (Var.get_fresh_var (Var.toString vi), ti)) tyDB in 
      let p = apply p newBinds in 
      let (binds,coerced) = havocPred _gamma p
        in (List.concat [newBinds;binds], coerced) 
      (* in (List.concat [mybinds;binds], coerced) *)
   
   
   | P.Forall (tyDB,p) -> 
       let newBinds = List.map (fun (vi, ti) -> (Var.get_fresh_var (Var.toString vi), ti)) tyDB in 
      (* let p = apply p newBinds in  *)
      let p = apply pred newBinds in 
     
      let (binds,coerced) = havocPred _gamma p
    
      in (List.concat [newBinds;binds], Q (newBinds, (telescope coerced))) 
        

   | P.True -> ([],Qf (coercePTtoT pred))
   | P.False -> ([], Qf (coercePTtoT pred))
   | P.Base p -> ([], Qf (coercePTtoT pred))
   | P.Rel p -> ([], Qf (coercePTtoT pred)) 
   | P.Not p -> let (binds, coerced) = havocPred _gamma p in 
                 (binds, Qf (negate (telescope coerced)))
   | P.If (p1,p2) -> 
                   let (bindp1, coercedp1) = havocPred _gamma p1 in 
                   let (bindp2, coercedp2) = havocPred _gamma p2 in 
                    (List.concat[bindp1;bindp2],    
                       Qf (If 
                             (telescope coercedp1, 
                             telescope coercedp2)
                           ))
   | P.Iff (p1,p2) -> 
                   (*FIXME :: \forall xi : ti. P1 /\ \forall yj : tj. P2
                            ----> 
                            \forall xi : ti, \forall yj : tj. P1 /\ P2 *)
                   
                   
                   let (bindp1, coercedp1) = havocPred _gamma p1 in 
                   let (bindp2, coercedp2) = havocPred _gamma p2 in 
                    (List.concat[bindp1;bindp2],    
                        Qf (Iff ( telescope coercedp1, 
                                  telescope coercedp2)
                                ))

   | P.Conj (p1,p2) -> 
                   (*FIXME :: \forall xi : ti. P1 /\ \forall yj : tj. P2
                            ----> 
                            \forall xi : ti, \forall yj : tj. P1 /\ P2 *)
                   let (bindp1, coercedp1) = havocPred _gamma p1 in 
                   let (bindp2, coercedp2) = havocPred _gamma p2 in 
                   let conjunction_pred = 
                        match (coercedp1, coercedp2) with 
                          | (Qf (pfree1), Qf (pfree2)) -> 
                                Qf (conj (telescope coercedp1, 
                                  telescope coercedp2))
                          | (Q (b1, pqunatified1) , Q (b2, pquantified2)) ->
                                Q (b1@b2, conj (pqunatified1, pquantified2))
                          | (Q (b1, pqunatified1), Qf (pfree2)) -> 
                                Q (b1, conj (pqunatified1, pfree2))       
                          | (Qf (pfree1), Q (b2, pquantified2)) ->
                                Q (b2, conj (pfree1, pquantified2))       
                           
                    in
                    (List.concat[bindp1;bindp2], conjunction_pred) 
   | P.Disj (p1,p2) -> 
          
                  (*FIXME :: \forall xi : ti. P1 /\ \forall yj : tj. P2
                            ----> 
                            \forall xi : ti, \forall yj : tj. P1 /\ P2 *)
                 
                   let (bindp1, coercedp1) = havocPred _gamma p1 in 
                   let (bindp2, coercedp2) = havocPred _gamma p2 in 
                    (List.concat[bindp1;bindp2],    
                        Qf (disj ( telescope coercedp1, 
                                   telescope coercedp2)
                            ))
   | P.Dot (p1,p2) -> 
          let (bindp1, coercedp1) = havocPred _gamma p1 in 
                   let (bindp2, coercedp2) = havocPred _gamma p2 in 
                    (List.concat[bindp1;bindp2],    
                         Qf (conj ( telescope coercedp1, 
                                    telescope coercedp2)
                          ))

   | _ -> 
        ([], Qf (coercePTtoT pred)) (* May need havoc here.*)


(*A very simplified version which lowers each RefTy to its base type and 
reifies the constraints to the program variable 
e.g. x : Base {v : t | \phi v} produces (phi(x) , x, t)
for other types x : \Tau Arrow | MArrow it produces (True,  x,  (Trlower (\Tau))
*)

let constraints_from_gamma _g : (Predicate.t list) = 
 List.map ( fun (x, refty) -> 
    match refty with 
      | RefTy.Base (v, t, pred) -> 
            Predicate.applySubst (x, v) pred 
      | _ -> Predicate.True ) _g  

let rec havocGamma (_glist) =
  let open RefTy in 
   List.map (fun (x , refty) -> (x, RefTy.toTyD refty)) _glist         

let prepend_preds (preds : predicates) (p : P.t) = 
        List.concat [preds;[p]]


let lookup_type (v : Var.t) (_gamma : vctybind list) = 
    try 
        let _v_ty = List.assoc v _gamma in 
        _v_ty

    with 
     | Not_found -> raise (Error ("Type for var Not found in \Gamma "^v))





(*A function to coerce predicates from the Predicate in Spec language to Predicates in VC*)     
let standardize ( calculated_vc : t ) : (standardt) =  
let () = Printf.printf "%s" ("\n Standardizing verification conditions ") in  
let VC (_g, _ante, _cons) = calculated_vc in 
let (_gfrom_ante,  standard_ante)  = havocPred _g _ante in 
let (_gfrom_cons, standard_cons) = havocPred _g _cons in 
T (List.concat [(havocGamma _g);_gfrom_ante;_gfrom_cons], standard_ante, standard_cons) 




(*Computation subtyping= This is where we also elaborate from Predicates to VC.VC*)
let trans_subtyping ({gamma;preds} as env : pc) (annotated : RefTy.t) (inferred:RefTy.t) : t = 
 
let () = Printf.printf "%s" ("\n >>>>>>>>>>>Annot Type<<<<<<<<<<<<<<<< "^(RefTy.toString annotated)) in 
let () = Printf.printf "%s" ("\n >>>>>>>>>>>Inferred Type<<<<<<<<<<<<< "^(RefTy.toString inferred)) in 
  match (inferred , annotated) with
        (Base (v1, bt1, p1), Base (v2, bt2, p2))  -> raise (Error "Unimplemented subtyping") 
       | (Arrow ( t1, t1'), Arrow (t2, t2'))  ->  raise (Error "Unimplemented subtyping") 
       | (MArrow (eff1, p1 , (v1, t1) , p1'), MArrow (eff2, p2, (v2, t2), p2')) -> 
                (*let phi_annot_imp_pre = P.If (p2 , p1) in*)
                
                (*Case if the annotated type is Ty_unknown*)     
                
                let baseT1 = RefTy.toTyD t1 in 
                let baseT2 = RefTy.toTyD t2 in 
                assert ((TyD.sametype  baseT1 baseT2) 
                    || (baseT2 = TyD.Ty_unknown));    
                
                (*Case if the annotated type is Ty_unknown we assume t2=t1*)     
                
                let t2 = match baseT2 with 
                    | TyD.Ty_unknown -> t1 
                    | _ -> t2  
                in 


                let temp_h = Var.get_fresh_var "_temp_h" in 
                let temp_v = Var.get_fresh_var "_temp_v" in 
                let temp_h' = Var.get_fresh_var "_temp_h'" in 
                (*new int heap variable*)
                let fresh_bvs = [(temp_h, TyD.Ty_heap);(temp_v, RefTy.toTyD t2);(temp_h', TyD.Ty_heap)] in 
                (*_Gamma_ext, add to Gamma whenever existential*)
                let fresh_bvs_for_gamma = List.map (fun (v, t) -> (v, RefTy.lift_base t)) fresh_bvs in
                let gamma = List.fold_left (fun _g  (v,t) -> extend_gamma (v,t) _g) gamma fresh_bvs_for_gamma in 
        


                (*TODO Also add constraint for effs*)
                (* let () = Printf.printf "%s" ("\n Original Inferred pre "^P.toString p1) in *)
                let p1_temp = apply p1 [(temp_h, TyD.Ty_heap)] in 

                (* let () = Printf.printf "%s" ("\n Applied Inferred pre "^P.toString p1_temp) in *)


(*                 let () = Printf.printf "%s" ("\n Original Annotatetd pre "^P.toString p2) in  *)
                let p2_temp = apply p2 [(temp_h, TyD.Ty_heap)] in 

               (*  let () = Printf.printf "%s" ("\n Applied Annotated pre "^P.toString p2_temp) in *)



                (*Post1 => pre2*) 
                let phi_annot_imp_pre = P.If (p2_temp, p1_temp) in 
        

          
                let () = Printf.printf "%s" ("\n Case Non-Exceptional: Original Inferred post "^P.toString p1') in 
                let t1_tyd = RefTy.toTyD t1 in 
                let t2_tyd = RefTy.toTyD t2 in 
                
                let p1'_temp = apply p1' [(temp_h, TyD.Ty_heap);(temp_v, t1_tyd);(temp_h', TyD.Ty_heap)] in 

                 
               (*@NOTE : Handling the case of Weakest-Pre acting as post*)
               let bvs_p2' = P.getBVs p2' in 
                let p2'_temp = 
                    if (List.length bvs_p2' = 3) then 
                      apply p2' [(temp_h, TyD.Ty_heap);(temp_v, t2_tyd);(temp_h', TyD.Ty_heap)] 
                    else if (List.length bvs_p2' = 1) then 
                       apply p2' [(temp_h', TyD.Ty_heap)]
                    else 
                        raise (Error "Post-condition is either of the form forall h v h'. Q | forall h' Q")     
                in 

              
               let ante_conj = P.True in 


                let phi_post_imp_anno = P.If (p1'_temp, p2'_temp)  in  
(*                         let () = Printf.printf "%s" (" \n POST => ANNO_POst \n "^(P.toString phi_post_imp_anno)) in
*)
               let ante = env.preds in  
               let ante_conj = P.Conj( ante_conj, pred_conjunction ante) in
               
               (*Gamma |- delta => Pre /\ post*)
                       
                       (* 

                       let vc_for_path = VC (gamma, 
                                             ante_conj, 
                                        P.Conj (phi_annot_imp_pre, 
                                                (P.If (p1_temp, phi_post_imp_anno)))) in    *)
                        
                let vc_for_path = VC (gamma, 
                                             P.Conj (ante_conj, p1_temp), 
                                             phi_post_imp_anno) in                             
                       (* let vc_pre = VC (gamma, 
                                             ante_conj, 
                                                phi_annot_imp_pre) in 

                       let vc_post =  VC (gamma, 
                                             P.Conj (ante_conj,p1_temp), 
                                             phi_post_imp_anno)in    *)
                 (*let vc_for_path = VC (gamma, ante_conj, P.Conj (phi_annot_imp_pre, phi_post_imp_anno)) in*)
                      vc_for_path   
               
       | (_,_) -> raise (Error ("\n SubTyping "^(RefTy.toString inferred)^(" MISMATCH ")^(RefTy.toString annotated)^" \n")) 




let rec fromTypeCheck (_gamma) _delta (subTy, supTy) =
        let env = {gamma=_gamma;preds=_delta} in 
        match (subTy, supTy) with 
        | (RefTy.Base (v1, t1, p1), RefTy.Base (v2, t2, p2)) ->
            let () = Printf.printf "%s" ("SubTy "^(RefTy.toString subTy)) in 
            let () = Printf.printf "%s" ("SuperTy "^(RefTy.toString supTy)) in 
            let _ = assert (TyD.sametype t1 t2) in 
            
            if (Predicate.isTrue p2) then 
              empty_vc 
            else    
            let p2 = P.applySubst (v1,v2) p2 in 
            let _gamma = extend_gamma (v1, subTy) _gamma in 
            let delta_pred = Predicate.list_conjunction _delta in 
            let gamma_preds = constraints_from_gamma _gamma in
            let predicate_from_gamma = Predicate.list_conjunction gamma_preds in 
              VC (_gamma, P.Conj(predicate_from_gamma, 
                                P.Conj(delta_pred,p1)), p2) 
        | (RefTy.MArrow (_,_,_,_), RefTy.MArrow (_,_,_,_)) ->     
            trans_subtyping env supTy subTy 
        | (_,_) -> 
        raise (Error "Unhandled Case Arrow or Tuple fromTypeCheck")




