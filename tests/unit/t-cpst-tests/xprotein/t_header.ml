module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap 
open SB  

let specfile = "tests/unit/t-cpst-tests/xprotein/t_header.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)

(*define transducer*)
               
let t_header =
   let t_open = Trans.Red (T_const (SLit "header"), T_string.t_string)  in
   let t_uid = T_uid.t in 
   let t_close = Trans.Red (T_const (SLit "header"), T_string.t_string)  in

   let t_action = T_header_action.t in 
   (*arrow = string "arrow" *)
   Trans.Bind (t_open, 
                Trans.Lambda (T_var "topen", getType "topen", 
                                Trans.Bind (t_uid, 
                                             Trans.Lambda (T_var "uid", getType "uid", 
                                                           Trans.Bind (t_close,  t_action))))) 
                                                                     
let () = 
   Morpheus.verifyCPST gamma t_header (getType "annot") true
