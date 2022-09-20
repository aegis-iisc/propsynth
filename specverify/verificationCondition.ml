
open SpecLang
open SpecMap
module P = Predicate
module BP = Predicate.BasePredicate
module RP = Predicate.RelPredicate
module RelId = RelId
module TS = TupSort
module PR = PrimitiveRelation
module SPS = SimpleProjSort
module PSS = ProjSortScheme
module PTS = ProjTypeScheme
module RefTy = RefinementType
module PRf = ParamRefType
module RefSS = RefinementSortScheme
module RefTyS = RefinementTypeScheme
module RI = RelId
module Env = TyDBinds
module L = Layout
module PRE = ParamRelEnv
module VE = VarEnv 
module RE = RelEnv
module TyD = TyD


(* module Printf = struct 
  let printf f s = ()
  let originalPrint = Printf.printf 


end  
 *) 


exception TrivialVC (* raised when antecedent has false *)
exception Failed of string
type tydbind = Var.t * TyD.t
type tydbinds = tydbind list
type bindings = {tbinds:tydbinds; rbinds:PRE.t}

type simple_pred = True
                 | False
                 | Base of BP.t 
                 | Rel of RP.t

type vc_pred =  Simple of simple_pred
             |  If of vc_pred * vc_pred
             |  Iff of vc_pred * vc_pred
             |  Conj of vc_pred list
             |  Disj of vc_pred list
             |  Not of vc_pred


type t = T of bindings * vc_pred * vc_pred

let empty = fun _ -> []

let len = Vector.length

let (<<) f g x = f (g x)

let vector_append (l, e) = List.concat[l;[e]]

let vector_prepend (e, l) = List.concat[[e];l]


(*define vector doubl fold_right*)    

let vectorAppend (vec,e) = List.concat [vec;[e]]
let vectorPrepend (e,vec) = List.concat [[e];vec]
let  vectorFoldrFoldr vec1 vec2 acc f = List.fold_right (fun el1 acc -> List.fold_right (fun el2 acc -> f el1 el2 acc) vec2 acc) vec1 acc 


let vector_foldr_foldr (vec1,vec2,acc,f) = 
  List.fold_right2 f vec1 vec2 acc

let addPredicate (T (bindings,pre,post)) new_pred = 
    let conjunct = (Conj [pre;new_pred]) in 
    T (bindings, conjunct, post)


let conj (p1 ,p2 ) : vc_pred = 
  match (p1,p2) with 
    (Simple True,_) -> p2
  | (_, Simple True) -> p1
  | (Simple False,_) -> Simple False
  | (_, Simple False) -> Simple False
  | (Simple sp1,Conj spv) -> Conj ( vector_prepend (p1,spv) )
  | (Conj spv,Simple sp2) -> Conj ( vector_append (spv,p2) )
  | (Conj spv1,Conj spv2) -> Conj ( Vector.concat [spv1;spv2] )
  | _ -> Conj ( Vector.new2 (p1,p2) )

let disj(p1 ,p2 ) : vc_pred = 
  match (p1,p2) with 
    (Simple True,_) -> Simple True
  | (_, Simple True) -> Simple True
  | (Simple False,_) -> p2
  | (_, Simple False) -> p1
  | (Simple sp1,Disj spv) -> Disj ( vector_prepend (p1,spv))
  | (Disj spv,Simple sp2) -> Disj ( vector_append (spv,p2))
  | (Disj spv1,Disj spv2) -> Disj ( Vector.concat [spv1;spv2])
  | _ -> Disj (Vector.new2 (p1,p2))

let negate (p : vc_pred) : vc_pred = 
  match p with
    Simple True -> Simple False
  | Simple False -> Simple True
  | _ -> Not p

let rec coercePTtoT (pt) = 
  match  pt with

    P.True -> Simple True
  | P.False -> Simple False
  | P.Base p -> Simple ( Base p)
  | P.Rel p -> Simple ( Rel p)
  | P.Not p -> negate ( coercePTtoT p)
  | P.If (p1,p2) -> If (coercePTtoT p1, coercePTtoT p2)
  | P.Iff (p1,p2) -> Iff (coercePTtoT p1, coercePTtoT p2)
  | P.Conj (p1,p2) -> 
      let
        t1 = coercePTtoT p1 in
      let t2 = coercePTtoT p2
      in
      conj (t1,t2)

  | P.Disj (p1,p2) -> disj (coercePTtoT p1, coercePTtoT p2)
  | _ -> raise (Failed "Cannot coerce PT to T")

