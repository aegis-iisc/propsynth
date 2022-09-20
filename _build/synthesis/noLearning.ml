module Syn = Lambdasyn
module VC = VerificationC   
open SpecLang 
module Gamma = Environment.TypingEnv 
module Sigma = Environment.Constructors
module Components = Environment.Components
module Explored = Environment.ExploredPaths  

module VCE = Vcencode 
module P = Predicate  
module SynTC = Syntypechecker
module DPred = Knowledge.DiffPredicate
module DMap = Knowledge.DistinguisherMap
module PGMap = Knowledge.PathGammaMap
module PTypeMap = Knowledge.PathTypeMap
exception LearningException of string
exception SynthesisException of string  
exception Unhandled
open Syn

module Message = struct 

  let show (s:string) = Printf.printf "%s" ("\n"^s) 


end

let itercount = ref 0 

type exploredTree = Leaf 
					| Node of exploredTree list	

type choiceResult = 
		| Nothing of DMap.t * Predicate.t list 
		| Chosen of (DMap.t *  Syn.monExp * path)

type deduceResult = 
		| Success of path
		| Conflict of { env :DPred.gammaCap; 
						dps:DMap.t ; 
						conflictpath : path;
						conflictpathtype : RefTy.t;
						disjuncts : Predicate.t list
						}

