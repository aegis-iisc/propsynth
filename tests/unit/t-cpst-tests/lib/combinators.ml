(*Expands a count n p to fold*)
module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
module F = T_iota
module S = T_lambda  
open SB  


let t_count n p specfile  =                     

        (*parse the associated spec file*)
        let ast = SB.parseLSpecFile specfile 
        let (tenv, formenv) =  SB.buildSigma ast  
        let getType s = TM.find tenv s  
        let getFormula s = FM.find formenv s 
               
        let f_typed = (folding_fun, getType "f") in 
        let g = getFormula "g" in 
        let acc_type  = (acc, getType "acc") in 
        let inv = getFormula "inv" in 
        let pre_post = getType "annotfold" in 
        Trans.Red (n, Trans.Lambda (T_var "n", getType "n", Trans.Fold (p, f_typed, g, acc_type, inv, pre_post)))


