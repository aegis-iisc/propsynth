module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/cdecl/t_exp.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)

(*define transducer*)     
let t_exp =                   
        let t_bool =  Trans.Red (T_const (SLit "int"), T_string.t_string) in 
        let t_int =  Trans.Red (T_const (SLit "bool"), T_string.t_string) in  
 
        Trans.Alt (t_bool, t_int) 
let () = 
   Morpheus.verifyCPST gamma t_exp (getType "annot") false   
