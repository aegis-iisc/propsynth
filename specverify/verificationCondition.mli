	
  open SpecLang
  module VE = VarEnv
  module RE = RelEnv
  module PRE = ParamRelEnv
  module TyD = TyD

   type simple_pred = 
        | True 
	| False
	|  Base of Predicate.BasePredicate.t 
        |  Rel of Predicate.RelPredicate.t

  type vc_pred =  Simple of simple_pred
                   |  If of vc_pred * vc_pred
                   |  Iff of vc_pred * vc_pred
                   |  Conj of vc_pred list
                   |  Disj of vc_pred list
                   |  Not of vc_pred

  type tydbind = Var.t * TyD.t

  type tydbinds = tydbind  list
  type bindings = {tbinds: tydbinds; rbinds:PRE.t}

  type t = T of bindings * vc_pred * vc_pred
  
  val fromTypeCheck : VE.t * PRE.t * RefinementType.t * 
    RefinementType.t -> t list

  val elaborate : (RE.RelMap.Key.t * RE.reldesc) list *
           (PRE.RelMap.Key.t * PRE.reldesc) list * t -> t
  val layout : t list -> Layout.t

  val layouts: t list   -> L.t

  val addPredicate : t -> vc_pred -> t 

  val coercePTtoT : Predicate.t -> vc_pred 
