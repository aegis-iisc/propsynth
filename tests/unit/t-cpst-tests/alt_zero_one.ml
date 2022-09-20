module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  


let populateEnv () = 
        let specfile = "tests/unit/alt_zero_one.spec" in  

        (*parse the associated spec file*)
        let ast = SB.parseLSpecFile specfile in 
        let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) in 
        let (tenv, formenv) =  SB.buildSigma ast in 
        (tenv, formenv)
   
  
let getType tenv s = TM.find tenv s  
let getFormula formenv s = FM.find formenv s 



let getTrans () = 
     let zero_one = Zero_one.getTrans () in 
      Trans.Alt (zero_one, zero_one)  

let () = 
 let (tenv, formenv) = populateEnv () in  
  Morpheus.verifyCPST (getTrans()) (getType tenv "annot")     
