module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  
open Trans
let specfile = "tests/unit/t-cpst-tests/simple-python/t_newline.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast
let gamma = SB.initializeGamma ast     
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let assumed = SB.checkAssumed ast 
          
(*place holder functions in L term*)
let init =   Trans.trivial_unit 
let step1 =  T_lam ("x", (T_var "x"), getType "step1") 
let finalqf = Trans.T_dref (T_var  "content") 
let finalother = Trans.trivial_unit

let t_newline = 
        let states_st = ["q0";"qf";"qe"] in 
        let regs = [] in 
         

        let _d1 = Del {name = "_d1";src = "q0"; tgt = "qf"; guard=getFormula "guard"; step=(step1); inv = True} in 
        let final = Trans.Final {fin = fun (st:Trans.state) -> 
                                        match st with 
                                           | "qf" -> (finalqf, getType ("finalqf"))
                                           | _ -> (finalother, getType ("finalother"))} in  
            
        let pst = 
           Trans { regs = regs;
            states=states_st;
            start = "q0";
            final = ["qf"];
            finalizer = final;
            init =  (init ,getType "init");
            deltas = [(_d1, getType ("step1"))];
            annot = getType "annot"}

          
        in 
        ST pst
let () = 
  Morpheus.verifyCPST gamma t_newline (getType "annot") false
                 


