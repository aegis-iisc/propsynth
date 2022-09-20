module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/simple-python/t_stmts.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast
let folding_fun = Trans.lambda "ac" (getType "f") 
let acc = Trans.T_var "acc"
 
(*define placeholder functions in L term with types*)
(*define transducer*)     
let t_stmts = 
        let f_typed = (folding_fun, getType "f") in  
        let acc_type = (acc, getType "acc") in
        let g = getFormula "g" in
        let inv = getFormula "inv" in
        let pre_post = getType "t_stmts" in 
        let t_stmt = T_identifier.t_identifier in  
        Trans.Fold (t_stmt, f_typed, g, acc_type, inv, pre_post) 
             
let () = 
   Morpheus.verifyCPST gamma t_stmts (getType "t_stmts") false
