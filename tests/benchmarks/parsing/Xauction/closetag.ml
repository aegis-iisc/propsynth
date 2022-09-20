module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  


let populateEnv () = 
        let specfile = "tests/benchmarks/parsing/Xauction/opentag.spec" in  

        (*parse the associated spec file*)
        let ast = SB.parseLSpecFile specfile in 
        let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) in 
        let (tenv, formenv) =  SB.buildSigma ast in 
        (tenv, formenv)
   
  
let getType tenv s = TM.find tenv s  
let getFormula formenv s = FM.find formenv s 


let getTrans () = 
   let (tenv, formenv) =  populateEnv () in 
   let out = Trans.trivial_var "out" in 
   let init = Trans.T_assign( (T_var "res"), (T_cref (T_const (ILit 0))))  in 
   let step_d1 = Trans.T_lam ("x", (T_var "x"), getType tenv ("step_d1")) in
   let step_d2 =  Trans.T_lam ("x", (T_var "x"), getType tenv ("step_d2")) in

   let step_d3 =  Trans.T_lam ("x", (T_var "x"), getType tenv ("step_d3")) in

   let step_d4 =  Trans.T_lam ("x", (T_var "x"), getType tenv ("step_d4")) in

   let finalqf = Trans.T_dref (T_var  "out") in 
   let finalother = Trans.trivial_unit in 

   (*define transducer*)     
   let opentag =                    
     let states_st = ["q0";"q1";"qf";"qe"] in 
        let regs = [(out, getType tenv "out")] in 
        let d1 = Trans.Del {name = "d1";src = "q0"; tgt = "q1"; guard=getFormula formenv ("guard_d1"); step=step_d1; inv = SpecLang.P.True} in 

        let d2 = Trans.Del {name = "d2";src = "q1"; tgt = "q1"; guard=getFormula formenv ("guard_d2"); step=step_d2; inv = getFormula formenv ("invariant_d2")} in

        let d3 = Trans.Del {name = "d3";src = "q1"; tgt = "qe"; guard=getFormula formenv ("guard_d3"); step=step_d3; inv = SpecLang.P.True} in


        let d4 = Trans.Del {name = "d4";src = "q1"; tgt = "qf"; guard=getFormula formenv ("guard_d4"); step=step_d4; inv = SpecLang.P.True} in


        let final = Trans.Final {fin = fun (st:Trans.state) -> 
                                match st with 
                                   | "qf" -> (finalqf, getType tenv ("finalqf"))
                                   | _ -> (finalother, getType tenv ("finalother"))} in  
        Trans.Trans { regs = regs;
                            states=states_st;
                            start = "q0";
                            final = ["qf"];
                            finalizer = final;        
                            (*A term for let cnt = ref 0 , and A type M {true} unit {update h' cnt 0}*)
                            init =  (init ,getType tenv "init");
                      deltas = [(d1, getType tenv ("step_d1"));(d2, getType tenv "step_d2");(d3, getType tenv "step_d3");(d4, getType tenv "step_d4")];
                            annot = getType tenv ("annot")}
        in    

        Trans.ST opentag

  
let () = 
 let (tenv, formenv) = populateEnv () in  
  Morpheus.verifyCPST (getTrans()) (getType tenv "annot") 

