module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/t_lambda.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast
(*define placeholder functions in L term with types*)
let init = Trans.trivial_unit  
let finalqf = Trans.T_dref (T_var  "boundx") 
let finalother = Trans.trivial_unit
let boundx = Trans.T_var "boundx"                   
(*define transducer*)     
let t_lambda =                    
        let states_st = ["q0"] in 

       (* let regs = [(res, SpecLang.RefTy.fromTyD (SpecLang.TyD.Ty_int))] in *)
        let regs = [] in 
        let final = Trans.Final {fin = fun (st:Trans.state) -> 
                                match st with 
                                   | "qf" -> (finalqf, getType ("finalqf"))
                                   | _ -> (finalother, getType ("finalother"))} in  
        let transition_system =  Trans.Trans { regs = regs;
                            states=states_st;
                            start = "qf";
                            final = ["qf"];
                            finalizer = final;        
                            (*A term for let cnt = ref 0 , and A type M {true} unit {update h' cnt 0}*)
                            init =  (init ,getType "init");
                            deltas = [];
                            annot = getType ("annot")}
        in    
        let body = Trans.ST transition_system in 
        Trans.Lambda (boundx, getType ("boundx"), body)

let () = 
   Morpheus.verifyCPST gamma t_lambda (getType "annot") true 
