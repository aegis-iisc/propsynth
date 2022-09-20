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
(*res transducers \x. Tx *)

let res_trans = 


  let _bound_x = Var.get_fresh_var "x" in 
  let _h_ident = Var.fromString "h" in  
  let _v_ident = Var.fromString "v" in 
  let _h'_ident = Var.fromString "h'" in 
  let _inp_ident = Var.fromString "inp" in
  let _i_ident = Var.fromString "i" in 
  
  (*Create $init and its types *)
  (*$init = skip *) 
   let _init_term =  T_unit in 
   let _init_ty_pre =   P.Forall ( [(_h_ident, TyD.Ty_heap)],
                                         P.True)

   in 
 
  let _init_ty_post =   Predicate.heap_inv_predicate (_v_ident, Ty_unit) in  
 

    (*init : ST {\h. True} unit {\h x h'. sel h' res = 0}*)         
   let _init_ty = RefTy.MArrow (Effect.State,_init_ty_pre, Ty_unit, _init_ty_post ) in 
 

  (*creating finalizer*)
  let _qf_finalizer_pre = P.Forall ([(_h_ident, Ty_heap)], P.True) in
    
   let v_eq_x_pred = P.Base (BP.varEq(_v_ident ,_bound_x)) in 
   let _qf_finalizer_post =  P.Forall ([(_h_ident, Ty_heap);(_v_ident, Ty_int); (_h'_ident, Ty_heap)],
                                  v_eq_x_pred) in 

   let _qf_finalizer_type = RefTy.MArrow (Effect.State, _qf_finalizer_pre, Ty_int, _qf_finalizer_post) in 


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
                           "qf" -> ((T_var _bound_x), _qf_finalizer_type(*M {\h. true} int {\h v h'. v = sel h res}*))  
                           | _ -> (T_unit,_other_finalizer_type))}
                                        
   in  
 

 
                                        
  
   let annotated_pre = P.Forall ([(_h_ident, Ty_heap)], P.True) in
   let annotated_post = P.Forall ( [(_h_ident, TyD.Ty_heap); (_v_ident, TyD.Ty_int) ;(_h'_ident, TyD.Ty_heap)],
                                               P.Base((BP.varEq (_v_ident, _bound_x )))
                                        )
                                      
        in 
        (*x:\tau -> M {true} v : int {\forall h v h'. invariant h h' /\ v = x}*)      
  let annotated_type = (RefTy.MArrow (Effect.State, annotated_pre, Ty_int, annotated_post )) in
      
   let states_st = ["qf"] in 
  
   let regs = [] in 
   let body=  Trans { regs = regs;
                            states=states_st;
                            start = "qf";
                            final = ["qf"];
                            finalizer = _final;
                            (*A term for let cnt = ref 0 , and a type M {true} unit {update h' cnt 0}*)
                            init =  ( _init_term ,_init_ty);
                            deltas = [];
                            annot = annotated_type}
  
    in Lambda (T_var _bound_x, 
                RefTy.fromTyD(Ty_int), 
                 ST body)   


let () = 
        let _trans = Red (T_var "varg", res_trans) in   
        (***************** make a call to type_synthesis_for_bind*******************)
        let _initial_env = VC.empty_gamma in  
        let (env, refty, vcs) = PTC.type_synthesize_program _initial_env _trans in 
        let () = Printf.printf "%s" ("Synthesized Type for Red "^(RefTy.toString refty)) in
        let standard_vcs = List.map (fun vc -> VC.standardize vc) vcs in 
        let () = printf "%s" "\n Final VCs" in 
        let () = List.iter (fun vc -> printf "%s" ("\n"^(VC.string_for_vc_stt vc))) standard_vcs in      
 
        discharge_VCS standard_vcs 

