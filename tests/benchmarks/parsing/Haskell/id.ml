module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  


let populateEnv () = 
        let specfile = "tests/benchmarks/parsing/Haskell/id.spec" in  

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
   let step1 = Trans.T_lam ("x", (T_var "x"), getType tenv ("step1")) in
   let step2 = Trans.trivial_unit in    
   let finalqf = Trans.T_dref (T_var  "out") in 
   let finalother = Trans.trivial_unit in 

   (*define transducer*)     
   let t_id =                    
        let states_st = ["q0";"qf";"qe"] in 
        let regs = [(out, getType tenv "out")] in 
        let d1 = Trans.Del {name = "d1";src = "q0"; tgt = "qf"; guard=getFormula formenv ("guard1"); step=step1; inv = SpecLang.P.True} in 

        let d2 = Trans.Del {name = "d2";src = "q0"; tgt = "qe"; guard=getFormula formenv ("guard2"); step=step2; inv = SpecLang.P.True} in 

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
                            deltas = [(d1, getType tenv ("step1"));(d2, getType tenv "step2")];
                            annot = getType tenv ("annot")}
        in    

        Trans.ST t_of

  
let () = 
 let (tenv, formenv) = populateEnv () in  
  Morpheus.verifyCPST (getTrans()) (getType tenv "annot") 

