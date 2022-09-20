module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/t_bidder_info.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 

(*define transducer*) 
    
(*
 *  t_b_neq_s = \s : string \b. \r.
                                case not (s == b ) --> Bidder {name = b; rating = r} 
                                | case (s == b) -->  err
       
 * t_bidder_name = 
                        string "<biddername>" >>= 
                                \_. alphanum+ 
                                        >>= \bidder. 
                                                string "<\biddername>" 
                                 >>= \_. bidder 
    
               
    (*t_bidder_rating*)
      t_bidder_rating = 
                       "<sellerrating>" >>= 
                        \_. digit+ 
                                >>= \rating. string "<\sellerrating>" 
                                        >>= \_. t_rating
     t_bidder_info = \s. 
                        t_bidder_name s 
                                >>= \bname. 
                                t_bidder_rating >>= 
                                        \brating.
                                        
                                        t_b_neq_s    
    *)
let t_bidder_info = 
        
       
        let t_bidder_name = T_bidder_name.t_bidder_name in 
        let t_bidder_rating = T_bidder_rating.t_seller_rating in 
        let t_action = T_action.t_b_neq_s in  
        
        Trans.Lambda (T_var "s", getType "s", 
                      Trans.Bind (t_bidder_name,
                        Trans.Lambda (T_var "bname", getType "bname", 
                          Trans.Bind (t_bidder_rating,   
                                 Trans.Lambda (T_var "brating", getType "brating", t_action
                           )))))
             
let () = 
   Morpheus.verifyCPST gamma t_seller_info (getType "t_bidder_info")   
