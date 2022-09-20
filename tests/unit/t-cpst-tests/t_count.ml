module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
module F = T_iota
module S = T_lambda  
open SB  

let specfile = "tests/unit/t-cpst-tests/t_count.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
let folding_fun = Trans.lambda "ac" (getType "f") 
let acc = Trans.T_var "acc"
    
(*define transducer*)     
let t_count  =                    
        let trans_t = T_included.t_included in 
        let f_typed = (folding_fun, getType "f") in 
        let g = getFormula "g" in 
        let acc_type  = (acc, getType "acc") in 
        let inv = getFormula "inv" in 
        let pre_post = getType "annotfold" in 
        Trans.Lambda (T_var "n", getType "n", Trans.Fold (trans_t, f_typed, g, acc_type, inv, pre_post))

let () = 
   Morpheus.verifyCPST gamma t_count (getType "annotfold")     