let truee () : vc_pred = Simple True
let falsee () : vc_pred = Simple False


(*
   * join-order(vc,vc1,vc2) : binds = binds1@binds2
   *                          envP = envP1 /\ envP2
   *)
let joinVCs ((binds1,envP1),(binds2,envP2)) : (tydbinds * vc_pred) =
  (Vector.concat [binds1;binds2],conj (envP1,envP2))

  (*
   * forall vc1 in vcs1 and vc2 in vcs2, vc is in vcs s.t
   * join-order (vc,vc1,vc2)
   *)
let  join (vcs1,vcs2) = 

  match (Vector.length vcs1, Vector.length vcs2) with
    (0,_) -> vcs2
  | (_,0) -> vcs1
  | _ -> 
       
      let  vcs = 
        try 
        vectorFoldrFoldr vcs1 vcs2 [] (fun vc1 vc2 acc -> (joinVCs (vc1, vc2)):: acc)  
        with
        | _ -> failwith "JOIN" 
      in 
      vcs

let rec havocPred (pred) : (tydbinds*vc_pred) list =
  let
    trivialAns () = Vector.new1 (Vector.new0(),coercePTtoT pred)
  in
  match pred with
    P.Exists (tyDB,p) -> 
      let
        mybinds =  tyDB in 
      let vcs = havocPred p
      in
  (*   let _ = Printf.printf "%s" ("HAVOC Exists") in 
      let _ = Printf.printf  "\n" in 
 *)
     
      Vector.map (vcs, fun (binds,envP) ->
          (Vector.concat [mybinds;binds],envP))

  | P.Conj (p1,p2) ->
      let
        vcs1 = havocPred p1 in 
      let vcs2 = havocPred p2
      in
      (* conj is a join point *)
      join (vcs1,vcs2)

  | P.Dot (p1,p2) -> 
  (*  let _ = Printf.printf "%s" ("HAVOC DOT") in 
      let _ = Printf.printf  "\n" in 
 *)
    Vector.concat [havocPred p1;
                                    havocPred p2]
  | _ -> (* let _ = Printf.printf "%s" ("HAVOC TrivialVC") in 
    *)
  trivialAns () (* May need havoc here.*)


let rec havocTyBind (v ,refTy) =
  let open RefTy in 
  let decomposeTupleBind = RefTy.decomposeTupleBind
  in
  match refTy with
  (* removing any _mark_ *)
    Base (_,TyD.Tunknown,_) -> Vector.new0 ()
  | Base (bv,td,pred) -> 
      let
        pred' = P.applySubst (v,bv) pred in 
      let  vcs = havocPred pred'  in 
      let  mybind = (v,td) in 

      Vector.map (vcs,fun (binds,envP) -> 
          (vector_append (binds,mybind),envP))

  | Tuple _ -> havocTyBindSeq ( decomposeTupleBind (v,refTy))
  (* Bindings for functions not needed *)
  | _ -> Vector.new0 ()

and havocTyBindSeq tyBinds =
  List.fold_left (fun (vcs1) (tyBind)-> join (vcs1,havocTyBind tyBind)) 
    (Vector.new1 (Vector.new0 (),truee())) tyBinds

let havocVE (ve ) =
  let
      (*
       * Remove polymorphic functions and constructors
       *)
    vevec = Vector.keepAllMap (ve, 
                               fun (v,RefTyS.T{tyvars;refss;_}) -> 
                                 match Vector.length tyvars with
                                   0 ->  Some (v,RefSS.toRefTy refss)
                                 | _ -> None)  in 
      (*
       * Remove true and false constructors
       *)
  let vevec = Vector.keepAllMap (vevec, 
                                 fun (v,refty) -> 
                                   match refty with
                                     RefTy.Base (_,_,p) -> 
                                       let isPT = match p with 
                                         | True -> true 
                                         | _ -> false in 

                                       if(isPT && ((Var.toString v = "true") 
                                                   || (Var.toString v = "false"))) then None 
                                       else Some (v,refty)
                                   | _ -> Some (v,refty))
  in
  havocTyBindSeq vevec
