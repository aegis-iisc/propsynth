module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/t_red_str.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast
(*define placeholder functions in L term with types*)
let init = Trans.trivial_unit  
let finalqf = Trans.T_dref (T_var  "boundx") 
let finalother = Trans.trivial_unit
let boundx = Trans.T_var "boundx"                   
(*define transducer*)     
let t_red = 
        let test_value = Trans.T_const(SLit "teststr") in 
        let t_lambda_str = T_lambda_str.t_lambda_str in 
        Trans.Red (test_value, t_lambda_str)

let () = 
   Morpheus.verifyCPST gamma t_red (getType "annot") true
