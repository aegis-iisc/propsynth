(*open TransTypeChecker*)
open SpecLang 
(* open Z3E *)

exception SolverTimeout
exception Unimplemented of string 
exception IncorrectRelSort of string     
module TyD = TyD
module Z3E = Z3_encode 
module RI = RelId
module BP = Predicate.BasePredicate
module RP = Predicate.RelPredicate
module PR = PrimitiveRelation

(*We are moving back to normal VCs*)
module VC = VerificationC
  
type result = Success | Undef | Failure
module FuncDecl = Z3.FuncDecl 
module Solver = Z3.Solver 
module Statistics = Z3.Statistics

 
exception VCEncodingFailed of string 
exception VCEex of string 

let ignore = fun _ -> ()

let z3_log = Z3E.logz3
let query_number = ref 0;
 
module Printf = struct 
  let printf d s = Printf.printf d ""
  let originalPrint = Printf.printf 
  let fprintf = Printf.fprintf
end  



let syscall cmd =
  let ic, oc = Unix.open_process cmd in 
  (* let pid = Unix.process_pid (ic, oc) in  *)
  let _  = Printf.printf "%s" ("\n $$$$$$HERE$$$$$$$$") in 
  let buf = Buffer.create 16 in
  (try
     while true do
       Buffer.add_channel buf ic 1
     done
   with End_of_file -> ());
  let _ = Unix.close_process (ic, oc) in

  (Buffer.contents buf)



                 



