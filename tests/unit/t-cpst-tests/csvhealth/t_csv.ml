(*
t_skip 4 >>
  (t_number >>= \x.
    ( t_number >>= \y. (t_number >>= \z.
                       t_action)))
   *)


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
 
(*define placeholder functions in L term with types*)
(*define transducer*)     
let t_csv = 
        let t_skip_4 =  T_skip_4.t_skip_4 in 
        let t_cancer_deaths = T_number.t_number in 
        let t_action_lt = T_action_lt.t in 
        let t_action_gt = T_action_gt.t in
        let t_cancer_deaths_min = Trans.Bind (T_number.t_number, t_action_lt) in 
        let t_cancer_deaths_max = Trans.Bind (T_number.t_number, t_action_gt) in 
        let t_triple = T_triple.t_triple in 
        (*4 components*)
        Trans.Bind (t_skip_4, Trans.Lambda(T_var "skip", getType "skip",
                    ( Trans.Bind (t_cancer_deaths,  Trans.Lambda(T_var "deaths", getType "deaths",
                         ( Trans.Bind (t_cancer_deaths_min, Trans.Lambda(T_var "min", getType "min",
                             (Trans.Bind (t_cancer_deaths_max, Trans.Lambda(T_var "max", getType "max",
                                             t_triple)))))))))))                               
                                             
                                       
                       
                        
let () = 
   Morpheus.verifyCPST gamma t_csv (getType "t_case")  true 
