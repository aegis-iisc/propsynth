module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
module F = T_iota
module S = T_lambda  
open SB  

let specfile = "tests/unit/t-cpst-tests/t_bind_single.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)

(*define transducer*)
let t_zero = T_zero_simple.t_zero
let t_second =                    
        let t_one = T_one_simple.t_one in 
        let trans_pair = T_pair.t_pair in 
        Trans.Lambda (T_var "zero", getType "zero", Trans.Bind (t_one, trans_pair)) 
                
let t_bind =Trans.Bind (t_zero, t_second) 
let () = 
   Morpheus.verifyCPST gamma t_second (getType "t_second") ;
   Morpheus.verifyCPST gamma t_bind (getType "t_bind")     