let discharge (VC.T (tydbinds, anteP, conseqP) as vc) 
    (typenames) 
    (qualifiers) =

  (* let solverDischarged = Z3E.getSolver () in  
     let _ = Solver.reset solverDischarged in 
     let expressions_list = Solver.get_assertions solverDischarged  in   
     let () = Printf.originalPrint "%s" ("\n# Initial Z3 expressions "^(string_of_int (List.length expressions_list))) in   
     let () = Printf.originalPrint "%s" ("\n Initial solver \n "^(Solver.to_string solverDischarged)) in   
  *)

  let () = Printf.printf "%s" ("GAMMA in VCE "^(VC.string_tybinds tydbinds)) in 

  let constMap = ConstMap.empty in  
  let relMap = RelMap.empty in 

  let tydbinds = tydbinds in 
  let rbinds = [] in 
  let anteP = anteP in 
  let conseqP = conseqP in 

         (*
       * Maps to keep track of encoded values
       *)

  (*int_sort and bool_sort are sort functions in MSFOL
    check how to encode MSFOL in Z3*)
  let tyMap = TyMap.empty  in 


  let tyMap = TyMap.add tyMap (TyD.Ty_int) (Z3E.Int (Z3E.mk_int_sort ())) in 
  let tyMap = TyMap.add tyMap (TyD.Ty_bool) (Z3E.Bool (Z3E.mk_bool_sort ())) in 
  let tyMap = TyMap.add tyMap (TyD.Ty_string) (Z3E.Str (Z3E.mk_string_sort ())) in  
  let tyMap = TyMap.add tyMap (TyD.Ty_alpha (Tyvar.fromString "int")) ( Z3E.Int (Z3E.mk_int_sort ())) in


  let addTyD tyMap tyd = 
    let sortToUninterpretedSort = 
      fun sort -> 
        (let tyMap = TyMap.add tyMap tyd sort in  
         (tyMap, sort) )
    in 
    let tyName = Z3E.genTypeName () in        
    sortToUninterpretedSort (Z3E.T (tyName, Z3E.mk_uninterpreted_s (tyName))) 

  in 


       (*
       * bootStrapBools for constMap
       *)
  let constMap = ConstMap.empty  in 

  let constMap = ConstMap.add constMap "true" Z3E.const_true in 
  let constMap = ConstMap.add constMap "false" Z3E.const_false in 
  (*add h and h' as heap variable*)


  let getConstForVar constMap v = (
    fun vstr -> 
      try 
        ConstMap.find constMap vstr
      with 
      |Not_found  -> raise (ConstMap.ConstNotFound vstr)) (Var.toString v) in 

  let relMap = RelMap.empty in 

  let getStrucRelForRelId relMap rid = (fun ridstr ->  
      try
        RelMap.find relMap ridstr 
      with
      |Not_found  -> raise (RelMap.RelNotFound ("Rel "^ridstr^" undeclared despite processing tydbinds")) 

    ) 
      (RI.toString rid)
  in     

  let lookupRelId relMap rid = (
    fun rstr -> 
      try 
        RelMap.find  relMap rstr 
      with 
      | Not_found -> raise (RelMap.RelNotFound ("Rel "^rstr^" undeclared despite processing tydbinds"))

  ) (RI.toString rid)
  in 

  let getSRCodomainSort relMap rid  : (Z3E.sort) = 

    let sr = 
      try
        RelMap.find relMap (RI.toString rid)
      with    
      | RelMap.RelNotFound _ -> 

        raise (RelMap.RelNotFound ("Rel "^(RI.toString rid)^" undeclared despite processing tydbinds"))
    in 

    ( match sr with 
      | Z3E.SR {ty;_} -> 
        (*The codomain for the relation is the last sort of the type list for relation*) 
        let codomain_sort = List.hd (List.rev ty) in 
        codomain_sort 
      | Z3E.MSR {mty;_} -> 
        let codomain_sort = List.hd (List.rev mty) in 
        codomain_sort)
  in 



    (*
       * Encoding functions
       * encodeConst and encodeStrucRel rely on uniqueness of 
       * bindings in tydbinds. In case of duplicate bindings,
       * duplication declarations show up in Z3 VC, but most
       * recent binding is used.
       *)

  let encodeTyD (tyMap, constMap, relMap) tyD  = 
    try 
      let () = Printf.printf "%s" ("encodeTyD "^TyD.toString tyD) in 
      (tyMap, constMap, relMap, (TyMap.find tyMap tyD))  
    with 
    | TyMap.TyDNotFound _ -> 
      let () = Printf.printf "%s" ("@@@@@"^(TyD.toString tyD)) in 

      let sortfortyD = (match tyD with 
            TyD.Ty_alpha _ ->  addTyD tyMap tyD 
          | _ -> addTyD tyMap tyD  

         (* failwith "Unexpected type" *))

      in
      (*add to the tyMap*)
      let tyMap = TyMap.add tyMap tyD (snd (sortfortyD)) in 
      (tyMap, constMap, relMap, (snd (sortfortyD))) 
  in      

  let encodeConst (tyMap, constMap, relMap) (v,tyd)  = 

    let vstr = Var.toString v in 
    let () = Printf.printf "%s" ("\n encodeConst "^vstr^ "\n ") in 
    let (tyMap, constMap, relMap, sort) = encodeTyD (tyMap, constMap, relMap) tyd in 
    let  const = Z3E.mkConst (vstr,sort) in 
    let constMap = ConstMap.add constMap vstr const
    in
    (tyMap, constMap, relMap, const)
  in 
  (**ERROR, Encode the Length relation as a function like decl_fun rlen ...*)
  let encodeStrucRel (tyMap, constMap, relMap) (rid ,TyD.Ty_arrow (t1,t2))  =
    let open TyD in 
    let  rstr = RI.toString rid in 
    let (tyMap, constMap, relMap,sorts) = 
      let (tyMap, constMap, relMap, sort) = encodeTyD (tyMap,constMap,relMap) t1 in  
      (tyMap, constMap, relMap,Vector.new1 (sort))
    in 
    let (tyMap, constMap, relMap,sorts) = 
      let (tyMap, constMap, relMap, sort) = encodeTyD (tyMap,constMap,relMap) t2 in  
      (tyMap, constMap, relMap, List.append sorts (Vector.new1 (sort)))
    in 

    let  sr = Z3E.mkStrucRel (rstr,  sorts) in

    let relMap = RelMap.add relMap rstr sr
    in
    (tyMap, constMap,relMap, sr)

  in 

  (* ---- Encoding TyD binds and relations ---- *)
  let open TyD in 
  let processTyDBind (tyMap, constMap, relMap) (v,tyd) = 

    let () = Printf.printf "%s" (" \nprocessTyDBind VCE "^(Var.toString v)) in 
    ( match tyd with  
        (*
         * Currently, the only values with function types
         * are structural relations encoded as functions from
         * a let or tuple of vals to bool.
         *)
      |Ty_arrow (t1,t2)   ->
        (match t2 with 
         | Ty_bool ->                       
           let (tyMap, constMap, relMap, sorts) = encodeStrucRel (tyMap, constMap, relMap) (RI.fromString (Var.toString v), tyd) in 
           (tyMap, constMap, relMap)
         | _ -> let (tyMap, constMap, relMap, _) = encodeConst (tyMap, constMap, relMap) (v,tyd) in 
           (tyMap, constMap, relMap) 
        )         
      |_ -> 
        let () = Printf.printf "%s" (" \n processTyDBind consEncoding Case ") in 

        let (tyMap, constMap, relMap, _) = encodeConst (tyMap, constMap, relMap) (v,tyd) in 
        let () = Printf.printf "%s" (" \n processTyDBind consEncoding done ") in 

        (tyMap, constMap, relMap)
    ) 

  in 

  let processTypenames (tyMap, constMap, relMap) tyd = 
    let () = Printf.printf "%s" (" \n processTypenames VCE "^(tyd)) in 
    let  (tyMap, constMap, relMap, sort_quad) = encodeTyD (tyMap, constMap, relMap) (TyD.fromString tyd) in 
    (tyMap, constMap, relMap)


  in

  let processQualifiers (tyMap, constMap, relMap) qual = 
    let () = Printf.printf "%s" (" \n processQualifiers VCE "^(SpecLang.RelSpec.Qualifier.toString qual)) in 
    let SpecLang.RelSpec.Qualifier.Qual {name;shape} = qual in 
    let z3_sorts_for_shape = 
      List.map (fun tyd_i -> 
          (try 
             TyMap.find tyMap tyd_i
           with 
           | TyMap.TyDNotFound _ -> 
             let sortfortyd_i = 
               (match tyd_i with 
                  TyD.Ty_alpha _ ->  addTyD tyMap tyd_i 
                | _ -> addTyD tyMap tyd_i  
               ) 
             in
             snd (sortfortyd_i)
          )

        ) shape
    in              
    if (List.length z3_sorts_for_shape > 2) then 
      let mrel = Z3E.mkMStrucRel (Var.toString name, z3_sorts_for_shape) in 
      let relMap = RelMap.add relMap (Var.toString name) mrel in 
      (tyMap, constMap, relMap)
    else 
    if (List.length z3_sorts_for_shape = 2) then 
      let mrel = Z3E.mkStrucRel (Var.toString name, z3_sorts_for_shape) in 
      let relMap = RelMap.add relMap (Var.toString name) mrel in 
      (tyMap, constMap, relMap)
    else 
      raise (VCEncodingFailed "Qualifier Processing with incorrect number of sorts")  


  in 

  let processPrimEq (tyMap, constMap, relMap) (primR, def) =
    let () = Printf.printf "%s" (" \nprocessPrimEq PrimEq  ") in 

          (*
           * tbinds of VC.t are already processed. So Z3 relation
           * representing primR has been created already.
           *)
    let Z3E.SR {ty;rel} = lookupRelId relMap primR in
    let sorts = ty in 
    let sr = rel in 
    (* 
           * primR is instantiated primitive relation. It has the
           * following form:
           *        primR = λv.rexpr
           * If primR is represented as a relation with sort T0*T1* ..
           * *Tn -> bool, then v has sort T0.
           *)

    let sort =
      try  
        List.nth sorts 0 
      with 
      | _ -> raise (VCEncodingFailed "empty sort list")  
    in 
    let (PR.Nary (v,PR.Nullary rexpr)) = def in 
    let vstr = Var.toString v in 
    let open RelLang in 
    let isBV = fun x -> Var.toString x = vstr in 
    let areBVs = fun els -> Vector.forall (els, 
                                           fun el ->
                                             match el with 
                                               Var x -> isBV x 
                                             | _ -> false) in 
    let areNotBVs = fun els -> Vector.forall (els, 
                                              fun el ->
                                                match el with 
                                                  Var x -> not ( isBV x )
                                                | _ -> true) in 
    let len = Vector.length in 

    let encodeRelElem relel = 
      match relel with   
      | Int i -> Z3E.mkInt i 
      | Bool true -> Z3E.const_true 
      | Bool false -> Z3E.const_false
      | Var v -> 
        try 
          getConstForVar constMap v
        with  
        | ConstMap.ConstNotFound v -> raise (VCEex ("Var "^v^" not found"))(* const_true  *)  
    in 


    let rec encodeQRelExpr  (e:expr) =
      match e with 
        T els -> 
        (match (len els, areBVs els, areNotBVs els) with
           (0,_,_) -> Z3E.mkNullSet ()
         | (_,true,false) -> Z3E.mkQSingletonSet  (Vector.map (els,
                                                               fun _ -> sort) )
         | (_,false,true) -> Z3E.mkSingletonSet (Vector.map (els,
                                                             encodeRelElem))
         | _ -> raise (VCEncodingFailed "In primitive relation definition, each rexpr atom should either contain all bvs or none"))
      | X (e1,e2) -> Z3E.mkCrossPrd (encodeQRelExpr e1, 
                                     encodeQRelExpr e2)
      | U (e1,e2) -> Z3E.mkUnion (encodeQRelExpr e1, 
                                  encodeQRelExpr e2)
      | D (e1,e2) -> Z3E.mkDiff (encodeQRelExpr e1, 
                                 encodeQRelExpr e2)
      | R (RInst {rel=rid; _},x) ->if isBV x 
        then Z3E.mkQStrucRelApp (getStrucRelForRelId relMap rid)
        else Z3E.mkStrucRelApp (getStrucRelForRelId relMap rid, 
                                getConstForVar constMap v) in 
    let rhsSet = encodeQRelExpr rexpr in 
    let lhsSet = Z3E.mkQStrucRelApp (Z3E.SR {ty=ty;rel=rel}) in 
    let eqAssn = Z3E.mkSetEqAssertion (lhsSet,rhsSet)
    in
    let () =  Z3E.dischargeAssertion eqAssn

    in (tyMap, constMap, relMap)

  in   



  (*Adding the sorts from the environment tydbinds and typenames *)
  let () = Printf.printf "%s" (" \n ******processTyDBind starting *****") in 

  let (tyMap, constMap, relMap) = List.fold_left (processTyDBind) (tyMap, constMap, relMap) tydbinds in  

  let () = Printf.printf "%s" (" \n ******Adding Typenames to tyMap*****") in 
  let (tyMap, constMap, relMap) = List.fold_left (processTypenames) (tyMap, constMap, relMap) typenames in 

  let () = Printf.printf "%s" (" \n ******Adding Qualifiers to relMap  *****") in 
  let (tyMap, constMap, relMap) = List.fold_left (processQualifiers) (tyMap, constMap, relMap) qualifiers in 



  (* ---- Type refinement encoding begins ---- *)
  (*encoding for base pred*)
  let rec encodeBasePred (tyMap, constMap, relMap) (bp)  = 

    let () = Printf.printf "%s" (" \n ******encodeBasePred *****") in 

    let
      open BP in 
    let encodeBaseExpr bexp = 
      let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp " in 

      match bexp with  
        (Int i) -> 
        let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp Int " in 
        let i_const = Z3E.mkInt i in 
        let (i_const_exp, iconst_sort) = Z3E.ast_expr_sort_pair i_const in 
        let i_const_eq_i = Z3E.mk_Integer_eq (i_const_exp, Z3E.mk_Numeric_constant i) in
        let _ = Z3E.dischargeAssertion  i_const_eq_i in 
        i_const

      (* mkConst(string_of_int i, int_sort) *)
      | Bool true -> 
        let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp BoolT " in 

        Z3E.const_true 
      | Bool false -> 
        let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp BoolF" in 

        Z3E.const_false
      | Var v -> 
        let () = Printf.printf "%s " ("\n $$$$$$$$$$$$$$$$$-encdode BaseExp Var %%%%%%%%%%%%%%%%%%%%%%"^(Ident.name v)) in 
        getConstForVar constMap v
      | Str s ->
        let () = Printf.printf "%s " ("\n $$$$$$$$$$$$$$$$$-encdode BaseExp Str "^(s)) in 
        let s_const = Z3E.mkStr s in 
        s_const
    in
    let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$" in 
    match bp with
      Eq (e1,e2) -> 
      let () = Printf.printf "%s " ("\n $$$$$$$$$$$$$$$$$ BasePredicate Eq  "^(BP.toString bp)^" \n ") in 
      Z3E.mkConstEqAssertion (encodeBaseExpr e1, encodeBaseExpr e2)
    | Iff (bp1,bp2) -> 
      let () = Printf.printf "%s "  ("\n $$$$$$$$$$$$$$$$$ BasePredicate Iff  "^ (BP.toString bp)^" \n ") in 

      Z3E.mkIff ( (encodeBasePred (tyMap, constMap, relMap) bp1),
                  (encodeBasePred (tyMap, constMap, relMap) bp2))
    | Gt (e1, e2) -> 
      Z3E.mkConstGtAssertion (encodeBaseExpr e1, encodeBaseExpr e2)
      (* raise (Unimplemented "encodeBasePred Gt case is missing")  *)
  in 
  (*encoding for r*)        
  let rec encodeRelExpr (tyMap, constMap, relMap) (e) =

    let () = Printf.printf "%s" (" \n ******encodeRelExpr *****") in 
    let () = Printf.printf "%s "  ("\n RelExp  "^ (RelLang.exprToString e)^" \n ") in 

    let open RelLang in 
    let encodeRelElem (tyMap, constMap, relMap) = fun x -> 
      let () = Printf.printf "%s" (" \n ******encodeRelElem  *****") in 

      match x with 
      | (Int i) -> Z3E.mkInt i 
      | Bool true -> Z3E.const_true 
      | Bool false -> Z3E.const_false
      | Var v -> getConstForVar constMap v
    in
    let () = Printf.printf "%s" (" \n ******encodeRelExpr here *****") in 

    match e with 
      V elm -> 
      let () = Printf.printf "%s" (" \n ******encodeRelExpr T *****") in 
      Z3E.mkSingletonSet( [encodeRelElem (tyMap, constMap, relMap) elm])

    |T els -> 
      let () = Printf.printf "%s" (" \n ******encodeRelExpr T *****") in 
      (match Vector.length els with 
         0 -> Z3E.mkNullSet ()
       | _ -> Z3E.mkSingletonSet(Vector.map (els,(encodeRelElem (tyMap, constMap, relMap)))))
    | X (e1,e2) -> 
      let () = Printf.printf "%s" (" \n ******encodeRelExpr X *****") in 

      Z3E.mkCrossPrd ( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                       (encodeRelExpr (tyMap, constMap, relMap) e2))
    | U (e1,e2) -> 
      let () = Printf.printf "%s" (" \n ******encodeRelExpr U *****") in 

      Z3E.mkUnion ( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                    (encodeRelExpr (tyMap, constMap, relMap) e2))
    | D (e1,e2) -> 
      let () = Printf.printf "%s" (" \n ******encodeRelExpr D *****") in 

      Z3E.mkDiff ( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                   (encodeRelExpr (tyMap, constMap, relMap) e2))
    | ADD (e1, e2) ->
      let () = Printf.printf "%s" (" \n ******encodeRelExpr ADD *****") in 

      Z3E.mkAddition ( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                       (encodeRelExpr (tyMap, constMap, relMap) e2)) 
    | SUBS (e1, e2) ->
      let () = Printf.printf "%s" (" \n ******encodeRelExpr SUBS *****") in 
      Z3E.mkSubstraction( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                          (encodeRelExpr (tyMap, constMap, relMap) e2)) 

    | R (RInst {rel=rid;_},v) -> 
      let () = Printf.printf "%s" (" \n ******encodeRelExpr R *****") in 

      let srforR = getStrucRelForRelId relMap rid in 
      let Z3E.SR{ty;rel} = srforR in 
      let list_layout_ty = List.map (fun sor-> Z3E.sort_layout sor) ty in 
      let str_ty  = (List.fold_left (fun acc l -> acc^(Layout.toString l) ) "{ " list_layout_ty)^" }" in 

      let ()  = Printf.printf "%s" ("Type "^str_ty) in 
      let const = getConstForVar constMap v in 
      let out = Z3E.mkStrucRelApp (
          (getStrucRelForRelId relMap rid), (getConstForVar constMap v)) in 
      out 
    | MultiR (RInst {rel=rid;_}, args) -> 

      let ()  = Printf.printf "%s" ("\n *******encodeRelExpr MultiR******** ") in 
      let srforR = getStrucRelForRelId relMap rid in 
      let Z3E.MSR{mty;mrel} = srforR in 
      let str_ty  = (List.fold_left (fun acc s -> acc^(Z3E.sortToString s)^" :-> " ) "{" mty )^" }" in 

      let ()  = Printf.printf "%s" ("Type "^str_ty) in 


      let argument_list = List.map (fun v -> getConstForVar constMap v) args in 
      let arg_exp_sort_list = List.map (fun argument -> Z3E.ast_expr_sort_pair argument) argument_list in 
      let  arg_sort_list = List.map (fun (_, s) -> Z3E.sortToZ3Sort s) arg_exp_sort_list in  
      let arg_exp_list = List.map (fun (v,_ ) -> v) arg_exp_sort_list in  
      let cosnt_for_arg_list = List.map (fun v -> getConstForVar constMap v) args in               

      let ()  = Printf.printf "%s" ("arguments "^(List.fold_left (fun acca (arg_exp)-> (acca^", "^Z3.Expr.to_string arg_exp)) "Arg Exps " arg_exp_list )) in 
      let ()  = Printf.printf "%s" ("arguments Sorts "^(List.fold_left(fun accs s -> (accs^", "^Z3.Sort.to_string s) ) "Arg Sorts " arg_sort_list)) in 
      (*We need to create a set by application*) 
      let ufApp = Z3E.mkMStrucRelApp  (srforR, cosnt_for_arg_list) in 
      let ()  = Printf.printf "%s" ("Uninterpreted Function App Encoding Done ") in
      ufApp


  in 

  (*encoding for rn*)
  let rec encodeNumericExpr (tyMap, constMap, relMap) (e) = 
    let () = Printf.printf "%s" (" \n ******encodeNumericExpr *****") in 
    let open RelLang in 
    let encodeNumericElem (tyMap, constMap, relMap) = fun x -> 
      match x with 
      | (Int i) -> 
        let () = Printf.printf "%s" "\n Encoding Numeric Elem \n " in 
        let res = Z3E.mk_Numeric_constant i in 
        let () = Printf.printf "%s" "\n Encoding Numeric Elem Success \n " in 
        res
      | Bool true -> raise (VCEex ("Incorrect argument to a numeric expression "^(RelLang.exprToString e) ))
      | Bool false -> raise (VCEex ("Incorrect argument to a numeric expression "^(RelLang.exprToString e) ))
      | Var v -> 
        let () = Printf.printf "%s" "\n Encoding Numeric Elem Var Case \n " in 
        let () = Printf.printf "%s" ("\n "^(Ident.name v)) in 
        let astforconst = getConstForVar constMap v in 
        let (ast_exp, ast_sort) = Z3E.ast_expr_sort_pair astforconst in 
        ast_exp 


    in
    match e with 
    |  V elm -> encodeNumericElem (tyMap, constMap, relMap) elm       
    |T els -> 
      (* If expression is a tuple then it must be a Singleton of type int*) 
      let () = Printf.printf "%s" (" \n ******encodeNumericExpr T *****") in 
      (
        match Vector.length els with 
          0 -> raise (VCEex ("Incorrect numeric expression "^(RelLang.exprToString e) )) 
        | 1 -> let numericValue = encodeNumericElem (tyMap, constMap, relMap) (List.hd els) in 
          numericValue
        | _ -> raise (VCEex ("Incorrect number of numeric arguments "^(RelLang.exprToString e) ))
      )
    | ADD (e1, e2) ->
      Z3E.mk_Integer_addition ( (encodeNumericExpr (tyMap, constMap, relMap) e1), 
                                (encodeNumericExpr (tyMap, constMap, relMap) e2)) 

    | SUBS (e1, e2) ->
      Z3E.mk_Integer_substraction ( (encodeNumericExpr (tyMap, constMap, relMap) e1), 
                                    (encodeNumericExpr (tyMap, constMap, relMap) e2)) 

    (*For Single argument relations, define a Uninterpreted function *) 
    | R (RInst {rel=rid;_},v) -> 
      let () = Printf.printf "%s" (" \n ******encodeNumericExpr R *****") in 
      (*get the function for the numeric relation if present, else add the function to tthe relMap
        create the function application*)
      let srforR = getStrucRelForRelId relMap rid in 
      let Z3E.SR{ty;rel} = srforR in 
      let list_layout_ty = List.map (fun sor-> Z3E.sort_layout sor) ty in 
      let str_ty  = (List.fold_left (fun acc l -> acc^(Layout.toString l) ) "{" list_layout_ty)^" }" in 

      let ()  = Printf.printf "%s" ("Type "^str_ty) in 
      let () = Printf.printf "%s" ("argument Name"^(Ident.name v)) in 

      let argument = getConstForVar constMap v in 
      let astLayout = Z3E.ast_layout argument in 
      let (arg_exp, arg_sort) = Z3E.ast_expr_sort_pair argument in 


      let reln_required_arg_sort = Z3E.sortToZ3Sort arg_sort in 
      let ()  = Printf.printf "%s" ("argument Sort "^(Z3.Sort.to_string reln_required_arg_sort)) in 


      let relate = Z3E.mk_Integer_func_decl (RelId.toString rid, [reln_required_arg_sort], (Z3E.mk_int_sort())) in 
      let ()  = Printf.printf "%s" ("relation "^(FuncDecl.to_string relate)) in 

      let ()  = Printf.printf "%s" ("arguments "^(Z3E.Expr.to_string arg_exp)) in 
      let ()  = Printf.printf "%s" ("argument Sort "^(Z3.Sort.to_string reln_required_arg_sort)) in 

      let relApp = Z3E.mk_Integer_rel_app  (relate, [arg_exp]) in 
      let ()  = Printf.printf "%s" ("relation App Done ") in
      relApp 
    (*Define a multi argument Uninterpreted function *) 
    | MultiR (RInst {rel=rid;_}, args) -> 
      let ()  = Printf.printf "%s" ("\n *******encodeNumericExpr MultiR******** "^(RelId.toString rid)) in 
      let srforR = getStrucRelForRelId relMap rid in 
      let Z3E.MSR{mty;mrel} = srforR in 
      let str_ty  = (List.fold_left (fun acc s -> acc^(Z3E.sortToString s)^" :-> " ) "{" mty )^" }" in 

      let ()  = Printf.printf "%s" ("Type "^str_ty) in 


      let argument_list = List.map (fun v -> getConstForVar constMap v) args in 
      let arg_exp_sort_list = List.map (fun argument -> Z3E.ast_expr_sort_pair argument) argument_list in 
      let  arg_sort_list = List.map (fun (_, s) -> Z3E.sortToZ3Sort s) arg_exp_sort_list in  
      let arg_exp_list = List.map (fun (v,_ ) -> v) arg_exp_sort_list in  

      let uf = Z3E.mk_Integer_func_decl (RelId.toString rid, arg_sort_list, (Z3E.mk_int_sort())) in 
      let ()  = Printf.printf "%s" ("uf "^(FuncDecl.to_string uf)) in 
      let ()  = Printf.printf "%s" ("arguments "^(List.fold_left (fun acca (arg_exp)-> (acca^", "^Z3.Expr.to_string arg_exp)) "Arg Exps " arg_exp_list )) in 
      let ()  = Printf.printf "%s" ("arguments Sorts "^(List.fold_left(fun accs s -> (accs^", "^Z3.Sort.to_string s) ) "Arg Sorts " arg_sort_list)) in 

      let ufApp = Z3E.mk_Integer_rel_app  (uf, arg_exp_list) in 
      let ()  = Printf.printf "%s" ("Uninterpreted Function App Encoding Done ") in
      ufApp




    | _ ->  raise (VCEex ("Incorrect numeric expression "^(RelLang.exprToString e) ))



  in
  (*encoding for rn > rn*)  
  let encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2) = 
    let () = Printf.printf "%s" (" \n ******encodeNumericGrtAssertion *****") in 
    let encoding_lhs =  encodeNumericExpr (tyMap, constMap, relMap) e1 in 
    let () = Printf.printf "%s" (" \n ******encodeNumericGrtAssertion LHS done *****") in 
    let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion RHS  *****") in 
    let encoding_rhs = encodeNumericExpr (tyMap, constMap, relMap) e2 in 
    let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion RHS done *****") in 
    let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion creating EQ  *****") in 
    let gt_assertion = Z3E.mk_Integer_gt (encoding_lhs,  encoding_rhs) in 
    let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion creating EQ  DONE*****") in 

    gt_assertion

  in

  (*Encoding of rn == rn*)
  let encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2) = 
    let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion *****") in 

    let encoding_lhs =  encodeNumericExpr (tyMap, constMap, relMap) e1 in 
    let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion LHS done *****") in 

    let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion RHS  *****") in 

    let encoding_rhs = encodeNumericExpr (tyMap, constMap, relMap) e2 in 
    let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion RHS done *****") in 


    let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion creating EQ  *****") in 

    let eq_assertion = Z3E.mk_Integer_eq (encoding_lhs,  encoding_rhs) in 
    let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion creating EQ  DONE*****") in 

    eq_assertion

  in
  let encodeRelPred (tyMap, constMap, relMap) (rp:RP.t)  =
    let () = Printf.printf "%s" (" \n ******encodeRelPred  *****"^(RP.toString rp)) in 
    let  open RelLang in 
    let f = (encodeRelExpr (tyMap, constMap, relMap)) in 
    let  open RP in 

    match  rp with 
    | NEq (e1, e2) -> 
      (match (e1, e2) with 
         (_, ADD (_,_)) 
       | (ADD (_,_), _)  
       | (_, SUBS(_,_))
       | (SUBS(_,_), _)->    
         let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION SUBS "^(RelLang.exprToString (e1) )^" = "^(RelLang.exprToString (e2) ) ) in  
         encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)


       (*for R and MultiR*)
       |(R (rie1, id1) as r1, R (rie2, id2) as r2 ) ->

         let () = Printf.printf "%s" ("\n Case :: Both Rel Exp ") in  

         let RInst {rel;_} = rie1 in
         let relId1 = RelId.toString rel in 

         let RInst {rel;_} = rie2 in
         let relId2 = RelId.toString rel in 


         let codomainsort_r1 = getSRCodomainSort relMap relId1 in  
         let codomainsort_r2 = getSRCodomainSort relMap relId2 in 

         (match (codomainsort_r1, codomainsort_r2) with 
            ( Int s1, Int s2) -> 
            encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)

          | (_, _)  -> 

            raise (IncorrectRelSort ("Numeric Expression with non numeric arguments in "^(relId1)^" OR "^(relId2)))
         )

       |(R (rie, id), _) ->
         let RInst {rel;_} = rie in
         let relId = RelId.toString rel in 
         let codomainsort_r = getSRCodomainSort relMap relId in 

         (match (codomainsort_r) with 
            ( Int s1) -> 
            encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
          | _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
         )


       | (_, R (rie, id))  ->               
         let RInst {rel;_} = rie in 
         let relId = RelId.toString rel in 
         let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 2"^relId) in 
         let codomainsort_r = getSRCodomainSort relMap relId in 

         (match (codomainsort_r) with 
            ( Int s1) -> 
            encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
          | _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
         )
       (*If either of the lhs or rhs is a MR then we can simple create equality expression*)
       | (MultiR (rie1, idl1) as r1, MultiR (rie2, idl2) as r2 ) ->

         let () = Printf.printf "%s" ("\n Case :: Both Rel Exp ") in  

         let RInst {rel;_} = rie1 in
         let relId1 = RelId.toString rel in 

         let RInst {rel;_} = rie2 in
         let relId2 = RelId.toString rel in 


         let codomainsort_r1 = getSRCodomainSort relMap relId1 in  
         let codomainsort_r2 = getSRCodomainSort relMap relId2 in 

         (match (codomainsort_r1, codomainsort_r2) with 
            ( Int s1, Int s2) -> 
            encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
          | (s1, s2)  -> 
            if (not (Z3E.same_sort s1 s2)) then 
              raise (IncorrectRelSort ("MultiR case Numeric Expression with non numeric arguments in "^(relId1)^" OR "^(relId2)))
            else
              Z3E.mkEqAssertion  (f e1, f e2)
         )

       |(MultiR (rie, id), _) ->
         let () = Printf.printf "%s" ("\n Case NEq (MR , Other) ") in 
         let RInst {rel;_} = rie in
         let relId = RelId.toString rel in 
         let codomainsort_r = getSRCodomainSort relMap relId in 

         (match (codomainsort_r) with 
            ( Int s1) -> 
            encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
          | _  -> 

            Z3E.mkEqAssertion (f e1, f e2)

         )


       | (_, MultiR (rie, id))  ->               
         let RInst {rel;_} = rie in 
         let relId = RelId.toString rel in 
         let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 2"^relId) in 
         let codomainsort_r = getSRCodomainSort relMap relId in 

         (match (codomainsort_r) with 
            ( Int s1) -> 
            encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
          |  _  -> 

            Z3E.mkEqAssertion  (f e1, f e2)

         )

       (*Incorrect case*) 
       | (_, _) ->  raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")


      )


    |Eq (e1,e2) -> (*if either of e1 or e2 is an arithmatic relation like rlen, then make arithmeticEqAssertion*)
      (match (e1, e2) with 

       |(R (rie1, id1) as r1, R (rie2, id2) as r2 ) ->
         Z3E.mkSetEqAssertion (f e1, f e2)       
       |(R (rie, id), _) ->
         Z3E.mkSetEqAssertion (f e1, f e2)    
       | (_, R (rie, id))  ->               
         Z3E.mkSetEqAssertion (f e1, f e2)    
       (*Case singleton set expression*)

       | (_,_) -> 
         let () = Printf.printf "%s" ("\n RELATIONAL EXPRESSION CASE "^(RelLang.exprToString ( e1) )^" = "^(RelLang.exprToString (e2) )) in 
         Z3E.mkSetEqAssertion (f e1, f e2)
      )      
    |Grt ( e1, e2) -> 
      (match (e1, e2) with 
       | (*simplest case*) (T el1, T el2)  -> 
         encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2) 

       | (_, ADD (_,_)) 
       | (ADD (_,_), _)  
       | (_, SUBS(_,_))
       | (SUBS(_,_), _)->    

         let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION SUBS "^(RelLang.exprToString (e1) )^" = "^(RelLang.exprToString (e2) ) ) in  
         encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)



       (*for R and MultiR*)
       |(R (rie1, id1) as r1, R (rie2, id2) as r2 ) ->

         let () = Printf.printf "%s" ("\n Case :: Both Rel Exp ") in  

         let RInst {rel;_} = rie1 in
         let relId1 = RelId.toString rel in 

         let RInst {rel;_} = rie2 in
         let relId2 = RelId.toString rel in 


         let codomainsort_r1 = getSRCodomainSort relMap relId1 in  
         let codomainsort_r2 = getSRCodomainSort relMap relId2 in 

         (match (codomainsort_r1, codomainsort_r2) with 
            ( Int s1, Int s2) -> 
            encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
          | _  -> raise (IncorrectRelSort ("Numeric Expression with non numeric arguments in "^(relId1)^" OR "^(relId2))) 
         )

       |(R (rie, id), _) ->
         let RInst {rel;_} = rie in
         let relId = RelId.toString rel in 
         let codomainsort_r = getSRCodomainSort relMap relId in 

         (match (codomainsort_r) with 
            ( Int s1) -> 
            encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
          |  _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
         )


       | (_, R (rie, id))  ->               
         let RInst {rel;_} = rie in 
         let relId = RelId.toString rel in 
         let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 2"^relId) in 
         let codomainsort_r = getSRCodomainSort relMap relId in 

         (match (codomainsort_r) with 
            ( Int s1) -> 
            encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
          | _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
         )

       | (MultiR (rie1, idl1) as r1, MultiR (rie2, idl2) as r2 ) ->

         let () = Printf.printf "%s" ("\n Case :: Both Rel Exp ") in  

         let RInst {rel;_} = rie1 in
         let relId1 = RelId.toString rel in 

         let RInst {rel;_} = rie2 in
         let relId2 = RelId.toString rel in 


         let codomainsort_r1 = getSRCodomainSort relMap relId1 in  
         let codomainsort_r2 = getSRCodomainSort relMap relId2 in 

         (match (codomainsort_r1, codomainsort_r2) with 
            ( Int s1, Int s2) -> 
            encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
          | (_, _)  -> raise (IncorrectRelSort "Numeric Expression with non numeric arguments")
         )

       |(MultiR (rie, id), _) ->
         let () = Printf.printf "%s" ("encode RelPredicate Grt (MR , Other)") in   
         let RInst {rel;_} = rie in
         let relId = RelId.toString rel in 
         let codomainsort_r = getSRCodomainSort relMap relId in 
         let () = Printf.printf "%s" (">>>>") in 
         (match (codomainsort_r) with 
            ( Int s1) -> 
            encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
          |  _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
         )


       | (_, MultiR (rie, id))  ->               
         let RInst {rel;_} = rie in 
         let relId = RelId.toString rel in 
         let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 2"^relId) in 
         let codomainsort_r = getSRCodomainSort relMap relId in 

         (match (codomainsort_r) with 
            ( Int s1) -> 
            encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
          |  _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
         )


       (*Case singleton set expression*)
       | (T el1, T el2) ->
         let () = Printf.printf "%s" ("\n singleton Set Eq CASE "^(RelLang.exprToString ( e1) )^" = "^(RelLang.exprToString (e2) )) in 
         encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
       | (_, _) ->  raise (IncorrectRelSort "Numeric Expression Grt (e1, e2) with non-numeric arguments")



      )

    | Sub (e1,e2) -> Z3E.mkSubSetAssertion (f e1, f e2)
    | SubEq (e1,e2) -> (fun s -> Z3E.mkOr( Vector.new2 (Z3E.mkSetEqAssertion s,
                                                        Z3E.mkSubSetAssertion s))) (f e1, f e2)
    (*TODO We need to generate Z3 for Grt *)                     
  in 

  let encodeSimplePred (tyMap, constMap, relMap) (sp ) =

    let () = Printf.printf "%s" (" \n ******encodeSimplePred *****") in 

    match  sp with  
      (VC.Base bp) -> encodeBasePred (tyMap, constMap, relMap) bp
    | (VC.Rel rp) -> encodeRelPred (tyMap, constMap, relMap) rp  
    | VC.True -> Z3E.mk_true () 
    | VC.False -> Z3E.mk_false () 
  in    
  let assertSimplePred  (tyMap, constMap, relMap) = Z3E.dischargeAssertion << encodeSimplePred (tyMap, constMap, relMap) in 

  let rec encodeVCPred (tyMap, constMap, relMap) vcp = 
    (*TODO We are working directly on the Predicate*)
    let () = Printf.printf "%s" (" \n ******encodeVCPred *****") in 

    match vcp with 

      VC.Simple sp -> encodeSimplePred (tyMap, constMap, relMap) sp
    | VC.Conj vcps -> Z3E.mkAnd (Vector.map (vcps, (encodeVCPred (tyMap, constMap, relMap)) ))
    | VC.Disj vcps -> Z3E.mkOr (Vector.map (vcps, (encodeVCPred (tyMap, constMap, relMap)  )))
    | VC.Not vcp -> Z3E.mkNot (encodeVCPred (tyMap, constMap, relMap) vcp)
    | VC.If (vcp1,vcp2) -> Z3E.mkIf ((encodeVCPred (tyMap, constMap, relMap) vcp1), 
                                     (encodeVCPred (tyMap, constMap, relMap) vcp2))
    | VC.Iff (vcp1,vcp2) -> Z3E.mkIff ((encodeVCPred (tyMap, constMap, relMap) vcp1), 
                                       (encodeVCPred (tyMap, constMap, relMap) vcp2)) in 



   (* example encoding 
      (∀x: sub(x,x))
      (∀x,y,z: sub(x,y)∧sub(y,z) → sub(x,z))
      (∀x,y: sub(x,y)∧sub(y,x) → x = y)
      (∀x,y,z: sub(x,y)∧sub(x,z) → sub(y,z)∨sub(z,y))
      (∀x,y: sub(x,y) → sub(List(x),List(y)))

      ** These declrations will already be in the context**
      (declare-sort Type)
      (declare-fun subtype (Type Type) Bool)
      (delcare-fun List (Type) Type)

      ** we need to encode following assertions **
      (assert (forall (x Type) (subtype x x)))
      
      (assert (forall (x Type) (y Type) (z type)
        (=> (and (subtype x y) (subtype y z))
            (subtype x z))))

      (assert (forall (x Type) (y Type)
        (=> (and (subtype x y) (subtype y x))
        (= x y))))

      (assert (forall (x Type) (y Type) (z type)
      (=> (and (subtype x y) (subtype x z)) 
          (or (subtype y z) (subtype z y)))))

      (assert (forall (x Type) (y Type)
      (=> (subtype x y)
      (subtype (List x) (List y)))))


       *)

  let rec encodeQuantifiedPred (tyMap, constMap, relMap) bindings vcp = 
        (*TODO We are working directly on the Predicate*)
    let _ = Printf.printf "%s" ("\n VCE :: encodeQunatifiedPred *******") in

    let (tyMap, constMap, relMap,  binding_ast_list) = 
        List.fold_left 
            (fun (tyMap, constMap, relMap, const_ast_list) (v_i, tyd_i) -> 
                  let (tyMap, constMap, relMap, const_ast_i ) = 
                      encodeConst (tyMap, constMap, relMap) (v_i,tyd_i) in
                  (tyMap, constMap, relMap, (const_ast_i :: const_ast_list))
      
            ) (tyMap, constMap, relMap, []) bindings in 

             
    let body_assertion = encodeVCPred (tyMap, constMap, relMap) vcp in 

    Z3E.mkUAssertion (binding_ast_list, body_assertion) in 


     



