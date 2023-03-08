(*defined Var or import from the specLang*)
open Printf 
open SpecLang 
exception IncorrectExp of string     

module RefTy = RefinementType

type var = Var.t 

let bvarcount = ref 0 
let incr_count () = 
        let count = !bvarcount in 
        let _ = bvarcount := count + 1 in  
        count

type caseExp = {constuctor : var;
                args : var list ;
                exp : typedMonExp}
(*terms generated will be in A-normal form*)
and  monExp = 
        | Evar of var 
        | Elam of (typedMonExp list) * typedMonExp (*Named Lambda Elam x1 : t1, x2:t2 . body *)
        | Efix of var * typedMonExp 
        | Eapp of monExp * (monExp list) (*Eapp foo [x1, x2, x3,...xn] *)
        | Ematch of typedMonExp * (caseExp list) 
        | Elet of monExp * monExp * monExp 
        | Eret of monExp 
        | Ebind of monExp * monExp * monExp
        | Ecapp of var * ( monExp list ) 
        | Ehole of RefTy.t(*a hole in place of an expression*)
        | Edo of monExp * monExp (*do x <- E*)
        | Eite of (monExp * monExp * monExp)
        | Eskip   

and typedMonExp = {expMon:monExp; ofType:RefTy.t }
 
type bindingtuple = (monExp * monExp)


