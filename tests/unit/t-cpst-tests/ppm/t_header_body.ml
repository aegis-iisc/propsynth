module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/t_header_body.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
let n = Trans.T_var "n" 
let max = Trans.T_var "max"
let width = Trans.T_var "width"
let height = Trans.T_var "height"
let vn = Trans.T_var "vn"    
(*define transducer*)     
let t_hba = 
        let t_natural = T_natural.t_natural in 

        (*ta = \b.  Pair (hdr,b*)
        let trans_action = T_pair.t_pair in 
        (*tbodya = \hdr. count (hdr.h (count hdr.w (rgb hdr.m)) >>= ta*)
       
        let rgb_m = Trans.Red (max, t_rgb) in
        let count_w = Trans.count width, rgb_m in
        let count_h = Trans.count height, count_w in 
        
        (*tba = \m. count_h >>= \d. ta*)
        let trans_body = Trans.Lambda (max , Trans.Bind (count_h, trans_action)) in
        
        (*mtba = \height. Natural >>= \max. trans_body*)
        let trans_max = Trans.Lambda (height, Trans.Bind (t_natural, trans_body)) in 

         (*hmtba = \width. Natural >>= \height. trans_max*)
        let trans_height = Trans.Lambda (width, Trans.Bind (t_natural, trans_max)) in 

       (*whmtba = \vn. Natural >>= \width. trans_height*)
        let trans_width = Trans.Lambda (vn, Trans.Bind (t_natural, trans_height)) in 

        let t_vnumber = T_vnumber.t_vnumber in 
        (*a primitive parser for string*)
        let t_P = T_constp.t_p
        (*ppm = P >> Theader_body*)            
        let ppm = Trans.Bind (t_P, Trans.Bind (t_vnumber, trans_width))  in 
        ppm

       
let () = 
   Morpheus.verifyCPST gamma t_hba (getType "annot")     