let rec assertVCPred  (tyMap, constMap, relMap) vcp = 
      let () = Printf.printf "%s" (" \n ******assertVCPred *****") in 
      match vcp with 
        VC.Simple sp -> assertSimplePred (tyMap, constMap, relMap) sp
      | VC.Conj spv -> List.iter (assertVCPred (tyMap, constMap, relMap)) spv
      | _ -> Z3E.dischargeAssertion (encodeVCPred (tyMap, constMap, relMap) vcp) in 
  


let rec encodeQVCPred  (tyMap, constMap, relMap) qvcp = 
    let () = Printf.printf "%s" (" \n  Q VCE :: assert QVCPred *****") in 

       match qvcp with 
          VC.Qf vcp -> encodeVCPred  (tyMap, constMap, relMap) vcp  
        | VC.Q (bindings, vcp) -> 
          encodeQuantifiedPred (tyMap, constMap, relMap) bindings vcp 

in   


let rec assertQVCPred  (tyMap, constMap, relMap) qvcp = 
    let () = Printf.printf "%s" (" \n  Q VCE :: assert QVCPred *****") in 

       match qvcp with 
          VC.Qf vcp -> assertVCPred  (tyMap, constMap, relMap) vcp  
        | VC.Q (bindings, vcp) -> 
          (*
          FIXME 
              dischargeAssertion <<  cencodeQunatifiedPred 
          *)
          Z3E.dischargeAssertion (encodeQuantifiedPred (tyMap, constMap, relMap) bindings vcp) 

