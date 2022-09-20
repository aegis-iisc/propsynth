module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/ppm/t_body.spec"

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


(*C = 2*)
let t_body = 
        
        (*   t_body = \ tr : (h, w, m) : triple -> 
         *              cols = T_cols.t_cols tr in 
         *              let rows = count h cols
         *              rows
         *              
         *      
         *
         *   t_body : tr -> 
         *              {true}
         *              [[rgb]]
         *              {\h, v, h'. len v == height tr}
         **)
        (*TODO :: Handle count*)
        let t_cols = T_cols.t_cols in 
        let cols = Trans.Red (T_var "tr", t_cols) in 
        let f_typed = (folding_fun, getType "f") in 
        
        (*every type has accessor functions with appropriate types*)
       
        let height_lam =  T_lam ("header", T_var "heignt", getType ("height")) in 
        let height = T_app height_lam (T_var "tr") in 
        
        let g_rows = getFormula "g_rows" in 
        let acc_type = (Trans.T_var "acc", getType "acc") in 
        let inv_rows = getFormula "inv_rows" in 
        let pre_psot = getType "annotfold" in 
        let rows = Trans.Fold (rgb, f_typed, g_rows, acc_type, inv_rows, pre_post)
        Trans.Lambda (T_var "tr" "tr", rows)
             
let () = 
   Morpheus.verifyCPST gamma t_body (getType "annotfold")     
