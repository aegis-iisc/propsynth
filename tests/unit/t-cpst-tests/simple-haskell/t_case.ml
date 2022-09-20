module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/simple-haskell/t_case.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast
let folding_fun = Trans.lambda "ac" (getType "f") 
let acc = Trans.T_var "acc"
 
(*define placeholder functions in L term with types*)
(*define transducer*)     
let t_case = 
        let f_typed = (folding_fun, getType "f") in  
        let acc_type = (acc, getType "acc") in
        let g = getFormula "g" in
        let inv = getFormula "inv" in
        let pre_post = getType "t_alts" in 
        let t_case_term =  Trans.Red (T_const (SLit "case"), T_string.t_string) in 
        let t_of =  Trans.Red (T_const (SLit "of"), T_string.t_string) in  
        let t_tree = T_tree.t_tree in 
        let t_alt = T_alt.t_alt in  
        let t_id = T_identifier.t_identifier in   
        let t_alts = Trans.Fold (t_alt, f_typed, g, acc_type, inv, pre_post) in 
        let t_createlist = T_createlist.t_createlist in 
        let t_concat = T_concat.t_concat in 
        (*4 components*)
        let t1 = Trans.Bind (t_case_term,
                      Trans.Lambda (T_var "x", getType "x", 
                         (Trans.Bind (t_id,   
                            Trans.Lambda (T_var "exp", getType "exp", 
                                Trans.Bind (t_of, 
                                     Trans.Lambda (T_var "of", getType "of" , t_createlist))))))) in       
        (*3 components*)                                
        let t2 = Trans.Bind (t1, Trans.Lambda (T_var "children0", getType "children0", 
                        Trans.Bind (t_alts,
                                Trans.Lambda (T_var "alts", getType "alts", t_concat)))) in 
        (*2 components*)
        Trans.Bind (t2, 
                Trans.Lambda (T_var "children", getType "children", t_tree))
             
let () = 
   Morpheus.verifyCPST gamma t_case (getType "t_case")  true 
