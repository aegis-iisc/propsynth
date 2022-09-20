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


(************************Tests Cases***************************************)
(*len transducers *)

let len_content =

  (
  let _h_ident = Var.get_fresh_var "h" in 
  let bind_x = Var.get_fresh_var "x" in 

  (*Create $init and its types *)
  (*$init = 
    * cnt := ref 0
    * content := ref []*)         
   let _init_term_0 =  T_assign( (T_var "cnt"), (T_cref (T_const (ILit 0)))) in 

   let _init_term_1 = T_assign ( T_var "content"), (T_ref (T_const ( Nil))) in 
   let _init_term = T_seq (_init_term_0, _init_term_1) in 
   let _init_ty_pre =   P.Forall ( [(_h_ident, TyD.Ty_heap)],
                                         P.True)

   in 
 
  (*Create $init and its types *)
   (*$init = 
    * out = ref [] *)         
   let _init_term_1 =  T_assign( (T_var "out"), (T_cref (T_const (Nil)))) in 

   let _init_ty_pre_1 =   P.Forall ( [(_h_ident, TyD.Ty_heap)],
                                         P.True)

   in 

   let _init_term = T_seq (_init_term_0, _init_term_1) in 


   let len_sel =
        let _local_ = Var.get_fresh_var "_local_" in 
              P.Conj( P.Rel(RP.Eq ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (Var.fromString "content")]),
                                                RelLang.relexpr_for_var _local_)),
              P.Rel(RP.Eq ( MultiR ( (RelLang.instOfRel (RelId.fromString "len")), [(_local_)]),
                                                RelLang.relexpr_for_int 0))
        )
  in 


        
  (*\forall (h, x, h'. sel h' lhs = const (rhs)
   * TODO :: Create a general function which takes the init_term and creates this type*)
  let _init_ty_post =    P.Forall ( [(_h_ident, TyD.Ty_heap); (_x_ident, TyD.Ty_unit ) ;(_h'_ident, TyD.Ty_heap)],
                                         P.Conj( P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (Var.fromString "cnt")]),
                                                RelLang.T ([RelLang.Int (0)]))), 
                                         (*_local_ = sel h' content /\ mem _local_ = 0*)
                                         len_sel 
                                         ))

        in 
 
   (*init : ST {\h. True} unit {\h x h'. sel h' res = 0}*)         
   let _init_ty = RefTy.MArrow (Effect.State,_init_ty_pre, Ty_unit, _init_ty_post ) in 
 


  (*create transition q0 ---> q0*)          

  (*\exists. i : Ty_int. inp : Ty_inp list. \Forall h. i = hd_sel h inp*)
  let _inp_ident = Var.fromString "inp" in
  let _i_ident = Var.fromString "i" in 
  let _h_ident = Var.fromString "h" in 
  
     
                       
     
  let pred_guard_0 = P.Rel(RP.Eq ( MultiR ( (RelLang.instOfRel (RelId.fromString "hd_sel")), [ (_h_ident); (_inp_ident) ]),
                           RelLang.T ([RelLang.Var ("i")]))) in 

 (*i \in [0-3]*)
  let pred_guard_1 =  P.list_disjuntcion 
                        [
                          (BP.varIntEq (Var.fromString "i", 0  ));

                          (BP.varIntEq (Var.fromString "i", 1  ));

                          (BP.varIntEq (Var.fromString "i", 2  ));

                         (BP.varIntEq (Var.fromString "i", 3  ))
                       ]     
   in 
 
   (* sel h cnt < bind_x*)
  let _cnt_ident = Var.fromString "cnt" in
  let pred_guard_2 =     P.Rel(RP.Grt ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h_ident); (_cnt_ident) ]),
                           RelLang.V (Var(_bind_x))))in 




  let pred_guard = P.Conj ( pred_guard_0, pred_guard_1, pred_guard_2) in 
 
                   
  let _d1_guard_body =     P.Forall ( [(_h_ident, Ty_heap)], 
                                   _pred_guard) in  
  let _d1_guard = _d1_guard_body in 
 
 (*Creating step ty :: TODO ::we need a type_synthesis system for each step*)
   (*type for step :  \x : \tau -> M {} 
    *                                                   unit 
    *                                                 {\h v h' . h' =   l0 = sel h content 
    *                                                                   l1 = sel h' content 
    *                                                                   len l1 = len l0 +  1 && 
    *                                                   sel h' cnt = sel h cnt + 1}*)
   (*pre and post from seq composition of the step*)
 
   let _d1_step_pre = (*define*) P.True in  
  
   let var_l0 = Var.get_fresh_var "local" in 
   let len_l0 =  RP.Eq( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h_ident); (Var.fromString "content")]),           
                                          RelLang.relexpr_for_var var_l0 ) in 

   let var_l1 = Var.get_fresh_var "local" in 
   let len_l1 =  RP.Eq( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (Var.fromString "content")]),           
                                          RelLang.relexpr_for_var var_l1 ) in 


   let len_l0_plus_1 = ADD (len_l0, RelLang.relexpr_for_int 1) in 
   let len_sel =  P.Rel(RP.Eq (len_l1, len_l0_plus_1)) in 

   let pred_cnt =  RP.Eq( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h'_ident); (Var.fromString "cnt")]),           
                        ADD (
                          MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h_ident); (Var.fromString "cnt")]), 
                          RelLang.relexpr_for_int 1 )) in 


        
   let _d1_step_post =    P.Forall ( [(_h_ident, TyD.Ty_heap); (_x_ident, TyD.Ty_unit ) ;(_h'_ident, TyD.Ty_heap)],
                                         P.Conj(
                                          pred_cnt,
                                         (*_local_ = sel h' content /\ mem _local_ = 0*)
                                         len_sel 
                                         ))

        in 
  
   
   

  let _d1_step_ty = RefTy.MArrow (Effect.State,_d1_step_pre, Ty_unit, _d1_step_post) in 
  (*step body*)
   let _d1_step_ = T_lam (T_var "x", (RefTy.fromTyD Ty_int), (*place holder*) (T_var "x"), _d1_step_ty) in  


   (*inv 
    *\forall h. len (sel h content) = sel h cnt*)
   let inv_pred = 
     let var_ltemp = Var.get_fresh_var "local" in 
     let sel_ltemp =  RP.Eq( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h_ident); (Var.fromString "content")]),           
                                          RelLang.relexpr_for_var var_ltemp ) in 

     let len_sel =   MultiR ( (RelLang.instOfRel (RelId.fromString "len")), [(var_ltemp)]) in 

     let sel_conut =  MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h_ident);(Var.fromString "cnt")]) in 
 
     let len_sel_content_eq_count = RP.Eq (len_sel, sel_count) in 

     P.Conj (sel_ltemp, len_sel_content_eq_count) 


  let _d1 = Del {name = "_d1";src = "q0"; tgt = "q0"; guard=_d1_guard; step=_d1_step; inv = inv_pred} in 

  let _d1_type = _d1_step_ty in  
 

  (*creating q0 ---> qf*)

  (*\exists. i : Ty_int. inp : Ty_inp list. \Forall h. i = hd_sel h inp*)
  let _inp_ident = Var.fromString "inp" in
  let _i_ident = Var.fromString "i" in 
  let _h_ident = Var.fromString "h" in 
  let pred_guard_0 = P.Rel(RP.Eq ( MultiR ( (RelLang.instOfRel (RelId.fromString "hd_sel")), [ (_h_ident); (_inp_ident) ]),
                           RelLang.T ([RelLang.Var ("i")]))) in 

