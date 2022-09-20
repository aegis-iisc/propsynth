module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap 
open SB  

let specfile = "tests/unit/t-cpst-tests/cdecl/t_date.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)

(*define transducer*)
(*4 components*)               
let t_date =
   let t_mm= T_mm.t  in 
   let t_dd = T_dd.t in 
   let t_yy = T_yy.t in 
   let t_sep = Trans.Red (T_const (SLit "sep"), T_string.t_string)  in
   let date_constructor = T_date_action.t in 
   (*arrow = string "arrow" *)
   Trans.Bind (t_mm, 
                Trans.Lambda (T_var "m", getType "m", 
                                Trans.Bind ( (Trans.Bind ( sep, t_dd )),
                                         Trans.Lambda (T_var "d", getType "d"
                                                    Trans.Bind ( (Trans.Bind ( sep, t_yy )),
                                                         Trans.Lambda (T_var "y", getType "y", date_constructor ))))))
 

                                                                    
let () = 
   Morpheus.verifyCPST gamma t_date (getType "annot") true
