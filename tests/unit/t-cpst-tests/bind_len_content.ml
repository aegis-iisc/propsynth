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
        
        let len_trans = Len.len_trans in 
        let content_trans = Content.content_trans in 


        let bounded_trans = Bind ((ST len_trans), Lambda (T_var "x", (RefTy.fromTyD TyD.Ty_int), (ST content_trans))) in  
        (***************** make a call to type_synthesis_for_bind*******************)
        let _initial_env = VC.empty_gamma in  
        let (refty, vcs) = PTC.type_synthesize_program _initial_env bounded_trans in 
        let () = Printf.printf "%s" ("Synthesized Type "^(RefTy.toString refty)) in 
        discharge_VCS vcs 