let createSubts (args : Syn.monExp list) (formals : (Var.t * RefTy.t) list) : (Var.t * Var.t) list =
     if (not (List.length args = List.length formals)) then 
        raise (SynthesisException "The formals and actual arguments size Mismacth") 
     else
        let formalVars = List.map (fun (vi, ti) -> vi) formals in 
        let actualVars = List.map (fun (mei) -> 
                                        match mei with 
                                            | Syn.Evar vi -> vi 
                                            | _ -> raise (SynthesisException "The Normal Form requires applications c
                                                    of the form F (xi, x2,...xn)")
                                        ) args in 
       List.combine (actualVars) (formalVars)                                    


(*The standard hoare-pecondition check*)
let hoarePre gamma ptypeMap spec path ei rti = 
    
    let () =Message.show ("Potential Component/Function  "^(Syn.monExp_toString ei)) in 
    let gammaMap = DPred.getGamma gamma in 
    let sigmaMap = DPred.getSigma gamma in 
    let deltaPred = DPred.getDelta gamma in 

    (*ideally there should be just one case Eapp ci args with possibly empty set of args
    mut we are treating Eapp vi () as vi ()*)    
    match ei with 
      | Eapp (ci, args) -> 
            let () =Message.show ("Show :: HoarePre Eapp case  "^(Syn.monExp_toString ei)) in 
  
            let uncurriedCompType = 
                match rti with 
                    | RefTy.Arrow ((_,_), _) -> RefTy.uncurry_Arrow rti
                    | RefTy.Uncurried(_,_) -> rti
                    | _ -> raise (LearningException "Illegal Type for Eapp") 
             in 
            

            let RefTy.Uncurried(formals, retty) =  uncurriedCompType in 
           
            (*Pre[ei/formali] Pre v:t Post[ei/foramli]*)             

            let RefTy.MArrow (_, ci_pre,  (vi,_), ci_post) = retty in 
            (*Pre[ei/formali]*)
            let subs = createSubts args formals in 
            let preWithActuals = Predicate.applySubsts subs ci_pre in 

            (*Post[ei/foramli]*)
            let postWithActuals = Predicate.applySubsts subs ci_post in 

            (* calculate the strongest post-condition SP (P, pi) *)    
            let vcStandard = 
                if (List.length path > 0) then 
                    
                    let (gammaMap, deltaPred, ptypeMap, prefixPathType) =
                                SynTC.typeForPath ptypeMap gammaMap sigmaMap deltaPred spec path in
                         
                 
                    let RefTy.MArrow (_,path_pre,(_,t), path_post) = prefixPathType in 
                        
                    (*hoarePre Query
                    given pre_path = \FA h. P
                          post_path = \FA h, v, h'. Q
                          ci_pre = \FA h. Pre_ci
                        -> 
                        \FA h0 v0 h0'.
                           P h0 /\ Q h0 v0 h0' => Pre_ci h0 
                       *)    
                    let h_var  = Var.get_fresh_var "h" in 
                    let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

                    let h'_var  = Var.get_fresh_var "h'" in 
                    let h'_type = RefTy.fromTyD (TyD.Ty_heap) in 

                    let x_var = Var.get_fresh_var "x" in 

                    let gammaMap = Gamma.add gammaMap h_var h_type in 
                    let gammaMap = Gamma.add gammaMap h'_var h'_type in 
                    let gammaMap = Gamma.add gammaMap x_var t in 

                    let pre_path_applied = VC.apply path_pre [(h_var, TyD.Ty_heap)] in 

                    let post_path_applied = VC.apply path_post 
                            [(h_var, TyD.Ty_heap);(x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in 
                    (*substitute current heap values for pre*)
                    let ci_pre_applied = VC.apply preWithActuals [(h'_var, TyD.Ty_heap)] in 
                   

                    let bvs = [(h_var, TyD.Ty_heap); (x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in  
                    let post_path_imp_pre_ci = Predicate.Forall (bvs, P.If (
                                                                        P.Conj (
                                                                        pre_path_applied, post_path_applied
                                                                        ), ci_pre_applied)) in   
                           
                    let vc1 = VC.VC(gammaMap, deltaPred, post_path_imp_pre_ci) in 
                    let vcStandard =  VC.standardize vc1 in 
                    vcStandard
                else
                    let RefTy.MArrow(_,goal_pre,(_,_), goal_post) = spec in 
                    let h_var  = Var.get_fresh_var "h" in 
                    let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

                    let gammaMap = Gamma.add gammaMap h_var h_type in 
                    
                    (*gaolpre => rti_pre*)
                    let goal_pre_applied = VC.apply goal_pre [(h_var, TyD.Ty_heap)] in 
                    let ci_pre_applied = VC.apply preWithActuals [(h_var, TyD.Ty_heap)] in 
                                    
                    let bvs = [(h_var, TyD.Ty_heap)] in                
                    let goal_pre_imp_ci_pre = Predicate.Forall (bvs, P.If (goal_pre_applied, ci_pre_applied)) in 
                    let vc1 = VC.VC(gammaMap, deltaPred, goal_pre_imp_ci_pre) in 
                    let vcStandard =  VC.standardize vc1 in 
                    vcStandard

                in                     
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

            let allowed = discharge_vc vcStandard in  
            let gammaCap = DPred.T {gamma=gammaMap;sigma=sigmaMap;delta=deltaPred} in 
            
            (*return the gamma, the formula \phi_post => pre_ci, and result if the compoenent is allowed*)                   
            (*(gammaCap, post_path_imp_pre_ci, allowed)*)
            (*return the gamma, the formula pre_ci, and result if the compoenent is allowed*)                   
            (gammaCap, ptypeMap, ci_pre, allowed)

                




      | Evar _ -> 
            let () =Message.show ("Show :: HoarePre Evar case  "^(Syn.monExp_toString ei)) in 
  
            let RefTy.MArrow (_, ci_pre,  (_,_), c_post) = rti in  
                
            let vcStandard= 
             if (List.length path > 0) then 
                (*extract fields from gamma^*)
                (*but this should be typed in the output heap*)
                (*\Gamma |= post_path => pre*)
                
                (*a function generating strongest postcondition for a path*)

                let (gammaMap, deltaPred, ptypeMap, path_type) = SynTC.typeForPath ptypeMap gammaMap sigmaMap deltaPred spec path in 
                
                (* Message.show (">>>>>>>>>>>PATH TYPE "^RefTy.toString path_type);
                 *)
                let RefTy.MArrow (_,pre_path,(_,t), post_path) = path_type in 
                
                (*hoarePre Query
                    given pre_path = \FA h. P
                          post_path = \FA h, v, h'. Q
                          ci_pre = \FA h. Pre_ci
                        -> 
                        \FA h0 v0 h0'.
                           P h0 /\ Q h0 v0 h0' => Pre_ci h0 
                *)

                let h_var  = Var.get_fresh_var "h" in 
                let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

                let h'_var  = Var.get_fresh_var "h'" in 
                let h'_type = RefTy.fromTyD (TyD.Ty_heap) in 

                let x_var = Var.get_fresh_var "x" in 

                let gammaMap = Gamma.add gammaMap h_var h_type in 
                let gammaMap = Gamma.add gammaMap h'_var h'_type in 
                let gammaMap = Gamma.add gammaMap x_var t in 

                let pre_path_applied = VC.apply pre_path [(h_var, TyD.Ty_heap)] in 

                let post_path_applied = VC.apply post_path [(h_var, TyD.Ty_heap);(x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in 
                (*substitute current heap values for pre*)
                let ci_pre_applied = VC.apply ci_pre [(h'_var, TyD.Ty_heap)] in 
               

                let bvs = [(h_var, TyD.Ty_heap); (x_var, RefTy.toTyD t); (h'_var, TyD.Ty_heap)] in  
                let post_path_imp_pre_ci = Predicate.Forall (bvs, P.If (
                                                                    P.Conj(
                                                                    pre_path_applied,
                                                                    post_path_applied
                                                                    ), ci_pre_applied)) in   
                       
                let vc1 = VC.VC(gammaMap, deltaPred, post_path_imp_pre_ci) in 
                let vcStandard =  VC.standardize vc1 in 
                vcStandard
             else 
                let RefTy.MArrow(_,goal_pre,(_,_), goal_post) = spec in 
                let h_var  = Var.get_fresh_var "h" in 
                let h_type = RefTy.fromTyD (TyD.Ty_heap) in 

                let gammaMap = Gamma.add gammaMap h_var h_type in 
                
                (*gaolpre => rti_pre*)

                let goal_pre_applied = VC.apply goal_pre [(h_var, TyD.Ty_heap)] in 

                let ci_pre_applied = VC.apply ci_pre [(h_var, TyD.Ty_heap)] in 
                                
                let bvs = [(h_var, TyD.Ty_heap)] in                
                let goal_pre_imp_ci_pre = Predicate.Forall (bvs, P.If (goal_pre_applied, ci_pre_applied)) in 
                let vc1 = VC.VC(gammaMap, deltaPred, goal_pre_imp_ci_pre) in 
                let vcStandard =  VC.standardize vc1 in 
                vcStandard
            in         
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

            let allowed = discharge_vc vcStandard in  
            let gammaCap = DPred.T {gamma=gammaMap;sigma=sigmaMap;delta=deltaPred} in 
            
            (*return the gamma, the formula \phi_post => pre_ci, and result if the compoenent is allowed*)                   
            (*(gammaCap, post_path_imp_pre_ci, allowed)*)
            (*return the gamma, the formula pre_ci, and result if the compoenent is allowed*)                   
            (gammaCap, ptypeMap, ci_pre, allowed)

        | _ -> raise (LearningException ("Hoare Pre Can be checked on Evar or Eapp, Incorrect Path element "^(Syn.monExp_toString ei)))    








let rec chooseBaseLine gammacap exploredpaths path spec 
	(dps : DMap.t) 
	(p2gMap : PGMap.t ) (ptypeMap : PTypeMap.t) :  (DPred.gammaCap * Explored.t * PGMap.t * PTypeMap.t *  choiceResult)= 
    let RefTy.MArrow (eff, pre, (v, t), post) = spec in 
    let gamma = DPred.getGamma gammacap in 
    let c_wellRetType = Gamma.enumerateAndFind gamma spec in 
   
    let c_es = List.filter (fun (vi, ti) -> 
    					let RefTy.MArrow (effi, _,(_,_), _) = ti in 
						Effect.isSubEffect effi eff) c_wellRetType in 
    
    

    (*choosing a component
    The failing disjunct keeps the list of failing Predicates while checking the Hoare Post => Pre implication*)
    let rec choice potentialChoices gammacap exploredpaths dps (p2gMap : PGMap.t) : (DPred.gammaCap * Explored.t * PGMap.t * choiceResult)= 
    	Message.show (" Show :: BaseLine Choice ");
    	
    	
    	match potentialChoices with 
    		| [] -> 
    		    (gammacap, exploredpaths,  p2gMap,  Nothing (dps, [])) 
    		| (vi, rti) :: xs -> 
    			
    			
				match rti with 
				| RefTy.Arrow ((varg, argty), _) -> 
					(*FIXME :: The arrow case of baseline *)
					Message.show (" Show *************** Arrow Component ************"^(Var.toString vi));
                    let uncurried = RefTy.uncurry_Arrow rti in 
                	let RefTy.Uncurried (args_ty_list, retty) = uncurried in 

				    let gammaMap = DPred.getGamma gammacap in 
    		        let sigmaMap = DPred.getSigma gammacap in 
    		        let deltaPred = DPred.getDelta gammacap in 
    		        (*All arguments are  always a scalar/Base Refinement*)
    		        Message.show (" Show *************** Synthesizing Args ei : ti for ************"^(Var.toString vi));

    		       (* lists of terms which can be used as argument *)    
    		        let e_potential_args_lists =  
    		        List.map (fun (argi, argtyi) -> esynthesizeScalar gammaMap sigmaMap deltaPred [argtyi;retty]) args_ty_list  in 

    		        let all_successful = List.filter (fun e_argi -> match e_argi with 
    		                                            | x ::xs -> true
    		                                            | [] -> false) e_potential_args_lists in 


    		        (*length of synthesized args match with the formal parameter*)
    		        let e_allsuccessful = (if ((List.length all_successful) = (List.length args_ty_list)) 
    		                                then Some all_successful
    		                                else None) in 


			   		(match e_allsuccessful with (*BEGIN1*)
                        | None -> (*Atleast one required argument cannot be synthesized thus cannot make the call*)
                            Message.show (" Show *************** Synthesizing Args ei : Failed for some  arg");
                            choice xs gammacap exploredpaths dps p2gMap ptypeMap
						| Some es -> (* es is a list of lists ([i;j...k]; [p;q;...n]...) *)
                            Message.show (" Show *************** Successfully Synthesized Args ei Forall i "^(string_of_int (List.length es)));
                                (*head exists for each of these *)
                                
                    		let () = List.iter (fun ai_list -> 
                                                     List.iter (
                                                                fun aij -> Message.show (" \n Show Argij "^(Syn.typedMonExp_toString aij))
                                                                ) ai_list) es in 


							   let rec n_cartesian_product = function
                                    | [] -> [[]]
                                    | x :: xs ->
                                        let rest = n_cartesian_product xs in
                                        List.concat (List.map (fun i -> List.map (fun rs -> i :: rs) rest) x)  in 


                                let chooseArgs (argsListEach : ((Syn.typedMonExp) list ) list)   : (Syn.typedMonExp list) list   = 
                                        n_cartesian_product argsListEach        
                                
                                in 

                                let possible_args_lists = chooseArgs es in 


                                let () = List.iter (fun li -> 
                                                    let () = Printf.printf "%s" ("\n Next Possible Args Options ") in 
                                                    List.iter (fun ei -> Printf.printf "%s" 
                                                                ("\n EI "^(Syn.monExp_toString ei.expMon) )) li) possible_args_lists in 
                                

                               
                                let rec createLibraryApplied possible_args = 
                                     match possible_args with 
                                     | [] -> []
                                     | x :: xs -> 
                                        let _ = List.iter (fun ei -> Printf.printf "%s" 
                                                                   ("\n Show :: Trying Args  "^(Syn.monExp_toString ei.expMon) )) x in                                
                                       
                                       let monExps_es = List.map (fun ei -> ei.expMon) x in 
                                       let appliedMonExp = Syn.Eapp (Syn.Evar vi, monExps_es) in  (*apply vi e_arg*)
                                       let boundVar = Var.fresh_binding_var "bound" in 
                                       let bound = Syn.Evar (boundVar) in 
                                       let doExpForApp = Syn.Edo (bound, appliedMonExp) in 
                                       let potentialPath = path@[doExpForApp] in 
                                       let () = Message.show (" Show *************** Calling Hoare-Pre ************"^(Var.toString vi)) in 
                                       let () = Message.show (" Show *************** On Path  ************"^(Syn.pathToString potentialPath)) in 
                                       
                                       (* FW_Call rule, implication check *)
                                       let (gammacap, ptypeMap, post_imp_phi_ci', allowed) = hoarePre gammacap ptypeMap spec path appliedMonExp rti in
                                       if (allowed) then 
                                               let () = Message.show (" Show *************** FW_Call-Allowed************"^(Var.toString vi)) in 
                                               x
                                       else 
                                           createLibraryApplied xs     
                                       
                                in 
                                
                                let ei_hds = createLibraryApplied possible_args_lists in 


                                if (List.length ei_hds == 0) then 
                                    choice xs gammacap exploredpaths dps p2gMap ptypeMap
                               	else	
									let monExps_es = List.map (fun ei -> ei.expMon) ei_hds in 
                                    let appliedMonExp = Syn.Eapp (Syn.Evar vi, monExps_es) in  (*apply vi e_arg*)
                                    let boundVar = Var.fresh_binding_var "bound" in 
                                    let bound = Syn.Evar (boundVar) in 
                                    let doExpForApp = Syn.Edo (bound, appliedMonExp) in 
                                    let potentialPath = path@[doExpForApp] in 
                                  
									if (Explored.mem exploredpaths potential_path) then 
                						choice xs gammacap exploredpaths dps p2gMap
                    		
                                	else    
                                		let (gammacap, ptypeMap, post_imp_phi_ci', allowed) = hoarePre gammacap ptypeMap spec path appliedMonExp rti in 
                                		if (allowed) then 
                                			(
                                			Message.show (" Show *************** Hoare-Allowed : ********"^(Var.toString vi));
                                			(gammacap, exploredpaths, p2gMap, Chosen (dps, monExp_vi, potential_path))  
                                            )	
                                         else
                                         	(
                                         	Message.show (" Show *************** Hoare-Not-Allowed : Chose another************"); 
                                			choice xs gammacap exploredpaths dps p2gMap ptypeMap
                                           )
					)            

				| RefTy.MArrow (_,_,(_,_),_) ->
                	let monExp_vi = Syn.Evar vi in  (*apply vi e_arg*)
                                
                	(*check the hoare pre-condition rule*)
                	let potential_path = path@[monExp_vi] in 
                	if (Explored.mem exploredpaths potential_path) then 
                			choice xs gammacap exploredpaths dps p2gMap
                    		
                	else    
                		let (gammacap, ptypeMap, post_imp_phi_ci', allowed) = hoarePre gammacap ptypeMap spec path monExp_vi rti in 
                		if (allowed) then 
                			(
                			Message.show (" Show *************** Hoare-Allowed : ********"^(Var.toString vi));
                			(gammacap, exploredpaths, p2gMap, Chosen (dps, monExp_vi, potential_path))  
                            )	
                         else
                         	(
                         	Message.show (" Show *************** Hoare-Not-Allowed : Chose another************"); 
                			choice xs gammacap exploredpaths dps p2gMap ptypeMap
                           )
                
     in 
	
    choice c_es gammacap exploredpaths dps p2gMap ptypeMap
   



and deduceBaseLine (gamma:DPred.gammaCap) 
					  exploredpaths 
						(compi:Syn.monExp) 
						(path:path) 
						(spec: RefTy.t) 
						(dps : DMap.t) 
						(p2gMap : PGMap.t) : (DPred.gammaCap * Explored.t * PGMap.t * deduceResult) = 
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
	 *)	let (verified,gamma, path_type) = SynTC.typeCheckPath  gammaMap sigmaMap deltaPred path spec  in 
		
		if (verified) then 
			 (
			 Message.show ("Show :: Found a correct Path "^(pathToString path));
			 (gamma, exploredpaths, p2gMap, Success path)
			 ) 
		else 
			(
				Message.show ("Show :: Incomplete Path "^(pathToString path)^" Now chosing Next component "^(Syn.monExp_toString compi));
			
				let (gamma, exploredpaths, p2gMap, nextComponent) = chooseC gamma exploredpaths path spec dps p2gMap in 
				match nextComponent with 
					| Nothing (dps', failingDisjuncts) ->  
									Message.show ("Show :: Conflicting path found "^(pathToString path));
										(gamma, 
										exploredpaths,
										p2gMap, 
										Conflict 
										{env=gamma;
										 dps=dps';
										 conflictpath=path;
										 conflictpathtype=path_type;
										 disjuncts= failingDisjuncts}
										)
					(*see if we also need to return an updated gamma*)					
					| Chosen	(dps', ci', pi') -> deduceBaseLine gamma exploredpaths ci' pi' spec dps' p2gMap				
			)
				 




let backtrackBaseLine gamma dps path p2gMap spec = 
	let gammaMap = DPred.getGamma gamma in 
	let sigmaMap = DPred.getSigma gamma in 
	let deltaPred = DPred.getDelta gamma in 
		

	let conflict_node = List.hd (List.rev path) in  
	match previousPath path with 
		| None -> raise (LearningException "No possible backtracking")
		| Some p_kminus1 ->
			 (gamma, p_kminus1, dps, p2gMap)		
			  (*e -> raise (LearningException ("No gamma for Path "^(pathToString p_kminus1)))*)			

(*cdcleffSynthesizeBind : DPred.gammaCap -> DMap.t -> RefTy.t -> Syn.monExp*)

let effSynthesizeBaseLine (gammaCap : DPred.gammaCap)  
						(dps : DMap.t) 
						(spec : RefTy.t) : Syn.monExp option = 
	Message.show "Show :: Running the Baseline version without Learning";
	
(* 	Message.show ("Gamma at CDCL"^(Gamma.toString (DPred.getGamma gammaCap)));				
 *)	let p = [] in 
	let pathGammaMap = PGMap.empty in 
	(*the main while loop in the paper*)
	let rec loop gammacap exploredpaths path spec dps path2GammaMap =
		Message.show (" EXPLORED :: "^(pathToString path));
		         	
		let (gammacap, exploredpaths, p2gMap, chooseres) = chooseC gammacap exploredpaths path spec dps path2GammaMap in 
		
		match chooseres with 
			| Nothing _ -> 
				
				if (List.length path > 0) then  
					let gammaMap = DPred.getGamma gammacap in 
					Message.show (" Show :: Conflict Path  Found  while backtracking");
	             	
					let sigmaMap = DPred.getSigma gammacap in 
					let deltaPred = DPred.getDelta gammacap in 
	    			let conflictpath = path in 
					
					let exploredpaths = Explored.add exploredpaths conflictpath in 
	             			
					 let (gammaMap, deltaPred, ptypeMap, conflictpathtype) = 
                                SynTC.typeForPath ptypeMap gammaMap sigmaMap deltaPred spec conflictpath in 
                
                    let gammacap = DPred.T {gamma = gammaMap; sigma=sigmaMap; delta= deltaPred} in 
                    

					Message.show ("**************Show :: Backtracking From ********"^(pathToString conflictpath));
	             	let (gammacap, backpath, dps, p2gMap) = backtrackC gammacap dps conflictpath p2gMap spec in
	         		Message.show ("**************Show :: Backtracked To ********"^(pathToString backpath));
	             	
	         		loop gammacap exploredpaths backpath spec dps p2gMap 
 				else			
					raise (LearningException "No program and No possible backtracking")
			| Chosen (dps', ci, pi) ->  
				Message.show (" EXPLORED :: "^(pathToString pi));
	    
				Message.show (" ShowPath :: "^pathToString pi);
	    		Message.show ("Show :: Chosen "^(Syn.monExp_toString ci));
				Message.show(" Run deduceR");
				let (gammacap, p2gMap, ptypeMap, deduceres) = deduceBaseLine gammacap exploredpaths ci pi spec dps' p2gMap in 
			    match deduceres with 
			    	| Success p -> 
						Message.show (" EXPLORED :: "^(pathToString p));
	    	    		Some (Syn.buildProgramTerm  p)
			    	| Conflict {env;dps;conflictpath;conflictpathtype;disjuncts} -> 
			    			Message.show (" Show :: Conflict Path  Found  ");
	             			let exploredpaths = Explored.add exploredpaths conflictpath in 
	             			Message.show ("**************Show :: Backtracking From ********"^(pathToString conflictpath));
	             			

	             			let (gammacap, backpath, dps, p2gMap) = backtrackC env dps conflictpath p2gMap spec in
	             			Message.show ("**************Show :: Backtracked to ********"^(pathToString backpath));
	             			
	             		
	             			loop gammacap exploredpaths backpath spec dps p2gMap 
 							 
	              			
			    		(*let dp = learnP gamma tk ck pk dp in 
			    		let (dp, tj, cj, pj, gamma) = backtrackC gamma tk ck pk dp in 
			    		loop gamma tj pj spec dp
		 		 *)
		
	in 

	loop gammaCap exploredpaths p spec dps pathGammaMap




