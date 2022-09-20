module VC = VerificationC

val z3_log : string -> unit

type result = Success | Undef | Failure

val discharge : VC.standardt -> (SpecLang.Var.t list) -> 
                    (SpecLang.RelSpec.Qualifier.t list) 
                    ->  result
