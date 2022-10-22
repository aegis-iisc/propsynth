open Z3
module Log = Z3.Log
module Solver = Z3.Solver
module OptSolver = Z3.Optimize
module Model = Z3.Model
module Symbol = Z3.Symbol
module Optimize = Z3.Optimize
module Integer = Z3.Arithmetic.Integer
module Bool = Z3.Boolean
module Sort = Z3.Sort
module Datatype = Z3.Datatype
module FuncDecl = Z3.FuncDecl
module Quantifier = Z3.Quantifier
module Expr = Z3.Expr
module Constructor = Z3.Datatype.Constructor
module Z3Sort = Z3.Sort

(* let logOpen = Log.open_ "Logging@z3"  *)
let logz3 s = Log.append s
open Boolean
open Arithmetic
open FuncDecl
open Integer
open Quantifier    
(* 
module Printf = struct 
  let printf f s = ()


end  
   *)


module Printf = struct 
  let printf d s = Printf.printf d s
  let originalPrint = Printf.printf 
end  

exception Z3ex of string 
(*Local types used for encoding*)

type context = Z3.context

type sort = Int of Z3Sort.sort 
          | Bool of Z3Sort.sort
          | T of string * Z3Sort.sort
          | U of string 
          | Str of Z3Sort.sort

let sortToString = fun s ->
  match s with 
    Int s -> (Z3Sort.to_string s)    
  | Bool s ->  (Z3Sort.to_string s)    
  | T (str, s) ->  (str^" :: "^(Z3Sort.to_string s))  
  | U (str) -> str
  | Str s ->  (Z3Sort.to_string s) 


let same_sort = fun s1 s2 ->
  match (s1, s2) with 
    (Int _, Int _) -> true     
  | (Bool _, Bool _)   -> true    
  | (T (str1, _), T (str2,_)) ->  if (str1 = str2) then true else false  
  | (U (str1), U (str2)) ->  if (str1 = str2) then true else false   
  | (Str _, Str _)   -> true    
  | ( _, _)-> false




let sort_layout = fun s ->
  match s with 
    Int s -> Layout.str (Z3Sort.to_string s)    
  | Bool s ->  Layout.str (Z3Sort.to_string s)    
  | T (str, s) -> Layout.str (str^" :-> "^(Z3Sort.to_string s))
  | U (str) -> Layout.str str

(*The ast in the older version of the z3 is replaced with expressions *)
type ast = AST of Z3.Expr.expr * sort

(*a tuatological comparision function for completeness of ConstMap*)
let sameAst ast1 ast2 = 
  true 
let ast_expr_sort_pair = fun (AST (ex, so)) -> (ex, so) 

let ast_layout = fun (AST (exp, s)) ->
  let str_expr = Z3.Expr.to_string exp in 
  let str_sort = Layout.toString (sort_layout s) in 
  Layout.str (str_expr^" , "^str_sort) 

type set = Null
         | Set of {ty : sort list;
                   pred : ast list -> Z3.Expr.expr }

type struc_rel = SR of {ty : sort list; 
                        rel : ast -> set}
               | MSR of {mty : sort list; mrel : (ast list) -> set   }      
(*a tautological function for completeness of RelMap*)
let sameSR sr1 sr2 = 
  true 

let sr_layout = fun (SR {ty ;rel }) ->
  let list_layout_ty = List.map (fun sor-> sort_layout sor) ty in 
  let str_ty  = (List.fold_left (fun acc l -> acc^(Layout.toString l) ) "{" list_layout_ty)^" }" in 

  (*Complete these printing functions *)
  let str_pred =  "pred" in 
  let str_sr = "{ "^str_ty^" | "^str_pred^" }" in 
  Layout.str str_sr
(* (fun as -> Z3.Expr.to_string as) *)  


let mkGenName (cnt,base) =
  let
    count = ref cnt
  in
  fun () -> 
    let name = base ^ (string_of_int (!count)) in 
    let _ = count := !count + 1
    in
    name

let genTypeName = mkGenName (0,"T")
let genSetName = mkGenName (0,"set")

let mkDefaultContext () =
  let cfg = [("model", "true"); ("proof", "true"); ("timeout", "30000")(* ;("smt.macro-finder","true") *)] in 
  let ctx = mk_context cfg
  in ctx

let ctx = ref @@ mkDefaultContext ()  
let solver = ref @@ Solver.mk_solver !ctx None 


let reset () = 
  begin
    ctx := mkDefaultContext ();
    solver := Solver.mk_solver !ctx None;
  end

