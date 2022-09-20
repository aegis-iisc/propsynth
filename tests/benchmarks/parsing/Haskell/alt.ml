module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  


let populateEnv () = 
        let specfile = "tests/unit/alt.spec" in  

        (*parse the associated spec file*)
        let ast = SB.parseLSpecFile specfile in 
        let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) in 
        let (tenv, formenv) =  SB.buildSigma ast in 
        (tenv, formenv)
   
  
let getType tenv s = TM.find tenv s  
let getFormula formenv s = FM.find formenv s 



let getTrans () = 
     let (tenv, formenv) = populateEnv () in    
     let exp1 = Exp.getTrans () in 
     let arrow = Exp.getTrans () in 
     let exp2 = Exp.getTrans () in 
     let sa = SA.getTrans () in 
     let exp2_sa = Trans.Bind (exp2, Trans.Lambda (T_var "z", (getType tenv z), sa)) in 
     let arrow_exp2_sa =Trans.Bind (arrow, Trans.Lambda (T_var "y", (getType tenv y), exp2_sa)) in
     let alt = Trans.Bind (exp1, Trans.Lambda (T_var "x", (getType tenv x), arrow_exp2_sa)) in 
     alt

(*let () = 
 let (tenv, formenv) = populateEnv () in  
  Morpheus.verifyCPST (getTrans()) (getType tenv "annot") *)    
