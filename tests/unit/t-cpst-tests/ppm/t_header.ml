module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/ppm/t_header.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
(*define transducer*)    
(*C = 4*)    
let t_header = 
        
        (*   t_header = do {
         *
         *                 w <- natural;
         *                 h <- natural;
         *                 m <- natural;
         *                 triple (w, h, m)
         *                } 
         *      
         *
         *   t_header  :  
         *              {true}
         *              triple 
         *              {\h, v, h'. true }
         **)
        
        let t_natural = Trans.Red (Trans.T_var "n",  T_number.t_number) in 
        let t_triple = T_triple.t_triple in 

        
        Trans.Bind (t_natural,
                        Trans.Lambda (T_var "br", getType "br", 
                               (Trans.Bind (t_natural,   
                                               Trans.Lambda (T_var "bg", getType "bg", 
                                                   Trans.Bind (t_natural, t_triple))))))  
             
let () = 
   Morpheus.verifyCPST gamma t_header (getType "annot")     
