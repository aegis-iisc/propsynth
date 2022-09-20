module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap 
open SB  

let specfile = "tests/unit/t-cpst-tests/cdecl/t_typedef.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)

(*define transducer*)
(*4 components*)               
let t_typedef =
   let t_typeexp = T_exp.t_exp in 
   let t_action = T_decl_action.t_action in 
   (*arrow = string "arrow" *)
   let typedef_term = Trans.Red (T_const (SLit "typedef"), T_string.t_string)  in
   Trans.Bind (typedef_term, 
                Trans.Lambda (T_var "typedefterm", getType "typedefterm", 
                                Trans.Bind (t_typeexp, 
                                             Trans.Lambda (T_var "typeexp", getType "typeexp", 
                                                           t_action)))) 
                                                                     
let () = 
   Morpheus.verifyCPST gamma t_typedef (getType "annot") true
