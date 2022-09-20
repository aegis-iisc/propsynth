module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/ppm/t_rgb.spec"  
(*C = 8*)
(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
let n = Trans.T_var "boundn" 
(*define transducer*)     
let t_number = T_number.t_number 
let t_triple = T_triple.t_triple 
let number_n =  Trans.Red (n, t_number) 
(*tba = \g:int. number n >>= ta*)
let tba = 
    Trans.Lambda (T_var "bb" , getType "bb", Trans.Bind (number_n, t_triple)) 
       

(*tgba = \r:int . number n >>= tba*)
let tgba =  
    Trans.Lambda (T_var "bg", getType "bg", Trans.Bind (number_n, tba)) 



(*trgba = \n. number n >>= tggba*)
let trgba = 
        Trans.Lambda (T_var "br", getType "br", Trans.Bind (number_n, tgba))
let t_rgb = Trans.Lambda (T_var "boundn", getType "boundn", Trans.Bind (number_n, trgba))
      
let () =

  Morpheus.verifyCPST gamma t_rgb (getType "trgb")

