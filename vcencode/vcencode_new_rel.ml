open TransTypeChecker
open SpecLang 
open Z3_encode

exception SolverTimeout
exception Unimplemented of string 
exception IncorrectRelSort of string     
module TyD = TyD

  module RI = RelId
  module BP = Predicate.BasePredicate
  module RP = Predicate.RelPredicate
  module PR = PrimitiveRelation
  module VC = VerificationC
  type result = Success | Undef | Failure
 
  module FuncDecl = Z3.FuncDecl 
  module Solver = Z3.Solver 

  
  exception VCEncodingFailed of string 
  exception VCEex of string 

let ignore = fun _ -> ()

let z3_log = Z3_encode.logz3

 
module Printf = struct 
  let printf  = Printf.printf 
  let originalPrint = Printf.printf 


end  
 



let discharge (VC.T (tydbinds, anteP, conseqP) as vc) =

   let ctx = ref @@ Z3_encode.mkDefaultContext ()  in 
  let solver = ref @@ Solver.mk_solver !ctx None in 
  let () = Solver.reset !solver in   

     


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

      
      let tyMap = TyMap.add tyMap (TyD.Ty_int) (Int (Z3_encode.mk_int_sort ())) in 
      let tyMap = TyMap.add tyMap (TyD.Ty_bool) (Bool (Z3_encode.mk_bool_sort ())) in 
      let tyMap = TyMap.add tyMap (TyD.Ty_alpha (Tyvar.fromString "int")) ( Int (Z3_encode.mk_int_sort ())) in 
      

      let addTyD tyMap tyd = 
                let sortToUninterpretedSort = 
                   fun sort -> 
                       (let tyMap = TyMap.add tyMap tyd sort in  
                            (tyMap, sort) )
                      in 
                  let tyName = Z3_encode.genTypeName () in        
                sortToUninterpretedSort (T (tyName, Z3_encode.mk_uninterpreted_s (tyName))) in 
      
      
       (*
       * bootStrapBools for constMap
       *)
      let constMap = ConstMap.empty  in 

      let constMap = ConstMap.add constMap "true" const_true in 
      let constMap = ConstMap.add constMap "false" const_false in 
      
        
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
    (*
       * Encoding functions
       * encodeConst and encodeStrucRel rely on uniqueness of 
       * bindings in tydbinds. In case of duplicate bindings,
       * duplication declarations show up in Z3 VC, but most
       * recent binding is used.
       *)

      let encodeTyD (tyMap, constMap, relMap) tyD  = 
        try 
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
      
        let  const = mkConst (vstr,sort) in 
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
                    (tyMap, constMap, relMap,Vector.new1 (sort))
          in 
                      
          let  sr = mkStrucRel (rstr, (List.rev sorts)) in

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
              let () = Printf.printf "%s" (" \nprocessTyDBind consEncoding Case ") in 
          
              let (tyMap, constMap, relMap, _) = encodeConst (tyMap, constMap, relMap) (v,tyd) in 
            let () = Printf.printf "%s" (" \nprocessTyDBind consEncoding done ") in 
          
            (tyMap, constMap, relMap)
          ) 
           
    in 

    
    let processPrimEq (tyMap, constMap, relMap) (primR, def) =
         let () = Printf.printf "%s" (" \nprocessPrimEq PrimEq  ") in 
          
          (*
           * tbinds of VC.t are already processed. So Z3 relation
           * representing primR has been created already.
           *)
          let open Z3_encode in  
          let SR {ty;rel} = lookupRelId relMap primR in
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
            |Int i -> mkInt i 
            | Bool true -> const_true 
            | Bool false -> const_false
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
                (0,_,_) -> mkNullSet ()
              | (_,true,false) -> mkQSingletonSet  (Vector.map (els,
                  fun _ -> sort) )
              | (_,false,true) -> mkSingletonSet (Vector.map (els,
                  encodeRelElem))
              | _ -> raise (VCEncodingFailed "In primitive relation definition, each rexpr atom should either contain all bvs or none"))
            | X (e1,e2) -> mkCrossPrd (encodeQRelExpr e1, 
                encodeQRelExpr e2)
            | U (e1,e2) -> mkUnion (encodeQRelExpr e1, 
                encodeQRelExpr e2)
            | D (e1,e2) -> mkDiff (encodeQRelExpr e1, 
                encodeQRelExpr e2)
            | R (RInst {rel=rid; _},x) ->if isBV x 
              then mkQStrucRelApp (getStrucRelForRelId relMap rid)
              else mkStrucRelApp (getStrucRelForRelId relMap rid, 
                getConstForVar constMap v) in 
          let rhsSet = encodeQRelExpr rexpr in 
          let lhsSet = mkQStrucRelApp (SR {ty=ty;rel=rel}) in 
          let eqAssn = mkSetEqAssertion (lhsSet,rhsSet)
        in
         let () =  dischargeAssertion eqAssn
      
        in (tyMap, constMap, relMap)

      in   

