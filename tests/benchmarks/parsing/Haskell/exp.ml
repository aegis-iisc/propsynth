module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  


let populateEnv () = 
        let specfile = "tests/unit/exp.spec" in  

        (*parse the associated spec file*)
        let ast = SB.parseLSpecFile specfile in 
        let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) in 
        let (tenv, formenv) =  SB.buildSigma ast in 
        (tenv, formenv)
   
  
let getType tenv s = TM.find tenv s  
let getFormula formenv s = FM.find formenv s 



let getTrans () = 
     let trans_id = Id.getTrans () in 
     let trans_const = Const.getTrans () in 
     let exp_trans = Trans.Alt (trans_mod, trans_content) in 
     exp_trans

(*let () = 
 let (tenv, formenv) = populateEnv () in  
  Morpheus.verifyCPST (getTrans()) (getType tenv "annot") *)    
