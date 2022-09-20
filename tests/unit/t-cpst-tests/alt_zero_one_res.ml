open SpecLang 
open TransTypeChecker    
open Printf
open TypedTransLang

module PTC = ProgramTypeChecker

module VCE = Vcencode 
module VC= VerificationC 

let discharge_VCS (vcs : VC.standardt list)  = 
(*discharge VCs*)
let  dischargeVC i vc = 
        match (VCE.discharge vc) with   
        VCE.Success -> 
            Printf.printf  "%s" ("VC# "^(string_of_int (i+1))^" discharged\n")
        | VCE.Undef -> (Printf.printf "%s" ("Solver timeout  while trying to \
                  \discharge VC #"^(string_of_int (i+1))); 
                   (* z3_log_close (); *)
          raise CantDischargeVC)
        |VCE.Failure -> (Printf.printf "%s" ("VC # " ^(string_of_int i)^
                                             " is invalid!"); ();
                                           raise CantDischargeVC)
in    
let unit_lists = List.mapi dischargeVC vcs in   
Printf.printf "%s" "The implementation is correct w.r.t given specification!\n"


(************************Tests Cases***************************************)
(*len transducers *)
let () =

        let trans_zero_one = Trans_0_1.zero_one_trans in 


        let bounded_trans = Alt (trans_zero_one, trans_zero_one) in

        (*create verification spec*)
        let _inp_ident = Var.fromString "inp" in 
        let _h_ident = Var.get_fresh_var "h" in  
        let _h'_ident = Var.get_fresh_var "h'" in
        let _v_ident = Var.get_fresh_var "v" in 
 
        (*STExc {true} int {\h v h. v = sel_hd inp && v \in [0-3]}*)

        let annotated_pre = P.Forall ([(_h_ident, Ty_heap)], True) in
         let annotated_post = P.Forall ( [(_h_ident, TyD.Ty_heap); (_v_ident, TyD.Ty_int) ;(_h'_ident, TyD.Ty_heap)],
                                         P.Conj (
                                                (P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "hd_sel")), [(_h_ident); (_inp_ident)]),
                                                  RelLang.V (RelLang.Var(Var.toString _v_ident))))),
                                                 (P.list_disjunction[P.Base((BP.varIntEq (_v_ident, 0 )));
                                                                     P.Base((BP.varIntEq (_v_ident, 1)));
                                                                      P.Base((BP.varIntEq (_v_ident, 2)));
                                                                       P.Base((BP.varIntEq (_v_ident, 3)))]
                                                )
                                              )
                                      )
        in 
        let annotated_type = RefTy.MArrow (Effect.State, annotated_pre, Ty_int, annotated_post ) in
 

        let _initial_env = VC.empty_gamma in 
        let (env, refty, vcs) = PTC.type_synthesize_program _initial_env bounded_trans in
        let () = Printf.printf "%s" ("\n >>>> Synthesized Type "^(RefTy.toString refty)) in 
         
        (*Check against spec*)

        let  _vcs_full = PTC.verify env vcs refty annotated_type in
        let () = Printf.printf "%s" ("Number of VCS "^ (string_of_int (List.length _vcs_full))) in 
        let standard_vcs = List.map (fun (vc) -> (VC.standardize vc)) _vcs_full in    
        let () = printf "%s" "\n Final VCs" in 
        let () = List.iter (fun vc -> Printf.printf "%s" ("\n"^(VC.string_for_vc_stt vc))) standard_vcs in      
 

        discharge_VCS (standard_vcs)

       
