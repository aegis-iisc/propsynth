module Trans = TypedTransLang
module SB = SigmaBuilder
module TM = TypesMap
module FM = FormMap
open SB  

let specfile = "tests/unit/t-cpst-tests/t_rgb.spec"  

(*parse the associated spec file*)
let ast = SB.parseLSpecFile specfile 
let () = Printf.printf "%s" ("\n ########SPECS######### \n "^(SpecLang.RelSpec.toString ast)) 
let (tenv, formenv) =  SB.buildSigma ast  
let getType s = TM.find tenv s  
let getFormula s = FM.find formenv s 
let gamma = SB.initializeGamma ast 
(*define placeholder functions in L term with types*)
let n = Trans.T_var "bn" in 
(*define transducer*)     
let t_rgba = 
        
        (*\bn : int.
         *  do {
         *   r <- t_number n ;
         *   g <- t_number n;
         *   b <- t_number n;
         *   return Triple (r, g, b)
         *
         * }
         *  ===
         *  t_number n >>= 
         *  (\r. t_number n >>= 
         *      \g. t_number n >>= 
         *          \b. triple b g r  :             
         *              n ->  
         *               {\h. true}
         *                      triple 
         *                {\h v h'. pr1 (v) <= n /\ pr2 (v) <= n /\ pr3(v) <= n} 
         *

         *
         * (\r. t_number n >>= 
         *      \g. t_number n >>= 
         *          \b. triple b g r) :  
         *              r ->  
         *               {\h. r <= n}
         *                      triple 
         *                 {\h v h'. pr1 (v) <= n /\ pr2 (v) <= n /\ pr3(v) <= n} 
         *
         *
         * \g. t_number n >>= 
         *          \b. triple b g r  : g r ->  
         *               {\h. g <= n /\ r <= n}
         *                      triple 
         *                 {\h v h'. pr1 (v) <= n /\ pr2 (v) <= n /\ pr3(v) <= n} 

         *

         *
         * triple : b g r ->  {\h. b <= n /\ g <= n /\ r <= n}
         *                      triple 
         *                      {\h v h'. pr1 (v) <= n /\ pr2 (v) <= n /\ pr3(v) <= n} 
         *
         * *)

        let t_number = T_number.t_number in 

        (*ta = \ b g r. t_triple*)
        let trans_action = T_triple.t_triple in 
        
        (*tba = \g r. number n >>= ta*)
        let blue = Trans.Red (n, t_number) in 
        let trans_blue = Trans.Lambda (T_var "boundy" , getType "boundy", Trans.Bind (blue, ta)) in
        
        (*tgba = \r . number n >>= tba*)
        let green = Trans.Red (n, t_number) in 
        let trans_green = Trans.Lambda (T_var "boundx", getType "boundx", Trans.Bind (green, trans_blue)) in 

        (*trgba = \n. number n >>= tggba*)
         let red = Trans.Red (n, t_number) in 
        let trans_red = Trans.Lambda (T_var "bn", getType "boundn", Trans.Bind (red, trans_green)) in 
        trans_red
 
let () = 
   Morpheus.verifyCPST gamma t_rgba (getType "annot")     