(*Change this function to finally generate OCAML input for Zhe's tool *)
let visitleaf (leaf_node : monExp) : bindingtuple list = 
    match leaf_node with 
        | Evar _ ->  (*let _bvi = leaf *)[(Evar (Var.fromString ("_bv"^(string_of_int (incr_count ())))), leaf_node)]
        | _ -> raise (IncorrectExp "leaf Node in a funapp must be a ")
(* *)
let rec visitnode (applynode : monExp) : bindingtuple list = 
    match applynode with 
        | Eapp (fname, args) -> 
                (*let bvi = fname (i ) *)
                let bindingtuple_list4args = List.map (fun argi -> visitnode argi) args in 
                let rhs = Eapp (fname, List.map (fun ltuplei -> fst (List.hd (List.rev (ltuplei)))) bindingtuple_list4args) in 
                let prefix = List.fold_left (fun prefix btlisti -> List.append prefix btlisti) [] bindingtuple_list4args in 
                let bindingtuple_node = (Evar (Var.fromString "_bv"^(string_of_int (incr_count ()))), rhs) in 
                List.append prefix [bindingtuple_node]    
        | Ecapp (cname, args) -> 
                let bindingtuple_list4args = List.map (fun argi -> visitnode argi) args in 
                let rhs = Ecapp (cname,  List.map (fun ltuplei -> fst (List.hd (List.rev (ltuplei)))) bindingtuple_list4args) in 
                let prefix = List.fold_left (fun prefix btlisti -> List.append prefix btlisti) [] bindingtuple_list4args in 
                let bindingtuple_node = (Evar (Var.fromString "_bv"^(string_of_int (incr_count ()))), rhs) in 
                List.append prefix [bindingtuple_node]    
        | Evar _ -> visitleaf applynode      
        | _ -> raise (IncorrectExp "Node in a Application Tree Must be either a var or a function ")



type path =  monExp list 

let is_empty_path p = 
    match p with 
        |[] -> true 
        | _ -> false 

(*The t ~ H relation
The exact logic can be made less or more precise*)
let satHypothesis (t : path) (hypothesis : path) : bool = 
    true



let rec equalMonExp m1 m2 =
      match (m1, m2) with
        | (Evar v1, Evar v2) -> Var.equal v1 v2 
        | (Elam (arglist1, body1), Elam (arglist2, body2)) ->
                (try
                    (List.fold_left2 (fun accBool arg1 arg2 -> 
                        accBool && (equalTypedMonExp arg1 arg2)) true arglist1 arglist2) 
                    && (equalTypedMonExp body1 body2) 
                with 
                 Invalid_argument e -> false)

        | (Efix (name1, body1), Efix (name2, body2)) -> 
                (Var.equal name1 name2) && (equalTypedMonExp body1 body2) 
        | (Eapp (fun1, arglist1), Eapp (fun2, arglist2))->
                (try
                    (equalMonExp fun1 fun2) && 
                
                    (List.fold_left2 (fun accBool arg1 arg2 -> 
                        accBool && (equalMonExp arg1 arg2)) true arglist1 arglist2) 
                    
                with 
                 Invalid_argument e -> false)

                 
        | (Ematch (matchingArg1, caselist1),Ematch (matchingArg2, caselist2)) -> 
                (equalTypedMonExp matchingArg1 matchingArg2)  
                         
        | (Edo (bound1, exp1), Edo (bound2, exp2)) -> 
                (equalMonExp exp1 exp2)
        | (Ehole t1, Ehole t2) ->
                 (RefTy.compare_types t1 t2)    
        | (Eite (b1, tr1, fl1), Eite (b2, tr2, fl2))-> 
                equalMonExp b1 b2 && equalMonExp tr1 tr2 && equalMonExp fl1 fl2
        |  (_,_) -> false         

and equalTypedMonExp tme1 tme2 = 
    equalMonExp tme1.expMon tme2.expMon


   
let rec doExp (ls : monExp list) : monExp= 
    match ls with 
        [] -> Eskip
        | x :: xs -> Edo (x, doExp (xs))

let rec monExp_toString (m:monExp) = 
    match m with 
        | Evar v -> (v)
        | Elet (v, e1, e2) -> ("\n let "^(monExp_toString v)^" = "^(monExp_toString e1)^" \n in "^(monExp_toString e2))
        | Eret ret ->  ("return "^(monExp_toString ret))
        | Ebind (mne, mne1, mne2) -> ((monExp_toString mne1)^" \n \t >>= \lambda "^
                                    (monExp_toString mne)^" . \n \t "^
                                    (monExp_toString mne2 ))  
        | Ecapp (cname, argls) -> "Ecapp "^(cname)^" ( "^(
                                List.fold_left (fun accstr ai -> 
                                                accstr^", "^(monExp_toString ai)) "" argls

                                                )^" )" 
        | Ematch (matchingArg, caselist) -> 
                let caselist_toString = 
                    List.fold_left (fun accstr casei -> (accstr^" \n | "^(caseExp_toString casei))) " " caselist 
                in 
                ("Ematch "^(typedMonExp_toString matchingArg)^" with "^caselist_toString)
        | Eapp (fun1, arglsit) -> 
            ("apply "^(monExp_toString fun1)^"  ("^
                (List.fold_left 
                    (fun accStr argi -> accStr^", "^(monExp_toString argi)^" )") ""  arglsit))        
        
        | Edo (bound, exp) -> 
                ("do "^(monExp_toString bound)^" <- "^(monExp_toString exp)) 
        | Eskip -> "Eskip"
        | Ehole t -> ("[?? : "^(RefTy.toString t^"]"))
        | Eite (bi, ttr, tfl) -> 
                ("If ("^(monExp_toString bi)^" ) then \n "^(monExp_toString ttr)^" \n else "^(monExp_toString tfl))
        | _ -> "Other expression"  


(*We will add more auxiliary functions here as we go along synthesis*)
and typedMonExp_toString (t:typedMonExp) : string = 
   let {expMon;ofType} = t in  
   ("{ \n"^(RefTy.toString ofType)^" \n "^monExp_toString expMon^" \n }") 

and caseExp_toString (t : caseExp) : string = 
    let argsToString = List.fold_left (fun accstr argi -> (accstr^" ,"^(Var.toString argi))) " " t.args in 
    ("CASE "^(Var.toString t.constuctor)^" ( "^(argsToString)^" ) -> "^(typedMonExp_toString t.exp))



let rec componentNameForMonExp mExp = 
        match mExp with 
         | Evar v -> (v)
         | Eapp (v , _) -> 
                (match v with 
                    | Evar v1 -> v1
                    | _ -> raise (IncorrectExp "a component is either a variable or a fun app"))
         | Ecapp (v, args) -> v
         | Edo (bound, exp) -> componentNameForMonExp exp
         | _ -> raise (IncorrectExp "a component is either a variable or a fun app")
       
        


let getExp (t : typedMonExp) =
    let {expMon;_} = t in expMon

let getType (t : typedMonExp) = 
   let {ofType;_} = t in ofType

(*placeholder , TODO implement complete later*)
let rec buildProgramTerm (path : path) =  
        match path with
            | [] -> Eskip
            | x :: xs ->
                match x with 
                | Edo (boundx, expx) ->  
                    Ebind (boundx, expx, buildProgramTerm xs)
                | Eapp (name, args) -> 
                     let boundVar = Var.get_fresh_var "bound" in 
                     let boundx = Evar (boundVar) in 
                                
                     Ebind (boundx, x, buildProgramTerm xs)    

                 | Evar v ->
                        let boundVar = Var.get_fresh_var "bound" in 
                        let boundx = Evar (boundVar) in 
                      
                        Ebind (boundx, x, buildProgramTerm xs )
                 | Eret retme -> 
                        x
                 | _ -> raise (IncorrectExp "Building Illformed Term")      
                                       

let pathToString (p:path) = 
        (List.fold_left (fun accstr ei -> accstr^(" ---> ")^(monExp_toString ei)) "pp-path " p)^"\n"

let previousComponent (p:path) = 
    if (List.length p < 2) then None 
        else 
         Some (List.nth (p) ((List.length p) - 2))

let previousPath (p : path) =
        if (List.length p < 1) then None
        else 
         Some (List.rev (List.tl (List.rev p)))


let merge matchingArg constructors consArgsList caseBodyList = 
       let () = Printf.printf "%s" (string_of_int (List.length constructors) )in 
       assert (List.length constructors == List.length consArgsList);
       assert (List.length consArgsList == List.length caseBodyList);
       
            
       let rec loop c a b cexpList = 
            match (c, a, b) with 
                | ([],[],[]) -> cexpList
                | (x::xs, y::ys, z::zs) -> 
                     let caseExp_i = {constuctor =x;args=y;exp=z} in 
                     loop xs ys zs (cexpList@[caseExp_i])     
        in 
        
       let megerdCaseExpList = loop constructors consArgsList caseBodyList [] in 
       
       let mergedExp = Ematch(matchingArg, megerdCaseExpList) in 
       mergedExp



 (*finds the last hole in the program and returns a prefix, the hole and 
 the suffix of the path*)      
 let getLastHole path = 
    let revPath = List.rev path in 
    let rec recurse p suffix= 
     match p with 
        [] -> (None, [], suffix)      
        | x :: xs -> 
            (match x with 
                | (Edo (x1,e)) ->
                    (match e with 
                        | Ehole _ ->
                                (Some x, xs, suffix)
                        | _ ->  recurse xs (suffix@[x]))
                | (Ehole _) -> (Some x, xs, suffix)
                | _ ->  recurse xs (suffix@[x]))

   in 
   let (hole, rev_prefix, rev_sufix) = recurse revPath [] in 
   (hole, List.rev (rev_prefix), List.rev (rev_sufix))



let rec isComplete path = 
    let (hls,_,_) = getLastHole path in 
    match hls with 
        | None -> true
        | Some _ -> false 


let rec substitute (subs : (monExp * monExp) list) (m:monExp) : monExp = 
      (*TODO : unimplemented*)
      m
    (* match m with 
        | Evar v -> (v)
        | Eret ret ->  ("return "^(monExp_toString ret))
        | Ebind (mne, mne1, mne2) -> ((monExp_toString mne1)^" \n \t >>= \lambda "^
                                    (monExp_toString mne)^" . \n \t "^
                                    (monExp_toString mne2 ))  
        | Ecapp (cname, argls) -> "Ecapp "^(cname)^" ( "^(
                                List.fold_left (fun accstr ai -> 
                                                accstr^", "^(monExp_toString ai)) "" argls

                                                )^" )" 
        | Ematch (matchingArg, caselist) -> 
                let caselist_toString = 
                    List.fold_left (fun accstr casei -> (accstr^" \n | "^(caseExp_toString casei))) " " caselist 
                in 
                ("Ematch "^(typedMonExp_toString matchingArg)^" with "^caselist_toString)
        | Eapp (fun1, arglsit) -> 
            ("apply "^(monExp_toString fun1)^"  ("^
                (List.fold_left 
                    (fun accStr argi -> accStr^", "^(monExp_toString argi)^" )") ""  arglsit))        
        
        | Edo (bound, exp) -> 
                ("do "^(monExp_toString bound)^" <- "^(monExp_toString exp)) 
        | Eskip -> "Eskip"
        | Ehole t -> ("[?? : "^(RefTy.toString t^"]"))
        | _ -> "Other expression"  
 *)



let substituteHoles (subs : (monExp * monExp) list) (hypothesis : path) = 
    
   let rec loop substituted remaining_hypothesis = 
     (match hypothesis with 
        | [] -> substituted
        | x :: xs -> 
            (match x with 
                | Edo (bound_x, body) -> 
                       (match body with 
                        | Ehole tx -> loop substituted xs 
                        | _ -> 
                            let subs_body = substitute (subs) body in 
                            let subs_x = Edo (bound_x, subs_body) in 
                            substituted@[subs_x]
                       )
                | _ -> raise (IncorrectExp "A hole is a do expression")
            )
        )
    in 
    loop [] hypothesis          



let rec findFirst (t_fw : monExp) tx = 
    (*TODO Unimplemented 
     This and related functions unify the 
    forward and backward restults post-synthesis
    *)
    (t_fw, t_fw)
    (* match t_fw with 
        | Ebind (boundx, expx, rem_t_fw) -> 
        | Eret t_ret ->
                match t_ret with
                    | Evar v -> 



 *)
let unifyFwBw gamma (t_fw : monExp) (hypothesis  : path) = 
    if (isComplete (hypothesis)) then 
        t_fw
    else      
      let rec unify subs rem_hypothesis rem_fw_term =  
        match rem_hypothesis with 
         | [] -> subs 
         | x :: xs -> 
             (*get the first hole*)
            (match x with 
                | Edo (boundx, holex) -> 
                    (match holex with 
                     | Ehole tx ->     
                        (*do boundx <- [??] : tx*)
                        let (fw_boundVar, rem_fw_term) = findFirst rem_fw_term tx in   
                        let subs = (fw_boundVar, boundx) :: subs in 
                        unify subs xs rem_fw_term
                     | _ -> unify subs xs rem_fw_term
                 )
                | _ -> raise (IncorrectExp "unfying a nonDo exp")     
             )    
        in 
        let subs = unify [] hypothesis t_fw in 
        let subst_path = substituteHoles subs hypothesis in 
        buildProgramTerm subst_path

     
let equalPath p1 p2 = 
       try 
            List.fold_left2 (fun accBool ci cj -> 
                accBool && equalMonExp ci cj) true p1 p2 
       with 
           Invalid_argument e-> false   


let pathInList p plist = 
    List.fold_left (fun accBool pi -> (accBool)||( equalPath p pi)) false plist



let rec expand (blist : bindingtuple list) (flatExp : monExp) : monExp = 
    match flatExp with 
        | Eite (g, t, f) -> Eite (expand blist g, 
                                expand blist t,
                                expand blist f)
        | Eapp (fname, args) -> 
            let args_expanded = List.map (fun ai -> expand blist ai) args in 
            Eapp (fname, args_expanded)
        | Evar v -> 
            if (v.[0] == '_') then 
                let def = 
                    try 
                        List.assoc flatExp blist 
                    with 
                      | Not_found -> raise (IncorrectExp ("No Binding for "^(v)))
                in              
                expand blist def 
                
            else 
                flatExp    
        | Elam (fargs, body) -> 
            Elam ((List.map (fun ai -> { expMon= 
                                         expand blist ai.expMon; 
                                         ofType = ai.ofType}) fargs),
                   { expMon = expand blist body.expMon;
                    ofType = body.ofType})  
        | _ -> flatExp



(*Assume that everything is fully expanded *)
let rec size (me : monExp) : int = 
    match me with 
        | Eite (g, t, f) -> size g + size t + size f 
        | Eapp (fname, args) -> 
            let args_sizes = List.fold_left (fun acc ai -> 
                                        acc + size (ai) 
                                        ) 0 args in 
             args_sizes + 1                              
        | Evar v -> 1    
        | _ -> raise (IncorrectExp "Incorrect Size call")


let compare t1_pair t2_pair : int =
    let (lbv1, tm1) = t1_pair in 
    let (lbv2, tm2) = t2_pair in 
    let m1 = tm1.expMon in 
    let m2 = tm2.expMon in 
    let s1 = size m1 in 
    let s2 = size m2 in 
    if (s1 == s2) then 0  
    else if (s1 > s2) then 100 
    else -100   
                                
             
let findInBindings (me:monExp) (blist: bindingtuple list) : (monExp*monExp) option = 
    if (List.length blist == 0) then None 
    else 

            try 
                let (foundbv, foundExp) = 
                    ( List.find (fun tuplei -> 
                     let (mbindi, mexpi) = tuplei in 
                     let expanded_me = expand blist me in 
                     let expanded_mexpi = expand blist mexpi in 
                    equalMonExp expanded_me expanded_mexpi  
                    ) blist) in 
                Some (foundbv, foundExp)    
             with 
                | Not_found -> None    


let exp4tuples (lbtuple : bindingtuple list) : monExp = 
     assert (List.length lbtuple > 0);
     List.fold_right (
                        fun (xi, ei) ej -> 
                        Elet (xi, ei, ej)
                    ) lbtuple (fst (List.hd (List.rev (lbtuple)))) 




let rec rewrite (m:monExp) : (string) = 
    match m with         
        | Evar v -> 
                if (String.equal v "Cons") then "::"
                else if (String.equal v "Nil") then "[]"
                else if (String.equal v "Ucons") then "+::"     
                else if (String.equal v "un") then "()"   
                else if (String.equal v "s" || String.equal v "size1" ) then "size"
                else if (String.equal v "n" || String.equal v "n0" || String.equal v "n1" || String.equal v "d1") then "size"        
                else if (String.equal v "a" || String.equal v "b" ) then "d"        
                
                else (v)
        | Elet (v, e1, e2) -> ("\n let "^(rewrite v)^" = "^(rewrite e1)^" in "^(rewrite e2))
        | Ecapp (cname, argls) -> (cname)^" "^(
                                List.fold_left (fun accstr ai -> 
                                                accstr^" "^(rewrite ai)) "" argls

                                                ) 
        | Ematch (matchingArg, caselist) -> 
                let caselist_toString = 
                    List.fold_left (fun accstr casei -> (accstr^" \n | "^(caseexp_rewrite casei))) " " caselist 
                in 
                ("\n \t match "^(monExp_toString matchingArg.expMon)^" with "^caselist_toString)
        | Eapp (fun1, arglist) -> 
            if not (String.equal (rewrite fun1) "::" || String.equal (rewrite fun1) "[]"|| String.equal (rewrite fun1) "+::") then 
                if (String.equal (rewrite fun1) "Node") then  
                    (
                    " ( "^(rewrite fun1)^" ( "^
                    (List.fold_left 
                     (fun accStr argi -> accStr^", "^(rewrite argi)) (rewrite (List.hd arglist))  
                        (List.tl arglist))
                    )^" ) )" 
                else    
                    (" ( "^(rewrite fun1)^" "^
                        (List.fold_left 
                            (fun accStr argi -> accStr^" "^(rewrite argi)) ""  arglist))^" ) "        
            else                            
                (assert (List.length arglist == 2);
                let funName = (rewrite fun1) in
                (List.fold_left 
                    (fun accStr argi -> accStr^" "^(funName)^" "^(rewrite argi)) (rewrite (List.hd arglist))  
                                (List.tl arglist))
                )                        
        


        | Eite (bi, ttr, tfl) -> 
                ("if ( "^(rewrite bi)^" ) \n then \n \t "^(rewrite ttr)^" \n else \n \t"^(rewrite tfl))
        
        | Elam (fargs, body) ->  
                let fargsString = 
                    List.fold_left (fun accstr ai -> (accstr^"  ("^(rewrite ai.expMon)^" : "^(TyD.toString (RefTy.toTyD ai.ofType))^")")) " " fargs in  
                
                ("let rec goal "^(fargsString)^" : ("^(TyD.toString (RefTy.toTyD body.ofType))^") = \n \t "^(rewrite body.expMon)) 
        | _ -> raise (IncorrectExp "Undefined Rewrite Rules")  


and caseexp_rewrite (t : caseExp) : string = 
    let argsToString = List.fold_left (fun accstr argi -> (accstr^" "^(Var.toString argi))) " " t.args in 
    ((Var.toString t.constuctor)^"  "^(argsToString)^" -> "^(rewrite) t.exp.expMon)
