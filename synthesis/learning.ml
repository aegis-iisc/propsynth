module Syn = Lambdasyn
module VC = VerificationC   
open SpecLang 
module Gamma = Environment.TypingEnv 
module Sigma = Environment.Constructors
module Components = Environment.Components
module Explored = Environment.ExploredTerms                 
module VCE = Vcencode 
module P = Predicate  
module SynTC = Syntypechecker
module DPred = Knowledge.DiffPredicate
module DMap = Knowledge.DistinguisherMap
module PGMap = Knowledge.PathGammaMap

exception LearningException of string 
exception Unhandled
open Syn

module Message = struct 

  let show (s:string) = Printf.printf "%s" ("\n"^s) 


end


module Learning :  sig
  
  val itercount : int ref   
  type exploredTree = Leaf 
                    | Node of exploredTree list 
  type choiceResult = 
        | Nothing of DMap.t * Predicate.t list 
        | Chosen of (DMap.t *  Var.t * path)

  type deduceResult = 
        | Success of path
        | Conflict of { env :DPred.gammaCap; 
                        dps:DMap.t ; 
                        conflictpath : path;
                        conflictpathtype : RefTy.t;
                        disjuncts : Predicate.t list
                        }

   val hoarePre :  DPred.gammaCap -> RefTy.t ->  path -> Var.t -> RefTy.t -> (DPred.gammaCap * Predicate.t * bool)                      
   val distinguish : DPred.gammaCap -> DMap.t -> RefTy.t ->  path -> Var.t -> RefTy.t -> (DPred.gammaCap * Predicate.t * bool)
   
   val chooseC :  DPred.gammaCap -> path -> RefTy.t -> DMap.t -> PGMap.t -> (DPred.gammaCap * PGMap.t * choiceResult)
   val deduceR : DPred.gammaCap -> Var.t ->  path -> RefTy.t -> 
				DMap.t -> PGMap.t -> (DPred.gammaCap * PGMap.t * deduceResult)

   val learnP :  DPred.gammaCap -> DMap.t -> path -> RefTy.t -> Predicate.t list -> DMap.t 
	
   val backtrackC : DPred.gammaCap -> DMap.t -> path -> PGMap.t -> RefTy.t  -> (DPred.gammaCap * path * DMap.t * PGMap.t)
   val cdcleffSynthesizeBind :  DPred.gammaCap ->   DMap.t  -> RefTy.t -> Syn.monExp
	                     

end = struct

let itercount = ref 0 

type exploredTree = Leaf 
					| Node of exploredTree list	

type choiceResult = 
		| Nothing of DMap.t * Predicate.t list 
		| Chosen of (DMap.t *  Var.t * path)

type deduceResult = 
		| Success of path
		| Conflict of { env :DPred.gammaCap; 
						dps:DMap.t ; 
						conflictpath : path;
						conflictpathtype : RefTy.t;
						disjuncts : Predicate.t list
						}

