module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/t_body.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
(*define transducer*)     
let t_body = 
        
        (*   t_body = \ (w, h, m) : triple -> 
         *              let rgb = t_rgb m in
         *              let cols = count w rgb in 
         *              let rows = count h cols in 
         *              rows
         *      
         *
         *   t_body : w h m -> 
         *              {true}
         *              [[rgb]] 
         *              {\h, v, h'. len v == h /\ wellformed v}
         **)
        
        let t_natural = T_natural.t_natural in 
      
        let rgb  = Trans.Red (max tr, t_rgb) in
        let cols = Trans.count (width tr) rgb in
        let rows = Trans.count (height tr) cols in
        
        Trans.Lambda (T_var "tr" "tr", rows)
             
let () = 
   Morpheus.verifyCPST gamma t_body (getType "annot")     
