module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/t_seller_info.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
(*define transducer*) 
    (*t_seller_name = 
                        string "<sellername>" >>= 
                                \_. alphanum+ 
                                        >>= \seller. string "<\sellername>" 
                                 >>= \_. t_name

                
      (*t_sellerrating*)
      t_seller_rating = 
                       string "<sellerrating>" >>= 
                        \_. digit+ 
                                >>= \rating. string "<\sellerrating>" 
                                        >>= \_. t_rating
     t_seller_info = t_seller_name >>= \sname. 
                        t_seller_rating >>= \srating.
                           Seller {name=sname;rating=srating}       
    *)
let t_seller_info = 
        
       
        let t_seller_name = T_seller_name.t_seller_name in 
        let t_seller_rating = T_seller_rating.t_seller_rating in 
        let t_action = T_action.t_seller_ino_constructor in  
        
        Trans.Bind (t_seller_name,
                      Trans.Lambda (T_var "sname", getType "sname", 
                         Trans.Bind (t_seller_rating,   
                            Trans.Lambda (T_var "srating", getType "srating", t_action
                           ))))
             
let () = 
   Morpheus.verifyCPST gamma t_seller_info (getType "t_seller_info")   