in   



(*main entry*) 
let _ = assertQVCPred (tyMap, constMap, relMap) anteP in 
      (*
       * We check the SAT of ¬conseqP
       *)

let _ = Z3E.dischargeAssertion (Z3E.mkNot (encodeQVCPred (tyMap, constMap, relMap) conseqP)) in 


let solverDischarged = Z3E.getSolver () in   
let logf = Z3.Log.open_ "z3log.log" in 


let expressions_list = Solver.get_assertions solverDischarged  in   

let () = Printf.originalPrint "%s" ("\n# of Final Z3 expressions "^(string_of_int (List.length expressions_list))) in   
(* let () = Printf.originalPrint "%s" ("\n Final solver \n "^(Solver.to_string solverDischarged)) in    *)

(* let () = Printf.originalPrint "%s" ("\n Stat solver \n "^(Statistics.to_string (Solver.get_statistics solverDischarged))) in 
   let () = Printf.originalPrint "%s" ("\n PARAM  \n "^(Z3.Params.ParamDescrs.to_string pdesc )) in  *)

let z3_channel = open_out "z3query.z" in
let qnstring = string_of_int !query_number in 
let _ = query_number := !query_number + 1 in 
Printf.fprintf z3_channel "%s\n" (";; "^(qnstring)^"\n"^(Solver.to_string solverDischarged)^"\n (check-sat)");
(* write something *)
close_out z3_channel;
(* let _ = run_command  "z3 testz3.z" "" in  *)