(*COrrect this in the simplest possible way *)


let rec fromTypeCheck (ve, pre, subTy, supTy)  = 
  let
    open RefTy
  in

  try 
    match (subTy,supTy) with
      (Base (_,TyD.Tunknown,p),_) -> 
        let () = Printf.printf "%s" ("@@"^(Layout.toString (P.layout p)))  in 
        if P.isFalse p 
        then raise TrivialVC else 
        
         raise (Failed "ML type of subtype is unknown") 
    | (Base (v1,t1,p1), Base (v2,t2,p2)) -> 
            (*
             * First, make sure that base types are same.
             *)
        let _ = assert (TyD.sametype t1 t2) in 
            (*
             * Second, substitute actuals for formals in p2
             *)
    
        let p2 = P.applySubst (v1,v2) p2 in 
        let ve = VE.add ve (v1,RefTyS.generalize (Vector.new0 (),
                                                  RefSS.fromRefTy (RefTy.fromTyD t1))) in 
        let envVCs = fun _ -> havocVE ve in 
        
       
        let anteVCs = fun _ -> havocPred p1 in 
        let vcs = fun _ -> join (envVCs (),anteVCs ()) in 
        
             

        let conseqPs = fun _ -> 
          match coercePTtoT p2 with
            Conj vcps -> vcps 
          | vcp -> Vector.new1 (vcp)
        in

        (*currently the match case does not end after the value*)
        let res = match p2 with
            True ->
              let () = Printf.printf "%s" ("@Empty Case ") in  
              []
          | _ -> 
              let folding_f = 
                fun (tybinds,anteP) (conseqP) (vcacc) ->
                  match anteP with
                    Simple False -> 
                      vcacc
                  | _ -> (T ( {tbinds=tybinds; rbinds=pre} , anteP, conseqP)) :: vcacc  
              in
            let vcl = List.length (vcs()) in 
            let cpl = List.length (conseqPs ()) in 
            
              vectorFoldrFoldr (vcs()) (conseqPs()) ([]) (folding_f)  
        in
        res    


    | (Tuple t1v,Tuple t2v) -> 
        
        List.concat (List.map2 
                       (fun (v1,t1) (v2,t2) -> 
                          fromTypeCheck (ve,pre,t1,t2)) t1v t2v )
    | (Arrow ((arg1,t11),t12),Arrow ((arg2,t21),t22)) -> 

        let
          vcs1 = fromTypeCheck (ve,pre,t21,t11) in 
        (* 
             * Typecheck results modulo argvar
              *)

        let () = Printf.printf "%s" ("\n RefType res subty before "^(RefTy.toString t12)) in 
        
        (*get the argument from t11 and t12*)


        let t12' = RefTy.applySubsts (Vector.new1 (arg2,arg1)) t12 in 
           
         let () = Printf.printf "%s" ("\n RefType res subty Afetr "^(RefTy.toString t12')) in   (*
             * Extend the environment with type for arg2
             *)
        let ve'  = VE.add ve (arg2, RefTyS.generalize 
                                (Vector.new0 (), RefSS.fromRefTy t21)) in 
        let vcs2 = fromTypeCheck (ve',pre,t12',t22)
        in
        Vector.concat [vcs1; vcs2]
  with   
  |e -> raise e

(* -- VC Elaboration -- *)
  (*
   * This rinst has relIds as its arguments.
   *)
type rinst = RInst of {targs : TyD.t list;
                       sargs : TS.t list;
                       rargs : RelId.t list;
                       rel : RelId.t}
type rsorted = {rel:RelId.t; sort : SPS.t}



module RelInstTable =

