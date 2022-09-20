
module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/csvhealth/t_skip_4.spec"  

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
let t_skip_4 =
        let f_typed = (folding_fun, getType "f") in 
        let g = getFormula "g" in 
        let acc_type  = (acc, getType "acc") in 
        let inv = getFormula "inv" in 
        let pre_post = getType "annotfold" in 
        let t_number = T_number.t_number in  
        let t_comma =  Trans.Red (T_const (SLit ","), T_string.t_string) in  
        let t_skip = Trans.Bind (t_number, Trans.Lambda (T_var "skip", getType "skip", t_comma)) in 
        Trans.Fold (t_skip, f_typed, g, acc_type, inv, pre_post)  

              
let () = 
   Morpheus.verifyCPST gamma t_skip_4 (getType "annotfold")  true 
