(* definition 
 *S = out : int; cnt = int
  x: int
   I = out = 0 ; cnt = x
   
   q0; i = 0 /\ cnt > 0 / cnt = cnt -1; out = out + 1; q0
   q0 ; i != 0 \/ cnt = 0 / skip ; qf 
   A (qf) = return out
 Failing 
   Change guard1 : ... sel (h, cnt) == 1 
*)
module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-pst-tests/t_loop.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 

(*define functions in L term with types*)
let out  = Trans.trivial_var "out"
let cnt  = Trans.trivial_var "cnt"
let boundx = Trans.trivial_var "boundx"    
let init0 = Trans.T_assign( (T_var "cnt"), (T_cref (T_const (ILit 0))))  
let init1 =  Trans.T_assign( (T_var "out"), (T_cref (T_const (ILit 0)))) 

let init = Trans.T_seq (init0, init1) 

let steploop = Trans.T_lam ("x", (T_var "x"), getType ("steploop"))  
let step1 = Trans.trivial_unit
let finalqf = Trans.T_dref (T_var  "out") 
let finalother = Trans.trivial_unit
let gamma = SB.initializeGamma ast                   
(*define transducer*)     
let t_loop =                    
        let states_st = ["q0";"qf"] in 

       (* let regs = [(res, SpecLang.RefTy.fromTyD (SpecLang.TyD.Ty_int))] in *)
        let regs = [(out, getType "out");(cnt, getType "cnt");(boundx, getType "boundx")] in 
        let d1 = Trans.Del {name = "d1";src = "q0"; tgt = "q0"; guard=getFormula ("guardloop"); step=steploop; inv = getFormula "invloop"} in 

        let d2 =  Trans.Del {name = "d2";src = "q0"; tgt = "qf"; guard=getFormula ("guard1"); step=step1; inv = SpecLang.Predicate.True} in 
 
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
                            deltas = [(d1, getType ("steploop"));(d2, getType ("step1"))];
                            annot = getType ("annot")}
        in    

        Trans.Lambda( T_var "boundx", getType "boundx", Trans.ST transition_system)

let () = 
   Morpheus.verifyCPST gamma t_loop (getType "annot") true
