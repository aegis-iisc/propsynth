(* definition 
 *S = out : int; cnt = int
  x: int
   I = out = 0 ; cnt = x
   
   q0; i = 0 /\ cnt > 0 / cnt = cnt -1; out = out + 1; q0
   q0 ; i != 0 \/ cnt = 0 / skip ; qf 
   A (qf) = return out
          
*)
module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  
open Trans

let specfile = "tests/unit/t-pst-tests/t_error.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 

(*define placeholder functions in L term with types*)
let init = trivial_unit

let step1 =  trivial_unit
let step2 = trivial_unit
let finalqf = T_const (ILit 0)
let finalother = trivial_unit
let gamma = SB.initializeGamma ast
(*define transducer*)     
let t_error =                    
  let states_st = ["q0";"qf";"qe"] in 

       (* let regs = [(res, SpecLang.RefTy.fromTyD (SpecLang.TyD.Ty_int))] in *)
        let regs = [] in 

        let d1 =  Trans.Del {name = "d1";src = "q0"; tgt = "qf"; guard=getFormula ("guard1"); step=step1; inv = SpecLang.Predicate.True} in 
 
        let d2 =  Trans.Del {name = "d2";src = "q0"; tgt = "qe"; guard=getFormula ("guard2"); step=step2; inv = SpecLang.Predicate.True} in 
 
        let final = Trans.Final {fin = fun (st:Trans.state) -> 
                                match st with 
                                   | "qf" -> (finalqf, getType ("finalqf"))
                                   | _ -> (finalother, getType ("finalother"))} in  
        let transition_system =  Trans.Trans { regs = regs;
                            states=states_st;
                            start = "q0";
                            final = ["qf"];
                            finalizer = final;        
                            (*A term for let cnt = ref 0 , and A type M {true} unit {update h' cnt 0}*)
                            init =  (init ,getType "init");
                            deltas = [(d1, getType ("step1"));(d2, getType ("step2"))];
                            annot = getType ("annot")}
        in    

        Trans.ST transition_system

let () = 
   Morpheus.verifyCPST gamma t_error (getType "annot") true     
