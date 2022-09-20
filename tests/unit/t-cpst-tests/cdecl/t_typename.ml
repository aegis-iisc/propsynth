module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  
open Trans
let specfile = "tests/unit/t-cpst-tests/cdecl/t_typename.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast
let gamma = SB.initializeGamma ast     
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 

(*place holder functions in L term*)
let init = 
 (*Create $init and its types *)
   (*$init = 
    * out = ref [] *)
   let _init_term_0 =  T_assign( (T_var "cnt"), (T_cref (T_const (ILit 0)))) in 
   let _init_term_1 =  T_assign( (T_var "content"), (T_cref (T_const (Nil)))) in
   
   T_seq (_init_term_0, _init_term_1)
     
let step1 =  T_lam ("x", (T_var "x"), getType "steploop") 
let step2 = T_lam ("x", (T_var "x"), getType "step2") 
let finalqf = Trans.T_dref (T_var  "content") 
let finalother = Trans.trivial_unit

let t_typename = 
        let states_st = ["q0";"qf";"qe"] in 
        let regs = [(T_var "out",getType "out")] in 
         
        let _d1 = Trans.Del {name = "_d1";src = "q0"; tgt = "q0"; guard=getFormula "guardloop"; step=(step1); inv = getFormula ("inv1")} in 

        let _d2 = Del {name = "_d2";src = "q0"; tgt = "qf"; guard=getFormula "guardexit"; step=(step2); inv = True} in 
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
            deltas = [(_d1, getType ("steploop"));(_d2, getType "step2")];
            annot = getType "annot"}

          
        in 
        ST pst

let () = 
   Morpheus.verifyCPST gamma t_typename (getType "annot") true
         


