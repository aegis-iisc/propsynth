module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/t_ppm.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
(*define transducer*)    
 (*# C = 5*)   
let t_ppm = 
        
        (*   t_ppm =  string "P" >>= 
         *                      \_. vernumber >>= 
         *                      \_. t_header >>= 
         *                      \tr. t_body >>= 
         *                      \b. t_pair 
         *      
         *
         *   t_ppm  :  {true}
         *              pair
         *              {\h, v, h'. true  }
         **)
        
        let t_vnumber = T_natural.t_natural in
        let t_triple = T_triple.t_triple in 
        let t_header = T_header.t_header in 
        let t_body = T_body.t_body in 
        let t_stringp = Trans.Red (T_var "P", T_string.t_string) in 
        
        Trans.Bind (t_stringp,
                      Trans.Lambda (T_var "_", getType "_", 
                         (Trans.Bind (t_vnumber,   
                            Trans.Lambda (T_var "_", getType "_", 
                                Trans.Bind (t_header , 
                                   Trans.Lambda (T_var "tr", getType "tr", 
                                      Trans.Bind (t_body, t_triple)
                           )))))))  
             
let () = 
   Morpheus.verifyCPST gamma t_header(getType "annot")     
