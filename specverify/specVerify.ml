
open SpecLang
open Typedtree

module TyD = TyD
module PTS = ProjTypeScheme
module RefTy = RefinementType
module PRf = ParamRefType
module RefSS = RefinementSortScheme
module RefTyS = RefinementTypeScheme
module P = Predicate
module BP = Predicate.BasePredicate
module RP = Predicate.RelPredicate
module L = Layout
module VE = VarEnv
module VC = VerificationCondition
module PRE = ParamRelEnv 


(*comment this out to print  Printf messages*)
module Printf = struct
  (* let printf f s = () *)
  let printf = Printf.printf
  let originalPrint = Printf.printf 


end 



module Tyvar =
struct
  open Tyvar
  let equal= fun (t,t') -> toString t = toString t'
  let eq = equal
end

type lambda = {var: pattern; body : expression}

type subst = Var.t*Var.t
type substs = subst list

let ($) (f,arg) = f arg
exception Destructpair of string
exception ANormalError
let fst = fun x ->
  match x with 
  | (a,b) -> a
  | _ -> raise (Destructpair " Trying to destruct a non-pair" )

let snd = fun x ->
  match x with 
  | (a,b) -> b
  | _ -> raise (Destructpair " Trying to destruct a non-pair" )

let empty = fun _ -> Vector.new0 ()

let unifiable = TyD.unifiable

let toRefTyS refTy = RefTyS.generalize (Vector.new0(), 
                                        RefSS.fromRefTy refTy)
let count = ref 4096

let getUniqueId symbase =
  let id = symbase ^ (string_of_int (!count)) in 
  let _ = count := !count + 1
  in
  Var.fromString id 

let genVar () =  getUniqueId "sv_" 
let getUniqueMarker () = getUniqueId "_mark_"

let dummyRefTyS () = RefTyS.generalize (Vector.new0(),
                                        RefSS.fromRefTy (RefTy.fromTyD (TyD.makeTunknown())))

let  newLongVar = fun (var,fld) -> Var.fromString ((Var.toString var)^"."^(Var.toString fld))

let  varEq (v1,v2) = ((Var.toString v1) = (Var.toString v2))

(*What is tyvec , what is the purpose of this *)
(* let varToExpVal = fun (var,tyvec) -> 
   Exp.Val.Atom (Exp.Val.Var (var,tyvec))
*)
let markVE ve = 
  let
    marker = getUniqueMarker ()
  in
  (marker,VE.add ve (marker,dummyRefTyS()))

exception PatternNotId of string 
let get_var_from_pattern vbpat = 
  let pat_desc = vbpat.pat_desc in 
  let patternVar = match pat_desc with
    | Tpat_var (id, loc) -> id 
    | _ -> raise (PatternNotId "Pattern not an Id") in 
  patternVar 

let is_function_Exp exp = 
  let expdesc = exp.exp_desc in 
  match expdesc with 
  | Texp_function (_,_,_) -> true
  | _ -> false


exception SpecVerifyExc of string


let print s  = () (* = Printf.printf "%s" s in () 
                  *)
(*
   * Decomposes single tuple bind of form v ↦ {x0:T0,x1:T1} to
   * multiple binds : [v.x0 ↦ T0, v.x1 ↦ T1]
   *)
let decomposeTupleBind = RefTy.decomposeTupleBind



(*
   * For functions with dependent types, bound variables within argument
   * types are refered from refinements of result types. At application
   * sites, actual program vars are substituted for formal boundvars.
   * unifyArgs returns such substitutions.
   * unifyArgs also returns new type bindings for actual vars. This is for
   * the sake of constructor pattern matches, where the returned type binds
   * contain type bindings for matched pattern vars.

   *)
let rec unifyArgs ((argv ,argTy) as argBind,
                   (arg:Ident.t) ) =
  let open Typedtree in  

  match (argTy, arg) with
  | (RefTy.Base (argName,_,_),_) -> 
       let () = Printf.printf "%s" "\n UnifyArgs Base RefinementType" in 
     (Vector.new1 (arg,argTy), Vector.new1 (arg,argName))
  |(RefTy.Tuple argBinds', _) -> 
       (*The constructor argument refinement occurs here*) 
      (* Unifying v0:{x0:T0,x1:T1} with v1 would return
       * v1 ↦ {x0:T0,x1:T1} as the only new bind. However,
       * all references v0 elements should now refer to v1
       * elements. Therefore, substs = [v1.x0/v0.x0, v1.x1/v0.x1]
      *)
      let binds = Vector.new1 (arg,argTy) in 
      let substs = List.concat  
          (Vector.map (argBinds', 
                       fun (argBind') ->
                         let (argv',_) = argBind' in 
                         let newVar = newLongVar (arg,argv') in 
                         let (_,substs') = unifyArgs (argBind', newVar ) in 
                         let  substs = Vector.map (substs', 
                                                   fun (n,o') -> (n, newLongVar (argv,o')))
                         in
                         substs
                      )
          ) 
      in
      (binds,substs)
  | (RefTy.Arrow _, _) -> 
    
      (Vector.new1 (arg,argTy), 
       Vector.new1 (arg,argv))
  | _ -> raise (SpecVerifyExc "Invalid argTy-argExpVal pair encountered")




(*Takes two refinement types and returns a unified type*)
let  rec unifyWithDisj refTy1  refTy2  =
   let () = Printf.originalPrint "%s" "\n*******Performing Unification with Disjunction *********\n" in 
   let () = Printf.printf "%s" ("\n \n ty of fst  "^RefTy.toString refTy1) in      
   let () = Printf.printf "%s" ("\n \n ty of snd "^RefTy.toString refTy2) in      
           
  let open RefTy in 
  match (refTy1, refTy2) with
    (Base (_, TyD.Tunknown, _),_) -> refTy2
  | (_,Base (_, TyD.Tunknown, _)) -> refTy1
  (*Disjunction of Predicates*)
  |(Base (bv1,td1,pred1),Base (bv2,td2,pred2)) ->

      let () = Printf.printf "%s" "\n*******unifyWithDisj Base , Base *********\n" in 

       let () = Printf.printf "%s" ("\n \n ty of fst  "^RefTy.toString refTy1) in      
       let () = Printf.printf "%s" ("\n \n ty of snd "^RefTy.toString refTy2) in      
      
      let _ = assert (TyD.sametype td1 td2) in 
      let unified_type = 
        match (td1, td2) with
        (Ttop, _) -> let () = Printf.printf "%s" ("\n \n case 1 ") in      
           refTy2 
        | (_, Ttop) ->    
            let () = Printf.printf "%s" ("\n \n csae 2 ") in      
      
          refTy1
        | (_,_)->
           (*let pred2 = Predicate.Conj (pred2, pred_unify_result_vars) in 
        *)  let pred1' = Predicate.applySubst (bv2,bv1) pred1 in
            (* let pred_unify_result_vars = Predicate.Base (BP.varEq (bv1, bv2)) in 
            let pred1' = Predicate.Conj (pred1', pred_unify_result_vars) in 
           *)
         
          Base (bv2,td2,Predicate.dot (pred1',pred2))
       in 
       unified_type   
  | (Tuple t1,Tuple t2) -> 

      let () = Printf.printf "%s" "\n*******Performing Tuple  : Tuple with Disjunction *********\n" in 
     let tuFun = fun l -> Tuple l 
      in 
      (tuFun
         (List.map2  
            (fun (v1,r1) (v2,r2) -> 
               let _ = assert (varEq (v1,v2)) 
               in
               (v2,unifyWithDisj (r1) (r2))) t1 t2))

  | (Arrow _,Arrow _) -> raise (SpecVerifyExc "Unimpl : Case returning arrow")
  | _ -> raise (SpecVerifyExc "Case rules types not unifiable")       



 (*
   * Invariant : bv and td of ty is unchanged.
   *)
let  wellFormedType (marker, markedVE , ty) =
   let () = Printf.printf "%s" "\n*******Checking WFT |Gamma |- tau *********\n" in 
   let () = Printf.printf "%s" ((RefTy.toString ty)^"\n") in 

   let var_for_ty =    
      match ty with 
          RefTy.Base (v,extd,pred) -> v
        | _ -> raise (SpecVerifyExc "WellFormedness check is not implemented only for Base RefinementType \n")
     
    in     
  let velist = VE.toVector markedVE in 
  let indx = Vector.index velist (fun (v,_) -> varEq (v,marker)) in 
  let i = match indx with 
    | Some i -> i 
    |_ -> raise (SpecVerifyExc "Marker absent")
  in 
  let prefix = Vector.prefix velist i in 

  let  _ = Printf.printf "\nPrefix Var environment :\n" in 
  let  _ = Printf.printf "---------\n" in 
  let  _ = Printf.printf "%s" ((VE.layout prefix)) in 

  (*In certain cases the bound variable of the ty and the prefix have a conflict, we remove such suoerfluos vars from the prefix 
    A better approach could be renaming the captured variable*)

  let sanitizedPrefix= List.filter (fun (visited_var, rtys) -> if (Var.equal visited_var var_for_ty) then false else true) prefix in      


  let  _ = Printf.printf "\nSanitized Prefix Var environment :\n" in 
  let  _ = Printf.printf "---------\n" in 
  let  _ = Printf.printf "%s" ((VE.layout sanitizedPrefix)) in 


  let exttylist = List.map 
      (fun (v,rtys) -> (v,
                        RefSS.toRefTy (RefTyS.specialize rtys))
      ) sanitizedPrefix in 



  let  flattened = List.concat 
      (List.map (fun (v,ty)-> 
           match ty with
             RefTy.Tuple _ -> decomposeTupleBind (v,ty)
           | _ -> Vector.new1 (v,ty)) exttylist) in 
  
  let (tyDB,pred1 ) = List.fold_left (
      fun (clos,pred') (exvar,exty) ->
        let () = Printf.printf "%s" ("Var : Ty "^Ident.name exvar^" :: "^RefTy.toString exty) in 
        match exty with 
          RefTy.Base (bv,extd,pred) -> (TyDBinds.add clos exvar extd,
                                        (*Look at this change , commented it to handle let t0 = [] in ... with this it resulted in t0= t0*)
                                        Predicate.conj (pred',(* Predicate.applySubst (exvar,bv) *) pred))
        | RefTy.Tuple _ -> raise (SpecVerifyExc "Tuple flattening incorrect\n")
        | _ -> (clos,pred')

    ) (TyDBinds.empty, Predicate.truee())  flattened  in 
  RefTy.mapBaseTy ty (fun (v,td,pred) -> (v,td,
                                          Predicate.exists (tyDB,Predicate.conj(pred1,pred))))



let normalized_function {var; body} =

  let fun_name = get_var_from_pattern var in 
  let rec get_params tfun_body params  = 
    match tfun_body.exp_desc with
    | Texp_function (_, clist, _)  ->
        let one_case = List.nth clist 0 in 
        let () = Printf.printf "%s" "@HERE" in 
        let (pat, exp) = (fun ({c_lhs;c_rhs;_}) -> (c_lhs, c_rhs)) one_case in 
        let params' = pat :: params in 
        get_params exp params' 

    | _ -> (Vector.rev params, tfun_body)
  in 

  let (parameters, normalbody ) =  get_params body [] in
  let () = Printf.printf "%s" (" params "^(string_of_int (List.length parameters))) in 

  (fun_name, parameters, normalbody)

(*return true if the functio name is raise*)
let is_excecption_call fucntionexp = 
  let open Typedtree  in 
  let exp_desc = fucntionexp.exp_desc in 
  let function_id = match exp_desc with 
    Texp_ident (p, l, vd) ->

      let () = Printf.printf "%s" "\n******Checking if the function call is to Pervasive.raise*********** \n" in
      let ident_var = match p with 
          Pident id -> id
        | _ -> raise (SpecVerifyExc "Only Pident handled ")
      in ident_var  
      
    | _ -> raise (SpecVerifyExc "Unimpl, function call requires the function to be an identity, unimplemented general case ")  
  in 
  (*TODO : This is a hack to check raise *)
  if Ident.name function_id = "raise" then true else false  


(*The main type-synthesis routine*)
let rec  type_synth_exp (ve, pre, exp) = 
  let open Typedtree  in 
  let exp_desc = exp.exp_desc in 
  let exp_type = exp.exp_type in 
  let normal_exp_type = TyD.normalizeTypes exp_type in 

  let trivialAns = fun _ -> ([], RefTy.fromTyD (normal_exp_type)) in 
  let exceptionAns = fun _ -> ([], RefTy.fromTyD (TyD.Ttop)) in 

  match exp_desc with 
  | Texp_ifthenelse (testexp, trueexp, falseexp) ->
    let () = Printf.originalPrint "%s" "\n \t ******* type synthesis : T-IF-THEN-ELSE ******  \n" in 
    
    let (vcstestexp, fty) = type_synth_exp (ve, pre, testexp) in 
    let () = Printf.printf "%s" "\n######### TestExp type \n" in 
    let () = Printf.printf "%s" (RefTy.toString fty) in 
    (*rather than checking that fty is a type with Base type bool we treat it a bool while checking the branches*)
    
    let testId = match testexp.exp_desc with 
      | Texp_ident (p, _,_) -> if (Path.is_ident p) then Path.head p else raise (ANormalError)
      | _ -> raise (ANormalError)

    in 
    (*\Gammac \Gamma, e1:bool*)
    (*create phi_true*)

    let (marker, markedVE) = markVE ve in 
    
    let markedVE = VE.add markedVE (testId, toRefTyS fty)  in 

    
        

    let predtesttrue = Predicate.Base (BP.varBoolEq (testId, true)) in 
    let dummyRefTy_true = RefTy.Base (Var.noName, TyD.Tbool, predtesttrue) in 

    let dummyTyDbind_true = (Var.genVar() , toRefTyS dummyRefTy_true) in 

    
    let extendedVE_true = VE.add markedVE dummyTyDbind_true  in 

    let (vcstrueexp, ftytrueexp) = type_synth_exp (extendedVE_true, pre, trueexp) in 
    let () = Printf.printf "%s" "\n#########  TrueExp type \n" in 
    let () = Printf.printf "%s" (RefTy.toString ftytrueexp) in 

    let wftype_true = wellFormedType (marker,extendedVE_true,ftytrueexp) in 
    

    (*create phi_false*)
    let predtestfalse = Predicate.Base (BP.varBoolEq (testId, false)) in 
    let dummyRefTy_false = RefTy.Base (Var.noName, TyD.Tbool, predtestfalse) in 

    let dummyTyDbind_false = (Var.genVar() , toRefTyS dummyRefTy_false) in 

    
    let extendedVE_false = VE.add markedVE dummyTyDbind_false  in 


    let (resvcs, resty) = 
      match falseexp with 
        | Some fexp -> 
          let (vcsfalseexp, ftyfalseexp) = type_synth_exp (extendedVE_false, pre, fexp) in  
          let () = Printf.printf "%s" "\n#########  FalseExp type \n" in 
          let () = Printf.printf "%s" (RefTy.toString ftyfalseexp) in 

          let wftype_false = wellFormedType (marker,extendedVE_false,ftyfalseexp) in 
    
            
          let unified_branch_exps = unifyWithDisj wftype_true wftype_false in 
          let  _ = Printf.printf "@\n \n Unified Type:\n" in 
          let  _ = Printf.printf "%s" ("\n "^(RefTy.toString unified_branch_exps)) in 

          let finalvcs = List.concat [vcstestexp;vcstrueexp;vcsfalseexp] in 

          (finalvcs, unified_branch_exps)
          
        | None -> 
          let finalvcs = List.concat [vcstestexp;vcstrueexp] in 

          (finalvcs, ftytrueexp)

     in 
     (resvcs, resty)       
   (*An exception in Ocaml is a function application for Pervasive.raise *)  
  | Texp_apply   (fexp, arg_label_exp_list) ->
       let () = Printf.originalPrint "%s" "\n \t ******* type synthesis : T-APP ******  \n" in 
    
       if (is_excecption_call fexp)
        then 
          let () = Printf.printf "%s" "\nException Case, handled differently \n" in 
           exceptionAns()
        else 
          let () = Printf.printf "%s" "\n Else Case, handled as per the typing rules of a T-APP \n" in 
          

         let (vcs1,fty) = type_synth_exp (ve, pre, fexp) in 
         let () = Printf.printf "%s" "\n######### Formal type ####### \n" in 
         let () = Printf.printf "%s" (RefTy.toString fty) in 
         
        (*uncurry the type*)
        let (parametersTyBind, resRefTy) =
          match fty with 
          | RefTy.Arrow (x,y) -> RefTy.uncurry_Arrow fty
          | _ -> 
              let exp_str = "Type of 271 not an arrow" in 
              raise (SpecVerifyExc exp_str) 
        in 

        (*The a-normal  form will have just one argument*)   
        let () = assert ((List.length arg_label_exp_list) = (List.length parametersTyBind)) in 
      (*Also assert the type of the arguments *)   
        let () = List.iter (fun (x,y) -> Printf.printf "%s" ("\n[ "^(Var.toString x)^" :: "^(RefTy.toString y)^" ] \n"))  parametersTyBind in  

    
        let folding_fun = fun (vcs, substs) (fargBind) (actual_arg_exp) ->
          let argValExp =  actual_arg_exp in
          let (_, fargty) = fargBind in 
          let exp_from_valExp  = 
            match (snd argValExp) with 
            | Some e -> e 
            | None -> raise (SpecVerifyExc "Expression missing")
          in    
          let (vcs2,argTy) = type_synth_exp (ve,pre,exp_from_valExp) in 
              (*
               *  Γ ⊢ argTy <: fargty
               *)

           let () = Printf.printf "%s" "\n actual type \n" in 
           let () = Printf.printf "%s" (RefTy.toString argTy) in 
         let () = Printf.printf "%s" "\n formal type \n" in 
           let () = Printf.printf "%s" (RefTy.toString fargty) in 
       
           let vcs3 = VC.fromTypeCheck (ve,pre,argTy,fargty) in         

           
         (*
               * Then, determine type of this expression by substituion of
               * actuals for formals.
               *)

          (**)
          (* let get the pattern for the id   *) 
          let exp_desc_from_exp = exp_from_valExp.exp_desc in 
          let argPId  = match exp_desc_from_exp with 
            | Texp_ident (p,_,_) -> p
            (*Handling exception handling*)
            | _ -> raise (SpecVerifyExc  "Unimpl, Only allowed arguments to a function are Identities")

          in 
          let argId = match argPId with 
              Pident id -> id
            | _ -> raise (SpecVerifyExc "Only Pident handled ")in 

          let  (_,substs') = unifyArgs (fargBind,argId)  
          in
          (List.concat[vcs2;vcs3],List.concat[substs;substs'])
        in 
        let (finalvcs, finalsubsts) = List.fold_left2 (folding_fun) (vcs1,[]) parametersTyBind arg_label_exp_list
        in 

        let _ = Printf.printf "%s" ("\n  VCS after T-apply \n") in 
        let _ = Printf.printf  "\n" in 

       let _ = Printf.printf "%s" (L.toString (VC.layouts finalvcs)) in 
       
        let resTy = RefTy.applySubsts finalsubsts resRefTy in 
        let () = Printf.printf "%s" ("\n *******************ty of return Value "^RefTy.toString resTy) in      
              

       (finalvcs, resTy)

  | Texp_ident (p, l, vd) ->

      let () = Printf.originalPrint "%s" "\n \t ******* type synthesis : T-VAR ******  \n" in 
      let ident_var = match p with 
          Pident id -> id
        | _ -> raise (SpecVerifyExc "Only Pident handled ")in 
      let () = Printf.printf "%s" ("\n ident "^(Ident.name ident_var)) in   
      let idRefTyS = VE.find ve ident_var in
      let idRefTy = RefTyS.specializeRefTy (idRefTyS) in 
      let () = Printf.printf "%s" ("\n idRefTys "^(RefTyS.toString idRefTyS)) in   
      let () = Printf.printf "%s" ("\n RefTys for id "^(RefTy.toString idRefTy)) in 
      ([], idRefTy)
  | Texp_constant c -> 
       let () = Printf.originalPrint "%s" "\n \t ******* type synthesis : T-CONST ******  \n" in 
    
       (*match on the different types for constants*)
       (*type constant =
    Const_int of int
  | Const_char of char
  | Const_string of string * string option
  | Const_float of string
  | Const_int32 of int32
  | Const_int64 of int64
  | Const_nativeint of nativeint*)
    let vc_type_pair = 
      match c with 
        Const_int  (i) -> let reftyvar_for_c = RefTy.genVar() in 
                let type_for_i = RefTy.Base (reftyvar_for_c, TyD.makeTvar (SpecLang.Tyvar.fromString "int"), Predicate.Base (BP.varIntEq (reftyvar_for_c, i ))) in 
                ([], type_for_i)  
      | _ -> Printf.printf "%s" ("type synthesis for constant, unimplemented case, returning trivial value");
            trivialAns ()
    in 
    vc_type_pair        
  | Texp_let (rf, vbl, exp) ->

      let () = Printf.originalPrint "%s" "\n \t ******* type synthesis : T-LET ******  \n" in 
          let  _ = Printf.printf "\nVar Env Let :\n" in 
        let  _ = Printf.printf "---------\n" in 
      
        let  _ = Printf.printf "%s" ((VE.layout ve)) in 
     
 
      let (marker, markedVE) = markVE ve in 
      (*list of VC and ([P1: Typeof E1; P2 : Typeof E2; .... : Pn : Typeof En)*)
      let (vcs1 , refTys_bind) = 
        type_synth_value_bindings (ve, pre, vbl) in 

      let value_type_list = match refTys_bind with 
        | RefTy.Tuple (var_binding_list) -> var_binding_list 
        | _ -> raise (SpecVerifyExc "Type of  not a tuple") in  
      (*\Gamma, P1: T1, P2:T2 ....Pn:Tn*)  
      let extendedVE = List.fold_left (
          fun veacc (var, refty) -> 
            (*we should also have Eq (P1, bv T1) to the constraints and should add the bv : baseOf (T1)*)
           let (newrefTy, bvBind) =  
            match refty with 
             RefTy.Base (bv, tyd, pred) -> 
                                        let  _ = Printf.printf "%s" ("\n BoundVar \n"^(Ident.name bv)) in 
                                        let  _ = Printf.printf "%s" ("\n Applied Var \n"^(Ident.name var)) in 
                                        
                                        

                                        let pred' = Predicate.applySubst (var,bv) pred in
                                        let pred_eq = Predicate.Base (BP.varEq (var, bv)) in
                                        (RefTy.Base (var, tyd, Predicate.Conj(pred_eq, pred')),( bv, toRefTyS (RefTy.Base (bv, tyd, pred) ))) 
                                    (*    (RefTy.Base (bv, tyd, Predicate.Conj(pred, pred')),( bv, toRefTyS (RefTy.Base (bv, tyd, Predicate.truee()) ))) *)
                                       
            | _ -> raise (SpecVerifyExc "The type of the let RHS expression must be a Base type")    
           in  
           let tsrefty  = toRefTyS newrefTy in 
           let ve' = VE.add veacc (var, tsrefty) in
           let ve'' = VE.add ve' bvBind in  
            ve'' 

        ) markedVE value_type_list in 



      let (vcs2, type_body_exp) = type_synth_exp (extendedVE, pre, exp) in 

      let () = Printf.printf "%s" ("\n RefinementType of the synth let body expression in T-let \n"^(RefTy.toString (type_body_exp))) in 
      let wft =  wellFormedType (marker,extendedVE,type_body_exp) in 
      
      (*  let wft =  wellFormedType (marker,extendedVE,type_body_exp) in 
       *) let () = Printf.printf "%s" ("\n WFT of the synth let body expression in T-let \n"^(RefTy.toString (wft))) in 
      

       (List.concat [vcs1;vcs2], wft)  
    
  (*match E with [P1 -> E1; P2  -> E2;....Pn -> En] or Exception (explist)*)
  | Texp_match (testexp, case_list, explist, p) ->
       let () = Printf.originalPrint "%s" "\n \t ******* type synthesis : T_MATCH ******  \n" in 
    
      (*\Gamma *)
      let (marker, markedVE) = markVE ve in 
      (*Extend the environment*)
      let open SpecLang in 
      let newTyVar = Tyvar.newSVar () in
      let new_Tvar = TyD.Tvar newTyVar in  
        
      let folding_function = fun  (vcs,wftypes) ({c_lhs;c_rhs;_}) ->
        let pat = c_lhs in 
        let expr = c_rhs in 
        (*does v/\mu*)
        let  valbind = {vb_pat = pat; vb_expr=testexp; vb_attributes = []; vb_loc = Location.none } in 
        let (marker,markedVE) = markVE ve in 
        
        let extendedVE = doIt_pat_testexp_bind(markedVE, pre, valbind) in 
        
        let  _ = Printf.printf "\nVar Env After adding [v/mu]:\n" in 
        let  _ = Printf.printf "---------\n" in 
      
        let  _ = Printf.printf "%s" ((VE.layout extendedVE)) in 
     
        let (vcs1,ty) = type_synth_exp (extendedVE,pre,expr) in 
        (*add red to vcs*)
        let () = Printf.printf "%s" ("\n RefinementType of the expression in case P->E \n"^(RefTy.toString (ty))) in 

        
        let wftype = wellFormedType (marker,extendedVE,ty)
        in
       
        (*add red to vcs*)
        let () = Printf.printf "%s" ("\n WellFormed RefinementType of the expression in case P->E \n"^(RefTy.toString (wftype))) in 

        (List.concat [vcs;vcs1], wftype :: wftypes)
      in  

      let (vcs, wftypes ) = List.fold_left folding_function ([],[]) case_list in 
      
      
       
      let (wftypes, wftype) = Vector.split_last wftypes in

      let unifiedType = List.fold_left unifyWithDisj wftype wftypes in 

         let  _ = Printf.printf "@\n \n Unified Type:\n" in 
        let  _ = Printf.printf "%s" ("\n "^(RefTy.toString unifiedType)) in 
    
 
         (*
             * 1. alphaRename boundvars forall wfTypes to a single var
             * 2. assert that tyd is same for all
             * 3. fold all alpha-renamed preds of wftypes with Disj

            *)

            
      (vcs,unifiedType)


  | Texp_tuple ( lsexp) ->
      let () = Printf.originalPrint "%s" "\n \t ******* type synthesis : T-TUPLE ******  \n" in 
     let vcs_type_list = List.map (fun e -> type_synth_exp (ve, pre, e)) lsexp in 
      let (vcs_final, types_final) = List.fold_left (fun (accvcs, types) (vcs, ty) -> (List.concat [accvcs;vcs], ty::types))
          ([],[]) vcs_type_list in 
      (vcs_final, List.hd (List.rev types_final) )                   
  | Texp_construct (lc, cd, lexp) ->

      let () = Printf.originalPrint "%s" "\n \t ******* type synthesis : T-CON-APP ******  \n" in 
     let  (vcs, constructor_resTy ) = type_synth_constructor_apply (ve , pre, cd, lexp)  
      in 
      
      (vcs, constructor_resTy )

  | Texp_function (lab, csl, part) ->
    let () = Printf.originalPrint "%s" "\n \t ******* type synthesis : T-LAMBDA ******  \n" in 
    
   (*    let () = Printf.printf "%s" "######### synthesis:function  \n" in
    *)   type_synth_function (ve, pre, exp_desc)

  | Texp_sequence (exp1 , exp2) -> 
    let () = Printf.originalPrint "%s" "\n \t ******* type synthesis : T-SEQ ******  \n" in 
       type_synth_exp (ve,pre,exp2) 

  | _ -> 
       let () = Printf.printf "%s" "\n######### synthesis:Other \n" in
       trivialAns ()   
(*generalize this to any constructor*)
and type_synth_constructor_apply (ve, pre, const_desc, list_exp) = 
  (*T-apply rule for the constructor rather than function , Ocaml constrcutors are treated differently than functions*)
  let constructorName =
    let open Types in 
    const_desc.cstr_name 
  in 

  let () = Printf.printf "%s" ("T-con apply Constructor Name "^constructorName) in 
  let constrTyS = 
    try
      VE.find ve (Var.fromString constructorName)  
    with 
    | _ -> raise (SpecVerifyExc ("Constructor "^constructorName^" not found in the VE"))
  in 
  let constrRefTy = RefTyS.specializeRefTy constrTyS in 


  let () = Printf.printf "%s" ("Constructor ref type "^(RefTy.toString constrRefTy)) in 


  match constructorName with 
   
   |"::" -> (*cons constructor expression case*)

      (*update the type of the argument in the variable environment*)
      let args_types = const_desc.cstr_args in 
      let localTyDBind = List.map2 (fun exp ty -> (exp, (RefTy.fromTyD (TyD.normalizeTypes ty)))) list_exp args_types in  

      ( match constrRefTy with 

          | Arrow ( (_, (Tuple tdl)) as par, fResTy ) -> 
             let () = Printf.printf "%s" ("####### Arrow (Tuple , dest ) case \n") in 
             let list_fargTyBinds = tdl in 
            let () = assert ((List.length list_fargTyBinds) = (List.length list_exp)) in 

            let folding_fun = fun (vcs, substs) (fargBind) (actual_arg_exp) ->
              let (_, fargty) = fargBind in 
              let exp_from_valExp = actual_arg_exp in 

              (*Two componets , if identity then use the local environment, else get the type by synthesizing type *) 
              let exp_desc_from_exp = exp_from_valExp.exp_desc in 

              match exp_desc_from_exp with 
              | Texp_ident (p,_,_) ->

                  let argId = match p with 
                      Pident id -> id
                    | _ -> raise (SpecVerifyExc "Only Pident handled ")in 

                 
                  let argTy = List.assoc exp_from_valExp localTyDBind in  
                  (*
                  *  Γ ⊢ argTy <: fargty
                  *)
                  let () = Printf.printf "%s" ("ty of argument const "^RefTy.toString argTy) in      
                  let () = Printf.printf "%s" ("ty of argument const "^RefTy.toString fargty) in      
                  let vcs1 = VC.fromTypeCheck (ve,pre,argTy,fargty) in         
                  (*unify the actual argument with the type of the formal*) 
                  let  (_,substs') = unifyArgs (fargBind,argId)  
                  in
                  (List.concat[vcs;vcs1],List.concat[substs;substs'])
                  

              (*If an expression*)
              | _ ->  

                  let (vcs0,argTy) = type_synth_exp (ve,pre,exp_from_valExp) in 
                  (*Create a local tempVar with this type
                  This is required as the AST is not a-normalized, in an anormalized form this will always be a Val*)
                  let tempVar = getUniqueId "temp" in 
                  let extendedVE = VE.add ve (tempVar, (toRefTyS argTy)) in  
                  let ve = VE.add ve (tempVar, (toRefTyS argTy)) in  
                      (*
                       *  Γ ⊢ argTy <: fargty
                       *)
                  let () = Printf.printf "%s" ("ty of argument const "^RefTy.toString argTy) in      
                  let () = Printf.printf "%s" ("ty of argument const "^RefTy.toString fargty) in      
                  
                  let vcs1 = VC.fromTypeCheck (extendedVE,pre,argTy,fargty) in         

                  let  (_,substs') = unifyArgs (fargBind,tempVar)  
                  in
                  (List.concat[vcs;vcs0;vcs1],List.concat[substs;substs'])
            in 
             let (finalvcs, finalsubsts) = List.fold_left2 (folding_fun) ([],[]) list_fargTyBinds list_exp in
              let resTy = RefTy.applySubsts finalsubsts fResTy in 
       
            (finalvcs, resTy)

            | Arrow (tdsrcBind, fResTy) -> 
             let () = Printf.printf "%s" ("####### Arrow (src , dest ) case \n") in
             let list_fargTyBinds = [tdsrcBind] in
            let () = Printf.printf "%s" ("length left "^ (string_of_int (List.length list_fargTyBinds))) in
            let () = Printf.printf "%s" ("length right "^ (string_of_int (List.length list_exp))) in
              
            let () = assert ((List.length list_fargTyBinds) = (List.length list_exp)) in 

            let folding_fun = fun (vcs, substs) (fargBind) (actual_arg_exp) ->
              let (_, fargty) = fargBind in 
              let exp_from_valExp = actual_arg_exp in
              let open Typedtree in 

              let (_,argTy) = type_synth_exp (ve,pre,exp_from_valExp) in 
                        (*
                         *  Γ ⊢ argTy <: fargty
                         *)

              let vcs1 = VC.fromTypeCheck (ve,pre,argTy,fargty) in         


              (* let get the pattern for the id   *) 
              let exp_desc_from_exp = exp_from_valExp.exp_desc in 
              let argPId  = match exp_desc_from_exp with 
                | Texp_ident (p,_,_) -> p

              in 
              let argId = match argPId with 
                  Pident id -> id
                | _ -> raise (SpecVerifyExc "Only Pident handled ")in 

              let  (_,substs') = unifyArgs (fargBind,argId)  
              in
              (List.concat[vcs;vcs1],List.concat[substs;substs'])
            in 
            let (finalvcs, finalsubsts) = List.fold_left2 (folding_fun) ([],[]) list_fargTyBinds list_exp in

            let resTy = RefTy.applySubsts finalsubsts fResTy in 
            (finalvcs, resTy)


            | (Base (var, tyd, pr) as constRefTy) -> 
             let () = Printf.printf "%s" ("#######T-const-apply Other case \n") in
             ([], constRefTy)

        )
  | "[]" -> (*nil constuctor constnat case*)
        let () = Printf.printf "%s" "Texp-const case for nilconstant" in 
        let nilVid = Var.fromString "nil" in  
        let resRefTyS = 
            try
              VE.find ve nilVid 
            with
            | _ -> failwith "nil constant not defined" 
         in 
         let resRefTy = RefTyS.specializeRefTy resRefTyS in 
   
      ([], resRefTy)


  | _ -> (*Any other data constructor*)
        let () = Printf.printf "%s" "T-consApply case user defined datatype" in 
      
        (*update the type of the argument in the variable environment*)
      let args_types = const_desc.cstr_args in 
      let localTyDBind = List.map2 (fun exp ty -> (exp, (RefTy.fromTyD (TyD.normalizeTypes ty)))) list_exp args_types in  

      ( match constrRefTy with 
          | Arrow ( (_, (Tuple tdl)) as par, fResTy ) -> 
             let () = Printf.printf "%s" ("####### T-consApply Arrow (Tuple , dest ) case \n") in 
             let list_fargTyBinds = tdl in 
             let () = assert ((List.length list_fargTyBinds) = (List.length list_exp)) in 
  
             let folding_fun = fun (vcs, substs) (fargBind) (actual_arg_exp) ->
                let (_, fargty) = fargBind in 
                let exp_from_valExp = actual_arg_exp in 
                (*Two componets , if identity then use the local environment, else get the type by synthesizing type *) 
                let exp_desc_from_exp = exp_from_valExp.exp_desc in 
                (*case Consname l e.g. Node (l,n,r)*)  
                match exp_desc_from_exp with 
                
                | Texp_ident (p,_,_) -> 
                    let () = Printf.printf "%s" ("Consstructor application to an Identity ") in      
                
                    let argId = (match p with 
                      Pident id -> id
                      | _ -> raise (SpecVerifyExc "Only Pident handled "))
                in 

                let argTy = List.assoc exp_from_valExp localTyDBind in  
                  (*
                  *  Γ ⊢ argTy <: fargty
                  *)
                let () = Printf.printf "%s" ("ty of argument const "^RefTy.toString argTy) in      
                let () = Printf.printf "%s" ("ty of argument const "^RefTy.toString fargty) in      
                let vcs1 = VC.fromTypeCheck (ve,pre,argTy,fargty) in         
                (*unify the actual argument with the type of the formal*) 
                let  (_,substs') = unifyArgs (fargBind,argId)  
                in
                (List.concat[vcs;vcs1],List.concat[substs;substs'])
                  

                (*case Consname applied to an expession, may arise in a not-anormal format, e.g.  Node (lexp, nexp, rexp)*)
                | _ ->  
                   let () = Printf.printf "%s" ("Consstructor application to an expression ") in      
                   let (vcs0,argTy) = type_synth_exp (ve,pre,exp_from_valExp) in 
                  (*Create a local tempVar with this type
                  This is required as the AST is not a-normalized, in an anormalized form this will always be a Val*)
                  let tempVar = getUniqueId "temp" in 
                  let extendedVE = VE.add ve (tempVar, (toRefTyS argTy)) in  
                  let ve = VE.add ve (tempVar, (toRefTyS argTy)) in  
                      (*
                       *  Γ ⊢ argTy <: fargty
                       *)
                  let () = Printf.printf "%s" ("ty of argument const "^RefTy.toString argTy) in      
                  let () = Printf.printf "%s" ("ty of argument const "^RefTy.toString fargty) in      
                  
                  let vcs1 = VC.fromTypeCheck (extendedVE,pre,argTy,fargty) in         

                  let  (_,substs') = unifyArgs (fargBind,tempVar)  
                  in
                  (List.concat[vcs;vcs0;vcs1],List.concat[substs;substs'])
            in 
             let (finalvcs, finalsubsts) = List.fold_left2 (folding_fun) ([],[]) list_fargTyBinds list_exp in
              let resTy = RefTy.applySubsts finalsubsts fResTy in 
       
            (finalvcs, resTy)

            | Arrow (tdsrcBind, fResTy) -> 
               let () = Printf.printf "%s" ("####### Arrow (src , dest ) case \n") in
               let list_fargTyBinds = [tdsrcBind] in
               let () = Printf.printf "%s" ("length left "^ (string_of_int (List.length list_fargTyBinds))) in
                let () = Printf.printf "%s" ("length right "^ (string_of_int (List.length list_exp))) in
               let () = assert ((List.length list_fargTyBinds) = (List.length list_exp)) in 

            let folding_fun = fun (vcs, substs) (fargBind) (actual_arg_exp) ->
              let (_, fargty) = fargBind in 
              let exp_from_valExp = actual_arg_exp in
              let open Typedtree in 

              let (_,argTy) = type_synth_exp (ve,pre,exp_from_valExp) in 
                        (*
                         *  Γ ⊢ argTy <: fargty
                         *)

              let vcs1 = VC.fromTypeCheck (ve,pre,argTy,fargty) in         


              (* let get the pattern for the id   *) 
              let exp_desc_from_exp = exp_from_valExp.exp_desc in 
              let argPId  = match exp_desc_from_exp with 
                | Texp_ident (p,_,_) -> p

              in 
              let argId = match argPId with 
                  Pident id -> id
                | _ -> raise (SpecVerifyExc "Only Pident handled ")in 

              let  (_,substs') = unifyArgs (fargBind,argId)  
              in
              (List.concat[vcs;vcs1],List.concat[substs;substs'])
            in 
            let (finalvcs, finalsubsts) = List.fold_left2 (folding_fun) ([],[]) list_fargTyBinds list_exp in

            let resTy = RefTy.applySubsts finalsubsts fResTy in 
            (finalvcs, resTy)


            | (Base (var, tyd, pr) as constRefTy) -> 
             let () = Printf.printf "%s" ("#######T-const-apply Other case \n") in
             ([], constRefTy)

        )
  


(*The v/\mu [\phi_c] v/\mu [phi_n]*)
and doIt_pat_testexp_bind (ve, pre, pat_exp_bind)  = 
  let pat= pat_exp_bind.vb_pat in 
  let testexp = pat_exp_bind.vb_expr in 
  let testExpId = match testexp.exp_desc with 
    | Texp_ident (p,_,_) -> Path.head p 
    | _ -> raise (SpecVerifyExc "The testexp must be and identity") 
  in   
  let () = Printf.printf "%s" ("Creating pat-exp binds for "^Ident.name testExpId) in 
  
  match pat.pat_desc with   
    | Tpat_construct (_, cd, pl) ->
      let cstr_name = cd.cstr_name in 
      let cstr_Id = Var.fromString cstr_name in 
      let cstr_refTyS = 
          try 
            VE.find ve (cstr_Id)
          with 
            | _ -> raise (SpecVerifyExc ("Constructor "^cstr_name^ "not defined"))  
      in 
      let cstr_refTy = RefinementTypeScheme.specializeRefTy cstr_refTyS in 

      let substituted_cstrResRefTy = 
        match cstr_refTy with 
          | Base (oldv, tyD, oldpred) -> RefTy.applySubsts [(testExpId, oldv)] cstr_refTy
          | Arrow ((_,_) as argBind, resTy) -> 
                match resTy with 
                | Base (oldv, tyd, oldpred) -> RefTy.applySubsts [(testExpId, oldv )] resTy 
                | _ -> raise (SpecVerifyExc "The result of an arrow type must be a Base for constructor")
          | _ -> raise (SpecVerifyExc "constructor cannot be a Tuple")
    
      in
       (* Extend ve' with a new dummy var to keep track of
               * relationship between matched arguments and rhsvar.*)
        

      (*get the tydBinds for constructor argumenst , e.g Node (n,l,r) -> (n : int, l:tree, r:tree)*)

      let () = Printf.printf "%s" ("\n \n RefinementType for the constructor "^(RefTy.toString cstr_refTy)) in 

      let formal_cstr_args = 
      match cstr_refTy with 
        | RefTy.Arrow ( (v,ty), dest) ->  
              (match ty with 
                 Tuple tl -> tl
                | _->raise (SpecVerifyExc "Unimple Constructor Arrow Type, only allowed case is [Tuple] => dest") )
        | _ -> []
      in 

      let formal_cstr_argBinds = List.map (fun (_,rty) ->
          match rty with 
          | RefTy.Base (v, tyd, phi) -> (v, rty)
          | _ -> raise (SpecVerifyExc "Unimple the argument types for the constructor must be Base type")
          ) formal_cstr_args 
      in 

      (*actual to formal bind*)
      let (substitutions, ve') = List.fold_left2 (fun (sub, ve)  (fargId, fargTy) (arg_pat) -> 
          let arg_pat_type = arg_pat.pat_type in  
         let arg_pat_normaltype = TyD.normalizeTypes (arg_pat_type) in       
    
         match arg_pat.pat_desc with 
           | Tpat_var (id, _) -> let ()= Printf.printf "%s" ("\n Arg_pat_name for the constructor "^(Ident.name id)) in 
              let sub = (id, fargId) :: sub in
              (*A bug here for the case tail of a list*)
              let fargIdType = 
                try 
                  VE.find ve fargId
                with 
                _ -> toRefTyS (RefTy.fromTyD arg_pat_normaltype)
              in 
              let ve' = VE.add ve (id, fargIdType) in 
              (sub, ve') 
           | Tpat_constant ci -> 
              match ci with 
                | Const_int i -> let new_var = Var.genVar() in 
                  let sub = (new_var, fargId) :: sub in
                  let type_for_newVar = RefTy.Base (Var.noName, TyD.Tvar (SpecLang.Tyvar.fromString "int"), Predicate.Base (BP.varIntEq (new_var, i )) ) in 
                  let ve' = VE.add ve (new_var, toRefTyS type_for_newVar) in   
                  (sub, ve') 
                | _ -> raise (SpecVerifyExc "arguments to constructors must be a Tpat_var of (Tpat_constant Const_int) ")     
              
           | _ -> raise (SpecVerifyExc "arguments to constructors must be a Tpat_var ")    
      
        ) ([],ve) (formal_cstr_argBinds) pl  in


        let () = List.iter (fun (oldid, newid) -> Printf.printf "%s" ("\n old "^(Ident.name oldid)^" |-> "^(Ident.name newid)^" \n ") ) substitutions in 

      let substituted_cstrResRefTy  =  RefTy.applySubsts substitutions substituted_cstrResRefTy in 

      let () = Printf.printf "%s" (" \n substituted RefTy "^(RefTy.toString substituted_cstrResRefTy)) in   
       
       let dummyTyDbind = (Var.genVar() , toRefTyS substituted_cstrResRefTy) in 


      let ve'' = VE.add ve'  dummyTyDbind in 


    (*   let ve'' = List.fold_left (fun ve arg_pat -> 
      let arg_pat_type = arg_pat.pat_type in  
      let arg_pat_normaltype = TyD.normalizeTypes (arg_pat_type) in       
      match arg_pat.pat_desc with 
       | Tpat_var (id, _) -> let ()= Printf.printf "%s" ("\n Arg_pat_name for the constructor "^(Ident.name id)) in 
         VE.add ve (id, toRefTyS (RefTy.fromTyD arg_pat_normaltype))
       | Tpat_constant (ci) -> ve   
       | _ -> raise (SpecVerifyExc "arguments to constructors must be a Tpat_var ")    
      ) ve' pl
       in*) 


     (*  let ve'' = List.fold_left2 (fun ve (fargId, fargTy) (arg_pat) -> 
         match arg_pat.pat_desc with 
           | Tpat_var (id, _) -> let ()= Printf.printf "%s" ("\n Arg_pat_name for the constructor "^(Ident.name id)) in 
              match fargTy with 
                | RefTy.Base (v, tyd, pred) -> 

                let pred_equate_cons_params = Predicate.Base (BP.varEq (v, id)) in 
                let pred' = Predicate.Conj (pred, pred_equate_cons_params) in 
                let unified_fargTy =  RefTy.Base (v, tyd, pred') in 
                  let ve = VE.add ve (id, toRefTyS unified_fargTy) in 
                  let ve = VE.add ve (v, toRefTyS fargTy) in 
                  ve
                | _-> raise (SpecVerifyExc "the type of arguments to constructors must be a  Base ")  
            | _ -> raise (SpecVerifyExc "arguments to constructors must be a Tpat_var ")    
      
        ) ve' (formal_cstr_argBinds) pl  in 
      *)
      ve''
        
      (*Expression e1 is type-checked under the extended environment:
        Γ, (x:ν:int | true) , xs: (ν:intlist | true), 
            Rmem(z) = Rid(x) [ Rmem(y)
          *)



     | _ -> raise (SpecVerifyExc "The pattern must be a Tpat_construct") 
     

and type_synth_value_bindings (ve, pre, vblist) = 
    let open Typedtree in 
    
    let mapping_function  = 
      fun vb -> 
        let vbpattern  = vb.vb_pat in 
        let vbid = get_var_from_pattern vbpattern in 
        let vbexpression = vb.vb_expr in 
        (vbid, type_synth_exp (ve, pre, vbexpression))  
    in 


    (*[(vcs1, refty1);(vcs2, refty2);...]*)
    let list_pair_vcs_refty = List.map mapping_function vblist in 
    
    let folding_function = 
      fun (vcs, var_refty_binds) (vari, (vcsi,reftyi)) -> 
        (List.concat [vcs;vcsi], ((vari, reftyi)::var_refty_binds)) in 
    let (vcs, var_to_type_list) = List.fold_left folding_function ([], []) list_pair_vcs_refty in
    (vcs, RefTy.Tuple var_to_type_list) 



and type_check_function (ve, pre, fexp, ty)  =
   
    let ((_,argRefTy) as argBind, resRefTy) = 
      match ty with 
        RefTy.Arrow (x,y) -> (x,y) 
      | _ -> raise (SpecVerifyExc ("Function with non-arrow type"^(RefTy.toString ty)))
    in 
    let () = Printf.printf "%s" ("\n Formal ArgTy "^(RefTy.toString argRefTy)) in 
    let () = Printf.printf "%s" ("\n Formal resRefTy "^(RefTy.toString resRefTy)) in 

    let (arg, fexp_body) = 
      (*The function body will be a list of bindings*)
      let case_list = 
          match fexp with 
            Texp_function(l, bd, _) -> bd in 
              let {c_lhs;c_guard;c_rhs} = 
              try 
                List.nth  case_list 0 
              with 
              | _ -> raise (SpecVerifyExc "incorrect arguments")
          | _ -> raise (SpecVerifyExc "The function body must be a Texp_function ")    
      in
      ( c_lhs, c_rhs) 
     in  
     let () = Printf.printf "%s" (" \n Arguments  :: "^(Var.toString (get_var_from_pattern arg)))    
     in 
     let extendedVE = VE.add ve ((get_var_from_pattern arg), toRefTyS argRefTy) in
   
    let (binds, substs) = unifyArgs (argBind, (get_var_from_pattern arg)) in 
    
    let _ = assert (List.length binds = 1) in 
    let resRefTy' = RefTy.applySubsts substs resRefTy in 
    let () = Printf.printf "%s" ("\n Substituted resRefTy' "^(RefTy.toString resRefTy')) in 

       (*
       * Γ[arg↦argRefTy] ⊢ body <= resRefTy
       *)
    let () = Printf.printf "%s" "Typechecking the body of the function in extendedVE \n" in 

    type_check_exp (extendedVE,pre,fexp_body,resRefTy')





and type_check_exp (ve, pre, exp, tyexp)  = 
    match exp.exp_desc with 
    | Texp_function (_,_,_) -> 
         let () = Printf.printf "%s" "Expression :: Texp_function \n" in 
         type_check_function(ve, pre, exp.exp_desc, tyexp)
    | _ -> 
        let () = Printf.printf "%s" "Expression :: Not a Texp_function \n" in 

        (*
         * Γ ⊢ exp => expRefTy
         *)
        let (expvcs,expRefTy) = type_synth_exp (ve,pre,exp) in 
        (*
         * Γ ⊢ expRefTy <: ty
         *)

        let () = Printf.printf "%s" ("\n \n refinement Type synthesized for exp ::: "^(RefTy.toString expRefTy)) in    
        let () = Printf.printf "%s" ("\n \nrefinement Type provided for tyexp :::"^(RefTy.toString tyexp)) in    

        let () = Printf.printf "%s" "\n \n Γ ⊢ expRefTy <: ty" in    

        let new_vcs = VC.fromTypeCheck (ve, pre, expRefTy, tyexp)  in 
       List.concat [expvcs;new_vcs]


and doIt_lambda (ve, pre, lambda) =
    let var  = lambda.var in 
    let body = lambda.body in

    let extendedPat = 
      match var.pat_desc with
      | Tpat_var (v,_)-> 
          (* let f = Tfun_exp exp*)
          let ftys = 
            try
              VE.find ve v  
            with 
            | _ -> raise (SpecVerifyExc ("Impossible case "^(Ident.name v)))   
          in  
          let () = Printf.originalPrint "%s" "\n \t ****************************************************  \n" in 
          let () = Printf.originalPrint "%s" "\n \t ******* type checking -T-SUBST *****  \n" in 
          let () = Printf.originalPrint "%s" ("\n \n \t Function "^(Var.toString v)^" being typechecked \n")  in 
          let () = Printf.originalPrint "%s" "\n \t ****************************************************  \n" in 
         
          let () = Printf.printf "%s" (RefTyS.toString ftys)  in 
          let  RefSS.T {prefty = PRf.T {refty=fty;params};_} 
            = RefTyS.specialize ftys  in 
          let var_from_pat = get_var_from_pattern var in     


          let extendedVE = VE.add (VE.remove ve var_from_pat) (var_from_pat,
                                                               ftys) in 
          let extendedPRE = List.fold_right (fun (r,sps) pre -> PRE.addUniterp pre (r, 
                                                                                   PTS.simple (empty(),sps))) params pre 
          in 
          let vcs = match RefTyS.isAssumption ftys with
              false -> (Printf.printf "%s" ("\n \n \t "^(Var.toString var_from_pat)^" will be\
                                                                        \ checked\n");
                                                                        Printf.printf "%s" ("\n \n \t *************************** \n"); 
                        type_check_function (extendedVE, extendedPRE, body.exp_desc , fty))
            | true -> (Printf.originalPrint "%s" ("\n \n \t "^(Var.toString var_from_pat)^" Assumed, will NOT be\
                                                                        \ checked\n");
                                                                        Printf.printf "%s" ("\n \n \t *************************** \n")
                                                                        ; 
                       
              Vector.new0 ())
          in 
          let () = Printf.printf "%s" ("\n \n Length of vcs "^(string_of_int (List.length vcs )))   in 
          (vcs,  extendedVE)
      (*if not Tpat_var then unhandled*)
      | _ -> ([], ve)  
    in 
    extendedPat  

and type_synth_function (ve , pre , fexp) 
    =
    let (arg, fexp_body) = 
      (*assume single case*)
      let case_list = match fexp with 
        | Texp_function(l, bd, _) -> bd in 

      let {c_lhs;c_guard;c_rhs} = List.nth case_list 0 in
      ( c_lhs, c_rhs) 

    in 

    let argType = arg.pat_type in
    let normal_arg_type = TyD.normalizeTypes argType in  
    let argRefTy = RefTy.fromTyD (normal_arg_type) in 
    let argBind = (get_var_from_pattern arg,argRefTy) in 
    (*val _ = L.print (L.seq[Var.layout arg, L.str " :-> ",
      RefTy.layout argRefTy], print)*)
    let extendedVE = VE.add ve ((get_var_from_pattern arg), toRefTyS argRefTy) in
      (*
       * Γ[arg↦argTy] ⊢ body => bodyTy
       *)
    let (bodyvcs,bodyRefTy) = type_synth_exp (extendedVE, pre, fexp_body)
    in
    (bodyvcs,RefTy.Arrow (argBind,bodyRefTy))                 





and doIt_value_bindings (ve, pre, valbinds) :(VC.t list * VE.t) = 
                                             let doIt_each_value_bind = 
                                               fun vb -> 
                                                 let vbpat = vb.vb_pat in 
                                                 let vbexp = vb.vb_expr in

                                                 if (is_function_Exp vb.vb_expr) then 
                                                   let () = Printf.printf "%s" "doIt_value_bindings:: fexp \n" in 
                                                   (* let (name, args, body_exp) = normalized_function 
                                                   *)
                                                   let lambda_for_vb = {var = vbpat; body = vb.vb_expr} in 
                                                   doIt_lambda (ve, pre, lambda_for_vb)

                                                 else
                                                   let () = Printf.printf "%s" "doIt_value_bindings:: Non-function exp \n" in 
                                                   doIt_exp (ve, pre, vbexp) 

                                             in 
                                             let vc_vepair_list = List.map doIt_each_value_bind valbinds in 
                                             let (vcs, tylist) = List.fold_left (
                                                 fun (vcacc, ty_list) (vcs, vet) -> ((List.concat[vcacc;vcs]),(vet::ty_list))) ([], []) (vc_vepair_list) in 
                                             (*returning the type of last vb as the refTy *)
                                             (vcs, List.hd (List.rev tylist))






and  doIt_exp (ve, pre, exp) : (VC.t list * VE.t) = 
                               let () = print "doIt exp" in 
                               let exp_desc = exp.exp_desc in 
                               let exp_type = exp.exp_type in 

                               (*do it find the function*)  
                               match exp_desc with 
                               | Texp_let (rf, vblist, exp) -> 
                                   let vcs_vb = doIt_value_bindings (ve, pre, vblist)in 
                                   vcs_vb
                               | _ -> ([], ve)


let doIt_struct_items (ve_init, pre, tstr) = 
  let () = Printf.printf "%s" "doIt sruct Items" in 

  (*Set the initial environment*)
  let struct_items = tstr.str_items  in 

  let doIt_struct_item (vcs, ve) struct_item  = 
    let  _ = Printf.printf "@Var Env:\n" in 
    let  _ = Printf.printf "---------\n" in 
      
    let  _ = Printf.printf "%s" ((VE.layout ve)) in 
    
    let vcs_ve = 
    match  struct_item.str_desc with 
    (*These are different Expressions which will generated an expression *) 
      Tstr_eval (exp , attr) ->  (*Any let expression at the top level  *)
        let () = print "Tstr_eval" in 
        let vcs_exp = doIt_exp (ve, pre, exp)
        in
        vcs_exp 

    | Tstr_value (rec_flag , value_bindings) -> (* and Tfun*)
        let () = Printf.printf "%s" "\n Case Tstr_value \n " in 
        let vcs_vb = doIt_value_bindings (ve, pre, value_bindings) in
        vcs_vb
    
    (*Extend this to handle user defined types (inductive and non-inductive)*)
    | Tstr_type (rec_flag, type_decl_list) -> (*Unimpl*) ([], ve )
    | _ -> ([], ve) in 

    (List.concat [vcs; (fst vcs_ve)] , snd (vcs_ve))

  in 
  let vcs_ve_pair = List.fold_left (doIt_struct_item) ([], ve_init) struct_items
   in
  fst vcs_ve_pair 



let doIt (ve, pre, tstr) = doIt_struct_items (ve, pre, tstr)
