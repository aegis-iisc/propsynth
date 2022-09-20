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
        
        let t_head = T_head.t_head in 

      let folded_trans = 
        let fresh_nu = Var.get_fresh_var "v" in 
        let fresh_x = Var.get_fresh_var "x" in 
        let fresh_y = Var.get_fresh_var "y" in 
        let fresh_h = Var.get_fresh_var "h" in
        let fresh_h' = Var.get_fresh_var "h'" in 
        let f_step_body_post =     P.Forall ([(fresh_h, Ty_heap);(fresh_nu, (Ty_list Ty_int)); (fresh_h', Ty_heap)],
                                             P.Rel(RP.Eq ( MultiR ( (RelLang.instOfRel (RelId.fromString "elems")), [(fresh_nu)]),
                                                   RelLang.U (
                                                        MultiR ( (RelLang.instOfRel (RelId.fromString "elems")), [(fresh_y)]),
                                                          RelLang.T [(RelLang.Var (Var.toString fresh_x))])))) in   
                                                        
                               
        let f_step_body_ty = RefTy.MArrow (Effect.StExc, (P.Forall([(fresh_h, Ty_heap)], P.True)), (TyD.Ty_list Ty_int), (f_step_body_post)) in 
        let f_step_y_body = RefTy.Arrow ((fresh_y, RefTy.Base ( fresh_y, TyD.Ty_list Ty_int, P.True)), f_step_body_ty) in 
        let f_step_x_body =  RefTy.Arrow ((fresh_x, RefTy.Base ( fresh_x, TyD.Ty_int, P.True)), f_step_y_body) in 
        let f_step_ty = f_step_x_body in 
        (*place holder*)
        let f_step = T_var (Var.fromString "step") in 
        (*base*)
        let base = T_nil in 
        let base_ty = RefTy.Base (Var.fromString "base", TyD.Ty_list Ty_int, P.True) in 
        Fold (t_head, (f_step, f_step_ty), (base, base_ty), P.True) (*should not typecheck*)

        in 

        (***************** make a call to type_synthesis_for_bind*******************)
        let _initial_env = VC.empty_gamma in  
        let (env, refty, vcs) = PTC.type_synthesize_program _initial_env folded_trans in 
         let () = Printf.printf "%s" ("Number of VCS "^ (string_of_int (List.length vcs))) in 
        let standard_vcs = List.map (fun (vc) -> (VC.standardize vc)) vcs in    
        let () = printf "%s" "\n Final VCs" in 
        let () = List.iter (fun vc -> Printf.printf "%s" ("\n"^(VC.string_for_vc_stt vc))) standard_vcs in      
 

        discharge_VCS (standard_vcs)

