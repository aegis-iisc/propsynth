open SpecLang 
open TransTypeChecker    
open Printf
open TypedTransLang

module PTC = ProgramTypeChecker

module VCE = Vcencode 
module VC= VerificationC 

let discharge_VCS (vcs : VC.standardt list)  = 
(*discharge VCs*)
let  dischargeVC i vc = 
        match (VCE.discharge vc) with   
        VCE.Success -> 
            Printf.printf  "%s" ("VC# "^(string_of_int (i+1))^" discharged\n")
        | VCE.Undef -> (Printf.printf "%s" ("Solver timeout  while trying to \
                  \discharge VC #"^(string_of_int (i+1))); 
                   (* z3_log_close (); *)
          raise CantDischargeVC)
        |VCE.Failure -> (Printf.printf "%s" ("VC # " ^(string_of_int i)^
                                             " is invalid!"); ();
                                           raise CantDischargeVC)
in    
let unit_lists = List.mapi dischargeVC vcs in   
Printf.printf "%s" "The implementation is correct w.r.t given specification!\n"



(*commonly used predicates*)
let sel_pred heap v =  RelLang.MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(heap); (v)])
let relV var_v = RelLang.V (RelLang.Var (Var.toString var_v)) 
let numeric_eq pred1 pred2 = P.Rel(RP.NEq (pred1, pred2))
let true_pred = P.Forall ([(Var.fromString "h", Ty_heap)], P.True) 
let post_unit body = P.Forall ([(Var.fromString "h", Ty_heap);(Var.fromString "v", Ty_unit); (Var.fromString "h'", Ty_heap)],
                                  body) 


(************************Tests Cases***************************************)
(*len transducers *)
(*definition*)
(*
let Len = 
                Init [len = 0]
                q0 [digit i/ len = len + (i - 0x30) ; consume inp] q1 {return len}
*)                                

(*creating predicates and functions in L*)
(*digit pred*)  

(* 
 * i \in [0-9]
 *)

(*we do not havea setmember ship relationhip
 * we can use more high level definition : {(i)} U digit = digit
 * *)
  let phi_digit =  P.list_disjunction 
                        [
                          P.Base((BP.varIntEq (Var.fromString "i", 0  )));

                          P.Base((BP.varIntEq (Var.fromString "i", 1  )));

                          P.Base((BP.varIntEq (Var.fromString "i", 2  )));

                          P.Base((BP.varIntEq (Var.fromString "i", 3  )));
                         P.Base((BP.varIntEq (Var.fromString "i", 4  )));

                          P.Base((BP.varIntEq (Var.fromString "i", 5  )));

                          P.Base((BP.varIntEq (Var.fromString "i", 6  )));

                          P.Base((BP.varIntEq (Var.fromString "i", 7 )));
                         P.Base((BP.varIntEq (Var.fromString "i", 8  )));

                          P.Base((BP.varIntEq (Var.fromString "i", 9  )))

  
  
                       ]     
   