(*   let  processBindEq (tyMap, constMap, relMap) (theR,def) : (TyMap.t* ConstMap.t* RelMap.t) =
          
          let () = Printf.printf "%s" (" Relation "^(RelId.toString theR) ) in 
          let Bind.Def {abs;_} = def in 
          let Bind.Abs (_,Bind.Expr {ground;fr}) = abs in 
          let (groundR, _,_) = ground in 
          let Bind.Fr (_,fre) = fr in 
          let open RelLang in 
          let rec doItFre fre = 
            match fre with 
             X (re1,re2) -> List.concat [doItFre re1; doItFre re2]
            |R (RInst {rel;_},_) -> [rel]
            | _ -> [theR](* raise (VCEncodingFailed "Transformer expression is not cross prd!") *)
          in   
          let paramRs = Vector.fromList (doItFre fre) in  
          
          let doItR = fun rid -> 
          mkQStrucRelApp( 
            getStrucRelForRelId relMap rid) in 
          let gSet = doItR groundR in 
          let pSets = Vector.map (paramRs, doItR) in 
          let frSet = mkQCrossPrd pSets in 
          let bindSet = mkBind (gSet,frSet) in 
          let  theSet = doItR theR 
        in
         let () =  assertBindEq (theSet,bindSet) in 
            (tyMap, constMap, relMap)
     
      in  
  *)    
     (*  let _ = List.iter processTyDBind tydbinds in 
      *) (* pre is rbinds of elaborated VC.t. Maps newRelNames to
         instantiated definitions.*)
    

      (*TODO No Bind or higher order relations for now *)
 (*     let () = Printf.printf "%s" (" \n ******processTyDBind starting *****") in 
             
      let (tyMap, constMap, relMap) = List.fold_left (processTyDBind) (tyMap, constMap, relMap) tydbinds in  
      let () = Printf.printf "%s" (" \n ******** processTyDBind finished ********") in 
   *)   
    
    (*
      let open PRE in 
     (*  let _ = List.iter 
        (fun (r,{def;_}) -> match def with
            PRE.Bind bdef -> processBindEq (r,bdef)
          | PRE.Prim pdef -> processPrimEq (r,pdef)) (PRE.toVector pre)

      *) 
      let (init_tyMap, init_constMap, init_relMap) = (tyMap, constMap, relMap) in    

     let () = Printf.printf "%s" (" \n ******PRE processing starting *****") in 
     
      let (tyMap, constMap, relMap) = 
        List.fold_left (fun (tyMap, constMap, relMap) (r,{def;_}) -> 
              match def with
              PRE.Bind bdef -> processBindEq (tyMap, constMap, relMap) (r,bdef)
            | PRE.Prim pdef -> processPrimEq (tyMap, constMap, relMap) (r,pdef)
          ) (init_tyMap, init_constMap, init_relMap) (PRE.toVector pre)

      in
*)
  let () = Printf.printf "%s" (" \n ******PRE processing finished *****") in 
    
      (* pre is rbinds of elaborated VC.t. Maps newRelNames to
         instantiated definitions.*)
        
   (* ---- Type refinement encoding begins ---- *)

    let rec encodeBasePred (tyMap, constMap, relMap) (bp)  = 
        
      let () = Printf.printf "%s" (" \n ******encodeBasePred *****") in 
    
        let
          open BP in 
          let encodeBaseExpr bexp = 
            let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp " in 
          
            match bexp with  
             (Int i) -> 
              let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp Int " in 
              let i_const = mkInt i in 
              let (i_const_exp, iconst_sort) =ast_expr_sort_pair i_const in 
              let i_const_eq_i = mk_Integer_eq (i_const_exp, mk_Numeric_constant i) in
              let _ = dischargeAssertion  i_const_eq_i in 
              i_const
              
              (* mkConst(string_of_int i, int_sort) *)
            | Bool true -> 
              let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp BoolT " in 
          
                const_true 
            | Bool false -> 
              let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp BoolF" in 
          
              const_false
            | Var v -> 
              let () = Printf.printf "%s " ("\n $$$$$$$$$$$$$$$$$-encdode BaseExp var "^(Ident.name v)) in 
          
            getConstForVar constMap v
        in
          let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$" in 
          match bp with
           Eq (e1,e2) -> 
            let () = Printf.printf "%s " ("\n $$$$$$$$$$$$$$$$$ BasePredicate Eq  "^(BP.toString bp)^" \n ") in 
              mkConstEqAssertion (encodeBaseExpr e1, encodeBaseExpr e2)
           | Iff (bp1,bp2) -> 
              let () = Printf.printf "%s "  ("\n $$$$$$$$$$$$$$$$$ BasePredicate Iff  "^ (BP.toString bp)^" \n ") in 
          
              mkIff ( (encodeBasePred (tyMap, constMap, relMap) bp1),
                (encodeBasePred (tyMap, constMap, relMap) bp2))
           | Gt (e1, e2) -> 
                raise (Unimplemented "encodeBasePred Gt case is missing") 
        in 
        
     let rec encodeRelExpr (tyMap, constMap, relMap) (e) =
    
      let () = Printf.printf "%s" (" \n ******encodeRelExpr *****") in 
      let () = Printf.printf "%s "  ("\n RelExp  "^ (RelLang.exprToString e)^" \n ") in 
    
        let open RelLang in 
        let encodeRelElem (tyMap, constMap, relMap) = fun x -> 
          let () = Printf.printf "%s" (" \n ******encodeRelElem  *****") in 
    
          match x with 
            | (Int i) -> mkInt i 
            | Bool true -> const_true 
            | Bool false -> const_false
            | Var v -> getConstForVar constMap v
        in
          let () = Printf.printf "%s" (" \n ******encodeRelExpr here *****") in 
    
         match e with 
            T els -> 
                let () = Printf.printf "%s" (" \n ******encodeRelExpr T *****") in 
                (match Vector.length els with 
                    0 -> mkNullSet ()
                    | _ -> mkSingletonSet(Vector.map (els,(encodeRelElem (tyMap, constMap, relMap)))))
            | X (e1,e2) -> 
              let () = Printf.printf "%s" (" \n ******encodeRelExpr X *****") in 
      
              mkCrossPrd ( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                (encodeRelExpr (tyMap, constMap, relMap) e2))
            | U (e1,e2) -> 
              let () = Printf.printf "%s" (" \n ******encodeRelExpr U *****") in 
      
                mkUnion ( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                (encodeRelExpr (tyMap, constMap, relMap) e2))
            | D (e1,e2) -> 
              let () = Printf.printf "%s" (" \n ******encodeRelExpr D *****") in 
      
              mkDiff ( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                (encodeRelExpr (tyMap, constMap, relMap) e2))
            | ADD (e1, e2) ->
              let () = Printf.printf "%s" (" \n ******encodeRelExpr ADD *****") in 
               
               mkAddition ( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                (encodeRelExpr (tyMap, constMap, relMap) e2)) 
         (*    | SUBS (e1, e2) ->
              let () = Printf.printf "%s" (" \n ******encodeRelExpr SUBS *****") in 
                let get_numeric_value_of_singleton e =
                  match e with 
                    |   T numels ->
                      (match Vector.length numels with 
                        0 -> mkNullSet ()
                      | _ ->  
                    
                    | _ -> raise (VCEex "Substraction only defined on values and not expressions") 
                 mk_Integer_substraction( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                (encodeRelExpr (tyMap, constMap, relMap) e2)) 

          *)   | R (RInst {rel=rid;_},v) -> 
              let () = Printf.printf "%s" (" \n ******encodeRelExpr R *****") in 
              
              let srforR = getStrucRelForRelId relMap rid in 
              let SR{ty;rel} = srforR in 
               let list_layout_ty = List.map (fun sor-> sort_layout sor) ty in 
               let str_ty  = (List.fold_left (fun acc l -> acc^(Layout.toString l) ) "{" list_layout_ty)^" }" in 

              let ()  = Printf.printf "%s" ("Type "^str_ty) in 
              let const = getConstForVar constMap v in 
              let out = mkStrucRelApp (
                (getStrucRelForRelId relMap rid), (getConstForVar constMap v)) in 
              
              

              let () = Printf.printf "%s" (" \n ******encodeRelExpr made rel exp  *****") in
              out 
            | MultiR (RInst {rel=rid;_}, elemls) -> 
                raise (Unimplemented "encodeRelPred MultiR is missing") 
              
      in 
      
      let rec encodeNumericExpr (tyMap, constMap, relMap) (e) = 
        let () = Printf.printf "%s" (" \n ******encodeNumericExpr *****") in 
        let open RelLang in 
        let encodeNumericElem (tyMap, constMap, relMap) = fun x -> 
          match x with 
            | (Int i) -> 
                    let () = Printf.printf "%s" "\n Encoding Numeric Elem \n " in 
                    let res = mk_Numeric_constant i in 
                    let () = Printf.printf "%s" "\n Encoding Numeric Elem Success \n " in 
                      res
            | Bool true -> raise (VCEex ("Incorrect argument to a numeric expression "^(RelLang.exprToString e) ))
            | Bool false -> raise (VCEex ("Incorrect argument to a numeric expression "^(RelLang.exprToString e) ))
            | Var v -> 
                        let () = Printf.printf "%s" "\n Encoding Numeric Elem Var Case \n " in 
                        let () = Printf.printf "%s" ("\n "^(Ident.name v)) in 
                        let astforconst = getConstForVar constMap v in 
                        let (ast_exp, ast_sort) =ast_expr_sort_pair astforconst in 
                         ast_exp 
             

        in
        match e with 
            T els -> 
                let () = Printf.printf "%s" (" \n ******encodeNumericExpr T *****") in 
                (
                match Vector.length els with 
                    0 -> raise (VCEex ("Incorrect numeric expression "^(RelLang.exprToString e) )) 
                    | 1 -> let numericValue = encodeNumericElem (tyMap, constMap, relMap) (List.hd els) in 
                            numericValue
                    | _ -> raise (VCEex ("Incorrect number of numeric arguments "^(RelLang.exprToString e) ))
                  )
            | ADD (e1, e2) ->
               mk_Integer_addition ( (encodeNumericExpr (tyMap, constMap, relMap) e1), 
                (encodeNumericExpr (tyMap, constMap, relMap) e2)) 
            
            | SUBS (e1, e2) ->
               mk_Integer_substraction ( (encodeNumericExpr (tyMap, constMap, relMap) e1), 
                (encodeNumericExpr (tyMap, constMap, relMap) e2)) 
            
            | R (RInst {rel=rid;_},v) -> 
              let () = Printf.printf "%s" (" \n ******encodeNumericExpr R *****") in 
              (*get the function for the numeric relation if present, else add the function to tthe relMap
              create the function application*)
               let srforR = getStrucRelForRelId relMap rid in 
              let SR{ty;rel} = srforR in 
               let list_layout_ty = List.map (fun sor-> sort_layout sor) ty in 
               let str_ty  = (List.fold_left (fun acc l -> acc^(Layout.toString l) ) "{" list_layout_ty)^" }" in 

              let ()  = Printf.printf "%s" ("Type "^str_ty) in 
              let () = Printf.printf "%s" ("argument Name"^(Ident.name v)) in 

              let argument = getConstForVar constMap v in 
              let astLayout = ast_layout argument in 
              let (arg_exp, arg_sort) =ast_expr_sort_pair argument in 
              
        
              let reln_required_arg_sort = sortToZ3Sort arg_sort in 
              let ()  = Printf.printf "%s" ("argument Sort "^(Z3.Sort.to_string reln_required_arg_sort)) in 
         
              
              let relate = mk_Integer_func_decl (RelId.toString rid, [reln_required_arg_sort], (mk_int_sort())) in 
              let ()  = Printf.printf "%s" ("relation "^(FuncDecl.to_string relate)) in 
              
              let ()  = Printf.printf "%s" ("arguments "^(Expr.to_string arg_exp)) in 
              let ()  = Printf.printf "%s" ("argument Sort "^(Z3.Sort.to_string reln_required_arg_sort)) in 
             
               let relApp = mk_Integer_rel_app  (relate, [arg_exp]) in 
                let ()  = Printf.printf "%s" ("relation App Done ") in
                relApp 
              
           | MultiR (RInst {rel=rid;_}, elemls) -> 
                raise (Unimplemented "Encoding Z3 for MultiR is missing")

            | _ ->  raise (VCEex ("Incorrect numeric expression "^(RelLang.exprToString e) ))
             
          

        in 
      let encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2) = 
            let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion *****") in 
               
          let encoding_lhs =  encodeNumericExpr (tyMap, constMap, relMap) e1 in 
            let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion LHS done *****") in 
        
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion RHS  *****") in 
      
          let encoding_rhs = encodeNumericExpr (tyMap, constMap, relMap) e2 in 
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion RHS done *****") in 
        
        
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion creating EQ  *****") in 
               
        let eq_assertion = mk_Integer_eq (encoding_lhs,  encoding_rhs) in 
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion creating EQ  DONE*****") in 
        
          eq_assertion

      in

      let encodeRelPred (tyMap, constMap, relMap) (rp:RP.t)  =
                let () = Printf.printf "%s" (" \n ******encodeRelPred  *****"^(RP.toString rp)) in 

          let  open RelLang in 
        let f = (encodeRelExpr (tyMap, constMap, relMap)) in 
        let  open RP in 
        
        match  rp with 
          (*Eq is overloaded, it can be SetEq or Arithmetic Eq*)
          (*Ashsih , A hack, encode a Rlen here itself*)
          Eq (e1,e2) -> (*if either of e1 or e2 is an arithmatic relation like rlen, then make arithmeticEqAssertion*)
              (match (e1, e2) with 
                (_, ADD (_,_)) ->
                        let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION ADD "^(RelLang.exprToString ( e1) )^" = "^(RelLang.exprToString (e2) ) ) in  
                        encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                | (ADD (_,_), _) -> 
                       let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION ADD "^(RelLang.exprToString (e1) )^" = "^(RelLang.exprToString (e2) ) ) in  
                       
                      encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                 

                | (_, SUBS(_,_))->
                        let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION SUBS "^(RelLang.exprToString ( e1) )^" = "^(RelLang.exprToString (e2) ) ) in  
                        encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                
                | (SUBS(_,_), _)->    

                      let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION SUBS "^(RelLang.exprToString (e1) )^" = "^(RelLang.exprToString (e2) ) ) in  
                      encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                     
                 (*Relation is Rlen, the general case should be any relation in arithmetic domain*) 
                 
                 |(R (rie1, id1) as r1, R (rie2, id2) as r2 ) ->
                     let () = Printf.printf "%s" ("\n Case :: Both Rel Exp ") in  
                 
                     let RInst {rel;_} = rie1 in
                     let relId1 = RelId.toString rel in 
                      
                     let RInst {rel;_} = rie2 in
                     let relId2 = RelId.toString rel in 
                     
                    if ( (relId1 = "Rlen" || relId1 = "Rplen" || relId1 = "Rlentail" || relId1 = "Rhdn" || relId1 = "Rsum")
                          && (not (relId2 = "Rlen" || relId2 = "Rplen" || relId2 = "Rlentail" || relId2 = "Rhdn" || relId2 = "Rsum"))
                       ) then (*case R1 is Numeric but R2 is not*)   
                      let () = Printf.printf "%s" ("\n case R1 is Numeric but R2 is non-numeric") in  
                      mkSetEqAssertion (f e1, f e2)      
                      
                    else 
                      if( not (relId1 = "Rlen" || relId1 = "Rplen" || relId1 = "Rlentail" || relId1 = "Rhdn"|| relId1 = "Rsum")
                          && (relId2 = "Rlen" || relId2 = "Rplen" || relId2 = "Rlentail" || relId2 = "Rhdn"|| relId2 = "Rsum"))
                        then 
                      (*case R1 is non Numeric but R2 is numeric*)
                      
                      let () = Printf.printf "%s" ("\n case R1 is non Numeric but R2 is numeric") in  
                       mkSetEqAssertion (f e1, f e2)       
                 (*      encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                  *)     (* raise (VCEex "Fail2") *)
                    else 
                      if ((relId1 = "Rlen" || relId1 = "Rplen" || relId1 = "Rlentail"|| relId1 = "Rhdn"|| relId1 = "Rsum")
                          && (relId2 = "Rlen" || relId2 = "Rplen" || relId2 = "Rlentail" || relId2 = "Rhdn"|| relId2 = "Rsum"))
                        then (*case R1 and R2 is numeric*)     
                       encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                    else 
                      mkSetEqAssertion (f e1, f e2)      

                 |(R (rie, id), _) ->
                    let RInst {rel;_} = rie in
                    let relId = RelId.toString rel in 
                    let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 1"^relId) in  
                    if (relId = "Rlen" || relId = "Rplen" || relId = "Rlentail" || relId = "Rhdn" || relId = "Rsum" )
                     then 
                      let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION TRUE"^relId) in  
                     
                       encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                     else

                      let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION FALSE"^relId) in  
                                            mkSetEqAssertion (f e1, f e2)    


                | (_, R (rie, id))  ->               
                      let RInst {rel;_} = rie in 
                    let relId = RelId.toString rel in 
                  let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 2"^relId) in 
                  if (relId = "Rlen" || relId = "Rplen" || relId = "Rlentail" || relId = "Rhdn"|| relId = "Rsum")
                     then 
                       let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION TRUE"^relId) in  
                    
                       encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                     else
                        let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION FALSE"^relId) in  
                    
                     mkSetEqAssertion (f e1, f e2)    
                  (*Case singleton set expression*)
                | (T el1, T el2) ->
                    let () = Printf.printf "%s" ("\n singleton Set Eq CASE "^(RelLang.exprToString ( e1) )^" = "^(RelLang.exprToString (e2) )) in 
                    encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                
                   
                | (_,_) -> 
                   let () = Printf.printf "%s" ("\n RELATIONAL EXPRESSION CASE "^(RelLang.exprToString ( e1) )^" = "^(RelLang.exprToString (e2) )) in 
                    mkSetEqAssertion (f e1, f e2)

                    

              )
                  
          | Grt ( e1, e2) -> 
              match (e1, e2) with 
              | (*simplest case*) (T el1, T el2)  -> 
                        encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1 e2) 
             
                 (_, ADD (_,_)) 
                | (ADD (_,_), _)  
                | (_, SUBS(_,_))
                | (SUBS(_,_), _)->    

                      let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION SUBS "^(RelLang.exprToString (e1) )^" = "^(RelLang.exprToString (e2) ) ) in  
                      encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
              
              
              |(R (rie1, id1) as r1, R (rie2, id2) as r2 ) ->
                     let () = Printf.printf "%s" ("\n Case :: Both Rel Exp ") in  
                 
                     let RInst {rel;_} = rie1 in
                     let relId1 = RelId.toString rel in 
                      
                     let RInst {rel;_} = rie2 in
                     let relId2 = RelId.toString rel in 
                     
                    if ( (relId1 = "Rlen" || relId1 = "Rplen" || relId1 = "Rlentail" || relId1 = "Rhdn" || relId1 = "Rsum")
                          && (not (relId2 = "Rlen" || relId2 = "Rplen" || relId2 = "Rlentail" || relId2 = "Rhdn" || relId2 = "Rsum"))
                       ) then (*case R1 is Numeric but R2 is not*)   
                                           
                      raise (IncorrectRelSort " Grt is defined only for numeric co-domain relations \n "^(relId2)^" does not has a numeric co-domain sort") 
                    else 
                      if( not (relId1 = "Rlen" || relId1 = "Rplen" || relId1 = "Rlentail" || relId1 = "Rhdn"|| relId1 = "Rsum")
                          && (relId2 = "Rlen" || relId2 = "Rplen" || relId2 = "Rlentail" || relId2 = "Rhdn"|| relId2 = "Rsum"))
                        then 
                      (*case R1 is non Numeric but R2 is numeric*)
                      
                      raise (IncorrectRelSort " Grt is defined only for numeric co-domain relations \n "^(relId2)^" does not has a numeric co-domain sort") 
                    else 
                      if ((relId1 = "Rlen" || relId1 = "Rplen" || relId1 = "Rlentail"|| relId1 = "Rhdn"|| relId1 = "Rsum")
                          && (relId2 = "Rlen" || relId2 = "Rplen" || relId2 = "Rlentail" || relId2 = "Rhdn"|| relId2 = "Rsum"))
                        then (*case R1 and R2 is numeric*)     
                       encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
                    else 
                      mkSetEqAssertion (f e1, f e2)      

         
              | (_, R (rie, id))  ->               
                    let RInst {rel;_} = rie in 
                    let relId = RelId.toString rel in 
            
                    let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 2"^relId) in 
                    if (relId = "Rlen" || relId = "Rplen" || relId = "Rlentail" || relId = "Rhdn"|| relId = "Rsum")
                          then 
                     let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION TRUE"^relId) in  
                         encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
                   else
                      raise (IncorrectRelSort " Grt is defined only for numeric co-domain relations \n "^(relId)^" does not has a numeric co-domain sort") 
               |(R (rie, id), _) ->
                    let RInst {rel;_} = rie in
                    let relId = RelId.toString rel in 
                    let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 1"^relId) in  
                    if (relId = "Rlen" || relId = "Rplen" || relId = "Rlentail" || relId = "Rhdn" || relId = "Rsum" )
                     then 
                      let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION TRUE"^relId) in  
                     
                       encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
                     else
                      raise (IncorrectRelSort " Grt is defined only for numeric co-domain relations \n "^(relId)^" does not has a numeric co-domain sort") 
               


          | Sub (e1,e2) -> mkSubSetAssertion (f e1, f e2)
          | SubEq (e1,e2) -> (fun s -> mkOr( Vector.new2 (mkSetEqAssertion s,
              mkSubSetAssertion s))) (f e1, f e2)
          (*TODO We need to generate Z3 for Grt *)                     
        in 
        
       let encodeSimplePred (tyMap, constMap, relMap) (sp ) =
          
         let () = Printf.printf "%s" (" \n ******encodeSimplePred *****") in 

         match  sp with  
          (VC.Base bp) -> encodeBasePred (tyMap, constMap, relMap) bp
        | (VC.Rel rp) -> encodeRelPred (tyMap, constMap, relMap) rp in 

      let assertSimplePred  (tyMap, constMap, relMap) = dischargeAssertion << encodeSimplePred (tyMap, constMap, relMap) in 

      let rec encodeVCPred (tyMap, constMap, relMap) vcp = 
              (*TODO We are working directly on the Predicate*)
              let () = Printf.printf "%s" (" \n ******encodeVCPred *****") in 

              match vcp with 

                  VC.Simple sp -> encodeSimplePred (tyMap, constMap, relMap) sp
                | VC.Conj vcps -> mkAnd (Vector.map (vcps, (encodeVCPred (tyMap, constMap, relMap)) ))
                | VC.Disj vcps -> mkOr (Vector.map (vcps, (encodeVCPred (tyMap, constMap, relMap)  )))
                | VC.Not vcp -> mkNot (encodeVCPred (tyMap, constMap, relMap) vcp)
                | VC.If (vcp1,vcp2) -> mkIf ((encodeVCPred (tyMap, constMap, relMap) vcp1), 
                      (encodeVCPred (tyMap, constMap, relMap) vcp2))
                | VC.Iff (vcp1,vcp2) -> mkIff ((encodeVCPred (tyMap, constMap, relMap) vcp1), 
                      (encodeVCPred (tyMap, constMap, relMap) vcp2)) in 

      let rec assertVCPred  (tyMap, constMap, relMap) vcp = 
       let () = Printf.printf "%s" (" \n ******assertVCPred *****") in 

      match vcp with 
          VC.Simple sp -> assertSimplePred (tyMap, constMap, relMap) sp
        | VC.Conj spv -> List.iter (assertVCPred (tyMap, constMap, relMap)) spv
        | _ -> dischargeAssertion (encodeVCPred (tyMap, constMap, relMap) vcp) in 

      let _ = assertVCPred (tyMap, constMap, relMap) anteP in 
      (*
       * We check the SAT of ¬conseqP
       *)

(*       let _ = mk_length_assertions() in  
       *)let _ = dischargeAssertion (mkNot (encodeVCPred (tyMap, constMap, relMap) conseqP)) in 
      let solverDischarged = getSolver () in 
      let expressions_list = Solver.get_assertions solverDischarged  in  


      let () = Printf.printf "%s" ("\n# of Z3 expressions "^(string_of_int (List.length expressions_list))) in   
      let () = Printf.originalPrint "%s" ("\nsolver \n "^(Solver.to_string solverDischarged)) in   
     
      let res =   Solver.check solverDischarged [] in
 
      let () = Solver.reset solverDischarged in 
     
    
      match  res with 
           SATISFIABLE -> Failure
         | UNKNOWN -> Undef 
         | UNSATISFIABLE -> Success
        | _ -> raise SolverTimeout



    
