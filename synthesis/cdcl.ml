open SpecLang 
module Gamma = Environment.TypingEnv 
module Sigma = Environment.Constructors
module DPred = Knowledge.DiffPredicate
module DMap = Knowledge.DistinguisherMap
module PGMap = Knowledge.PathGammaMap
module CDCL = Learning



let callLearning (gammaCap : DPred.gammaCap)  
					(dps : DMap.t) (spec : RefTy.t) = 
	 CDCL.cdcleffSynthesizeBind gammacap dps spec				