(*   
let phi_digit_ascii =  P.list_disjunction 
                        [
                          P.base((BP.varinteq (Var.fromString "i", '0x30'  )));

                          P.base((BP.varinteq (Var.fromString "i", '0x31'  )));

                          P.base((BP.varinteq (Var.fromString "i", '0x32'  )));

                          P.base((BP.varinteq (Var.fromString "i", '0x33'  )));

                          P.base((BP.varinteq (Var.fromString "i", '0x34'  )));

                          P.base((BP.varinteq (Var.fromString "i", '0x35'  )));

                          P.base((BP.varinteq (Var.fromString "i", '0x36'  )));

                          P.base((BP.varinteq (Var.fromString "i", '0x37'  )));

                          P.base((BP.varinteq (Var.fromString "i", '0x38'  )));

                          P.base((BP.varinteq (Var.fromString "i", '0x39'  )))

                      ]     
 let phi_digit =  P.list_disjunction 
                        [
                          P.base((BP.varinteq (Var.fromString "i", '0'  )));

                          P.base((BP.varinteq (Var.fromString "i", '1'  )));

                          P.base((BP.varinteq (Var.fromString "i", '2'  )));

                          P.base((BP.varinteq (Var.fromString "i", '3'  )));

                          P.base((BP.varinteq (Var.fromString "i", '4'  )));

                          P.base((BP.varinteq (Var.fromString "i", '5'  )));

                          P.base((BP.varinteq (Var.fromString "i", '6'  )));

                          P.base((BP.varinteq (Var.fromString "i", '7'  )));

                          P.base((BP.varinteq (Var.fromString "i", '8'  )));

                          P.base((BP.varinteq (Var.fromString "i", '9'  )))

                      ]     
*)   
(*type for step1 len := !len + (i) 
 *state {true} unit {sel h' len = sel h len + (i - 0x30)}
 *  
 * 
let type_step1 = let lhs_sel = sel_pred (Var.fromString "h'") (Var.fromString "len") in 
        let rhs_sel = sel_pred (Var.fromString "h") (Var.fromString "len") in
        let rhs = RelLang.ADD (rhs_sel, RelLang.relexpr_for_var (Var.fromString "i") in 
        let post_pred = post_unit_body (numeric_eq lhs_sel, rhs) in 
        let pre_pred = true_pred in 
        RefTy.MArrow (Effect.State, pre_pred, Ty_unit, post_pred)    
in 


(*placeholder body for step1 *)   
let step1 = T_lam ("x",  (T_var "x")(*place holder*), type_step1) in  

(*initializer len := ref 0*)
let _init_term =  T_assign( (T_var "len"), (T_cref (T_const (ILit 0)))) in 
let _init_ty_pre =  true_pred in 

 
(*\forall (h, v, h'. sel h' lhs = const (rhs)*)
   
let _init_ty_post =    P.Forall ( [(_h_ident, TyD.Ty_heap); (_v_ident, TyD.Ty_unit ) ;(_h'_ident, TyD.Ty_heap)],
                                         P.Conj (P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (Var.fromString "res")]),
                                                RelLang.T ([RelLang.Int (0)]))),

 
                                      ))
in 
 

*)


let len_trans = 
  
  let _h_ident = Var.get_fresh_var "h" in  
  let _v_ident = Var.get_fresh_var "v" in 
  let _h'_ident = Var.get_fresh_var "h'" in 
  let _inp_ident = Var.fromString "inp" in
  let _i_ident = Var.fromString "i" in 
  
  let _h'_ident = Var.get_fresh_var "h'" in
  (*Create $init and its types *)
  (*$init = 
    * res = ref 0 *)         
   let _init_term =  T_assign( (T_var "res"), (T_cref (T_const (ILit 0)))) in 
   let _init_ty_pre =   P.Forall ( [(_h_ident, TyD.Ty_heap)],
                                         P.True)

   in 
 
  (*\forall (h, v, h'. sel h' lhs = const (rhs)
   *
   * TODO :: Create a general function which takes the init_term and creates this type*)
   let preserve_h_inp = P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "hd_sel")), [(_h'_ident); (Var.fromString "inp")]),
                                                MultiR (RelLang.instOfRel (RelId.fromString "hd_sel"), [(_h_ident); (Var.fromString "inp")]))) in 

  let _init_ty_post =    P.Forall ( [(_h_ident, TyD.Ty_heap); (_v_ident, TyD.Ty_unit ) ;(_h'_ident, TyD.Ty_heap)],
                                         P.Conj (P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (Var.fromString "res")]),
                                                RelLang.T ([RelLang.Int (0)]))),
                                                preserve_h_inp


 
                                      ))

            in 
 

    (*init : ST {\h. True} unit {\h x h'. sel h' res = 0}*)         
   let _init_ty = RefTy.MArrow (Effect.State,_init_ty_pre, Ty_unit, _init_ty_post ) in 
 


  (*create transition q0 ---> qf*)          
 
  let _h_ident = Var.get_fresh_var "h" in  
  let _v_ident = Var.get_fresh_var "v" in 
  let _h'_ident = Var.get_fresh_var "h'" in 
  let _inp_ident = Var.fromString "inp" in
  
  let _h'_ident = Var.get_fresh_var "h'" in

  (*\exists. :  \Forall h. i = hd_sel h inp*)
 
  let pred_guard_0 = P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "hd_sel")), [ (_h_ident); (_inp_ident) ]),
                           (RelLang.V (RelLang.Var ("i"))))) in 

 (*i \in [0-9]*)
  let pred_guard_1 =  phi_digit   in 

  let pred_guard = P.Conj ( pred_guard_0, pred_guard_1) in 
 
                   
  let _d1_guard_body =     P.Forall ( [(_h_ident, Ty_heap)], 
                                   pred_guard) in  
  let _d1_guard = _d1_guard_body in 
 
  (* Creating step body
   * \x. 
   * res := x
   * *)
  

 (*Creating step ty :: TODO ::we need a type_synthesis system for each step*)
   (*type for step : (\i res := x)  : i : \tau -> M {True) 
    *                                                   unit 
    *                                                 {\h v h' . sel h' res = x}}*)
   (*pre and post from seq composition of the step*)
   
    
   let _d1_step_pre = P.Forall ([(_h_ident, Ty_heap)], P.True) in
   let sel_pred =  P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (Var.fromString "res")]),
                                                RelLang.V (RelLang.Var (Var.toString _i_ident)))) in 

   
   let _d1_step_post =  P.Forall ([(_h_ident, Ty_heap);(_v_ident, Ty_unit); (_h'_ident, Ty_heap)],
                                  sel_pred) in 


  (* let _d1_step_ty = RefTy.Arrow( (_bound_x, RefTy.fromTyD (Ty_int)),
                                        ( RefTy.MArrow (Effect.State,_d1_step_pre, Ty_unit, _d1_step_post))) in *)
   let _d1_step_ty =  RefTy.MArrow (Effect.State,_d1_step_pre, Ty_unit, _d1_step_post) in 
   (*step body*)
   let _d1_step = T_lam ("x",  (T_var "x")(*place holder*), _d1_step_ty) in  


  (*transition d1*)
  let _d1 = Del {name = "_d1";src = "q0"; tgt = "qf"; guard=_d1_guard; step=_d1_step; inv = True} in 

  let _d1_type = _d1_step_ty in  
 

  (*creating finalizer*)
 
  let _h_ident = Var.get_fresh_var "h" in  
  let _v_ident = Var.get_fresh_var "v" in 
  let _h'_ident = Var.get_fresh_var "h'" in 
  let _inp_ident = Var.fromString "inp" in
  
  let _h'_ident = Var.get_fresh_var "h'" in

  let _qf_finalizer_pre = P.Forall ([(_h_ident, Ty_heap)], P.True) in
   let sel_pred =  P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h_ident); (Var.fromString "res")]),
                                                RelLang.V (RelLang.Var (Var.toString _v_ident)))) in 

   
   let _qf_finalizer_post =  P.Forall ([(_h_ident, Ty_heap);(_v_ident, Ty_int); (_h'_ident, Ty_heap)],
                                  sel_pred) in 

   let _qf_finalizer_type = RefTy.MArrow (Effect.State, _qf_finalizer_pre, Ty_int, _qf_finalizer_post) in 

   
   (*creating other finalizer*)
 
  let _h_ident = Var.get_fresh_var "h" in  
  let _v_ident = Var.get_fresh_var "v" in 
  let _h'_ident = Var.get_fresh_var "h'" in 
  let _inp_ident = Var.fromString "inp" in
  
  let _h'_ident = Var.get_fresh_var "h'" in

   let _other_finalizer_pre = P.Forall ([(_h_ident, Ty_heap)], P.True) in
   let _other_finalizer_post = P.Forall ( [(_h_ident, TyD.Ty_heap); (_v_ident, TyD.Ty_unit) ;(_h'_ident, TyD.Ty_heap)],
                                         Rel (RP.Eq (
                                                                        (RelLang.V (RelLang.Var ("h"))),
                                                                        (RelLang.V (RelLang.Var ("h'")))
                                                                        ))  
                                        
                                        ) in 
   
   let _other_finalizer_type = RefTy.MArrow (Effect.State, _other_finalizer_pre, Ty_unit, _other_finalizer_post) in 

   let _final = Final {fin = fun (st:state) -> 
                        (match st with 
                           "qf" -> (T_dref (T_var (Var.fromString "res")), _qf_finalizer_type(*M {\h. true} int {\h v h'. v = sel h res}*))  
                           | _ -> (T_unit,_other_finalizer_type))}
                                        
   in 

   (*creating annotation*)

 
  let _h_ident = Var.get_fresh_var "h" in  
  let _v_ident = Var.get_fresh_var "v" in 
  let _h'_ident = Var.get_fresh_var "h'" in 
  let _inp_ident = Var.fromString "inp" in
  let _i_ident = Var.get_fresh_var "i" in 
  
  let _h'_ident = Var.get_fresh_var "h'" in

   let annotated_pre = P.Forall ([(_h_ident, Ty_heap)], True) in
   let annotated_post = P.Forall ( [(_h_ident, TyD.Ty_heap); (_v_ident, TyD.Ty_int) ;(_h'_ident, TyD.Ty_heap)],
                                         P.Conj (
                                                (P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "hd_sel")), [(_h_ident); (_inp_ident)]),
                                                  RelLang.V (RelLang.Var(Var.toString _v_ident))))),
                                                 (P.list_disjunction[P.Base((BP.varIntEq (_v_ident, 0 )));
                                                                     P.Base((BP.varIntEq (_v_ident, 1)));
                                                                     P.Base((BP.varIntEq (_v_ident, 2)));
                                                                     P.Base((BP.varIntEq (_v_ident, 3)));
                                                                     P.Base((BP.varIntEq (_v_ident, 4 )));
                                                                     P.Base((BP.varIntEq (_v_ident, 5)));
                                                                     P.Base((BP.varIntEq (_v_ident, 6)));
                                                                     P.Base((BP.varIntEq (_v_ident, 7)));
                                                                     P.Base((BP.varIntEq (_v_ident, 8 )));
                                                                     P.Base((BP.varIntEq (_v_ident, 9)))]
                                                )
                                              )
                                      )
        in 
  let annotated_type = RefTy.MArrow (Effect.State, annotated_pre, Ty_int, annotated_post ) in
      
   let states_st = ["q0";"qf"] in 
  
   let regs = [(T_var "res",RefTy.fromTyD (TyD.Ty_int))] in 
   let transition_system =  Trans { regs = regs;
                            states=states_st;
                            start = "q0";
                            final = ["qf"];
                            finalizer = _final;        
                            (*A term for let cnt = ref 0 , and A type M {true} unit {update h' cnt 0}*)
                            init =  ( _init_term ,_init_ty);
                            deltas = [(_d1, _d1_type)];
                            annot = annotated_type}
   in    
  
 ST transition_system


let () = 
        let _trans = len_trans in   
        (***************** make a call to type_synthesis_for_bind*******************)
        let _initial_env = VC.empty_gamma in  
        let (env, refty, vcs) = PTC.type_synthesize_program _initial_env _trans in 
       (*Check against spec*)

        (*let  _vcs_full = PTC.verify env vcs refty annotated_type in
         *)
        let () = Printf.printf "%s" ("Number of VCS "^ (string_of_int (List.length vcs))) in 
        let standard_vcs = List.map (fun (vc) -> (VC.standardize vc)) vcs in    
        let () = printf "%s" "\n Final VCs" in 
        let () = List.iter (fun vc -> printf "%s" ("\n"^(VC.string_for_vc_stt vc))) standard_vcs in      
 

        discharge_VCS standard_vcs

