module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  
open Trans
let specfile = "tests/unit/t-cpst-tests/ppm/t_cols.spec"

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
let folding_fun = Trans.lambda "ac" (getType "f")    
(*define placeholder functions in L term with types*)
(*define transducer*)     
(*count n p program*)


(*C = 2 *)
let t_cols = 
        
        (*   t_cols = \ (w, h, m) : triple -> 
         *              let rgb = t_rgb m in
         *              let cols = count w rgb in 
         *              cols 
         *              
         *      
         *
         *   t_cols : (w, h, m) -> 
         *              {true}
         *              [rgb]
         *              {\h, v, h'. len v == w}
         **)
        (*TODO :: Handle count*)
        let t_rgb = T_rgb.t_rgb in  
        let f_typed = (folding_fun, getType "f") in 
        
        (*every type has accessor functions with appropriate types*)
        let max_lam = T_lam ("header", T_var "max", getType ("max")) in 
        let max = T_app (max_lam, (T_var "tr")) in 
        
        let width_lam =  T_lam ("header", T_var "width", getType ("width")) in 
        let width = T_app (width_lam, (T_var "tr")) in 
        
        let height_lam =  T_lam ("header", T_var "height", getType ("height")) in 
        let height = T_app (height_lam, (T_var "tr")) in 
        
        let rgb  = Trans.Red (T_var "max", t_rgb) in
        let g_cols = getFormula "g_cols" in 
        let acc_type = (Trans.T_var "acc", getType "acc") in 
        let inv_cols = getFormula "inv_cols" in 
        let pre_post = getType "annotfold" in 
        let cols = Trans.Fold (rgb, f_typed, g_cols, acc_type, inv_cols, pre_post) in 
        Trans.Lambda (T_var "tr", getType "tr", cols)
             
let () = 
   Morpheus.verifyCPST gamma t_cols (getType "annotfold")     
