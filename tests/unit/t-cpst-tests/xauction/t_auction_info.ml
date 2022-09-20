module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/xauction/t_auction_info.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
(*define transducer*) 
  (*t_auctioninfo s = 
   *            string "<auctioninfo>" >> 
   *                            t_bidders s >>= \bs
   *                                            string "<\auctioninfo>" >>
   *                                                            bs
   *    
   *    *)
(*C=4*)    
let t_auction_info = 
        
        let t_open =  Trans.Red (T_const (SLit "<auctioninfo>"), T_string.t_sring) in 
        let t_bidders = T_bidders.t_bidders in 
        let t_close =   Trans.Red (T_const (SLit "<\auctioninfo>"), T_string.t_sring) in 
        let t_action = T_action.acution_info in  
        
        Trans.Lambda (T_var "s", getType "s",
          Trans.Bind (t_open,
                    Trans.Bind ( 
                        Trans.Red (T_var "s", t_bidders),
                                Trans.Lambda (T_var "bs", getType "bs", 
                                              Trans.Bind (t_close, 
                                                          Trans.Red (T_var "bs", t_action))
                           ))))
             
let () = 
   Morpheus.verifyCPST gamma t_auction_info (getType "t_seller_info")   
