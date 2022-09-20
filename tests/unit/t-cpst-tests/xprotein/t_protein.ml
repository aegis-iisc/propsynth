module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap 
open SB  

let specfile = "tests/unit/t-cpst-tests/xprotein/t_protein.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)

(*define transducer*)
               
let t_protein =
   let t_open = Trans.Red (T_const (SLit "protein"), T_string.t_string)  in
   let t_uid = T_uid.t in 
   (*let t_name_check = T_name_check.t in *)
   let t_name =  T_identifier.t_identifier in 
   let t_close = Trans.Red (T_const (SLit "\protein"), T_string.t_string)  in
        
   let t_other_name = T_identifier.t_identifier in 
   
   let t_action = T_protein_action.t in 
   (*arrow = string "arrow" *)
   Trans.Bind (t_open, 
                Trans.Lambda (T_var "topen", getType "topen", 
                                Trans.Bind (t_name, 
                                             Trans.Lambda (T_var "pname", getType "pname", 
                                                           Trans.Bind (t_close,  t_action))))) 
                                                                     
let () = 
   Morpheus.verifyCPST gamma t_protein (getType "annot") true
