module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
module F = T_one
module S = T_two  
open SB  

let specfile = "tests/unit/t-cpst-tests/t_alt.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)

(*define transducer*)     
let t_alt =                    
        let trans_one = T_one.t_one in 
        let trans_two = T_two.t_two in 
        Trans.Alt (trans_one, trans_two) 
let () = 
   Morpheus.verifyCPST gamma t_alt (getType "annot")     
