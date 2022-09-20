module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  
open Trans


let populateEnv () = 

        let specfile = "tests/unit/result.spec" in  
        (*parse the associated spec file*)
        let ast = SB.parseLSpecFile specfile in 
        let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) in 
        let (tenv, formenv) =  SB.buildSigma ast in 
        (tenv, formenv)
   
  
let getType tenv s = TM.find tenv s  
let getFormula formenv s = FM.find formenv s 


let getTrans () = 
  let (tenv, formenv) = populateEnv () in 
(*place holder functions in L term*)
  let init = Trans.T_unit in  
  let finalqf = Trans.T_dref (T_var  "boundx") in  
  let finalother = Trans.trivial_unit in 

  let result = 
        let states_st = ["q0"] in 
        let regs = [] in 
         

        let final = Trans.Final {fin = fun (st:Trans.state) -> 
                                        match st with 
                                           | "q0" -> (finalqf, getType tenv ("finalqf"))
                                           | _ -> (finalother, getType tenv ("finalother"))} in  
            
        let pst = 
           Trans { regs = regs;
            states=states_st;
            start = "q0";
            final = ["q0"];
            finalizer = final;
            init =  (init ,getType tenv "init");
            deltas = [];
            annot = getType tenv "annot"}
        in 
        Trans.Lambda (T_var "boundx", getType tenv "boundx", ST pst)
 in result

let () = 
   let (tenv, formenv) = populateEnv () in 
   Morpheus.verifyCPST (getTrans()) (getType tenv "annot")     
         


