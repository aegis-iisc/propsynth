module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
module F = T_iota
module S = T_lambda  
open SB  

let specfile = "tests/unit/t-cpst-tests/t_bind.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)

(*define transducer*)     
let t_bind =                    
        let trans_first = T_iota.t_iota in 
        let trans_second = T_lambda.t_lambda in 
        Trans.Bind (trans_first, trans_second) 
let () = 
   Morpheus.verifyCPST gamma t_bind (getType "annot") true