struct

  module RIKey = 
  struct
    type t = rinst
    let len = Vector.length  
    let layout = fun (RInst {targs;sargs;rargs;rel}) -> L.str ( 
        RelLang.ieToString (RelLang.RInst {targs=targs; sargs=sargs;
                                           args=Vector.map (rargs,RelLang.instOfRel); rel=rel}) )
    let idStrEq = fun (id1,id2) -> (RI.toString id1 = RI.toString id2)
    let equal (RInst {rel=id1; targs=targs1; 
                      sargs=sargs1; rargs=rargs1}, 
               RInst {rel=id2; targs=targs2; 
                      sargs=sargs2; rargs=rargs2}) =

      let eq = (RI.equal (id1,id2)) &&
               (len targs1 = len targs2) &&
               (List.for_all2 (TyD.sametype) targs1 targs2) &&
               (len sargs1 = len sargs2) &&
               (List.for_all2 (TS.equal) sargs1 sargs2) &&
               (len sargs1 = len sargs2) &&
               (List.for_all2 (TS.equal) sargs1 sargs2) &&
               (len rargs1 = len rargs2) &&
               (List.for_all2 (fun x y -> RI.equal (x,y)) rargs1 rargs2)
      in
      eq


  end

  module RIValue =
  struct
    type t = rsorted
    let layout {rel;sort} = L.str ((RI.toString rel) ^"::" 
                                   ^(SPS.toString sort) )
  end
  module Map = ApplicativeMap (RIKey)
      (RIValue)
  include Map
end

(*The bound equation *)
module RIT = RelInstTable


exception Return of (RIT.t * RI.t)
exception SVarNotFound
exception ReturnPRE of PRE.t


module SVarHash =
struct
  type t = SVar.t
  let equal t1 t2  = SVar.eq t1 t2
  let hash t1  = int_of_string (SVar.toString t1)  
end

module SVarHashtbl = Hashtbl.Make (SVarHash) 