let outbuf = syscall  "z3 -T:50 z3query.z" in 

let () = Printf.originalPrint "%s" ("\n OutBuf:"^outbuf^":"^outbuf) in   
let res = 
  if (String.equal outbuf "unsat\n") then 
    Solver.UNSATISFIABLE
  else if (String.equal outbuf "sat\n") then 
    Solver.SATISFIABLE 
  else if (String.equal outbuf "unknown\n" || String.equal outbuf "timeout\n") then 
    Solver.UNKNOWN
  else 
    raise (VCEex "SOLVER RETURNED AN ILLEGAL VALUE")
in      


(* let res = Solver.check solverDischarged [] in 
   let _ = Z3.Log.append (Solver.to_string solverDischarged) in
   let _ =  Z3.Log.close () in *)

let () = Printf.originalPrint "%s" ("\n $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$") in   

let _ = Solver.reset solverDischarged in 



match  res with 
| SATISFIABLE -> 
  let () = Printf.originalPrint "%s" ("\n $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$") in   
  Failure
| UNSATISFIABLE -> 
  let () = Printf.originalPrint "%s" ("\n $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$") in   
  Success
| UNKNOWN ->
  let () = Printf.originalPrint "%s" ("\n $$$$$$$$$$$$$ Timeout SMT $$$$$$$$$$$$$$") in   
  Undef 




