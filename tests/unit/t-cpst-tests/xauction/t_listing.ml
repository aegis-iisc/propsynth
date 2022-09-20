module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/t_listing.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 

(*define transducer*) 
    
   
(*C = 5*)   
let t_listing = 
        
        let t_open =  Trans.Red (T_const (SLit "<listing>"), T_string.t_sring)  in
         let t_close =  Trans.Red (T_const (SLit "</listing>"), T_string.t_sring)  in
 
        let t_seller_info = T_sellerinfo.t_seller_info in 
        let t_auction_info = T_auction.t_auction_info in 
        let t_action = T_action.listing_action in  
         
        Trans.Bind (t_open,
                        Trans.Lambda (T_var "open", getType "open", 
                                Trans.Bind (t_seller_info,   
                                  Trans.Lambda (T_var "si", getType "si", 
                                     Trans.Bind (t_auction_info, 
                                        Trans.Lambda (T_var "ai", getType "ai", t_action))))))
             
let () = 
   Morpheus.verifyCPST gamma t_listing (getType "t_bidder_info") true


