open SpecLang 
open TransTypeChecker    
open Printf
open TypedTransLang


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




(************************Tests Cases***************************************)
(*define a transducers *)

let defs = 

(*test 1*)

      
  (*@@ guard_st1 = \Exists cnt. \Forall h (sel h cnt) > 0 ~ Grt   @@*)
  let _h_ident = Var.fromString "h" in 
  let _cnt_ident = Var.fromString "cnt" in
  let pred_guard_1 =     P.Rel(RP.Grt ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h_ident); (_cnt_ident) ]),
                           RelLang.T ([RelLang.Int (0)])))in 

  (*\exists. i : Ty_int. inp : Ty_inp list. \Forall h. i = hd_sel h inp*)
  let _inp_ident = Var.fromString "inp" in
  let _i_ident = Var.fromString "i" in 
  let _h_ident = Var.fromString "h" in 
  let pred_guard_2 = P.Rel(RP.Eq ( MultiR ( (RelLang.instOfRel (RelId.fromString "hd_sel")), [ (_h_ident); (_inp_ident) ]),
                           RelLang.T ([RelLang.Var ("i")]))) in 

(*for now assume that char bot is a an int 1000*)
(*not (i = 1000*)

  let pred_guard_3 = P.Not (P.Base (BP.varIntEq (Var.fromString "i", 1000 ))) in        

  let conj_pred_guard = P.Conj (  (P.Conj (pred_guard_1, pred_guard_2 )), pred_guard_3) in 
 

  (*\Exists cnt, inp, i. \Forall h. i = sel h inp /\ i != 1000 /\ sel h cnt > 0*)
 (* let _d1_guard_body =  P.Exists( [(_cnt_ident, Ty_int);(_inp_ident, (Ty_list (Ty_int)) )],
                                  P.Forall ( [(_h_ident, Ty_heap);(_i_ident, Ty_int)], 
                                   conj_pred_guard)) in  
   *)                    
let _d1_guard_body =     P.Forall ( [(_h_ident, Ty_heap)], 
                                   conj_pred_guard) in  
                       


  
  
   let _d1_guard = _d1_guard_body in 
 
  (* Creating step body
   * \x. decr x()*)
  let decr_pre = (*sel h cnt > 0*)  P.Rel(RP.Grt ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h_ident);(_cnt_ident) ]),
                           RelLang.T ([RelLang.Int (0)]))) in 

  let _h'_ident = Var.fromString "h'" in 
  let _x_ident = Var.fromString "x" in 
  let decr_post = (*\forall h h'. sel h' cnt = sel h cnt - 1 *)
(* rhs ~
    SUBS (sel h cnt : expr , 1 : expr ) : RelLang.expr 
    SUBS ( _ , RelLang.T [(RelLang.Int (1))] : expr)
    SUBS (  MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [RelLang.Var (_h_ident); RelLang.Var (_cnt_ident) ]) : expr, _)
lhs 
         MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [RelLang.Var (_h'_ident); RelLang.Var (_cnt_ident) ]) : expr


  final 
        RP.Eq (lhs, rhs) 
    
*)
   let rhs_fst = 
        (  RelLang.MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h_ident);  (_cnt_ident) ])) in 

   let rhs_snd = RelLang.T [(RelLang.Int (1))] in 
   let rhs = RelLang.SUBS (rhs_fst, rhs_snd) in 
   let lhs = 
        RelLang.MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident);(_cnt_ident) ]) in 
   P.Forall ([(_h_ident, TyD.Ty_heap); (_x_ident, TyD.Ty_int) ;(_h'_ident, TyD.Ty_heap)],
            Rel (RP.NEq (lhs, rhs))) in 

  let _d1_decr_ty = RefTy.MArrow (decr_pre,  Ty_int, decr_post) in 
  let _d1_step_decr = T_lam ( "x", (T_app ((T_var "decr"), (T_var "x"))), _d1_decr_ty )   in 
  let _d1_step_update_inp = T_assign (T_var "inp" ,  (T_app ((T_var "tail"), (T_var "inp")))) in 
  (*step body*)
  let _d1_step_body = T_seq (_d1_step_decr, _d1_step_update_inp) in 

 (*Creating step ty*)
  (*pre and post from seq composition of the step*)
  let _d1_step_pre = decr_pre in  
  let _d1_step_post = decr_post in 

  let _d1_step_ty = RefTy.MArrow (_d1_step_pre, Ty_unit,  _d1_step_post) in 
 

  let _d1_step = T_lam ("x", _d1_step_body, _d1_step_ty) in 
  let _d1 = Del {name = "_d1";src = "q0"; tgt = "q1"; guard=_d1_guard; step=_d1_step; inv = True} in 

  let _d1_type = _d1_step_ty in  
  
  (*Annotated Type for Transducer*)
  (*let annotated_post = P.True in*)
  let annotated_post = P.Forall ( [(_h_ident, TyD.Ty_heap); (_x_ident, TyD.Ty_int) ;(_h'_ident, TyD.Ty_heap)],
                                         P.Rel(RP.Grt ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (_cnt_ident) ]),
                                                RelLang.T ([RelLang.Int (0)]))) 

                                       )
  in
   let annotated_post = P.Forall ( [(_h_ident, TyD.Ty_heap); (_x_ident, TyD.Ty_int) ;(_h'_ident, TyD.Ty_heap)],
                                         P.Disj (P.Rel(RP.Grt ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (_cnt_ident) ]),
                                                RelLang.T ([RelLang.Int (1)]))), 
                                         P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (_cnt_ident) ]),
                                                RelLang.T ([RelLang.Int (1)]))) 

                                           )     
                                       )

                       
        in 
  let annotated_type = RefTy.MArrow (True, Ty_unit, annotated_post ) in


  let  _d2 = Del {name = "_d2";src = "q1"; tgt = "qf"; guard=_d1_guard; step=_d1_step; inv = True} in 

  let _d2_type = _d1_step_ty in  
  

 let _num_3 = Var.fromString "3" in 
 let states_st = ["q0";"q1";"qf"] in 
        
  (*Type of init M true () update h' cnt 0 *)

  let _init_ty_pre =   P.Forall ( [(_h_ident, TyD.Ty_heap)],
                                         P.True)

 in 
  let _init_ty_post =    P.Forall ( [(_h_ident, TyD.Ty_heap); (_x_ident, TyD.Ty_int) ;(_h'_ident, TyD.Ty_heap)],
                                         P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (_cnt_ident) ]),
                                                RelLang.T ([RelLang.Int (3)]))) 

 
                                      )

            in 
   let _init_term = T_seq  ( (T_cref( (T_var "cnt"), (T_const (ILit 3)))),
                       (T_cref( (T_var "inp"), (T_const (Llit []))))) in 
 (* let _init_ty_post = Op( Uupdate (Uterm (T_var "h'"), Uterm (T_var "cnt"), (Uterm (T_const (ILit 0))))) in *)
  let _init_ty = RefTy.MArrow (_init_ty_pre, Ty_unit, _init_ty_post ) in 
  let test_trans = Trans {states=states_st;
                            start = "q0";
                            final = ["qf"];
                            (*A term for let cnt = ref 0 , and a type M {true} unit {update h' cnt 0}*)
                            init =  ( _init_term ,_init_ty);
                            deltas = [(_d1, _d1_type);(_d2, _d2_type)];
                            annot = annotated_type} in 


let final = generate_vcs test_trans in

discharge_VCS final 


