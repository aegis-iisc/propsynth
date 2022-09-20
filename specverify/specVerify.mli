 open SpecLang
 open SpecMap
 open Typedtree
 
  module L = Layout
  module VE = VarEnv 
  module PRE = ParamRelEnv
  module TyD = TyD
  module PTS = ProjTypeScheme
  module RefTy = RefinementType
  module PRf = ParamRefType
  module RefSS = RefinementSortScheme
  module RefTyS = RefinementTypeScheme
  module P = Predicate
  module RP = P.RelPredicate
  module BP = P.BasePredicate
 
  module VC = VerificationCondition


  val doIt : VE.t * PRE.t * Typedtree.structure -> VC.t list

