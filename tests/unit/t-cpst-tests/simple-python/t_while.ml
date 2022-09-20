module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/simple-python/t_while.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
(*define transducer*)    
    (*9 components*)
let t_while = 
       
        let t_while_term =  Trans.Red (T_const (SLit "while"), T_string.t_string) in 
        let t_test =  T_identifier.t_identifier in 
        let t_colon_term =  Trans.Red (T_const (SLit "colon"), T_string.t_string) in 
        let t_suite = T_suite.t_suite in 
        let t_tree = T_tree.t_tree in 
        let t_createlist = T_createlist.t_list in 
        let t_concat = T_concat.t_concat in
        let t_tree = T_tree.t_tree in  
        let t1 = Trans.Bind (t_while_term,
                      Trans.Lambda (T_var "whileterm", getType "whileterm", 
                         (Trans.Bind (t_test,   
                            Trans.Lambda (T_var "test", getType "test", 
                                Trans.Bind (t_colon_term, 
                                     Trans.Lambda (T_var "colon", getType "colon" , t_createlist))))))) in       
                                        
        let t2 = Trans.Bind (t1, Trans.Lambda (T_var "children0", getType "children0", 
                        Trans.Bind (t_suite ,
                                Trans.Lambda (T_var "suite", getType "suite", t_concat)
                           ))) in  
        
        Trans.Bind (t2, 
                Trans.Lambda (T_var "children", getType "children", t_tree))
             
let () = 
   Morpheus.verifyCPST gamma t_while (getType "t_while")   true
