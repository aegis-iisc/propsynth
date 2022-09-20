module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/simple-python/t_suite.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)

(*define transducer*)
(*4 components*)               
let t_suite =
   let t_nl = T_newline.t_newline in 
   (*arrow = string "arrow" *)
   let t_tree = T_tree.t_tree in 
   let t_stmts = T_stmts.t_stmts  in
   (*t_suite = t_nl >>= \nl. many t_stmts >>= \children t_tree*)     
   
   Trans.Bind (t_nl, 
                Trans.Lambda (T_var "nl", getType "nl", 
                                Trans.Bind (t_stmts, 
                                             Trans.Lambda (T_var "stmts", getType "stmts", t_tree)))) 
                                                                     
let () = 
   Morpheus.verifyCPST gamma t_suite (getType "t_suite") false 