(*The standard hoare-pecondition check*)
let rec hoarePre gamma spec path ci rti = 
	let () =Message.show ("Potential Component/Function  "^(Var.toString ci)) in 
    let RefTy.MArrow (_, ci_pre,  (_,_), c_post) = rti in  

	(*extract fields from gamma^*)
	let gammaMap = DPred.getGamma gamma in 
	let sigmaMap = DPred.getSigma gamma in 
	let deltaPred = DPred.getDelta gamma in 
	(*but this should be typed in the output heap*)
	(*\Gamma |= post_path => pre*)
	
	(*??TODO : we need a function generating strongest postcondition for a path*)

	(*either first component or *)
	let (gammaMap, deltaPred, path_type) = SynTC.typeForPath gammaMap sigmaMap deltaPred spec path in 
	
	(* Message.show (">>>>>>>>>>>PATH TYPE "^RefTy.toString path_type);
	 *)
	let RefTy.MArrow (_,post_pre,(_,t), post_path) = path_type in 
	let h_var  = Var.get_fresh_var "h" in 
    let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

	let h'_var  = Var.get_fresh_var "h'" in 
    let h'_type = RefTy.fromTyD (TyD.Ty_heap) in 

    let x_var = Var.get_fresh_var "x" in 

    let gammaMap = Gamma.add gammaMap h_var h_type in 
    let gammaMap = Gamma.add gammaMap h'_var h'_type in 
    let gammaMap = Gamma.add gammaMap x_var t in 

	
    
    let post_path_applied = VC.apply post_path [(h_var, TyD.Ty_heap);(x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in 
              

	(*substitute current heap values for pre*)
    let ci_pre_applied = VC.apply ci_pre [(h'_var, TyD.Ty_heap)] in 
   

	let bvs = [(h_var, TyD.Ty_heap); (x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in 	
    let post_path_imp_pre_ci = Predicate.Forall (bvs, P.If (post_path_applied, ci_pre_applied)) in   
           
	let vc1 = VC.VC(gammaMap, deltaPred, post_path_imp_pre_ci) in 
	let vcStandard =  VC.standardize vc1 in 
	

	let discharge_vc vcStandard = 
		try
		Message.show ("\n Printing VCs");
        Message.show ("\n"^(VC.string_for_vc_stt vcStandard));      
        let result = VCE.discharge vcStandard  in 
		    match result with 
		    | VCE.Success -> 
		                    Message.show (" Show ***************D (ci) hoarePre Successful************"^(Var.toString ci));
		                    true
		    | VCE.Failure -> 
		    				Message.show (" Show ***************D (ci) hoarePre Failed************"^(Var.toString ci));
		                    false
		    | VCE.Undef -> raise (LearningException "Typechecking Did not terminate")  
		    
		 with
		 	VerificationC.Error e -> raise (LearningException "Checking a distingushing predicate did not terminate")

	in 	 	

	let allowed = discharge_vc vcStandard in  
	let gammaCap = DPred.T {gamma=gammaMap;sigma=sigmaMap;delta=deltaPred} in 
	
	(*return the gamma, the formula \phi_post => pre_ci, and result if the compoenent is allowed*)                   
	(*(gammaCap, post_path_imp_pre_ci, allowed)*)
	(*return the gamma, the formula pre_ci, and result if the compoenent is allowed*)                   
	(gammaCap, ci_pre, allowed)



	


(*a routine to verify that the choice ci, in the current gamma satisfies the distinguishing constraints*)
let distinguish gamma dps spec path ci rti= 
 	

	let gammaMap = DPred.getGamma gamma in 
	let sigmaMap = DPred.getSigma gamma in 
	let deltaPred = DPred.getDelta gamma in 
	 	
	let (gammaMap, deltaPred, path_type) = SynTC.typeForPath gammaMap sigmaMap deltaPred spec path in 
	
	(*construct VCs ci_post => D(ci)*)
	
	let potential_path = path@[ci] in 
	let (gammaMap, deltaPred, potential_path_type) = 
					SynTC.typeForPathSuffix gammaMap sigmaMap deltaPred [ci] path_type in 


(* 
	Message.show " DISTINGUISH Potential Path Type";
	Message.show (" DISTINGUISH Potential Path "^(pathToString potential_path));
	
 *)

(* 	Message.show " DISTINGUISH DPS";
	Message.show (" DISTINGUISH DPS"^(DMap.toString dps));
 *)	

	let diffpred_ci = 
			try
				DMap.find dps ci 
			with 
				Knowledge.NoMappingForVar e -> DPred.empty
	in 			

	let diffpred_ci_gammaCap = DPred.getGammaCap diffpred_ci in 
	let diffpred_ci_learntPred = DPred.getLearnt diffpred_ci in 

	
	Message.show (RefTy.toString potential_path_type);



	let diffpred_ci_learntPred = DPred.getLearnt diffpred_ci in 
(* 
	Message.show "DiffPredicate";
	Message.show ("DISTINGUISH DiffPredicate "^(Predicate.toString diffpred_ci_learntPred));
 *)
	let RefTy.MArrow (_,pot_path_pre,(_,t), pot_path_post) = potential_path_type in 
	let h_var  = Var.get_fresh_var "h" in 
    let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

	let h'_var  = Var.get_fresh_var "h'" in 
    let h'_type = RefTy.fromTyD (TyD.Ty_heap) in 

    let x_var = Var.get_fresh_var "x" in 

    let gammaMap  = Gamma.add gammaMap h_var h_type in 
    let gammaMap = Gamma.add gammaMap h'_var h'_type in 
    let gammaMap = Gamma.add gammaMap  x_var t in 


    let pot_path_post_applied = VC.apply pot_path_post 
    						[(h_var, TyD.Ty_heap);(x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in 
    
          

	(*substitute current heap values for pre*)
    let d_ci_applied_h' = VC.apply diffpred_ci_learntPred [(h'_var, TyD.Ty_heap)] in 
   

	let bvs = [(h_var, TyD.Ty_heap); (x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in 	
    let pot_path_posti_imp_d_ci = Predicate.Forall (bvs, P.If (pot_path_post_applied, d_ci_applied_h')) in   

    let gammaMap4vc2 = gammaMap@(DPred.getGamma diffpred_ci_gammaCap) in 
    let deltaPred4vc2 = Predicate.Conj(deltaPred, (DPred.getDelta diffpred_ci_gammaCap)) in  
    let vc2 = VC.VC(gammaMap4vc2, deltaPred4vc2, pot_path_posti_imp_d_ci) in 

(*     Message.show ("\n Predicate testsed "^(Predicate.toString pot_path_posti_imp_d_ci));
 *)
	let vcs = [vc2] in 
	
	let vcsStandard = List.map (fun vc -> VC.standardize vc) vcs in 
	
	
	let discharge_vc vcStandard = 
		try
		Message.show ("\n Printing VCs");
        Message.show ("\n"^(VC.string_for_vc_stt vcStandard));      
        let result = VCE.discharge vcStandard  in 
		    match result with 
		    | VCE.Success -> 
		                    true
		    | VCE.Failure -> 
		                    false
		    | VCE.Undef -> raise (LearningException "Typechecking Did not terminate")  
		    
		 with
		 	VerificationC.Error e -> raise (LearningException "Checking a distingushing predicate did not terminate")

	in 	 	

	let isDistinguished = List.fold_left (fun failure svci -> failure && discharge_vc svci) true vcsStandard in  
	
	 
	let () =  
	if (isDistinguished) then 
		Message.show (" Show ***************D (ci) Successful************"^(Var.toString ci))
	else 
	    Message.show ("Show ***************Selection Failed************"^(Var.toString ci))
	
	in                   
	let RefTy.MArrow (_,_, (_,_), potential_path_post) = potential_path_type in 
	let gammaCapPotential = DPred.T {gamma=gammaMap4vc2;sigma=sigmaMap;delta=deltaPred4vc2} in 
	(gammaCapPotential, potential_path_post, isDistinguished)







let rec chooseC gammacap path spec (dps : DMap.t) (p2gMap : PGMap.t) :  (DPred.gammaCap * PGMap.t * choiceResult)= 
    let RefTy.MArrow (eff, pre, (v, t), post) = spec in 
    let gamma = DPred.getGamma gammacap in 
    let c_wellRetType = Gamma.enumerateAndFind gamma spec in 
   
    let c_wellRetTypeLambda = Gamma.lambdas4RetType gamma spec in 
    let c_es = List.filter (fun (vi, ti) -> 
    					let RefTy.MArrow (effi, _,(_,_), _) = ti in 
						Effect.isSubEffect effi eff) c_wellRetType in 
    
    let c_es = c_es@c_wellRetTypeLambda in 

    (*choosing a component
    The failing disjunct keeps the list of failing Predicates while checking the Hoare Post => Pre implication*)
    let rec choice potentialChoices gammacap dps (failingDisjuncts : Predicate.t list) (p2gMap : PGMap.t) : (DPred.gammaCap * PGMap.t * choiceResult)= 
    	Message.show "Choice ";
    	
    	(* let potentialChoices = List.filter (fun (vi, _) -> not (Explored.mem explored vi)) foundTypes in  
        Message.show "UNExplored Comn ";
         let () = List.iter (fun (vi,_) -> Message.show (Var.toString vi)) foundTypes in 
 *)
    	match potentialChoices with 
		| [] -> 
		    (gammacap, p2gMap,  Nothing (dps, failingDisjuncts)) 
		| (vi, rti) :: xs -> 
			match rti with 
    			| RefTy.Arrow ((varg, argty), retty) -> 
					Message.show (" Show *************** Arrow Component ************"^(Var.toString vi));
				
					let gammaMap = DPred.getGamma gammacap in 
					let sigmaMap = DPred.getSigma gammacap in 
					let deltaPred = DPred.getDelta gammacap in 
					let e_arg = (*Synthesis.synthesize gammaMap sigmaMap deltaPred argty true in *) None in 
					(match e_arg with (*BEGIN1*)
						| None -> choice xs gammacap dps failingDisjuncts p2gMap
						| Some e -> 
						 	let (gammacap, post_imp_phi_ci', allowed) =  hoarePre gammacap spec path vi retty in
						 	if (allowed) then 
			    				let (gamma_with_ci, phi_ci', isDistinguished) = distinguish gammacap dps spec path vi rti in 
			    				if (isDistinguished) then 
				                	let p2gMap = PGMap.add p2gMap (path@[vi]) gamma_with_ci in 
			    					(*chosen a ci s.t. path--> ci is allowed and distinguished*)
			    					(gamma_with_ci, p2gMap, Chosen (dps, vi, path@[vi]))  
			    				else
				                 	(*~phi_ci'*)
				                   let not_phi_ci' =  Predicate.Not phi_ci' in 
				                   (*D(ci)*)
				                   let dp_ci = 
				                   			try 
				                   				DMap.find dps vi 
				                   			with 
				                   			 	Knowledge.NoMappingForVar e -> DPred.empty

				                   in 
								   let learnt_diff_conjunct = DPred.DP {gammacap=gamma_with_ci; learnt=not_phi_ci'} in
				                   (*The two gamma will have overlap, requires thinking*)
				                   let updated_dp_ci = DPred.conjunction dp_ci learnt_diff_conjunct in 
				                   let updated_dps = DMap.replace dps vi updated_dp_ci in 
				                   (*make a different choice*)
				                   choice xs gammacap updated_dps failingDisjuncts p2gMap
				                	
		             		else
							    let failing_predicate = post_imp_phi_ci' in 
				             	(*if Case c1...ck ----> vi  , add D (ck) = pre (vi) *)
				             	let dps= 
				             		if (List.length path > 0) then 
					             		(*D(ci)*)               
					 					let c_terminial = List.hd (List.rev (path)) in 
						                let dp_cterminal = 
						                   			try 
						                   				DMap.find dps c_terminial 
						                   			with 
						                   			 	Knowledge.NoMappingForVar e -> DPred.empty

						                   in 
						                  
						                let learnt_diff_disjunct  = DPred.DP {gammacap=gammacap; learnt=failing_predicate} in
						                   (*The two gamma will have overlap, requires thinking
						                     take disjunction*)
						                let updated_dp_cterminal = DPred.disjunction dp_cterminal learnt_diff_disjunct in 
						                let dps = DMap.replace dps c_terminial updated_dp_cterminal in 
						                dps  
						            else 
						            	dps  
						        in     	
				                let failingDisjuncts = failing_predicate :: failingDisjuncts in 
				                choice xs gammacap dps failingDisjuncts p2gMap
				              

					) (*END1*)	

    		
    			| RefTy.MArrow (_,_,(_,_),_) -> 
    			(*check the hoare pre-condition rule*)
		    			    
		    			let (gammacap, post_imp_phi_ci', allowed) = hoarePre gammacap spec path vi rti in 
		    			if (allowed) then 
		    				(
		    				Message.show (" Show *************** Hoare-Allowed : Now Checking distingushing Predicate ************"^(Var.toString vi));
		    				let (gamma_with_ci, phi_ci', isDistinguished) = distinguish gammacap dps spec path vi rti in 
		    				if (isDistinguished) then 
			                	(
			                	Message.show (" Show *************** Distinguished : Returning the choice ************"^(Var.toString vi));  
		    				(* 	Message.show (" Show *************** PGMap Before ************"^(PGMap.toString p2gMap));  
		    				 *)	
		    					let p2gMap = PGMap.add p2gMap (path@[vi]) gamma_with_ci in 
		    				(* 	Message.show (" Show *************** PGMap After ************"^(PGMap.toString p2gMap));  
		    				 *)	(*chosen a ci s.t. path--> ci is allowed and distinguished*)
		    					(gamma_with_ci, p2gMap, Chosen (dps, vi, path@[vi]))  
		    				)
			                else
			                	(Message.show (" Show *************** Not-Distinguished : Now Adding conjunct ************"^(Var.toString vi)); 
		    				 
			                   (*~phi_ci'*)
			                   let not_phi_ci' =  Predicate.Not phi_ci' in 
			                   (*D(ci)*)
			                  
			                   let dp_ci = 
			                   			try 
			                   				DMap.find dps vi 
			                   			with 
			                   			 	Knowledge.NoMappingForVar e -> DPred.empty

			                   in 

			                   let learnt_diff_conjunct = DPred.DP {gammacap=gamma_with_ci; learnt=not_phi_ci'} in
			                   (*The two gamma will have overlap, requires thinking*)
			                   let updated_dp_ci = DPred.conjunction dp_ci learnt_diff_conjunct in 
			                   let updated_dps = DMap.replace dps vi updated_dp_ci in 
			                   (*make a different choice*)
			                   choice xs gammacap updated_dps failingDisjuncts p2gMap)
			                )	
			             else

			             	(
			             	Message.show (" Show *************** Hoare-Not-Allowed : Now Adding Disjuncts ************"); 
		    				let failing_predicate = post_imp_phi_ci' in 
			             	(*if Case c1...ck ----> vi  , add D (ck) = pre (vi) *)
			             	let dps= 
			             		if (List.length path > 0) then 
				             		(*D(ci)*)               
				 					let c_terminial = List.hd (List.rev (path)) in 
					                let dp_cterminal = 
					                   			try 
					                   				DMap.find dps c_terminial 
					                   			with 
					                   			 	Knowledge.NoMappingForVar e -> DPred.empty

					                   in 
					                  
					                let learnt_diff_disjunct  = DPred.DP {gammacap=gammacap; learnt=failing_predicate} in
					                   (*The two gamma will have overlap, requires thinking
					                     take disjunction*)
					                let updated_dp_cterminal = DPred.disjunction dp_cterminal learnt_diff_disjunct in 
					                let dps = DMap.replace dps c_terminial updated_dp_cterminal in 
					                dps  
					            else 
					            	dps  
					        in     	
			                let failingDisjuncts = failing_predicate :: failingDisjuncts in 
			                choice xs gammacap dps failingDisjuncts p2gMap
			               )
			             (*?? Add (phi' => phi_ci_pre) as a disjunct in the Differentiating predicate
	             TODO add the disjunction predicate learnt from the failure of choosing a component*)	

     in 
    let failingDisjuncts = [] in  
    choice c_es gammacap dps failingDisjuncts p2gMap
   


and deduceR (gamma:DPred.gammaCap) (compi:Var.t) (path:path) (spec: RefTy.t) 
				(dps : DMap.t) (p2gMap : PGMap.t) : (DPred.gammaCap * PGMap.t * deduceResult) = 
	
	Message.show (" EXPLORED :: "^(pathToString path));
	    
	if (!itercount > 100) then 
                (* let () = Message.show (List.fold_left (fun str vi -> (str^"::"^(Var.toString vi))) "ENUM " !enumerated) in  *)
         raise (LearningException "FORCED STOPPED") 
    else
    	let _ = itercount := !itercount + 1 in  
        let gammaMap = DPred.getGamma gamma in 
		let sigmaMap = DPred.getSigma gamma in 
		let deltaPred = DPred.getDelta gamma in 
		

	(* 	let (gammaMap, deltaPred, path_type) = SynTC.typeForPath gammaMap sigmaMap deltaPred spec path in 
	 *)	let (verified, gamma, path_type) = SynTC.typeCheckPath gammaMap sigmaMap deltaPred path spec in 
		
		if (verified) then 
			 (
			 Message.show ("Show :: Found a correct Path "^(pathToString path));
			 (gamma, p2gMap, Success path)
			 ) 
		else 
			(
				Message.show ("Show :: Incomplete Path "^(pathToString path)^" Now chosing Next component "^(Var.toString compi));
			
				let (gamma, p2gMap, nextComponent) = chooseC gamma path spec dps p2gMap in 
				match nextComponent with 
					| Nothing (dps', failingDisjuncts) ->  
									Message.show ("Show :: Conflicting path found "^(pathToString path));
										(gamma, 
										p2gMap, 
										Conflict 
										{env=gamma;
										 dps=dps';
										 conflictpath=path;
										 conflictpathtype=path_type;
										 disjuncts= failingDisjuncts}
										)
					(*see if we also need to return an updated gamma*)					
					| Chosen	(dps', ci', pi') -> deduceR gamma ci' pi' spec dps' p2gMap				
			)
				 





let learnP gamma dps path path_type disjuncts = 
	(* Message.show ("**************Show :: LearnP For Conflict Path ********"^(pathToString path));
	Message.show ("**************Show :: LearnP Initial DPS ********"^(DMap.toString dps));
	 *)                	
	match path with 
	| [] -> raise (LearningException "learning called on an empty path")
	| x :: xs -> 
		let gammaMap = DPred.getGamma gamma in 
		let sigmaMap = DPred.getSigma gamma in 
		let deltaPred = DPred.getDelta gamma in 
		
		let RefTy.MArrow (eff, phi_k, (v, t), phi_k') = path_type in 
	    let negationPost = Predicate.Not phi_k' in


	    (* let disjunction =  List.fold_left (fun disjunct p -> Predicate.Disj (disjunct, p)) (False) disjuncts  in 
	     *)(*the disjunction is not needed*)
	    (* let learntPredicte = Predicate.Disj (negationPost, disjunction) in 
	     *)
	     let learntPredicte = negationPost in 
	     let learnt_dp = DPred.DP {gammacap = gamma;learnt= learntPredicte } in 

	    let conflictNode = List.hd (List.rev (path)) in 
	(*     Message.show ("**************Show :: LearnP Adding DP for Conflict Node ********"^(Var.toString conflictNode));
	 *)
	    let dp_conflictNode = 
	                   			try 
	                   				DMap.find dps conflictNode 
	                   			with 
	                   			 	Knowledge.NoMappingForVar e -> DPred.empty

	                   in 
	                
	    
	    let updated_dp_conflictingNode = DPred.conjunction dp_conflictNode learnt_dp in 
	    
	    let updated_dps = DMap.replace dps conflictNode updated_dp_conflictingNode in 
	(*     Message.show ("**************Show :: LearnP Final DPS ********"^(DMap.toString updated_dps));
	 *)                           
	    (updated_dps)

	

let backtrackC gamma dps path p2gMap spec = 
	let gammaMap = DPred.getGamma gamma in 
	let sigmaMap = DPred.getSigma gamma in 
	let deltaPred = DPred.getDelta gamma in 
		

	let conflict_node = List.hd (List.rev path) in  
	match previousPath path with 
		| None -> raise (LearningException "No possible backtracking")
		| Some p_kminus1 ->
			try 
				if (List.length p_kminus1 > 0) then 
					let k_minus1 = List.hd (List.rev p_kminus1) in 
					let gamma_kminus1 = PGMap.find p2gMap p_kminus1  in 

					let gammaMap_km1 = DPred.getGamma gamma_kminus1 in 
					let sigmaMap_km1 = DPred.getSigma gamma_kminus1 in 
					let deltaPred_km1 = DPred.getDelta gamma_kminus1 in 

					(*TODO :: This might lead to unsoundness as the two paths will have two different Gamma*)
					
					let (gammaMap_km1, deltaPred_km1, type_pkminus1) = SynTC.typeForPath gammaMap_km1 sigmaMap_km1 deltaPred_km1 spec p_kminus1 in 
					let RefTy.MArrow (_, _, (_,_), post_kminus1 ) = type_pkminus1 in 
					let ann_k_type = Gamma.find gammaMap_km1 conflict_node in
					
					let RefTy.MArrow (_, pre_k,(_,_),_) = ann_k_type in 

					let gamma_kminus1 = DPred.T{gamma=gammaMap_km1; sigma = sigmaMap_km1; delta= deltaPred_km1} in 
					
					let learnt_predicate = Predicate.Not (Predicate.If (post_kminus1, pre_k)) in 
					let diffpred_kminus1_k = DPred.DP {gammacap = gamma_kminus1; learnt=learnt_predicate} in 
					let dp_kminus1 = 
		                   			try 
		                   				DMap.find dps k_minus1
		                   			with 
		                   			 	Knowledge.NoMappingForVar e -> DPred.empty

		            in 
		                
		    		let updated_dp_kminus1 = DPred.conjunction dp_kminus1 diffpred_kminus1_k in 
		    		let updated_dps = DMap.replace dps k_minus1 updated_dp_kminus1 in 
		    		(gamma_kminus1, p_kminus1, updated_dps, p2gMap) 
		     
		    	else 
		    		(gamma, p_kminus1, dps, p2gMap)		
			with 
				e -> raise e
			  (*e -> raise (LearningException ("No gamma for Path "^(pathToString p_kminus1)))*)			

(*cdcleffSynthesizeBind : DPred.gammaCap -> DMap.t -> RefTy.t -> Syn.monExp*)
let cdcleffSynthesizeBind (gammaCap : DPred.gammaCap)  
					(dps : DMap.t) (spec : RefTy.t) : Syn.monExp = 
	Message.show "Show :: in CDCL";
	
(* 	Message.show ("Gamma at CDCL"^(Gamma.toString (DPred.getGamma gammaCap)));				
 *)	let p = [] in 
	let pathGammaMap = PGMap.empty in 
	(*the main while loop in the paper*)
	let rec loop gammacap path spec dps path2GammaMap =
		
		Message.show (" EXPLORED :: "^(pathToString path));
	             	         	
		let (gammacap, p2gMap, chooseres) = chooseC gammacap path spec dps path2GammaMap in 
		
		match chooseres with 
			| Nothing _ -> 
				
				if (List.length path > 0) then  
					let gammaMap = DPred.getGamma gammacap in 
					Message.show (" Show :: Conflict Path  Found  while backtracking");
	             	
					let sigmaMap = DPred.getSigma gammacap in 
					let deltaPred = DPred.getDelta gammacap in 
	

					let conflictpath = path in 
					
					let (gammaMap, deltaPred, conflictpathtype) = 
								SynTC.typeForPath gammaMap sigmaMap deltaPred spec conflictpath in 
				
					let gammacap = DPred.T {gamma = gammaMap; sigma=sigmaMap; delta= deltaPred} in 
					

					(*TODO :: hack passing empty disjunct, but disjuncts are not needed anyway*)
					let dps = learnP gammacap dps path conflictpathtype [] in 
			    	Message.show ("**************Show :: Backtracking From ********"^(pathToString conflictpath));
	             	let (gammacap, backpath, dps, p2gMap) = backtrackC gammacap dps conflictpath p2gMap spec in
	         		Message.show ("**************Show :: Backtracked To ********"^(pathToString backpath));
	             	
	         		loop gammacap backpath spec dps p2gMap 
 				else			
					raise (LearningException "No program and No possible backtracking")
			| Chosen (dps', ci, pi) ->  
				
				Message.show (" EXPLORED :: "^(pathToString pi));
	    
				Message.show (" ShowPath :: "^pathToString pi);
	    
				Message.show ("Show :: Chosen "^(Var.toString ci));
			(* 	Message.show ("New DPS "^(DMap.toString dps));
			 *)	Message.show(" Run deduceR");
				let (gammacap, p2gMap, deduceres) = deduceR gammacap ci pi spec dps' p2gMap in 
			    match deduceres with 
			    	| Success p ->
			    			Message.show (" EXPLORED :: "^(pathToString p));
	    	 
			    			Syn.buildProgramTerm  p
			    	| Conflict {env;dps;conflictpath;conflictpathtype;disjuncts} -> 
			    			Message.show (" Show :: Conflict Path  Found  :: Calling learnP Now");
	             			(* Message.show ("**************Show :: Printing The Learnt DPS Before LP ********"^((DMap.toString dps)));
	             			Message.show ("**************Show :: Printing The CPTYPE Before LP ********"^((RefTy.toString conflictpathtype)));
	             			Message.show ("**************Show :: Printing The GammaCap Before LP ********"^((DPred.gammaCapToString env)));
	             			 *)
	             			let dps = learnP env dps conflictpath conflictpathtype disjuncts in 
			    			
			    		(* 	Message.show ("**************Show :: Printing The Learnt DPS Before BT ********"^((DMap.toString dps)));
	             		 *)	Message.show ("**************Show :: Backtracking From ********"^(pathToString conflictpath));
	             			
	             			
	             			let (gammacap, backpath, dps, p2gMap) = backtrackC env dps conflictpath p2gMap spec in
	             			Message.show ("**************Show :: Backtracked to ********"^(pathToString backpath));
	             			
	             			(* Message.show ("**************Show :: Printing The Learnt DPS After BT ********"^((DMap.toString dps)));
	             			 *)(*  Syn.buildProgramTerm  conflictpath
	              			 *) 
	             			 
	             			Message.show ("**************Show :: LOOP ********"^(pathToString backpath));
	             			(* Message.show ("**************Show :: Printing The GammaCap After BT ********"^((DPred.gammaCapToString env)));
  *)
	             			loop gammacap backpath spec dps p2gMap 
 							 
	              			
			    		(*let dp = learnP gamma tk ck pk dp in 
			    		let (dp, tj, cj, pj, gamma) = backtrackC gamma tk ck pk dp in 
			    		loop gamma tj pj spec dp
		 		 *)
		
	in 

	loop gammaCap p spec dps pathGammaMap

end


