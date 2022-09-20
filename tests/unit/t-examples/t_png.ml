module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  
open SpecLang

let populateEnv () = 
        let specfile = "tests/unit/t_png.spec" in  

        (*parse the associated spec file*)
        let ast = SB.parseLSpecFile specfile in 
        let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) in 
        let (tenv, formenv) =  SB.buildSigma ast in 
        (tenv, formenv)
   
  
let getType tenv s = TM.find tenv s  
let getFormula formenv s = FM.find formenv s 



let getTrans () = 
     let (tenv, formenv) = populateEnv () in    
     let trans_chunk = Chunk.getTrans () in 
     (*define f_step, base and inv*)
     (*place holder*)
     let f_step = Trans.T_var (Var.fromString "step") in 
     (*base*)
     let base = Trans.T_nil in 
          
     let trans_png = Trans.Fold (trans_chunk, (f_step, getType tenv "f_step"), (base, getType tenv "base"), (getFormula formenv "inv")) in 
     trans_png

let () = 
 let (tenv, formenv) = populateEnv () in  
  Morpheus.verifyCPST (getTrans()) (getType tenv "annot")     