(*
 * Z3 API for the current ctx

let int_sort = Int (mk_int_sort ())  
let bool_sort = Bool (mk_bool_sort ()) *)
let mkSym s =  Symbol.mk_string !ctx s 
let mk_app f args = Expr.mk_app !ctx f args
let mk_int_sort () = Integer.mk_sort !ctx
let mk_bool_sort () = Bool.mk_sort !ctx
let mk_string_sort () = Seq.mk_string_sort !ctx
let mk_false () = Bool.mk_false !ctx
let mk_true () = Bool.mk_true !ctx
let mk_numeral_i i = Integer.mk_numeral_i !ctx i
let mk_uninterpreted_s s = Z3Sort.mk_uninterpreted_s !ctx s
let sortToZ3Sort sort = 
  match sort with 
    Int t -> t 
  | Bool t -> t 
  | T (name,t) -> t
  | U name -> mk_uninterpreted_s name   
  | Str t -> t 

let sortToString sort = Sort.to_string (sortToZ3Sort sort)

let typeCheckAst (AST (ast,sort),sort') = 
  match (sort,sort') with
    (Int _,Int _) -> 
    (*(Printf.printf "%s" ("Sort Checking Int, Int "^(sortToString sort)
                             ^" vs "^(sortToString sort')));*)

    true
  | (Bool _ , Bool _) ->
    (*(Printf.printf "%s" ("Sort Checking Bool Bool"^(sortToString sort)
                            ^" vs "^(sortToString sort')));*)

    true
  | (Str _ , Str _) ->
    (*(Printf.printf "%s" ("Sort Checking Bool Bool"^(sortToString sort)
                            ^" vs "^(sortToString sort')));*)

    true

  | (T (name1,_), T (name2, _)) ->  
    (* (Printf.printf "%s" ("Sort Checking named , named "^(sortToString sort)
                  ^" vs "^(sortToString sort'))); *)
    name1 = name2
  | (U name1, U name2) -> 
    name1 = name2 
  | _ -> (Printf.printf "%s" ("Sort mismatch: other , other  "^(sortToString sort)
                              ^" vs "^(sortToString sort')); false)

let astToZ3Ast (AST (z3_ast,sort)) = z3_ast

let astToString (AST (z3_ast,_)) =
  Expr.to_string z3_ast

let sortOfAst (AST (_,sort)) = sort

let constToString ast = Expr.to_string (astToZ3Ast ast)

let strucRelToString sr = failwith "unimpl"



let mk_const_s str sort = Expr.mk_const_s !ctx str sort
let mk_constructor_s a b c d e = Datatype.mk_constructor_s !ctx a b c d e
let mk_sort_s a b = Datatype.mk_sort_s !ctx a b
let mk_func_decl_s name arg_sorts res_sort = 
  FuncDecl.mk_func_decl_s !ctx name arg_sorts res_sort
let mk_and conjs = Boolean.mk_and !ctx conjs
let mk_or conjs = Boolean.mk_or !ctx conjs
let mk_eq e1 e2 = Boolean.mk_eq !ctx e1 e2
let mk_gt e1 e2 = mk_gt !ctx e1 e2
let mk_lt e1 e2 = mk_lt !ctx e1 e2
let mk_ge e1 e2 = mk_ge !ctx e1 e2
let mk_le e1 e2 = mk_le !ctx e1 e2
let mk_not e =  mk_not !ctx e
let mk_ite e1 e2 e3 = mk_ite !ctx e1 e2 e3
let mk_distinct es = mk_distinct !ctx es
let mk_add es = mk_add !ctx es
let mk_sub es = mk_sub !ctx es
let mk_mul es = mk_mul !ctx es
let _assert e = Solver.add !solver [e]
let getSolver () = !solver  
let _assert_all e = Solver.add !solver e
let push () = Solver.push !solver
let pop () = Solver.pop !solver 1
let check_sat () = Solver.check !solver []
let get_model () = match Solver.get_model !solver with
  | Some model -> model
  | None -> failwith "No model exists!"
let mk_iff t1 t2 = mk_iff !ctx t1 t2

let truee = mk_true () 
let falsee = mk_false ()
let const_false = AST (falsee, Bool (mk_bool_sort ()))
let const_true = AST (truee, Bool (mk_bool_sort ()))





let mkConst (name,sort) =
  let z3_sort = sortToZ3Sort sort in 
  let const = Expr.mk_const (!ctx) (mkSym name) (z3_sort) in 
  (* let _ = Printf.printf "%s" ("(declare-const "^(Expr.to_string (const))^" "^(Sort.to_string (z3_sort))^")") in 
     let _ = Printf.printf "%s" "\n" *)
  (* in *)
  AST (const, sort)
(*create a string literal*)
let mkStr s = 
  let s_const_exp = Seq.mk_string (!ctx) s in 
  let s_sort = Seq.mk_string_sort (!ctx) in 
  AST (s_const_exp, Str (s_sort)) 


let mkInt i = mkConst (string_of_int i,  Int (mk_int_sort()))


let mkEq (AST (x1,_) , AST (x2,_)) = mk_eq x1 x2



let mkBoundVar (index,sort) = 
  let qExp = Quantifier.mk_bound !ctx (index) (sortToZ3Sort sort) in 
  AST (qExp, sort )

let mk_pattern el = mk_pattern !ctx el



(*
       * Encoding Sets and Structural Relations. 
       * An n-arity set is eta-equivalent of an n-arity boolean 
       * Z3 function. Set s = \(x1,x2,..,xn).z3_f(x1,x2,...,xn)
       * Eg: s = s1 ∪ s2 is encoded as  
       * ∀x1,x2,..,xn, s(x1,x2,..,xn) = s1(x1,x2,..,xn) 
       *                              ∨ s2 (x1,x2,..,xn)
       * An n-arity structural relation is a curried version of
       * eta-equivalent of n-arity boolean Z3 function.
       * Relation Rmem = \x1.\(x2,...,xn).z3_f(x1,x2,...,xn)
       * Relation application will, therefore, produce a function
       * that accepts n-1 arguments and produces an n-arity set.
       * Eg: Rmem(l) = Rmem(l1) U Rmem(l2) is encoded as 
       * ∀x1,..,xn-1, Rmem(l,x1,..,xn-1) = Rmem(l1,x1,..,xn-1) 
       *                                 ∨ Rmem(l2,x1,..,xn-1)
       *)
let mkSet (name,sorts) =
  let nargs = Vector.length sorts in 
  let z3_sorts = Vector.map (sorts, sortToZ3Sort) in 
  let func = FuncDecl.mk_func_decl !ctx (mkSym name) z3_sorts (mk_bool_sort ()) in 
  let _ = logz3 (FuncDecl.to_string func )in  
  let _ = logz3 "\n" in 

  let pred = 
    fun asts -> 
      (* Following results in Size exception. Reason unknown. *)
      (*let astStr = fn _ ->(L.toString $ L.vector $ Vector.map 
        (asts, fn ast -> L.str $ astToString ast))*)
      let sortStrs = List.map (fun s -> (sortToString s)) sorts  in 
      let sortStr = fun _ -> (List.fold_left (fun acc s ->  acc^","^s) "(" sortStrs)^")" in 
      let errMsg = (fun _ -> "Type Mismatch. Set: "^name^".\n") in
      (*let () = Printf.printf "%s" (" Testing assertion for "^name^" \n ") in 
        let () = Printf.printf "%s" (" ast length "^(string_of_int (Vector.length asts))^" \n ") in 
        let () = Printf.printf "%s" (" sorts length "^(string_of_int (Vector.length sortStrs))^" \n ") in *)

      let _ = assert (Vector.length asts = Vector.length sorts) in 
      let _ = assert (List.for_all2 (fun ast s -> typeCheckAst (ast, s)) asts sorts ) in 
      let z3_asts = Vector.map (asts,astToZ3Ast) 
      in
      FuncDecl.apply func z3_asts  
  in
  Set {ty = sorts; pred = pred}



let mkStrucRel (name,sorts) =
  let nargs = Vector.length sorts in 
  let domainTy = Vector.sub (sorts,0) in 



  let  Set {ty;pred} = mkSet (name,sorts) in 
  let rel = fun ast -> 
    let _ = assert (typeCheckAst (ast,domainTy)) in 
              (*
               * Constructing (n-1)-arity set from an n-arity
               * boolean function. 
               * n >= 2 invariant follows from structural relations.
               *)
    let ty' = Vector.dropPrefix (sorts,1) in 
    let pred' = fun asts ->
      pred (Vector.concat 
              [Vector.new1 ast; asts])
    in
    Set {ty = ty';pred = pred'}

  in
  SR {ty=sorts;rel = rel}


let mkMStrucRel (name,sorts) =
  let
    nargs = Vector.length sorts in 
  let co_domainTy = List.hd (List.rev sorts) in
  let domainTys = List.rev (List.tl (List.rev sorts)) in 


  let  Set {ty;pred} = mkSet (name,sorts) in 
  let mrel = fun ast_list -> 
    let _ = List.iter2 (fun ast domainTy ->  assert (typeCheckAst (ast,domainTy))) ast_list in 
              (*
               * Constructing (n-1)-arity set from an n-arity
               * boolean function. 
               * n >= 2 invariant follows from structural relations.
               *)
    let ty' = [co_domainTy] in 
    let pred' = fun asts ->
      pred (Vector.concat 
              [ast_list; asts])
    in
    Set {ty = ty';pred = pred'}

  in
  MSR {mty=sorts;mrel = mrel}


let mkMStrucRelApp (MSR {mrel;_}, ls_ast) = 
  (*    let () = Printf.printf "%s" " *********mkStrucRelApp*****" in 
  *)   try 
    mrel ls_ast
  with 
  | e -> raise e

let mkStrucRelApp (SR {rel;_}, ast) = 
  (*    let () = Printf.printf "%s" " *********mkStrucRelApp*****" in 
  *)   try 
    rel ast
  with 
  | e -> raise e

let mkSetUProp (indx, sorts , propfn) =
  let numbvs = Vector.length sorts in 
  let (bvs,indx') = Vector.mapAndFold (sorts, indx, fun (sort,i) -> (mkBoundVar (i,sort), i+1)) in 
  (* 
           * De-brujin. Therefore: bv_n,bv_n-1,...,bv_0 
           * Z3 applies the convention that the last element in the
           * bvnames and bvtys array refers to the variable with
           * index 0, the second to last element of bvnames and
           * bvtys refers to the variable with index 1
           *)
  let bvnames = Vector.tabulate (numbvs, (fun i -> mkSym ("bv"^(string_of_int (indx+numbvs-i-1) )))) in 
  let bvtys = Vector.rev (Vector.map (sorts,sortToZ3Sort)) in 
  let (patterns,prop) = propfn bvs in 
          (*
           * We currently disable explicit pattern annotations,
           * as they are not serving any purpose.
           *)


  let forall = mk_forall 
      !ctx
      bvtys 
      bvnames 
      prop
      None 
      []
      []
      None 
      None
  in
  forall

let mkSetProp (sorts , propfn )  = mkSetUProp (0, sorts, propfn)

let  mkSetExProp (indx, sorts, propfn) =
  let numbvs = Vector.length sorts in 
  let (bvs,indx') = Vector.mapAndFold (sorts, indx, fun (sort,i) -> (mkBoundVar (i,sort), i+1)) in 
  (* 
           * De-brujin. Therefore: bv_n,bv_n-1,...,bv_0 
           *)
  let bvnames = Vector.tabulate (numbvs, fun i -> mkSym  ("ev"^(string_of_int (numbvs-i-1)))) in 
  let bvtys = Vector.rev (Vector.map (sorts,sortToZ3Sort)) in 
  let (patterns,prop) = propfn bvs in 
          (*
           * We currently disable explicit pattern annotations,
           * as they are not serving any purpose.
           *)
  let exists = mk_exists !ctx bvtys bvnames  prop None  []  []    None   None
  in
  exists


let dischargeAssertion assr = 
  let _ = logz3 ("(assert "^(Expr.to_string assr)^")") in 
  let  _ = logz3 "\n"
  in
  _assert (assr)

let assertSetProp (sorts,prop) =
  dischargeAssertion (Quantifier.expr_of_quantifier (mkSetProp (sorts,prop)))
(* 

let assertNumericProp (sorts, prop) = 

 *)
let mkNullSet = fun () -> Null

let mkEmptySet sorts = 
  let (Set {ty;pred} as set) = mkSet (genSetName (),sorts) in 
  let  _ = assertSetProp (sorts, 
                          (fun bvAsts ->
                             let fnapp = pred bvAsts in 
                             let  prop = mk_eq (fnapp) (mk_false ()) in 
                             let  pattern = mk_pattern [fnapp] 
                             in
                             ([pattern], prop) ))

  in
  set 

let  mkSingletonSet asts = 
  let
    sorts = Vector.map (asts,sortOfAst) in 
  let Set {ty;pred} as set = mkSet (genSetName (),sorts) in 
  let _ = assertSetProp (sorts, fun bvAsts ->
      let fnapp = pred bvAsts in 
      let  eqs = Vector.map2 (bvAsts,asts,mkEq) in 
      let  conj = mk_and eqs in 
      let  iff = mk_iff fnapp conj  in 
      let pattern = mk_pattern [fnapp]
      in
      ([pattern], iff)
    )
  in
  set

let mkMultiPatterns multipatlist = List.map (fun terms -> mk_pattern terms) multipatlist

let mkSimplePatterns patlist = List.map (fun pat -> mk_pattern [pat]) patlist


let rec mkEqAssertion (s1,s2) = 
  match  (s1,s2) with 
    (Null,Null) -> truee
  | (Null,Set {ty;_}) -> mkEqAssertion (mkEmptySet ty, s2)
  | (Set {ty;_},Null) -> mkEqAssertion (s1, mkEmptySet ty)
  | (Set {ty=sorts1;pred=pred1}, Set {ty=sorts2;pred=pred2}) -> 
    let () = Printf.printf "%s" "@mkSetEqAssertion" in 


    let setPropQuantifier=  mkSetProp (sorts1, fun bvAsts -> 

        let fnapp1 = pred1 bvAsts in 
        let fnapp2 = pred2 bvAsts in 
        let iff = mk_iff fnapp1 fnapp2 in 
        let pats = mkSimplePatterns [fnapp1;fnapp2]
        in
        (pats,iff)) in 

    Quantifier.expr_of_quantifier setPropQuantifier


let rec mkSetEqAssertion (s1,s2) = 
  match  (s1,s2) with 
    (Null,Null) -> truee
  | (Null,Set {ty;_}) -> mkSetEqAssertion (mkEmptySet ty, s2)
  | (Set {ty;_},Null) -> mkSetEqAssertion (s1, mkEmptySet ty)
  | (Set {ty=sorts1;pred=pred1}, Set {ty=sorts2;pred=pred2}) -> 
    (* let () = Printf.printf "%s" "@mkSetEqAssertion" in 
    *)    (*
           * Pre-condition of sorts1 = sorts2 is automatically
           * checked when pred1 and pred2 are applied
           *)
    let setPropQuantifier=  mkSetProp (sorts1, fun bvAsts -> 

        let fnapp1 = pred1 bvAsts in 
        let fnapp2 = pred2 bvAsts in 
        let iff = mk_iff fnapp1 fnapp2 in 
        let pats = mkSimplePatterns [fnapp1;fnapp2]
        in
        (pats,iff)) in 

    Quantifier.expr_of_quantifier setPropQuantifier

let mkSubSetAssertion (s1,s2) = match (s1,s2) with
    (Null,Null) -> falsee
  | (Null,Set {ty;_}) -> truee
  | (Set {ty;_},Null) -> falsee
  | (Set {ty=sorts1;pred=pred1}, Set {ty=sorts2;pred=pred2}) -> 
          (*
           * Pre-condition of sorts1 = sorts2 is automatically
           * checked when pred1 and pred2 are applied
           *)
    let setPropQuantifier =  mkSetProp (sorts1, fun bvAsts -> 

        let fnapp1 = pred1 bvAsts in 
        let fnapp2 = pred2 bvAsts in 
        let implies = mk_implies !ctx fnapp1 fnapp2 in 
        let pats = mkSimplePatterns [fnapp1;fnapp2] in 

        (pats,implies))
    in 
    Quantifier.expr_of_quantifier setPropQuantifier   

let mkSubSetAssertion (s1,s2) = match (s1,s2) with 
    (Null,Null) -> falsee
  | (Null,Set {ty;_}) -> truee
  | (Set {ty;_},Null) -> falsee
  | (Set {ty=sorts1;pred=pred1}, Set {ty=sorts2;pred=pred2}) -> 
          (*
           * Pre-condition of sorts1 = sorts2 is automatically
           * checked when pred1 and pred2 are applied
           *)
    let setPropQuantifier =  mkSetProp (sorts1, fun bvAsts -> 
        let
          fnapp1 = pred1 bvAsts in 
        let  fnapp2 = pred2 bvAsts in 
        let implies = mk_implies !ctx fnapp1 fnapp2 in 
        let  pats = mkSimplePatterns [fnapp1;fnapp2] in 

        (pats,implies))
    in 
    Quantifier.expr_of_quantifier setPropQuantifier

let mkAddition = function 
  | (Null,s2) -> s2 
  | (s1,Null) -> s1 
  | (Set {ty=sorts1;pred=pred1}, Set {ty=sorts2;pred=pred2}) ->
    let Set {ty;pred} as s  = mkSet (genSetName (), sorts1) in 
    let _ = assertSetProp (ty, fun bvAsts ->
        let fnapp = pred bvAsts in 
        let fnapp1 = pred1 bvAsts in 
        let fnapp2 = pred2 bvAsts in 
        let add = mk_add [fnapp1;fnapp2] in 
        let pats = mkSimplePatterns [fnapp; fnapp1; fnapp2]
        in
        (pats, add)
      )
    in
    s
let mkSubstraction = function 
  | (Null,s2) -> s2 
  | (s1,Null) -> s1 
  | (Set {ty=sorts1;pred=pred1}, Set {ty=sorts2;pred=pred2}) ->
    let Set {ty;pred} as s  = mkSet (genSetName (), sorts1) in 
    let _ = assertSetProp (ty, fun bvAsts ->
        let fnapp = pred bvAsts in 
        let fnapp1 = pred1 bvAsts in 
        let fnapp2 = pred2 bvAsts in 
        let sub = mk_sub[fnapp1;fnapp2] in 
        let pats = mkSimplePatterns [fnapp; fnapp1; fnapp2]
        in
        (pats, sub)
      )
    in
    s


let mkUnion = function 
  | (Null,s2) -> s2 
  | (s1,Null) -> s1 
  | (Set {ty=sorts1;pred=pred1}, Set {ty=sorts2;pred=pred2}) ->
    let Set {ty;pred} as s  = mkSet (genSetName (), sorts1) in 
    let _ = assertSetProp (ty, fun bvAsts ->
        let fnapp = pred bvAsts in 
        let fnapp1 = pred1 bvAsts in 
        let fnapp2 = pred2 bvAsts in 
        let disj = mk_or [fnapp1;fnapp2] in 
        let iff = mk_iff fnapp disj in 
        let pats = mkSimplePatterns [fnapp; fnapp1; fnapp2]
        in
        (pats, iff)
      )
    in
    s
let mkCrossPrd = function 
    (Null,_) ->
    Null 
  |(_,Null) -> Null 
  | (Set {ty=sorts1;pred=pred1}, Set {ty=sorts2;pred=pred2}) ->
    let sorts = Vector.concat [sorts1;sorts2] in
    let Set {ty;pred} as s = mkSet (genSetName (), sorts) in 
    let _ = assertSetProp (ty, fun bvAsts ->

        let bvAsts1 = Vector.prefix bvAsts (Vector.length sorts1) in 
        let bvAsts2 = Vector.dropPrefix (bvAsts, Vector.length sorts1) in 
        let fnapp = pred bvAsts in 
        let fnapp1 = pred1 bvAsts1 in 
        let fnapp2 = pred2 bvAsts2 in 
        let conj = mk_and [fnapp1;fnapp2] in 
        let iff = mk_iff fnapp conj in 
        let pats = mkMultiPatterns [[fnapp]; [fnapp1;fnapp2]]
        in
        (pats, iff)
      )
    in
    s
let mkDiff = function 
    (Null,s2) -> Null 
  | (s1,Null) -> s1 
  | (Set {ty=sorts1;pred=pred1}, Set {ty=sorts2;pred=pred2}) ->
    let Set {ty;pred} as s = mkSet (genSetName (), sorts1) in  
    let _ = assertSetProp (ty, fun bvAsts ->

        let fnapp = pred bvAsts in 
        let fnapp1 = pred1 bvAsts in 
        let fnapp2 = pred2 bvAsts in 
        let nfnapp2 = mk_not fnapp2 in 
        let conj = 	mk_and [fnapp1;nfnapp2] in 
        let iff = mk_iff fnapp conj in 
        let pats = mkSimplePatterns [fnapp ;fnapp1; fnapp2]
        in
        (pats, iff)
      )
    in
    s
let mkQCrossPrd = fun (sets) ->
  let length = Vector.length in 
  let h = fun (x,y) -> (x, Vector.map (y,length), List.concat y) in 
  let (dsorts,lens,rsorts) = h (Vector.unzip(List.map (fun (Set {ty;_}) -> (Vector.sub (ty,0), Vector.dropPrefix (ty,1))) sets)) in 
  let sorts = Vector.concat [dsorts;rsorts] in 
  let Set {ty;pred} as s  = mkSet (genSetName (), sorts) in 
  let _ = assertSetProp (ty, fun bvAsts ->

      let dbvs = Vector.prefix bvAsts (length dsorts) in 
      let rbvs = Vector.dropPrefix (bvAsts, length dsorts) in 
      let (bvss, _) = Vector.map2AndFold (dbvs,lens,rbvs,
                                          fun (dbv,len,rest) -> 
                                            (Vector.concat [Vector.new1 dbv; Vector.prefix rest len], 
                                             Vector.dropPrefix (rest, len))) in 
      let _ = assert (length sets = length bvss) in 
      let fnapps = Vector.map2 (sets, bvss, 
                                fun (Set {pred;_},bvs) -> pred bvs) in 
      let conj = mk_and fnapps in 
      let fnapp = pred bvAsts in 
      let iff = mk_iff fnapp conj in 
      let pats = mkMultiPatterns [[fnapp]; (fnapps)]
      in
      (pats, iff)
    )
  in
  s

let mkQSingletonSet sorts = 
  let len = Vector.length in 
  let qSorts = Vector.concat [sorts;sorts] in 
  let Set {ty;pred} as set  = mkSet (genSetName (),qSorts) in 
  let _ = assertSetProp (qSorts, fun bvAsts ->

      let fnapp = pred bvAsts in 
      let bvAsts1 = Vector.prefix bvAsts (len sorts) in 
      let bvAsts2 = Vector.dropPrefix (bvAsts, len sorts) in 
      let eqs = Vector.map2 (bvAsts1,bvAsts2,mkEq) in 
      let conj = if len eqs = 1 then Vector.sub (eqs,0) 
        else mk_and eqs in 
      let iff = mk_iff fnapp conj in 
      let pattern = mk_pattern [fnapp] 
      in
      ([pattern], iff)
    )
  in
  set

let mkQStrucRelApp (SR {ty;rel}) = 
  Set {ty=ty; pred=
                fun bvs ->
                  let bv0 = Vector.sub (bvs,0) in 
                  let bvs'= Vector.dropPrefix (bvs,1) in 
                  let Set {pred;_} = rel bv0
                  in
                  pred bvs'
      }

let mkBind  = function 
  | (Set {ty=ty1; pred=pred1}, Set {ty=ty2; pred=pred2}) ->
    let length = Vector.length in 
    let srDomain = Vector.sub (ty1,0) in 
    let sorts = Vector.concat [Vector.new1 srDomain;
                               ty2] in 
    let Set {ty;pred} as s = mkSet (genSetName (), sorts) in 
    let _ = assertSetProp (ty, fun bvAsts ->

        let bvs1 = Vector.prefix bvAsts (length ty1) in 
        let bvs2 = Vector.dropPrefix (bvAsts,1)  in 
        let fnapp1 = pred1 bvs1 in 
        let fnapp2 = pred2 bvs2  in 
        let conj = mk_and [fnapp1;fnapp2] in 
        let fnapp = pred bvAsts in 
        let iff = mk_iff fnapp conj in 
        let pats = mkMultiPatterns [[fnapp]; [fnapp1;
                                              fnapp2]] in 

        (pats, iff)
      )
    in
    s
  | (Null,_) -> Null 
  | (_,Null) -> Null

let assertBindIf (Set {ty=ty1;pred=pred1}, Set {ty=ty2;pred=pred2}) =
  let length = Vector.length in 
  let suffix = fun (l,n) -> Vector.dropPrefix 
      (l, (length l)-n) in 
  let sorts = ty2 in 
  let prop = mkSetProp (sorts, fun bvAsts ->

      let rLen1 = (length ty1) - 1 in 
      let bvs10 = Vector.sub (bvAsts,0) in 
      let bvs11 = suffix (bvAsts,rLen1) in 
      let bvs1 = Vector.concat [Vector.new1 bvs10;bvs11] in 
      let bvs2 = bvAsts in 
      let fnapp1 = pred1 bvs1 in 
      let fnapp2 = pred2 bvs2 in 
      let imp = mk_implies !ctx fnapp2 fnapp1 in 
      let pats = mkMultiPatterns [[fnapp2; fnapp1]]
      in
      (pats, imp)
    )
  in
  let expr_for_prop = Quantifier.expr_of_quantifier prop in 
  dischargeAssertion expr_for_prop

let assertBindOnlyIf  = function 
  |(Set {ty=ty1;pred=pred1},
    Set {ty=ty2;pred=pred2}) ->
    let length = Vector.length in 
    let usorts = ty1 in 
    let dLen1 = 1  in 
    let rLen1 = (length ty1) - dLen1 in 
    let exsorts = Vector.dropSuffix(Vector.dropPrefix 
                                      (ty2,dLen1),rLen1) in 
    let exi = 0 in 
    let ui = length exsorts in 
    let expropfn ((ubvs : ast list), (exbvs:ast list)) =

      let fnapp1 = pred1 ubvs in 
      let allbvs = Vector.concat [
          (Vector.new1 (Vector.sub (ubvs,0)));
          exbvs;
          Vector.dropPrefix (ubvs,1)] in 
      let fnapp2 = pred2 allbvs in 
      let imp = mk_implies !ctx fnapp1 fnapp2 in 
      let pats = mkMultiPatterns [[fnapp1; fnapp2]] in 

      (pats,imp)
    in 
    let uprop = mkSetUProp (ui,usorts, fun ubvs ->

        let fnapp1 = pred1 ubvs in 
        let exprop = mkSetExProp (exi, exsorts, 
                                  fun exbvs ->
                    (*
                    let _ = print "Ex bvs are: "
                    let _ = print $ Vector.toString astToString exbvs
                    let _ = print "\n fnapp1 is: "
                    let _ = print $ Z3_ast_to_string (ctx,fnapp1)
                    let _ = print "\n"
                    *)
                                    expropfn (ubvs,exbvs)
                                 ) in 
        let pats = mkSimplePatterns []
        in
        (pats, Quantifier.expr_of_quantifier exprop)
      )
    in
    dischargeAssertion (Quantifier.expr_of_quantifier uprop)

  |  _ -> failwith "Bind eqn with null set"

let assertBindEq x = (assertBindIf x ; assertBindOnlyIf x)

let mkUAssertion (asts,assn) =
  let asts = Vector.map (asts, fun ast -> astToZ3Ast ast) in 
  let forall = mk_forall_const 
      !ctx 
      asts
      assn
      None 
      []
      []
      None 
      None  

  in
  Z3.Quantifier.expr_of_quantifier forall

let mkNot assr = mk_not assr 

let mkIf (asr1,asr2) = mk_implies !ctx asr1 asr2 

let mkIff (asr1,asr2) = mk_iff  asr1 asr2 

let mkAnd asrv = mk_and asrv 

let mkOr asrv = mk_or asrv 


let mkConstEqAssertion (AST (x1,s1) as ast1, AST (x2,s2)) = 
  (typeCheckAst (ast1,s2); mk_eq x1 x2)

let mkConstGtAssertion (AST (x1,s1) as ast1, AST (x2,s2)) = 
  (typeCheckAst (ast1,s2); mk_gt x1 x2)

(* 
let mkInt i = AST (Symbol.mk_int i,  mk_int_sort)
 *)

(****************** Encoding Numeric Expressions ***************)
(*
(declare-fun rlen (Int) Int)
(declare-const a0 Int)
(declare-const b1 Int)
(declare-const xs Int)
(declare-const l1 Int)
(declare-const l2 Int)
(declare-const t1 Int)
(declare-const t2 Int)
(declare-fun u (Int Int) Int)

(assert (= b1 1))
(assert (= (rlen l1) (u (rlen xs) b1)))
(assert (= (rlen t1) (u (rlen xs) (rlen l2))))
(assert (= (rlen t2) (u (rlen t1) b1)))

(assert (not (= (rlen t2) (u (rlen l1) (rlen l2)))))
(check-sat)
(get-model)***)


let mk_Numeric_constant i = 
  let const1 = Integer.mk_numeral_i !ctx i in
  const1 

let mk_Integer_var_constant name = 
  let const1 =  Expr.mk_const !ctx (mkSym name) (mk_int_sort ())in    
  const1

let mk_Integer_func_decl (name, arg_sorts, res_sort) = 
  let relnfunc = FuncDecl.mk_func_decl !ctx (mkSym name) arg_sorts res_sort in    
  relnfunc

let mk_Integer_rel_app (relfunc, args) =
  mk_app relfunc args   

let mk_Integer_addition (arg1, arg2) = 
  let addition = mk_add  [arg1;arg2] in 
  addition

let mk_Integer_substraction (arg1, arg2) = 
  let subs = mk_sub  [arg1;arg2] in 
  subs   
let mk_Integer_eq (e1, e2) = 
  let eqexpr =mk_eq e1 e2 in 
  eqexpr   
let mk_Integer_gt (e1, e2) = 
  let gtexpr = mk_gt e1 e2 in 
  gtexpr
let mk_arithmetic_const name sort = 
  let const =   Expr.mk_const !ctx (mkSym name) (sort) in
  const

(* 
let mk_length_assertions () = 

    let relnfunc = FuncDecl.mk_func_decl !ctx (mkSym "rlen") [mk_int_sort ()] (mk_int_sort()) in 
    let const0 = Expr.mk_const !ctx (mkSym "a0") (mk_int_sort ())in 
    let const1 = Expr.mk_const !ctx (mkSym "b1") (mk_int_sort ()) in 
    let constxs = Expr.mk_const !ctx (mkSym "xs") (mk_int_sort ())in 
    let constl1 = Expr.mk_const !ctx (mkSym "l1") (mk_int_sort ())in 
    let constl2 = Expr.mk_const !ctx (mkSym "l2") (mk_int_sort()) in
    let constt1 = Expr.mk_const !ctx (mkSym "t1") (mk_int_sort()) in 
    let constt2 = Expr.mk_const !ctx (mkSym "t2") (mk_int_sort()) in 

    let ass1 = mk_eq const1 (Integer.mk_numeral_i !ctx 1) in 
    let ()  = dischargeAssertion ass1  in 
    let ass2 = mk_eq (mk_app relnfunc [constl1]) (mk_add  [(mk_app relnfunc [constxs]);  const1])  in 
    let () = dischargeAssertion ass2 in 
    let ass3 = mk_eq (mk_app relnfunc [constt1]) (mk_add  [(mk_app relnfunc [constxs]);  (mk_app relnfunc [constl2])])  in 
    let () = dischargeAssertion ass3 in 
    let ass4 = mk_eq (mk_app relnfunc [constl1]) (mk_add  [(mk_app relnfunc [constt1]);  const1])  in 
    let () = dischargeAssertion ass4 in 

    let assfinal = mk_not (mk_eq (mk_app relnfunc [constt2]) (mk_add  [(mk_app relnfunc [constl1]) ; (mk_app relnfunc [constl2])])) in 
    dischargeAssertion assfinal
 *)

