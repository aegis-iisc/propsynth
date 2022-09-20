module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap 
open SB  

let specfile = "tests/unit/t-cpst-tests/simple-haskell/t_alt.spec"  

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
let t_alt =
   let t_tree = T_tree.t_tree in 
   let t_pat = T_identifier.t_identifier in 
   (*arrow = string "arrow" *)
   let t_arrow = Trans.Red (T_const (SLit "arrow"), T_string.t_string)  in
   let t_rhs = T_identifier.t_identifier in 
   (*t_alt = t_pat >>= \p. t_arrow >>= \ar. t_rhs >>= \r. t_tree*)     
   Trans.Bind (t_pat, 
                Trans.Lambda (T_var "p", getType "p", 
                                Trans.Bind (t_arrow, 
                                             Trans.Lambda (T_var "ar", getType "ar", 
                                                           Trans.Bind (t_rhs , t_tree))))) 
                                                                     
let () = 
   Morpheus.verifyCPST gamma t_alt (getType "t_alt") false