(* sel h cnt = bind_x*)
  let _cnt_ident = Var.fromString "cnt" in
  let pred_guard_1 =      P.Rel(RP.NEq ( MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [(_h_ident); (_cnt_ident) ]),
                           RelLang.V (Var(_bind_x))))in 




  let pred_guard = P.Conj (  pred_guard_0, pred_guard_1) in 
 
                   
  let _d2_guard_body =     P.Forall ( [(_h_ident, Ty_heap)], 
                                   _pred_guard) in  
  let _d2_guard = _d2_guard_body in 
 
  (* Creating step body
   * skip
   * *)
  

 (*Creating step ty :: TODO ::we need a type_synthesis system for each step*)
   (*type for step :M {(cnt--> _) && (out --> _)  
    *                          unit 
    *                     {\h v h' . h' = Invarinat h h'*)
  let _d2_step_pre = decr_pre in  
  let _d2_step_post = decr_post in 

  let _d2_step_ty = RefTy.MArrow (Effect.State,_d1_step_pre, Ty_unit, _d2_step_post) in 
  (*step body*)
   let _d2_step_ = T_lam (T_var "x", (RefTy.fromTyD Ty_int), (*place holder*) (T_var "x"), _d2_step_ty) in  



  let _d2 = Del {name = "_d2";src = "q0"; tgt = "qf"; guard=_d2_guard; step=_d2_step; inv = True} in 

  let _d2_type = _d2_step_ty in  
 


   (*define finalizer*)
 (*creating finalizer
  * State {\h True}
  * v : p
  * {\h v h' .
  * fst p = x 
  * snd p = sel h content 
  * *)
 
  let _h_ident = Var.get_fresh_var "h" in  
  let _v_ident = Var.get_fresh_var "v" in 
  let _h'_ident = Var.get_fresh_var "h'" in 
  let _inp_ident = Var.fromString "inp" in
   let _bound_x = Var.get_fresh_var "x" in 
  let _h'_ident = Var.get_fresh_var "h'" in

  let _qf_finalizer_pre = P.Forall ([(_h_ident, Ty_heap)], P.True) in
   let _fst_v_pred = RP.NEq  ( MultiR (RelLang.instOfRel (RelId.fromString "fst"), [(_v_ident)]), 
                                   RelLang.V (RelLang.Var (Var.toString _x_ident))) in 
   let _sel_h_content_re =   MultiR ( (RelLang.instOfRel (RelId.fromString "sel")), [ (_h_ident); (Var.fromString "content") ]) in 
   let _snd_v_pred = RP.NEq  ( MultiR (RelLang.instOfRel (RelId.fromString "snd"), [(_v_ident)]), 
                                   _sel_h_content_re) in 
     
                          
   let _qf_finalizer_post =  P.Forall ([(_h_ident, Ty_heap);(_v_ident, Ty_int); (_h'_ident, Ty_heap)],
                                  P.Conj (_fst_v_pred, _snd_v_pred)) in 

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



  (*Annotated Type for content
   *
   *x : \tau -> M {\h (inp -> _) v : int (\h, v, h'.  
                                                {v : p | fst v = len (snd v)}
   * *)
   (*TODO let annotated_post = P.True in*)
   let annotated_post = P.Forall ( [(_h_ident, TyD.Ty_heap); (_x_ident, TyD.Ty_int) ;(_h'_ident, TyD.Ty_heap)],
                                        (*TODO : Expand *)
                                       )
  in
   let annotated_post = P.Forall ( [(_h_ident, TyD.Ty_heap); (_x_ident, TyD.Ty_int) ;(_h'_ident, TyD.Ty_heap)],
                                        (*TODO : Expand*)                                           )     
                                       
        in 
  let annotated_type = RefTy.MArrow (Effect.Pure, True, Ty_unit, annotated_post ) in
      
  let states_st = ["q0";"qf";"qe"] in 
  
  let regs = [(T_var "cnt",RefTy.fromTyD (TyD.Ty_int)); 
                        (T_var "content", RefTy.fromTyD (TyD.Ty_list (TyD.Ty_int)))] in 
                    Trans { regs = regs;
                            states=states_st;
                            start = "q0";
                            final = ["qf"];
                            finalizer = _final;
                            init =  ( _init_term ,_init_ty);
                            deltas = [(_d1, _d1_type);(_d2, _d2_type);(_d3, _d3_type)];
                            annot = annotated_type}
  )   
  


let () = 
        let bounded_trans = Bind ((ST len_trans), Lambda (T_var "x", (RefTy.fromTyD TyD.Ty_int), (ST content_trans))) in  
        (***************** make a call to type_synthesis_for_bind*******************)
        let _initial_env = VC.empty_gamma in  
        let (refty, vcs) = PTC.type_synthesize_program _initial_env bounded_trans in 
        let () = Printf.printf "%s" ("Synthesized Type "^(RefTy.toString refty)) in 
        discharge_VCS vcs 

