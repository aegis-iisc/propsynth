module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB 
open SpecLang    
open Trans

let populateEnv () = 
        let specfile = "tests/unit/t_content.spec" in  

        (*parse the associated spec file*)

        let ast = SB.parseLSpecFile specfile in 
        let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) in 
        let (tenv, formenv) =  SB.buildSigma ast in 
        (tenv, formenv)    
let getType tenv s = TM.find tenv s  
let getFormula formenv s = FM.find formenv s 

let getTrans () =
 let (tenv, formenv) = populateEnv() in 
 let getType = getType tenv in 
 let getFormula = getFormula formenv in 

(*place holder functions in L term*)
let init = 
  (*Create $init and its types *)
   (*$init = 
    * out = ref [] *)
   let _init_term_0 =  T_assign( (T_var "cnt"), (T_cref (T_const (ILit 0)))) in 
   let _init_term_1 =  T_assign( (T_var "out"), (T_cref (T_const (Nil)))) in 
   T_seq (_init_term_0, _init_term_1) 
in      
let step1 =  T_lam ("x", (T_var "x"), getType ("step1")) in 
let step2 = T_lam ("x", (T_var "x"), getType ("step2")) in 
let finalqf = Trans.T_dref (T_var  "content") in 
let finalother = Trans.trivial_unit in 

let t_content = 
        let states_st = ["q0";"qf";"qe"] in 
        let regs = [(T_var "cnt",getType "cnt"); 
                                (T_var "content", getType "content")] in 
         
        let _d1 = Trans.Del {name = "_d1";src = "q0"; tgt = "q0"; guard=getFormula "guard1"; step=(step1); inv = getFormula ("inv1")} in 

        let _d2 = Del {name = "_d2";src = "q0"; tgt = "qf"; guard=getFormula "guard2"; step=(step2); inv = True} in 
        let final = Trans.Final {fin = fun (st:Trans.state) -> 
                                        match st with 
                                           | "qf" -> (finalqf, getType ("finalqf"))
                                           | _ -> (finalother, getType ("finalother"))} in  
            
        let pst = 
           Trans { regs = regs;
            states=states_st;
            start = "q0";
            final = ["qf"];
            finalizer = final;
            init =  (init ,getType "init");
            deltas = [(_d1, getType ("step1"));(_d2, getType "step2")];
            annot = getType "annot"}

          
        in 
        Trans.Lambda (T_var "boundx", getType "boundx", ST pst)
in 
t_content
(*
let () = 
   let (tenv, _) = populateEnv() in 
   Morpheus.verifyCPST (getTrans()) (getType tenv "annot")     
*)         


