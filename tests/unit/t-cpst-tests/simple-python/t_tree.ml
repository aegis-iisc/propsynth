module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/simple-python/t_tree.spec"
(* 
 * I = { ();}
 * d = []
 * A(q0) = {return 1}
 *
 *
 *)
(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 

let init = Trans.trivial_unit   
let finalqf = Trans.(T_var "x") 
let finalother = Trans.trivial_unit
(*define transducer*)     
let t_tree =                    
        let states_st = ["q0"] in 

       (* let regs = [(res, SpecLang.RefTy.fromTyD (SpecLang.TyD.Ty_int))] in *)
        let regs = [] in 

        let final = Trans.Final {fin = fun (st:Trans.state) -> 
                                match st with 
                                   | "q0" -> (finalqf, getType ("finalqf"))
                                   | _ -> (finalother, getType ("finalother"))} in  
        let transition_system =  Trans.Trans { regs = regs;
                            states=states_st;
                            start = "q0";
                            final = ["q0"];
                            finalizer = final;        
                            init =  (init ,getType "init");
                            deltas = [];
                            annot = getType ("annot")}
        in    
 
                      (*  Trans.Lambda (T_var "node", getType "node",
                             Trans.Lambda( T_var "indent", getType "indent", *)
                                Trans.Lambda (T_var "children", getType "children", Trans.ST transition_system)

let () = 
   Morpheus.verifyCPST gamma t_tree (getType "annot") false

