module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap 
open SB  

let specfile = "tests/unit/t-cpst-tests/icc/t_chunk.spec"  

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
let t =
   let t_gs = T_getstream.t in
   let t_take = T_take.t in 
   let t_drop = T_take.t in 
   let t_ss = T_setstream.t in 
   let t_tag = T_tag_choice1.t in 
   (*arrow = string "arrow" *)
   Trans.Lambda (T_var "sz", getType "sz",
        Trans.Bind (t_gs, 
                Trans.Lambda (T_var "s", getType "s", 
                                   Trans.Bind (Trans.Bind (Trans.Red (T_var "sz", t_take), t_ss),
                                                 Trans.Lambda (T_var "dc1", getType "dc1", 
                                                              Trans.Bind (t_tag, 
                                                                          Trans.Lambda ( T_var "dc2", getType "dc2", 
                                                                                         Trans.Bind (Trans.Red (T_var "sz", t_drop), 
                                                                                                     Trans.Lambda (T_var "dc3", getType "dc3", Trans.Red (T_var "s", t_ss)))))))))) 
                                                            
                                                                     
let () = 
   Morpheus.verifyCPST gamma t (getType "annot") true
