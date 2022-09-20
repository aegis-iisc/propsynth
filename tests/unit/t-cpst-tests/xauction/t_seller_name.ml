module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/xauction/t_seller_name.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 

(*define transducer*) 
(*C = 4 *)    
(*
 * t_bidder_name = 
                        string "<biddername>" >>= 
                                \_. alphanum+ 
                                        >>= \bidder. 
                                                string "<\biddername>" 
                                 >>= \_. bidder 
   *)
   let t = 
        let t_open =  Trans.Red (T_const (SLit "<biddername>"), T_string.t_string)  in
        let t_sname = T_identifier.t_identifier in 
        let t_close =  Trans.Red (T_const (SLit "<\biddername>"), T_string.t_string)  in
        (*a helper function for semantic action*)
        let t_action = T_action_sname.t in  
        
         Trans.Bind (t_open,
                        Trans.Lambda (T_var "open", getType "open", 
                           Trans.Bind (t_sname,   
                                 Trans.Lambda (T_var "sname", getType "sname", 
                                        Trans.Bind (t_close, 
                                                    Trans.Lambda (T_var "close", getType "close", t_action))))))        
             
let () = 
   Morpheus.verifyCPST gamma t (getType "annot") false  
