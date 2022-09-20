open VerificationCondition
open SpecLang 
open Z3_encode

module TyD = TyD

  module RI = RelId
  module BP = Predicate.BasePredicate
  module RP = Predicate.RelPredicate
  module PR = PrimitiveRelation
  module L = Layout
  module VC = VerificationCondition
  type result = Success | Undef | Failure
 
  module FuncDecl = Z3.FuncDecl 
  module Solver = Z3.Solver 

  
  exception VCEncodingFailed of string 

let ignore = fun _ -> ()

let z3_log = Z3_encode.logz3

let discharge pre= 


(*Verification Conditions Manual Creation*)
  let tdbinds = [] in
  (*131(x_1 :  'a_4258 list,
132          x_0 :  'a_4258 list,
133          nil :  'a_2 list,
134          anc_1024 :  'a_4258 list,
135          anc_1025 :  'a_4258 list,
136          l1 :  'a_4258 list,
137          l2 :  'a_4258 list)
*)


  let b1 = (Var.fromString "x_1", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in 
let b2 = (Var.fromString "x_0", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in 
let b3 = (Var.fromString "nil", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in
let b4 = (Var.fromString "anc_1024", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in 
let b5 = (Var.fromString "anc_1025", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in 
let b6 = (Var.fromString "l1", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in 
let b7 = (Var.fromString "l2", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in 
let bnew_x = (Var.fromString "x", TyD.Tvar (Tyvar.fromString "a_4285") ) in 
let b71 = (Var.fromString "xs", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in 
let b72 = (Var.fromString "sv_1027", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in 
let b_1027 = (Var.fromString "anc_1027", TyD.Tvar (Tyvar.fromString "a_4285") ) in 
let b_1030 = (Var.fromString "anc_1030", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in 

let b8 = (Var.fromString "v_6", TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")]) ) in 

let tdbinds = [b1;b2;b3;b4;b5;b6;b7;bnew_x;b71;b72;b_1027;b_1030;b8] in 
let rbinds = PRE.empty in 

let bindings = {tbinds = tdbinds; rbinds = rbinds}  in

(*
  Rhd  ::  {typescheme = : @ss: :.   _ list :-> {Tuple _}, def = \v_1. bind (Rhd : (v_1),\:v_0. {(v_0)})} 
   
 Rmem  ::  {typescheme = : @ss: :.   _ list :-> {Tuple _}, def = \v_3. bind (Rmem : (v_3),\:v_2. {(v_2)})} 
   
 Rob  ::  {typescheme = : @ss: :.   _ list :-> {Tuple __}, def = \v_6. bind (Rob : (v_6),\:v_4v_5. ({(v_4)} X {(v_5)}))} 
   
 Robs  ::  {typescheme = : @ss: :.   _ list :-> {Tuple __}, def = \v_9. bind (Robs : (v_9),\:v_7v_8. ({(v_7)} X {(v_8)}))} 

*)
let tyd_a4285 = TupSort.T (TyD.Tvar (Tyvar.fromString "a_4285")) in 
let rhD_domain = (TyD.Tconstr(Tycon.fromString "list" , [TyD.Tvar (Tyvar.fromString "a_4285")])) in
let rhD_range =  (TupSort.Tuple [tyd_a4285]) in
let rhDSpS = SimpleProjSort.ColonArrow (rhD_domain, rhD_range) in 

let rob_domain = (TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")])) in
let rob_range =  (TupSort.Tuple [tyd_a4285; tyd_a4285]) in
let robSpS = SimpleProjSort.ColonArrow (rob_domain, rob_range) in 


let robs_domain = (TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")])) in
let robs_range =  (TupSort.Tuple [tyd_a4285; tyd_a4285]) in
let robsSpS = SimpleProjSort.ColonArrow (robs_domain, robs_range) in 



let rmem_domain = (TyD.Tconstr(Tycon.fromString "list",[TyD.Tvar (Tyvar.fromString "a_4285")])) in
let rmem_range =  (TupSort.Tuple [tyd_a4285]) in
let rmemSpS = SimpleProjSort.ColonArrow (rmem_domain, rmem_range) in 


let tydbindRhD = ((Var.fromString "Rhd"), rhDSpS) in 
let tydbindRob = ((Var.fromString "Rob"), robSpS) in 
let tydbindRobs = ((Var.fromString "Robs"), robsSpS) in 
let tydbindRmem = ((Var.fromString "Rmem"), rmemSpS) in 



let newsortbinds = [tydbindRhD;tydbindRob;tydbindRobs;tydbindRmem] in 


let newtydbinds = List.map 
                                (fun (rid, sort) ->
                                  let SPS.ColonArrow (tyd,TS.Tuple tts) = sort in 
                                  let tydvec =tyd :: (Vector.map (tts, 
                                                                  fun tts -> match  tts with
                                                                      TS.T tyd -> tyd 
                                                                    | TS.S t ->  raise (VCEncodingFailed "Unhandled Case") )) in 
                                  (*How we create a boolean type??*)
                                  let boolTyD = TyD.makeTbool () in 
                                  let relArgTyd = TyD.Ttuple (tydvec) in 
                                  let relTyD = TyD.makeTarrow ((relArgTyd), (boolTyD)) in
                                  let rtov = Var.fromString << RelId.toString in 
                                  let relvid = rtov rid
                                  in 
                                  (relvid,relTyD)
                               ) newsortbinds in 



let tdbinds = List.concat [tdbinds;newtydbinds] in 

let bindings = {tbinds = tdbinds; rbinds = rbinds}  in


(*iterate *)


let pre_vc_predList = [] in 


  (*
    1Robs(nil) = {()}
2       Rob(nil) = {()}
3       Rmem(nil) = {()}
4       Rhd(nil) = {()}
5       anc_1025 = x_1
6       anc_1024 = x_0
7       l2 = x_1
8       l2 = anc_1025
9       l1 = x_0
10       l1 = anc_1024
11       Robs(l1) = {()}
12       Rob(l1) = {()}
13       Rmem(l1) = {()}
14       Rhd(l1) = {()}
15       v_6 = x_1
16       v_6 = anc_1025
17       v_6 = l2

  *)
  let relIdRobs = RelId.fromString "Robs" in 
  let robsInst = RelLang.instOfRel relIdRobs in 
  
  let relIdRob = RelId.fromString "Rob" in 
  let robInst = RelLang.instOfRel relIdRob in 
  

  let relIdRhd = RelId.fromString "Rhd" in 
  let rhdInst = RelLang.instOfRel relIdRhd in 

  let relIdRmem = RelId.fromString "Rmem" in 
  let rmemInst = RelLang.instOfRel relIdRmem in 
  

  let pred1 =  Simple (Rel (RP.Eq (R (robsInst, Var.fromString "nil"), T []))) in 
  let pred2 = Simple (Rel (RP.Eq (R (robInst, Var.fromString "nil"), T []))) in 
  let pred3= Simple (Rel (RP.Eq (R (rmemInst, Var.fromString "nil"), T []))) in 
  let pred4 = Simple (Rel (RP.Eq (R (rhdInst, Var.fromString "nil"), T []))) in 

  let pred5 = Simple (Base (BP.Eq ( 
                              (Var (Var.fromString "anc_1025")), Var ((Var.fromString "x_1") ))))  in 

  let pred6 = Simple (Base (BP.Eq ( 
                              (Var (Var.fromString "anc_1024")), (Var (Var.fromString "x_0") ))))  in 

  let pred7 = Simple (Base (BP.Eq ( 
                              (Var (Var.fromString "l2")), (Var (Var.fromString "x_1") )))) in 

  let pred8 = Simple (Base (BP.Eq ( 
                              (Var (Var.fromString "l2")), (Var (Var.fromString "anc_1025") ))))  in 


  let pred9 = Simple (Base (BP.Eq ( 
                              (Var (Var.fromString "l1")), (Var (Var.fromString "x_0") )))) in 
  let pred10 =Simple (Base (BP.Eq ( 
                              (Var (Var.fromString "l1")), (Var (Var.fromString "anc_1024") ))))  in 

 let pred101 =Simple (Base (BP.Eq ( 
                              (Var (Var.fromString "anc_1027")), (Var (Var.fromString "x") ))))  in 



(* 

  let pred11 = Simple (Rel (RP.Eq (R (robsInst, Var.fromString "l1"), T []))) in 
  let pred12= Simple (Rel (RP.Eq (R (robInst, Var.fromString "l1"), T []))) in 
  let pred13= Simple (Rel (RP.Eq (R (rmemInst, Var.fromString "l1"), T []))) in 

  let pred14 = Simple (Rel (RP.Eq (R (rhdInst, Var.fromString "l1"), T []))) in 
 *)
(*

* Rhd(l1) = {(x)}
  
 *)  
  let rhd_l1 =  Simple (
        Rel ( RP.Eq ( RelLang.R (rhdInst, Var.fromString "l1"), RelLang.T [ (RelLang.Var (Var.fromString ("x")))]))) in 
  
  let rmem_xs = RelLang.R (rmemInst, Var.fromString "xs") in 
  let tuple_x =  RelLang.T [(RelLang.Var (Var.fromString ("x")))] in 
  

(*  Rmem(l1) = ({(x)} U (Rmem(xs) U {()}))
*)
  let rmem_l1= Simple (Rel (RP.Eq ( RelLang.R (rmemInst, Var.fromString "l1"), RelLang.U( tuple_x,  (RelLang.U (rmem_xs, RelLang.T []) )) ))) in 
  (*Robs(l3) = (({(x)} X Rmem(xs)) U (Robs(xs) U {()}))
*)


  (*Rob(l1) = ({(x)} X Rmem(xs))
  *)
  let rob_l1 = Simple (Rel (RP.Eq ( RelLang.R (robInst, Var.fromString "l1"), 
                                    RelLang.X (tuple_x, rmem_xs))
                            )
                      ) in 

  
  let robs_xs = RelLang.R (robsInst, Var.fromString "xs") in 
  let robs_l1 = Simple (Rel (RP.Eq (RelLang.R (robsInst, Var.fromString "l1"), 
                                    (RelLang.U ( (RelLang.X( tuple_x, rmem_xs)),                 
                                                         
                                                (RelLang.U (robs_xs, RelLang.T []))
                                              )
                                    )
                                  ))) in 
  
   

  let rmem_anc1030= Simple (Rel (RP.Eq ( RelLang.R (rmemInst, Var.fromString "anc_1030"), RelLang.U((RelLang.R (rmemInst, Var.fromString "xs")),
                                                                                                (RelLang.R (rmemInst, Var.fromString "l2")) ) ) )) in 





(*

* Rhd(v_6) = {(anc_1027)}
  
 *) 

(*  Rmem(v_6) = ({(anc_1027)} U (Rmem(anc_1030) U {()}))

*)
(*Robs(l3) = (({(x)} X Rmem(xs)) U (Robs(xs) U {()}))
*)


  (*Rob(v_6) = ({anc_1027} X Rmem(anc_1030))
  *)

(* Robs(v_6) = (({(anc_1027)} X Rmem(anc_1030)) U (Robs(anc_1030) U {()}))
 *)  
  let rhd_v6 =  Simple (
        Rel ( RP.Eq ( RelLang.R (rhdInst, Var.fromString "v_6"), RelLang.T [ (RelLang.Var (Var.fromString ("anc_1027")))]))) in 
  
  let rmem_anc1030_exp = RelLang.R (rmemInst, Var.fromString "anc_1030") in 
  
   let tuple_anc1027 =  RelLang.T [(RelLang.Var (Var.fromString ("anc_1027")))] in 
  

  let rmem_v6= Simple (Rel (RP.Eq ( RelLang.R (rmemInst, Var.fromString "v_6"), RelLang.U( tuple_anc1027,  (RelLang.U (rmem_anc1030_exp, RelLang.T []) )) ))) in 
  
  let rob_v6 = Simple (Rel (RP.Eq ( RelLang.R (robInst, Var.fromString "v_6"), 
                                    RelLang.X (tuple_anc1027, rmem_anc1030_exp))
                            )
                      ) in 

 
  let robs_anc1030 = RelLang.R (robsInst, Var.fromString "anc_1030") in 
  let robs_v6 = Simple (Rel (RP.Eq (RelLang.R (robsInst, Var.fromString "v_6"), 
                                    (RelLang.U ( (RelLang.X( tuple_anc1027, rmem_anc1030_exp)),                 
                                                         
                                                (RelLang.U (robs_anc1030, RelLang.T []))
                                              )
                                    )
                                  ))) in 
  
   

   (* 

  let pred15 = Simple (Base (BP.Eq ( 
                              (Var (Var.fromString "v_6")), (Var (Var.fromString "x_1") ))))  in 

  let pred16 = Simple (Base (BP.Eq ( 
                              (Var (Var.fromString "v_6")), (Var (Var.fromString "anc_1025") ))))  in 

  let pred17 = Simple (Base (BP.Eq ( 
                              (Var (Var.fromString "v_6")), (Var (Var.fromString "l2") ))))  in 

 *)



  let pre_vc_predList = [pred1;pred2;pred3;pred4;pred5;pred6;pred7;pred8;pred9;pred10;pred101; rhd_l1; rmem_l1; rob_l1; robs_l1;
                                          rhd_v6;rmem_v6;robs_v6;rob_v6 ;rmem_anc1030
                                          (* pred11;pred12;pred13;pred14;pred15;pred16;pred17 *)] in 



  let pre_condition = Conj (pre_vc_predList) in 


  (*generate the post-condition*)
  (*Rmem(v_6) = (Rmem(l1) U Rmem(l2))
  *)


  let instVarRmem = Var.fromString "v_6" in 
  (*Rmem(v_6)*)

  let r_expr_lhs = RelLang.R (rmemInst, instVarRmem) in 
  let elhs = r_expr_lhs in 


  let instVarRmem_l1 = Var.fromString "l1" in
  let instVarRmem_l2 = Var.fromString "l2" in 
  (*Rmem(l1)*)
  let r_expr_l1 = RelLang.R (rmemInst, instVarRmem_l1) in 
  let r_expr_l2 = RelLang.R (rmemInst, instVarRmem_l2) in 
  
 


  let erhs = RelLang.U (r_expr_l1, r_expr_l2) in 
  let  post_condition = Simple (Rel (RP.Eq (elhs, erhs)))  in 
  let vcs = VC.T (bindings, pre_condition, post_condition) in 

  let _ = Printf.printf "%s" ("discharged VCS") in 
  let _ = Printf.printf "%s" (L.toString (VC.layouts [vcs])) in 
  let _ = Printf.printf  "\n"  in 


  let anteP = pre_condition in 
  let conseqP = post_condition in 
  let tydbinds = tdbinds in 
  let pre = rbinds in 

    
         (*
       * Maps to keep track of encoded values
       *)
      
      (*int_sort and bool_sort are sort functions in MSFOL
        check how to encode MSFOL in Z3*)
       let tyMap = TyMap.empty  in 

      
      let tyMap = TyMap.add tyMap (TyD.Tint) (Int (Z3_encode.mk_int_sort ())) in 
      let tyMap = TyMap.add tyMap (TyD.Tbool) (Bool (Z3_encode.mk_bool_sort ())) in 


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
             TyD.Tvar _ ->  addTyD tyMap tyD 
            | TyD.Tconstr _ -> addTyD tyMap tyD
            | _ -> 

            failwith "Unexpected type")

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
        (**ERROR*)
        let encodeStrucRel (tyMap, constMap, relMap) (rid ,TyD.Tarrow (t1,_))  =
          let open TyD in 
          let  rstr = RI.toString rid in 
          let (tyMap, constMap, relMap,sorts) = 
            match t1 with 
              TyD.Ttuple tydr -> 
                let () = Printf.printf "%s" "\n encodeSTR case Tuple \n " in
                List.fold_left (fun (tyMap, constMap, relMap, sortsList) tyD -> 
                  let (tyMap, constMap, relMap, sort) = encodeTyD (tyMap, constMap, relMap) tyD in 
                  (tyMap, constMap, relMap, (sort::sortsList))   
                ) (tyMap, constMap, relMap, []) (tydr)  
              (*   List.map (fun tyD -> 
                                  let (tyMap, constMap, relMap, sort) = encodeTyD (tyMap, constMap, relMap) tyD in 
                                      sort) (tydr)  *)
              | _ ->  
                    let () = Printf.printf "%s" "\n encodeSTR case Other \n " in 
                    let (tyMap, constMap, relMap, sort) = encodeTyD (tyMap,constMap,relMap) t1 in  
                    (tyMap, constMap, relMap,Vector.new1 (sort))
          in 
          let () = Printf.printf "%s" "\n encodeSTR case sorts \n " in
                      
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
          |Tarrow (t1,t2)   ->
                (match t2 with 
                  | Tbool ->                       
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
               | ConstMap.ConstNotFound v -> const_true   
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

   let  processBindEq (tyMap, constMap, relMap) (theR,def) : (TyMap.t* ConstMap.t* RelMap.t) =
          
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
      
     (*  let _ = List.iter processTyDBind tydbinds in 
      *) (* pre is rbinds of elaborated VC.t. Maps newRelNames to
         instantiated definitions.*)
      let () = Printf.printf "%s" (" \n ******processTyDBind starting *****") in 
             
      let (tyMap, constMap, relMap) = List.fold_left (processTyDBind) (tyMap, constMap, relMap) tydbinds in  
      let () = Printf.printf "%s" (" \n ******** processTyDBind finished ********") in 
      
    
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

  let () = Printf.printf "%s" (" \n ******PRE processing finished *****") in 
    
      (* pre is rbinds of elaborated VC.t. Maps newRelNames to
         instantiated definitions.*)
        
   (* ---- Type refinement encoding begins ---- *)

    let rec encodeBasePred (tyMap, constMap, relMap) (bp)  = 
        
      let () = Printf.printf "%s" (" \n ******encodeBasePred *****") in 
    
        let
          open BP in 
          let encodeBaseExpr bexp = 
            match bexp with  
             (Int i) -> mkConst(string_of_int i, int_sort)
            | Bool true -> const_true 
            | Bool false -> const_false
            | Var v -> getConstForVar constMap v
        in
          match bp with
           Eq (e1,e2) -> mkConstEqAssertion 
              (encodeBaseExpr e1, encodeBaseExpr e2)
           | Iff (bp1,bp2) -> mkIff ( (encodeBasePred (tyMap, constMap, relMap) bp1),
                (encodeBasePred (tyMap, constMap, relMap) bp2))
        in 
        
     let rec encodeRelExpr (tyMap, constMap, relMap) (e) =
    
      let () = Printf.printf "%s" (" \n ******encodeRelExpr *****") in 
    
        let open RelLang in 
        let encodeRelElem (tyMap, constMap, relMap) = fun x -> 
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
      
                (
                match Vector.length els with 
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
            | R (RInst {rel=rid;_},v) -> 
              let () = Printf.printf "%s" (" \n ******encodeRelExpr R *****") in 
              
              (* try 
               *)mkStrucRelApp (
                (getStrucRelForRelId relMap rid), (getConstForVar constMap v))
              (*  with 
              | _ -> raise (VCEex "failed at mkStrucRel")
 *)
        in 

        
      let encodeRelPred (tyMap, constMap, relMap) (rp:RP.t)  =
                let () = Printf.printf "%s" (" \n ******encodeRelPred *****") in 

          let  open RelLang in 
        let f = (encodeRelExpr (tyMap, constMap, relMap)) in 
        let  open RP in 
        
        match  rp with 
          Eq (e1,e2) -> mkSetEqAssertion (f e1, f e2)
          | Sub (e1,e2) -> mkSubSetAssertion (f e1, f e2)
          | SubEq (e1,e2) -> (fun s -> mkOr( Vector.new2 (mkSetEqAssertion s,
              mkSubSetAssertion s))) (f e1, f e2)

        in 
        
       let encodeSimplePred (tyMap, constMap, relMap) (sp ) =
                let () = Printf.printf "%s" (" \n ******encodeSimplePred *****") in 

         match  sp with  
          (Base bp) -> encodeBasePred (tyMap, constMap, relMap) bp
        | (Rel rp) -> encodeRelPred (tyMap, constMap, relMap) rp in 

      let assertSimplePred  (tyMap, constMap, relMap) = dischargeAssertion << encodeSimplePred (tyMap, constMap, relMap) in 

      let rec encodeVCPred (tyMap, constMap, relMap) vcp = 

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
      let _ = dischargeAssertion (mkNot (encodeVCPred (tyMap, constMap, relMap) conseqP)) in 
      let solverDischarged = getSolver () in 
      let expressions_list = Solver.get_assertions solverDischarged  in  

      let () = Printf.printf "%s" ("exp_list_size "^(string_of_int (List.length expressions_list))) in   
      let () = Printf.printf "%s" ("solver  "^(Solver.to_string solverDischarged)) in   
     
      let res =   Solver.check solverDischarged [] in 
     
    
      match  res with 
           SATISFIABLE -> Success 
         | UNKNOWN -> Undef 
         | UNSATISFIABLE -> Failure
        | _ -> failwith "Integer received when Z3_lbool expected"


 
    