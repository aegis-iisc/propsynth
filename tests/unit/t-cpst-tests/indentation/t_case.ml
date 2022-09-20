module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/t_case.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
(*define transducer*)     
let t_case = 
        
        (*   t_case =  string "case" >>= 
         *                  \x. t_identifier >>= 
         *                      \y.  string "of" >>= 
         *                       \z. t_alt  >>= 
         *                          \p1. many t_alt >>=    
         *                             \ps. t_tree
         *      
         *
         *   t_case  :  {\h, v, h'. case : stexc {sel h ind = I} 
         *               v : tree     
         *              { indentedTree I v }
         *                                                                      
         **)
        
        let t_case_term =   Trans.Red (T_const (SLit "case"), T_string.t_sring)  in
        let t_arrow = Trans.Red (T_const (SLit "arrow"), T_string.t_sring)  in
        let t_tree = T_tree.t_tree in 
        let t_alt = T_alt.t_alt in  
        let t_id = T_identifier.t_identifier in   
        let t_alts = Trans.many t_alt in 
        
        Trans.Bind (t_case_term,
                      Trans.Lambda (T_var "x", getType "x", 
                         (Trans.Bind (t_identifier,   
                            Trans.Lambda (T_var "y", getType "y", 
                                Trans.Bind (t_alt , 
                                   Trans.Lambda (T_var "p1", getType "p1", 
                                      Trans.Bind (t_alts, t_tree)
                           )))))))  
             
let () = 
   Morpheus.verifyCPST gamma t_case (getType "t_case")   
