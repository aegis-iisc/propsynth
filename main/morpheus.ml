open SpecLang
module PTC = ProgramTypeChecker
module VCE = Vcencode 
module VC= TransTypeChecker.VerificationC 

exception CantDischargeVC

let discharge_VCS (vcs : VC.standardt list)  = 
(*discharge VCs*)
let  dischargeVC i vc =
        let () = Printf.printf "%s" ("\n ***************** VC number "^(string_of_int i)^"\n \n "^(VC.string_for_vc_stt vc)^"***************************") in 
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

let verifyAssumedCPST initial_gamma cpst annot = 
        let () = Printf.printf "%s" "################## MORPHEUS ASSUMED Case ##########################" in 
        ()



let verifyCPST initial_gamma cpst annot solve = 
 let (env, refty, vcs) = PTC.type_synthesize_program initial_gamma cpst in
 match cpst with 
  | ST _ 
  | Fold (_,_,_,_,_,_) ->    
        let () = Printf.printf "%s" "################## MORPHEUS FOLDING VCS##########################" in 
        let () = Printf.printf "%s" ("\n Number-VCS "^ (string_of_int (List.length vcs))) in 
        let standard_vcs = List.map (fun (vc) -> (VC.standardize vc)) vcs in    
        let () = Printf.printf "%s" "\n Final VCs" in 
        (*let () = List.iter (fun vc -> Printf.printf "%s" ("\n"^(VC.string_for_vc_stt vc))) standard_vcs in*)      
        if (solve) then 
                discharge_VCS standard_vcs
        else 
                ()

  | Lambda (_, _, _) ->  
        let () = Printf.printf "%s" "################## MORPHEUS DISCHARGING PST VCS##########################" in
        let  RefTy.Arrow ((v,targ), refbody) = refty in 
        let  vcs = PTC.verify env vcs refbody annot in
        let () = Printf.printf "%s" ("\n Number-VCS "^ (string_of_int (List.length vcs))) in 
        let standard_vcs = List.map (fun (vc) -> (VC.standardize vc)) vcs in    
        (*let () = Printf.printf "%s" "\n Final VCs" in 
        let () = List.iter (fun vc -> Printf.printf "%s" ("\n"^(VC.string_for_vc_stt vc))) standard_vcs in*)      
       
           if (solve) then 
                discharge_VCS standard_vcs
        else 
                ()




 (*Check against spec*)
 | _ ->   
        let () = Printf.printf "%s" "################## MORPHEUS DISCHARGING CPST VCS##########################" in 
        let  _vcs_full = PTC.verify env vcs refty annot in
        let () = Printf.printf "%s" ("Number-VCS "^ (string_of_int (List.length _vcs_full))) in 
        let standard_vcs = List.map (fun (vc) -> (VC.standardize vc)) _vcs_full in    
        (*let () = Printf.printf "%s" "\n Final VCs" in 
        let () = List.iter (fun vc -> Printf.printf "%s" ("\n"^(VC.string_for_vc_stt vc))) standard_vcs in*)      
        
           if (solve) then 
                discharge_VCS standard_vcs
        else 
                ()