let elaborate (re,pre,vc) =

  let count = ref 0 in 
  (* let genSym = fun idbase -> 
    let symbase = (*"_"^*)(RI.toString idbase) in 
    let id = symbase ^ (string_of_int (!count)) in 
    let _ = count := !count + 1 
    in
    RI.fromString id in 
   *)
  let genSym = fun idbase -> idbase  in 

  let inv = fun (x,y) -> (y,x) in 
  let fst = fun (x,y) -> x in 
  let snd = fun (x,y) -> y in 
  let mapFoldTuple b f (x,y) =
    ((fun (b',x') -> 
        ((fun (b'',y') -> (b'',(x',y'))) << (f b')) y) 
     << (f b)) x  in 
  let  mapSnd f (x,y) = (x,f y) in 

  let T ({tbinds=tydbinds;rbinds},anteP,conseqP) = vc in

  let tyDB = Vector.fold (tydbinds,TyDBinds.empty, 
                          fun ((v,tyd),tyDB) -> TyDBinds.add tyDB v tyd) in 
      (*
       * initRIT contains params from typespecs. Variable rbinds is a
       * PRE and not RE, as it lets us use same VC.t to represent both
       * high-level and elaborated VCs.
       *)
  let initRIT = Vector.fold ( rbinds, RIT.empty, 
                              fun ((r,{tys;_}),rit) ->
                                let PTS.T {sortscheme=PSS.T {sort = ProjSort.T {sort; 
                                                                                _}; _};_} = tys in 
                                let letue = {rel=r;sort=sort} in 
                                let key = RInst {rel=r;targs=empty();sargs=empty();
                                                 rargs=empty()} 
                                in
            (*
             * A rel-param is its own instantiation
             *)
                                RIT.add rit key letue
                            ) in 

  let getSymForRInst rit rinst = 
    try 
      let res = 
        let temp = RIT.find rit rinst in 
        temp.rel
      in 
      Some res 
    with
    | RIT.KeyNotFound _ -> None  
  in 


  let  doItPRInst (RelLang.RInst {targs;sargs;args;rel} as ie) rit
    : (RIT.t * RI.t) = 
    try 
      let rinst = RInst {rel=rel; targs=targs; sargs=sargs;
                         rargs = Vector.map (args, 
                                             fun (RelLang.RInst {rel;_}) -> rel)} in 
      let _ = match getSymForRInst rit rinst with 
          None -> ()
        | Some rel' -> raise (Return (rit,rel')) in 

      let rel' = genSym rel in 
      let err = fun _ -> (Failed ("Unknown prim rel "^(RI.toString rel))) in 

      let relTyS =
        let open ParamRelEnv in  
        let {tys;_} = (PRE.find pre rel)  in
        tys in 

      let PSS.T {sort;_} = PTS.instantiate (relTyS,targs) in 
      let ProjSort.T {sort=sps; _} = sort in 
      let SPS.ColonArrow (prD,prR) = sps in 

      let rec rangeOf = function  
        |(TyD.Tarrow (_,tye)) -> (rangeOf tye )
        | tyd -> tyd 
      in 
      let rinstSort = SPS.ColonArrow (rangeOf prD,prR) in 
      let rit' = RIT.add rit rinst {rel=rel';sort=rinstSort}
      in
      (rit',rel')
    with 
    | (Return a) -> a

  in 

  let rec doItIE ( RelLang.RInst {targs;sargs;args;rel} as ie) rit 
    : (RIT.t * RI.t) =
    try 
      let len = Vector.length in 

      let _ = 
        let parrel = PRE.find pre rel in 
        let def = parrel.def in 
        try 
          match def with 
            PRE.Prim _ -> raise (Return  (doItPRInst ie rit))
          | _ -> ()
        with  
        | PRE.ParamRelNotFound _ -> () in 

      let (syms,rit') = Vector.mapAndFold (args,rit,
                                           fun (ie,rit) -> inv  (doItIE ie rit)) in  
      let rinst = RInst {targs=targs;sargs=sargs;rargs=syms;
                         rel=rel} in 
          (*
           * Note: When rel is a rel-param, then syms is an empty
           * vector. Map rit, which is derived from initRIT, already
           * maps rel-params (from rbinds) to themselves.
           *)
      let _ = match  getSymForRInst rit' rinst with 
          None -> ()
        (* If rel-param, always returns *)
        | Some rel' -> raise (Return (rit',rel')) in  
      let rel' = genSym rel in 
      let err = fun _ -> Failed ("Unknown rel "^(RI.toString rel)) in 
      (* Obs : Pulling #ty out of case fails typecheck *)

      let relTyS =
       (*  let open ParamRelEnv in
        let open RelEnv in   
        *) try  
          match len args with  
            0 -> let open RE in let {ty;_} = (RE.find re rel) in ty  
          | _ -> let open PRE in let {tys;_} = (PRE.find pre rel) in tys 
        with 
        |PRE.ParamRelNotFound _ ->  raise (err())   
        | RE.RelNotFound _ ->  raise (err())
      in 
      let relSS = PTS.instantiate (relTyS,targs) in 
      let ProjSort.T {sort;_} = PSS.instantiate (relSS,sargs) in 
      let rit'' = RIT.add rit' rinst {rel=rel';sort=sort}
      in
      (rit'',rel')
    with 
    | (Return a) -> a
  in 

  let rec doItRExpr (rit:RelInstTable.t) rexpr
    : (RIT.t * RelLang.expr) =
    let g = mapFoldTuple rit doItRExpr
    in
    match rexpr with
      RelLang.T _ -> (rit,rexpr)
    | RelLang.X (x,y) -> mapSnd (fun (x,y) -> RelLang.X (x,y)) (g (x,y))
    | RelLang.U (x,y) -> mapSnd (fun (x,y) -> RelLang.U (x,y)) (g (x,y))
    | RelLang.D (x,y) -> mapSnd (fun (x,y) -> RelLang.D (x,y)) (g (x,y))
    | RelLang.ADD (x,y) -> mapSnd (fun (x,y) -> RelLang.ADD (x,y)) (g (x,y))
    | RelLang.SUBS (x,y) -> mapSnd (fun (x,y) -> RelLang.SUBS (x,y)) (g (x,y))
    | RelLang.R (ie,v) -> 

        let (rit',newRel) = doItIE ie rit in 
              (*
               * Obs: We would ideally like to have a modified
               * instexpr type which is just RI.t. However, this
               * requires entirely new SpecLang. 
               *)
        let ie' = RelLang.RInst {targs=empty();sargs=empty();
                                 args=empty(); rel=newRel}
        in
        (rit', RelLang.R (ie',v))
  in 


  let elabRPred (tab : RelInstTable.t) rpred = match  rpred with
      RP.Eq (e1, e2) -> mapSnd (fun (e1, e2) -> RP.Eq (e1, e2)) (mapFoldTuple tab doItRExpr (e1, e2))
    | RP.Sub (e1, e2) -> mapSnd (fun (e1, e2) -> RP.Sub (e1, e2)) (mapFoldTuple tab doItRExpr (e1, e2))
    | RP.SubEq (e1, e2) -> mapSnd (fun (e1, e2) -> RP.SubEq (e1, e2)) (mapFoldTuple tab doItRExpr (e1, e2))

  in 

  let elabSimplePred (rinstTab : RelInstTable.t) sp = 
    match sp with 
      Rel rpred -> mapSnd (fun x -> Rel x) (elabRPred rinstTab rpred)
    | _ -> (rinstTab,sp)

  in 
  let rec elabVCPred (rinstTab : RelInstTable.t) (vcpred:vc_pred) :
    (RelInstTable.t*vc_pred) = 
    match vcpred with
      Simple sp  -> mapSnd (fun x -> Simple x) (elabSimplePred rinstTab sp)
    | Conj vcps -> mapSnd (fun xl-> Conj xl) ((inv << Vector.mapAndFold) 
                                                (vcps, rinstTab, fun (vcp,rt) -> inv ( elabVCPred rt vcp)))
    | Disj vcps -> mapSnd (fun xl-> Disj xl) ((inv << Vector.mapAndFold) 
                                                (vcps, rinstTab, fun (vcp,rt) -> inv (elabVCPred rt vcp)))
    | Not vcp -> mapSnd (fun xl-> Not xl) (elabVCPred rinstTab vcp)
    | If (vcp1, vcp2) -> mapSnd (fun (x1,x2)-> If (x1,x2))  (mapFoldTuple rinstTab elabVCPred (vcp1, vcp2))
    | Iff (vcp1, vcp2) -> mapSnd (fun (x1,x2)-> If (x1,x2)) (mapFoldTuple rinstTab elabVCPred (vcp1, vcp2))

  in 
  let (rinstTab,anteP') = elabVCPred initRIT anteP in 
  let (rinstTab,conseqP') = elabVCPred rinstTab conseqP in 
(*

      (*
       * Encode svars as tyvars.
       *)

*)


  let sMap = SVarHashtbl.create 20 in

  let encodeSVar = 
    fun v -> 
      try 
        SVarHashtbl.find sMap v 
      with
      | Not_found -> 
          let tyvar = TyD.makeTvar (Tyvar.fromString (SVar.toString v)) in 
          let _ = SVarHashtbl.add sMap v tyvar
          in
          tyvar 
  in 

    let newtydbinds = Vector.map (RelInstTable.toVector rinstTab,
                                  fun (_,{rel=relId';sort}) ->
                                    let SPS.ColonArrow (tyd,TS.Tuple tts) = sort in 
                                    let tydvec =tyd :: (Vector.map (tts, 
                                                                    fun tts -> match  tts with
                                                                        TS.T tyd -> tyd 
                                                                      | TS.S t ->  encodeSVar t)) in 
                                    (*How we create a boolean type??*)
                                    let boolTyD = TyD.makeTbool () in 
                                    let relArgTyd = TyD.Ttuple (tydvec) in 
                                    let relTyD = TyD.makeTarrow ((relArgTyd), (boolTyD)) in
                                    let rtov = Var.fromString << RelId.toString in 
                                    let relvid = rtov relId'
                                    in 
                                    (relvid,relTyD)
                                 ) in 

  (* --- new tydbinds generation done --- *)

  let instPrimRelDef def (RInst {rargs;rel; _}) =

    let rtov = Var.fromString << RelId.toString in 
    let argVars = Vector.map (rargs, rtov) in 
    let def' = PR.instantiate (def,argVars) []
    in
    def'

  in   
  
  let instParamRelDef def (RInst {targs;sargs;rargs;rel}) =
     
      let abs = Bind.instantiate (def, targs, rargs) in 
      let Bind.Abs (bv,expr) = abs in 
      let Bind.Expr {ground=(grel,gtargs,_); fr} = expr in 
      let grinst = RInst {targs=gtargs; sargs=empty();
        rargs=empty(); rel=grel} in 
      let {rel=grAlias;_} = 
          try 
            RIT.find rinstTab grinst 
           with   
           | RIT.KeyNotFound _ -> failwith "GRel Inst not found"
      in      
      let expr' = Bind.Expr {ground=(grAlias,empty(),bv); fr=fr} in 
      let abs' = Bind.Abs (bv,expr') in 
      let def' = Bind.fromAbs abs' 
     in
      def'
      
     in  
 
    (*
    * newPre contains instantiated definitions of instantiated
    * parametric/primitive relations.
    * rinstTab was already processed to generate newtydbinds.
    * Therefore, type declarations of all relations in newPre are
    * present in tbinds of elaborated VC.t.
    *)
    let newPre =
    let open PRE in 
     List.fold_right 
     (fun (rinst, {rel=newRel;sort}) (newPre) ->
        try 
          let RInst {rel;rargs; _} = rinst in 
          let {def;_} = 
            try 
              PRE.find pre rel 
             (*
              * r \in domain(rinstTab) /\ r \notin domain(pre) ->
              * r is a rel-param
              *)
             with 
             |PRE.ParamRelNotFound _ -> raise (ReturnPRE newPre) 
           in   
           let def'  = match (def, len rargs) with
             (PRE.Prim pdef, _) -> PRE.Prim (instPrimRelDef (pdef) (rinst))
           | (PRE.Bind bdef, 0) -> raise (ReturnPRE newPre)
           | (PRE.Bind bdef, _) -> PRE.Bind (instParamRelDef bdef rinst)
         in
           PRE.add newPre (newRel,{tys=PTS.simple (empty,sort); 
             def=def'})
          with 
        |ReturnPRE newPre -> newPre
      )
       (RIT.toVector rinstTab) PRE.empty
    
    in 
    let tydbinds' = Vector.concat [tydbinds;newtydbinds] in 
    let bindings = {tbinds=tydbinds'; rbinds=newPre} in 
      (*
      let _ = print "RelInstTable : \n"
      let _ = Control.message (Control.Top, fun _ ->
        RIT.layout rinstTab)
      *)

  T (bindings,anteP',conseqP')


let layout (vcs : t list) =

  let laytTyDBinds tybinds = L.vector (Vector.map (tybinds,
                                                   fun (v,tyd) -> L.str ((Var.toString v) ^ " : " ^ 
                                                                         (TyD.toString tyd) ^ "\n"))) in 

  let laytSimplePred sp = match sp with 
      True -> L.str "true"
    | False -> L.str "false"
    | Base bp -> L.str ( BP.toString bp)
    | Rel rp -> L.str (RP.toString rp )

  in 
  let rec laytVCPred vcpred = match vcpred with 
      Simple p -> laytSimplePred p
    | Conj vcv -> L.align (Vector.toListMap (vcv,
                                             fun vc -> L.seq [laytVCPred vc ; L.str "\n"]))
    | Disj vcv -> L.align ( Vector.toListMap (vcv,
                                              fun vc -> L.seq [L.str "OR [";laytVCPred vc; L.str "]"]))
    | Not vc -> L.seq [L.str "NOT ["; laytVCPred vc; L.str "]"]
    | If (vc1,vc2) -> L.seq [laytVCPred vc1; L.str " -> "; 
                             laytVCPred vc2]
    | Iff (vc1,vc2) -> L.seq [laytVCPred vc1; L.str " <-> "; 
                              laytVCPred vc2]
  in 

  let layoutVC (T ({tbinds=tybinds;rbinds=pre},vcp1,vcp2)) = 



    (*         Pretty.nest ("bindings",
    *)       let t1 = L.seq[ L.str "bindings \t \n";
            laytTyDBinds tybinds;
    (*   T {length = L.length_tree (laytTyDBinds tybinds); tree =laytTyDBinds tybinds}; 
     *)  PRE.layout pre] in 
    let t2 = L.seq[ L.str " in \t \n";
        L.indent(laytVCPred vcp1,3);
        L.str "=>";
        L.indent (laytVCPred vcp2,3) ; L.str "\n"] in 

    L.seq [t1;t2]  
  in
  L.align (Vector.toListMap (vcs, layoutVC))

let layouts (vcs) =
  L.seq [(L.str "Verification Conditions:\n") ; (layout vcs)]


