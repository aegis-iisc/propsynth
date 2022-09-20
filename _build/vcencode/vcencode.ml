(*open TransTypeChecker*)
open SpecLang 
open Z3_encode

exception SolverTimeout
exception Unimplemented of string 
exception IncorrectRelSort of string     
module TyD = TyD

  module RI = RelId
  module BP = Predicate.BasePredicate
  module RP = Predicate.RelPredicate
  module PR = PrimitiveRelation

 (*We are moving back to normal VCs*)
  module VC = VerificationC
    
  type result = Success | Undef | Failure
 
  module FuncDecl = Z3.FuncDecl 
  module Solver = Z3.Solver 

  
  exception VCEncodingFailed of string 
  exception VCEex of string 

let ignore = fun _ -> ()

let z3_log = Z3_encode.logz3

 
module Printf = struct 
  let printf d s = Printf.printf d s
  let originalPrint = Printf.printf 
end  




let discharge (VC.T (tydbinds, anteP, conseqP) as vc) 
        (typenames) 
        (qualifiers) =

  let ctx = ref @@ Z3_encode.mkDefaultContext ()  in 
  let solver = ref @@ Solver.mk_solver !ctx None in 
  
  let () = Solver.reset !solver in   
    
  let () = Printf.printf "%s" ("GAMMA in VCE "^(VC.string_tybinds tydbinds)) in 

  let constMap = ConstMap.empty in  
  let relMap = RelMap.empty in 

  let tydbinds = tydbinds in 
  let rbinds = [] in 
  let anteP = anteP in 
  let conseqP = conseqP in 
    
         (*
       * Maps to keep track of encoded values
       *)
      
      (*int_sort and bool_sort are sort functions in MSFOL
        check how to encode MSFOL in Z3*)
       let tyMap = TyMap.empty  in 

      
      let tyMap = TyMap.add tyMap (TyD.Ty_int) (Int (Z3_encode.mk_int_sort ())) in 
      let tyMap = TyMap.add tyMap (TyD.Ty_bool) (Bool (Z3_encode.mk_bool_sort ())) in 
      let tyMap = TyMap.add tyMap (TyD.Ty_string) (Str (Z3_encode.mk_string_sort ())) in  
      let tyMap = TyMap.add tyMap (TyD.Ty_alpha (Tyvar.fromString "int")) ( Int (Z3_encode.mk_int_sort ())) in
      

      let addTyD tyMap tyd = 
                let sortToUninterpretedSort = 
                   fun sort -> 
                       (let tyMap = TyMap.add tyMap tyd sort in  
                            (tyMap, sort) )
                      in 
                  let tyName = Z3_encode.genTypeName () in        
                sortToUninterpretedSort (T (tyName, Z3_encode.mk_uninterpreted_s (tyName))) 
   
        in 
      
      
       (*
       * bootStrapBools for constMap
       *)
      let constMap = ConstMap.empty  in 

      let constMap = ConstMap.add constMap "true" const_true in 
      let constMap = ConstMap.add constMap "false" const_false in 
      (*add h and h' as heap variable*)
        
        
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
    
      let getSRCodomainSort relMap rid  : (sort) = 
        
        let sr = 
          try
            RelMap.find relMap (RI.toString rid)
          with    
          | RelMap.RelNotFound _ -> 
        
            raise (RelMap.RelNotFound ("Rel "^(RI.toString rid)^" undeclared despite processing tydbinds"))
         in 
       
        ( match sr with 
         | SR {ty;_} -> 
                 (*The codomain for the relation is the last sort of the type list for relation*) 
                 let codomain_sort = List.hd (List.rev ty) in 
                 codomain_sort 
         | MSR {mty;_} -> 
                let codomain_sort = List.hd (List.rev mty) in 
              codomain_sort)
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
          let () = Printf.printf "%s" ("encodeTyD "^TyD.toString tyD) in 
          (tyMap, constMap, relMap, (TyMap.find tyMap tyD))  
        with 
        | TyMap.TyDNotFound _ -> 
          let () = Printf.printf "%s" ("@@@@@"^(TyD.toString tyD)) in 
      
          let sortfortyD = (match tyD with 
             TyD.Ty_alpha _ ->  addTyD tyMap tyD 
            | _ -> addTyD tyMap tyD  

            (* failwith "Unexpected type" *))

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
        (**ERROR, Encode the Length relation as a function like decl_fun rlen ...*)
      let encodeStrucRel (tyMap, constMap, relMap) (rid ,TyD.Ty_arrow (t1,t2))  =
          let open TyD in 
          let  rstr = RI.toString rid in 
          let (tyMap, constMap, relMap,sorts) = 
                    let (tyMap, constMap, relMap, sort) = encodeTyD (tyMap,constMap,relMap) t1 in  
                    (tyMap, constMap, relMap,Vector.new1 (sort))
          in 
          let (tyMap, constMap, relMap,sorts) = 
                    let (tyMap, constMap, relMap, sort) = encodeTyD (tyMap,constMap,relMap) t2 in  
                    (tyMap, constMap, relMap, List.append sorts (Vector.new1 (sort)))
          in 
                      
          let  sr = mkStrucRel (rstr,  sorts) in

          let relMap = RelMap.add relMap rstr sr
        in
          (tyMap, constMap,relMap, sr)
       
      in 
        (*TODO Temporarily we add sel and update and other relation sorts manually, we need to decuple Parametric relations from the translation and get these sorts 
         * automatically from the definition later.*)
      let addSelUpdate (tyMap, constMap, relMap) =
          let open TyD in       
          
          (*some useful tyd encoding as sorts*)

          let  (tyMap, constMap, relMap, sort_tree) = encodeTyD (tyMap, constMap, relMap) (TyD.fromString "tree") in 
          let  (tyMap, constMap, relMap, sort_char_list) = encodeTyD (tyMap, constMap, relMap) (Ty_list (Ty_char)) in 
          let  (tyMap, constMap, relMap, sort_int) = encodeTyD (tyMap, constMap, relMap) (Ty_int) in 
          let  (tyMap, constMap, relMap, sort_tree_list) = encodeTyD (tyMap, constMap, relMap) (Ty_list (TyD.fromString "tree")) in 
          let  (tyMap, constMap, relMap, sort_bool) = encodeTyD (tyMap, constMap, relMap) (Ty_bool) in 
          let  (tyMap, constMap, relMap, sort_char) = encodeTyD (tyMap, constMap, relMap) (Ty_char) in 
          let  (tyMap, constMap, relMap, sort_string) = 
            encodeTyD (tyMap, constMap, relMap) (Ty_string) in 
          
          let  (tyMap, constMap, relMap, sort_string_list) = 
            encodeTyD (tyMap, constMap, relMap) (Ty_list (Ty_string)) in 
            
          let  (tyMap, constMap, relMap, sort_float) = encodeTyD (tyMap, constMap, relMap) (Ty_float) in 
         
          let  (tyMap, constMap, relMap, sort_int_list) = encodeTyD (tyMap, constMap, relMap) (Ty_list (Ty_int)) in 
          let  (tyMap, constMap, relMap, sort_pair) = encodeTyD (tyMap, constMap, relMap) (TyD.fromString "pair") in 
          let  (tyMap, constMap, relMap, sort_revpair) = encodeTyD (tyMap, constMap, relMap) (TyD.fromString "revpair") in 
          let  (tyMap, constMap, relMap, sort_triple) = encodeTyD (tyMap, constMap, relMap) (TyD.fromString "triple") in 
          let (tyMap, constMap, relMap, sort_heap) = encodeTyD (tyMap, constMap, relMap) (Ty_heap) in  
          let (tyMap, constMap, relMap, sort_int_ref) = encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_int)) in
          let (tyMap, constMap, relMap, sort_ref_int_list) = encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_list (Ty_int))) in
          let (tyMap, constMap, relMap, sort_ref_char_list) = encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_list (Ty_char))) in
          

          let (tyMap, constMap, relMap, sort_bool_ref) = encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_bool)) in
          let (tyMap, constMap, relMap, sort_intplist_ref) = encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_list (TyD.fromString "intpair"))) in
          let (tyMap, constMap, relMap, sort_intplist) = encodeTyD (tyMap, constMap, relMap) (Ty_list (TyD.fromString "intpair")) in





           (*queue and queue ref*)
          let  (tyMap, constMap, relMap, sort_queue) = encodeTyD (tyMap, constMap, relMap) (TyD.fromString "queue") in 
          let  (tyMap, constMap, relMap, sort_queue_ref) = encodeTyD (tyMap, constMap, relMap) (Ty_ref (TyD.fromString "queue")) in 
            
          (*nlrecord and nlrecord database
            type code = Cs | Cu | Cn
            (*database is a list of record of {fields:value}*)
            type nlrecord = 
                  {nletter : string; 
                    user : string ; 
                    subscribed : bool ; 
                    code : code ; 
                    articles_read : [string]
                    };  


            type nl =  ref [nlrecord];
  
              *)
        let  (tyMap, constMap, relMap, sort_nl) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "nl") in 
        
        let  (tyMap, constMap, relMap, sort_user) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "user") in 
        
        let  (tyMap, constMap, relMap, sort_nlrecord) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "nlrecord") in 
        let  (tyMap, constMap, relMap, sort_nlrecord_list) = 
            encodeTyD (tyMap, constMap, relMap) (Ty_list (TyD.fromString "nlrecord")) in 
         
          let  (tyMap, constMap, relMap, sort_nldb) = 
            encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_list (TyD.fromString "nlrecord"))) in 
         
         
          let  (tyMap, constMap, relMap, sort_code) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "code") in 
          
           (*png and related types
           type pngtriple = Triple of {len : int ; ts :  [char]; data : [char]}*)
           let  (tyMap, constMap, relMap, sort_pngtriple) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "pngtriple") in 
          (**pair of int, [char] *)
          let  (tyMap, constMap, relMap, sort_pngpair) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "pngpair") in 


          (*firewall sorts*)
          
          let  (tyMap, constMap, relMap, sort_srpair_list) = 
            encodeTyD (tyMap, constMap, relMap) (Ty_list (TyD.fromString "srpair")) in 
          

          let  (tyMap, constMap, relMap, sort_cstab) = 
            encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_list (TyD.fromString "srpair"))) in 
                   
           let  (tyMap, constMap, relMap, sort_dtab) = 
            encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_list (TyD.Ty_int))) in 
          (*cdecl sorts *)    
            let  (tyMap, constMap, relMap, sort_ids) = 
            encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_list (TyD.Ty_string))) in 
        
            let  (tyMap, constMap, relMap, sort_types) = 
            encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_list (TyD.Ty_string))) in 
        
            let  (tyMap, constMap, relMap, sort_tdecl) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "tdecl") in 
        
            let  (tyMap, constMap, relMap, sort_typeexpr) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "typeexpr") in 
           
           let  (tyMap, constMap, relMap, sort_externvar) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "externvar") in 


            
           
           let  (tyMap, constMap, relMap, sort_externfun) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "externfun") in 

          (**cdecl predicates  *)

          let idsel = mkMStrucRel ("idsel", 
                        [sort_heap; sort_ids; sort_string_list]) in 
          

           let relMap = RelMap.add relMap ("idsel") idsel in 
    
           
          let tysel = mkMStrucRel ("tysel", 
                        [sort_heap; sort_types; sort_string_list]) in 
          

           let relMap = RelMap.add relMap ("tysel") tysel in 


          
          let ldisjoint = mkMStrucRel ("ldisjoint", 
                        [sort_string_list; sort_string_list; sort_bool]) in 
          

           let relMap = RelMap.add relMap ("ldisjoint") ldisjoint in 
     
            

          let memids = mkMStrucRel ("memids", 
                        [sort_string_list; sort_string; sort_bool]) in 
          

           let relMap = RelMap.add relMap ("memids") memids in 
     

           let memtypes = mkMStrucRel ("memtypes", 
                        [sort_string_list; sort_string; sort_bool]) in 
          

           let relMap = RelMap.add relMap ("memtypes") memtypes in 
     

            let slsize = mkStrucRel ("slsize", 
                        [sort_string_list; sort_int]) in 
          

           let relMap = RelMap.add relMap ("slsize") slsize in 
     


          (*png triple field predicates*)  
          
          let  (tyMap, constMap, relMap, sort_quad) = 
            encodeTyD (tyMap, constMap, relMap) (TyD.fromString "quad") in 
          
          let length = mkStrucRel ("length", 
                        [sort_char_list; sort_int]) in 
          let relMap = RelMap.add relMap ("length") length in 


          let quadlength = mkStrucRel ("quadlength", 
                        [sort_quad; sort_int]) in 
          let relMap = RelMap.add relMap ("quadlength") quadlength in 


          let intval = mkStrucRel ("intval", 
                        [sort_char; sort_int]) in 
          let relMap = RelMap.add relMap ("intval") intval in 


          let asciinumberlist = mkStrucRel ("asciinumberlist", 
                        [sort_char_list; sort_bool]) in 
          let relMap = RelMap.add relMap ("asciinumberlist") asciinumberlist in 


          
          let asciinumber = mkStrucRel ("asciinumber", 
                        [sort_char_list; sort_bool]) in 
          let relMap = RelMap.add relMap ("asciinumber") asciinumber in 
  
        
          let asciiupper = mkStrucRel ("asciiupper", 
                        [sort_char_list; sort_bool]) in 
          let relMap = RelMap.add relMap ("asciiupper") asciiupper in 
  
          
          let asciialphanum = mkStrucRel ("asciialphanum", 
                        [sort_char_list; sort_bool]) in 
          let relMap = RelMap.add relMap ("asciialphanum") asciialphanum in 
  
          

          let pnglen = mkStrucRel ("pnglen", 
                        [sort_pngtriple; sort_int]) in 
          let relMap = RelMap.add relMap ("pnglen") pnglen in 
  

          let pngts = mkStrucRel ("pngts", 
                        [sort_pngtriple; sort_quad]) in 
          let relMap = RelMap.add relMap ("pngts") pngts in 
  
          let pngdata = mkStrucRel ("pngdata", 
                        [sort_pngtriple; sort_char_list]) in 
          let relMap = RelMap.add relMap ("pngdata") pngdata in 

          let ppfst = mkStrucRel ("ppfst", 
                        [sort_pngpair; sort_int]) in 
          let relMap = RelMap.add relMap ("ppfst") ppfst in 

          let ppsnd = mkStrucRel ("ppsnd", 
                        [sort_pngpair; sort_char_list]) in 
          let relMap = RelMap.add relMap ("ppsnd") ppsnd in 

            (*nlrecord field predicates*)
          let nletter = mkStrucRel ("nletter", 
                        [sort_nlrecord; sort_nl]) in 
          let relMap = RelMap.add relMap ("nletter") nletter in 
        
          let user = mkStrucRel ("user", 
                        [sort_nlrecord; sort_user]) in 
          let relMap = RelMap.add relMap ("user") user in 
    
      
           let subscribed = mkMStrucRel ("subscribed", 
                        [sort_nlrecord_list; sort_nl; sort_user;sort_bool]) in 
          let relMap = RelMap.add relMap ("subscribed") subscribed in 
      

          let unsubscribed = mkMStrucRel ("unsubscribed", 
                         [sort_nlrecord_list; sort_nl; sort_user;sort_bool]) in 
          let relMap = RelMap.add relMap ("unsubscribed") unsubscribed in 
      
          let confirmed = mkMStrucRel ("confirmed", 
                         [sort_nlrecord_list; sort_nl; sort_user;sort_bool]) in 
          let relMap = RelMap.add relMap ("confirmed") confirmed in 

         
          let code = mkStrucRel ("code", 
                        [sort_nlrecord; sort_code]) in 
          let relMap = RelMap.add relMap ("code") code in 

          let articles = mkStrucRel ("articles", 
                        [sort_nlrecord_list; sort_string_list]) in 
          let relMap = RelMap.add relMap ("articles") articles in 
          

           (*nldb predicates*)  
           let dsel = mkMStrucRel ("dsel", 
                        [sort_heap; sort_nldb; sort_nlrecord_list]) in 
          let relMap = RelMap.add relMap ("dsel") dsel in 
    

          let nlmem = mkMStrucRel ("nlmem", 
                          [sort_nlrecord_list; sort_nl; sort_user;sort_bool]) in 
          let relMap = RelMap.add relMap ("nlmem") nlmem in 
    

          let ns = mkMStrucRel ("ns", 
                        [sort_nlrecord_list; sort_nl; sort_user;sort_nlrecord]) in 
          let relMap = RelMap.add relMap ("ns") ns in 
    

          let goodcode = mkMStrucRel ("gooccode", 
                        [sort_nlrecord_list; sort_code;sort_bool]) in 
          let relMap = RelMap.add relMap ("goodcode") goodcode in 
    
          (*firewall predicates*)
           let didsel = mkMStrucRel ("didsel", 
                        [sort_heap; sort_dtab; sort_int_list]) in 
          let relMap = RelMap.add relMap ("didsel") didsel in 
    
          let dcssel = mkMStrucRel ("dcssel", 
                        [sort_heap; sort_cstab; sort_srpair_list]) in 
          let relMap = RelMap.add relMap ("dcssel") dcssel in 
     
          let device = mkMStrucRel ("device", 
                        [sort_int_list; sort_int; sort_bool]) in 
          let relMap = RelMap.add relMap ("device") device in 
     
          let dsize = mkStrucRel ("dsize", 
                        [sort_int_list; sort_int]) in 
          let relMap = RelMap.add relMap ("dsize") dsize in 
    
          let cansend = mkMStrucRel ("cansend", 
                        [sort_srpair_list; sort_int; sort_int; sort_bool]) in 
          let relMap = RelMap.add relMap ("cansend") cansend in 

          let central = mkMStrucRel ("central", 
                        [sort_srpair_list; sort_int; sort_bool]) in 
          let relMap = RelMap.add relMap ("central") central in 
          

           (*queue predicates*)
          let disjointid = RI.fromString "disjoint" in 
          let disjointpred = mkMStrucRel (RI.toString disjointid, 
                        [sort_queue; sort_queue; sort_bool]) in 
          let relMap = RelMap.add relMap (RI.toString disjointid) disjointpred in 
 

          let uniqueid = RI.fromString "unique" in 
          let uniquepred = mkStrucRel (RI.toString uniqueid, 
                        [sort_queue; sort_bool]) in 
          let relMap = RelMap.add relMap (RI.toString uniqueid) uniquepred in 
  
          
          let emptypred = mkStrucRel ("empty", 
                        [sort_queue; sort_bool]) in 
          let relMap = RelMap.add relMap ("empty") emptypred in 
    
          let qelems = mkStrucRel ("qelems", 
                        [sort_queue; sort_int]) in 
          let relMap = RelMap.add relMap ("qelems") qelems in 
    

          let qsize = mkStrucRel ("qsize", 
                        [sort_queue; sort_int]) in 
          let relMap = RelMap.add relMap ("qsize") qsize in 
    

          let qmem = mkMStrucRel ("qmem", 
                        [sort_queue; sort_int; sort_bool]) in 
          let relMap = RelMap.add relMap ("qmem") qmem in 
    

         let sorts = [sort_heap;sort_queue_ref;sort_queue] in 
         let qsel = mkMStrucRel ("qsel", sorts) in 
         let relMap = RelMap.add relMap ("qsel") qsel in 
        

         (*int list size*)
          let sorts = [sort_int_list;sort_int] in 
         let isize = mkStrucRel ("isize", sorts) in 
         let relMap = RelMap.add relMap ("isize") isize in 
                  


           (*node (tree) relation*)      
          let nodeid = RI.fromString "node" in 
          let node = mkStrucRel (RI.toString nodeid, [sort_tree ;sort_char_list]) in 
          let relMap = RelMap.add relMap (RI.toString nodeid) node in 

          let indentid = RI.fromString "indent" in 
          let indent = mkStrucRel (RI.toString indentid, [sort_tree ;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString indentid) indent in 

          let childrenid = RI.fromString "children" in 
          let children = mkStrucRel (RI.toString indentid, [sort_tree ;sort_tree_list]) in 
          let relMap = RelMap.add relMap (RI.toString childrenid) children in 


          let otlid = RI.fromString "offsideTreeList" in 
          let otl = mkMStrucRel (RI.toString indentid, [sort_int ;sort_tree_list;sort_bool]) in 
          let relMap = RelMap.add relMap (RI.toString otlid) otl in 



          let otid = RI.fromString "offsideTree" in 
          let ot = mkMStrucRel (RI.toString indentid, [sort_int ;sort_tree;sort_bool]) in 
          let relMap = RelMap.add relMap (RI.toString otid) ot in 

          (*mem relation*)
          let memid = RI.fromString "mem" in 
          let mem = mkMStrucRel (RI.toString memid, [sort_int_list;sort_int;sort_bool]) in 
          let relMap = RelMap.add relMap (RI.toString memid) mem in 

          let cmemid = RI.fromString "cmem" in 
          let cmem = mkMStrucRel (RI.toString cmemid, [sort_char_list;sort_char;sort_bool]) in 
          let relMap = RelMap.add relMap (RI.toString cmemid) cmem in 

        
          
          let sortedid = RI.fromString "sorted" in 
          let sorted = mkStrucRel (RI.toString sortedid, [sort_int_list;sort_bool]) in 
          let relMap = RelMap.add relMap (RI.toString sortedid) sorted in 
          
          
          
          (*elems relation*)      
          let elemsid = RI.fromString "elems" in 
           
          let elems = mkStrucRel (RI.toString elemsid, [sort_int_list;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString elemsid) elems in 

           (*len relation*)      
          let lenid = RI.fromString "len" in 
           
          let len = mkStrucRel (RI.toString lenid, [sort_int_list;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString lenid) len in 

          let sizeid = RI.fromString "size" in 
           
          let size = mkStrucRel (RI.toString sizeid, [sort_char_list;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString sizeid) size in 




          let minid = RI.fromString "min" in 
           
          let min = mkStrucRel (RI.toString minid, [sort_int_list;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString minid) min in 
 

           let maxid = RI.fromString "max" in 
           
          let max = mkStrucRel (RI.toString maxid, [sort_int_list;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString maxid) max in 

          (*fst relation*)      
          let fstid = RI.fromString "fst" in 
           
          let fst = mkStrucRel (RI.toString fstid, [sort_pair;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString fstid) fst in 
         
          (*fst relation*)      
          let fstid = RI.fromString "fst" in 
           
          let fst = mkStrucRel (RI.toString fstid, [sort_pair;sort_float]) in 
          let relMap = RelMap.add relMap (RI.toString fstid) fst in 
         

         (*snd relation*)      
          let sndid = RI.fromString "snd" in 
           
          let snd = mkStrucRel (RI.toString sndid, [sort_pair;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString sndid) snd in 
       

         (*(int list* int) fst relation*)      
          let revfstid = RI.fromString "revfst" in 
           
          let revfst = mkStrucRel (RI.toString revfstid, [sort_revpair;sort_int_list]) in 
          let relMap = RelMap.add relMap (RI.toString revfstid) revfst in 
         (*snd relation*)      
          let revsndid = RI.fromString "revsnd" in 
          let revsnd = mkStrucRel (RI.toString revsndid, [sort_revpair;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString revsndid) revsnd in 
       

          (*(int * int )
           * fst relation*)      
          let fstid = RI.fromString "fstint" in 
          let fst = mkStrucRel (RI.toString fstid, [sort_pair;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString fstid) fst in 
         
         (*snd relation*)      
          let sndid = RI.fromString "sndint" in 
           
          let snd = mkStrucRel (RI.toString sndid, [sort_pair;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString sndid) snd in 
        
           (*pr1 relation*)      
          let pr1id = RI.fromString "pr1" in 
           
          let pr1 = mkStrucRel (RI.toString pr1id, [sort_triple;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString pr1id) pr1 in 
          
            (*pr2 relation*)      
          let pr2id = RI.fromString "pr2" in 
           
          let pr2 = mkStrucRel (RI.toString pr2id, [sort_triple;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString pr2id) pr2 in 
          
           
          (*pr3 relation*)      
          let pr3id = RI.fromString "pr3" in 
           
          let pr3 = mkStrucRel (RI.toString pr3id, [sort_triple;sort_int]) in 
          let relMap = RelMap.add relMap (RI.toString pr3id) pr3 in 
          
          
          (*wellformed relation*)      
          let wfid = RI.fromString "wellformed" in 
           
          let wellformed = mkStrucRel (RI.toString wfid, [sort_pair;sort_bool]) in 
          let relMap = RelMap.add relMap (RI.toString wfid) wellformed in 




          (*create sel : Ty_heap :ref 't :-> 't *)
          let selid = RI.fromString "sel" in 
          let ty_var = Tyvar.fromString "int" in 
         
          (*No polymorphic support currently*)
          let (tyMap, constMap, relMap, sort_ref) = encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_alpha ty_var)) in
          let (tyMap, constMap, relMap, sort_val) = encodeTyD (tyMap, constMap, relMap) (Ty_alpha ty_var) in 


          let sorts = [sort_heap;sort_ref;sort_val] in 
          let sr_sel = mkMStrucRel (RI.toString selid, sorts) in 


          let relMap = RelMap.add relMap (RI.toString selid) sr_sel in 
         (*create update*)
         
          (*create int_sel : heap :-> ref int :-> int*)
          (*No polymorphic support currently*)
          
          let int_selid = RI.fromString "isel" in 
          let sorts = [sort_heap;sort_int_ref;sort_int] in 
          let int_sr_sel = mkMStrucRel (RI.toString selid, sorts) in 


          let relMap = RelMap.add relMap (RI.toString int_selid) int_sr_sel in 
        

            (*create mem_sel : heap :-> ref int list:-> int*)
          let sel_mem_id = RI.fromString "mem_sel" in 
          let sorts = [sort_heap;sort_ref_int_list;sort_int_list] in 
          let sr_mem_sel = mkMStrucRel (RI.toString sel_mem_id, sorts) in 
          let relMap = RelMap.add relMap (RI.toString sel_mem_id) sr_mem_sel in 


          
        
          (*create bool_sel : heap :-> ref int :-> int*)
          let bool_selid = RI.fromString "bsel" in 
          let sorts = [sort_heap;sort_bool_ref;sort_bool] in 
          let bool_sr_sel = mkMStrucRel (RI.toString bool_selid, sorts) in 
          let relMap = RelMap.add relMap (RI.toString bool_selid) bool_sr_sel in 
           
          (*create int_list_sel : heap :-> ref int list :->int list*)
         let intlist_selid = RI.fromString "ilssel" in 
         let sorts = [sort_heap;sort_ref_int_list;sort_int_list] in 
         let intlist_sr_sel = mkMStrucRel (RI.toString intlist_selid, sorts) in 


         let relMap = RelMap.add relMap (RI.toString intlist_selid) intlist_sr_sel in 
        
         
         let charlist_selid = RI.fromString "clsel" in 
         let sorts = [sort_heap;sort_ref_char_list;sort_char_list] in 
         let charlist_sr_sel = mkMStrucRel (RI.toString charlist_selid, sorts) in 


         let relMap = RelMap.add relMap (RI.toString charlist_selid) charlist_sr_sel in 
        


         let intplist_selid = RI.fromString "plssel" in 
         let sorts = [sort_heap;sort_intplist_ref;sort_intplist] in 
         let intplist_sr_sel = mkMStrucRel (RI.toString intplist_selid, sorts) in 
         let relMap = RelMap.add relMap (RI.toString intplist_selid) intplist_sr_sel in 
        

          (*create phd : intpair list :-> intpair*) 

          let phd_id = RI.fromString "phd" in 
          let (tyMap, constMap, relMap, sort_intplist) = encodeTyD (tyMap, constMap, relMap)  (Ty_list (TyD.fromString "intpair")) in 
          let (tyMap, constMap, relMap, sort_intpair) = encodeTyD (tyMap, constMap, relMap)  (TyD.fromString "intpair")  in 

          let phdsorts = [sort_intplist;sort_intpair] in 
          let sr_phd = mkStrucRel (RI.toString phd_id, phdsorts) in 
          let relMap = RelMap.add relMap (RI.toString phd_id) sr_phd in 

          (*create pelems : intpair list :-> intpair*) 

          let pelems_id = RI.fromString "pelems" in 
          let (tyMap, constMap, relMap, sort_intplist) = encodeTyD (tyMap, constMap, relMap)  (Ty_list (TyD.fromString "intpair")) in 
          let (tyMap, constMap, relMap, sort_intpair) = encodeTyD (tyMap, constMap, relMap)  (TyD.fromString "intpair")  in 

          let pelemssorts = [sort_intplist;sort_intpair] in 
          let sr_pelems = mkStrucRel (RI.toString phd_id, pelemssorts) in 
          let relMap = RelMap.add relMap (RI.toString pelems_id) sr_pelems in 

          (*create plen : intpair list :-> int*) 

          let plen_id = RI.fromString "plen" in 
          let (tyMap, constMap, relMap, sort_intplist) = encodeTyD (tyMap, constMap, relMap)  (Ty_list (TyD.fromString "intpair")) in 

          let (tyMap, constMap, relMap, sort_int) = encodeTyD (tyMap, constMap, relMap)  (Ty_int)  in 
          let plensorts = [sort_intplist;sort_int] in 
          let sr_plen = mkStrucRel (RI.toString plen_id, plensorts) in 
          let relMap = RelMap.add relMap (RI.toString plen_id) sr_plen in 












         (*create sel_update*)


        (*create functions for len :
         * the definition of logical functions like num_prefix2 and num_prefix_3 gives extra set of axioms
         * making these functions partially interpreted*)
         let num_prefix_2_ID = RI.fromString "num_prefix_2" in 
         let  (tyMap, constMap, relMap, sort_int_list) = encodeTyD (tyMap, constMap, relMap) (Ty_list (Ty_int)) in 
          let  (tyMap, constMap, relMap, sort_int) = encodeTyD (tyMap, constMap, relMap) (Ty_int) in 
           
          let num_prefix_2 = mkMStrucRel (RI.toString num_prefix_2_ID, [sort_int_list;sort_int]) in 


         let num_prefix_3_ID = RI.fromString "num_prefix_3" in 
           let num_prefix_3 = mkMStrucRel (RI.toString num_prefix_3_ID, [sort_int_list;sort_int]) in 


         let num_head_ID = RI.fromString "num_hd" in 
           let num_head = mkMStrucRel (RI.toString num_head_ID, [sort_int_list;sort_int]) in 
   
          let relMap = RelMap.add relMap (RI.toString num_head_ID) num_head in 

          let relMap = RelMap.add relMap (RI.toString num_prefix_2_ID) num_prefix_2 in 

          let relMap = RelMap.add relMap (RI.toString num_prefix_3_ID) num_prefix_3 in 

      
          (*TODO remove later *)
          
          (*let (tyMap, constMap, relMap, temp_const) = encodeConst (tyMap, constMap, relMap) ((Var.fromString "var_local0"), (Ty_list(Ty_int))) in
        
          let (tyMap, constMap, relMap, temp_const) = encodeConst (tyMap, constMap, relMap) ((Var.fromString "var_local1"), (Ty_list(Ty_int))) in
        
          let (tyMap, constMap, relMap, temp_const) = encodeConst (tyMap, constMap, relMap) ((Var.fromString "var_x22"), (Ty_int)) in*)
        
        
          (*create tail_sel : heap :-> ref int list :-> int list*) 

          let sel_tl_id = RI.fromString "tail_sel" in 
          let (tyMap, constMap, relMap, sort_heap) = encodeTyD (tyMap, constMap, relMap) (Ty_heap) in  
          let (tyMap, constMap, relMap, sort_ref_int_list) = encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_list (Ty_int))) in
          let (tyMap, constMap, relMap, sort_tail) = encodeTyD (tyMap, constMap, relMap) (Ty_list Ty_int) in 
          

          let sorts = [sort_heap;sort_ref_int_list;sort_tail] in 
          let sr_tail_sel = mkMStrucRel (RI.toString sel_tl_id, sorts) in 


          let relMap = RelMap.add relMap (RI.toString sel_tl_id) sr_tail_sel in 
         (*create hd : int list :-> int*) 

          let hd_id = RI.fromString "hd" in 
          let (tyMap, constMap, relMap, sort_list) = encodeTyD (tyMap, constMap, relMap) (Ty_list Ty_int) in 
          
          let (tyMap, constMap, relMap, sort_hd) = encodeTyD (tyMap, constMap, relMap) (Ty_int) in 

          let sorts = [sort_list;sort_hd] in 
          let sr_hd = mkStrucRel (RI.toString hd_id, sorts) in 


          let relMap = RelMap.add relMap (RI.toString hd_id) sr_hd in 

        (*create tail : int list :-> int list*) 

          let tail_id = RI.fromString "tail" in 
          let (tyMap, constMap, relMap, sort_list) = encodeTyD (tyMap, constMap, relMap) (Ty_list Ty_int) in 
          
          let (tyMap, constMap, relMap, sort_tail) = encodeTyD (tyMap, constMap, relMap) (Ty_list Ty_int) in 

          let sorts = [sort_list;sort_tail] in 
          let sr_tail = mkStrucRel (RI.toString tail_id, sorts) in 


          let relMap = RelMap.add relMap (RI.toString tail_id) sr_tail in 


          (*TODO remove later *)
          


          (*create bool_sel : heap -> ref bool -> bool*)
          let (tyMap, constMap, relMap, errconst) = encodeConst (tyMap, constMap, relMap) ((Var.fromString "err"), (Ty_ref (Ty_bool))) in
          let sel_bool = RI.fromString "bool_sel" in 
          let (tyMap, constMap, relMap, sort_heap) = encodeTyD (tyMap, constMap, relMap) (Ty_heap) in  
          (*TODO :: These Manual Mappings must be automated*)
         

    (*      let (tyMap, constMap, relMap, inpconst) = encodeConst (tyMap, constMap, relMap) ((Var.fromString "inp"), (Ty_ref (Ty_list Ty_int))) in *)
          let (tyMap, constMap, relMap, sort_ref_bool) = encodeTyD (tyMap, constMap, relMap) (Ty_ref Ty_bool) in 
          
          let (tyMap, constMap, relMap, sort_value_bool) = encodeTyD (tyMap, constMap, relMap) (Ty_bool)in
                
  (*        let (tyMap, constMap, relMap, const) = encodeConst (tyMap, constMap, relMap) ((Var.fromString "var_i8"), (Ty_ref (Ty_list Ty_int))) in *)
          

          let sorts_bool_sel = [sort_heap;sort_ref_bool;sort_value_bool] in 
          let bool_sel_rel = mkMStrucRel (RI.toString sel_bool, sorts_bool_sel) in 


          let relMap = RelMap.add relMap (RI.toString sel_bool) bool_sel_rel in 
          (*mannual encoding len : list int -> int*)      

          let len_id = RI.fromString "leni" in 
          let (tyMap, constMap, relMap, sort_list) = encodeTyD (tyMap, constMap, relMap) (Ty_list Ty_int) in 
          let (tyMap, constMap, relMap, sort_len) = encodeTyD (tyMap, constMap, relMap) (Ty_int) in 

          let sort_len = [sort_list;sort_len] in 
          let sr_len = mkMStrucRel (RI.toString len_id, sort_len) in 

          let relMap = RelMap.add relMap (RI.toString len_id) sr_len in 



          (*end remove later*)
         (*create hd_select
          * heap -> ref list int -> int *)
          let selhdid = RI.fromString "hd_sel" in 
          let (tyMap, constMap, relMap, sort_heap) = encodeTyD (tyMap, constMap, relMap) (Ty_heap) in  
          let () = Printf.printf "%s" (" \n Sort for Heap >>>> "^sortToString sort_heap) in   
          (*TODO :: These Manual Mappings must be automated*)
         

         let (tyMap, constMap, relMap, sort_val) = encodeTyD (tyMap, constMap, relMap) (Ty_list Ty_int) in 
          
          let (tyMap, constMap, relMap, sort_ref_int_list) = encodeTyD (tyMap, constMap, relMap) (Ty_ref (Ty_list (Ty_int))) in
                
          
          let (tyMap, constMap, relMap, sort_hd) = encodeTyD (tyMap, constMap, relMap) (Ty_int) in

          let sorts = [sort_heap;sort_ref_int_list;sort_hd] in 
          let sr_sel = mkMStrucRel (RI.toString selhdid, sorts) in 


          let relMap = RelMap.add relMap (RI.toString selhdid) sr_sel in 
          (tyMap, constMap, relMap) 

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
          |Ty_arrow (t1,t2)   ->
                (match t2 with 
                  | Ty_bool ->                       
                        let (tyMap, constMap, relMap, sorts) = encodeStrucRel (tyMap, constMap, relMap) (RI.fromString (Var.toString v), tyd) in 
                        (tyMap, constMap, relMap)
                  | _ -> let (tyMap, constMap, relMap, _) = encodeConst (tyMap, constMap, relMap) (v,tyd) in 
                         (tyMap, constMap, relMap) 
                )         
          |_ -> 
              let () = Printf.printf "%s" (" \n processTyDBind consEncoding Case ") in 
          
              let (tyMap, constMap, relMap, _) = encodeConst (tyMap, constMap, relMap) (v,tyd) in 
            let () = Printf.printf "%s" (" \n processTyDBind consEncoding done ") in 
          
            (tyMap, constMap, relMap)
          ) 
           
    in 

    let processTypenames (tyMap, constMap, relMap) tyd = 
        let () = Printf.printf "%s" (" \n processTypenames VCE "^(tyd)) in 
        let  (tyMap, constMap, relMap, sort_quad) = encodeTyD (tyMap, constMap, relMap) (TyD.fromString tyd) in 
        (tyMap, constMap, relMap)
           
           
    in

    let processQualifiers (tyMap, constMap, relMap) qual = 
        let () = Printf.printf "%s" (" \n processQualifiers VCE "^(SpecLang.RelSpec.Qualifier.toString qual)) in 
        let SpecLang.RelSpec.Qualifier.Qual {name;shape} = qual in 
        let z3_sorts_for_shape = 
                  List.map (fun tyd_i -> 
                                    (try 
                                      TyMap.find tyMap tyd_i
                                    with 
                                      | TyMap.TyDNotFound _ -> 
                                         let sortfortyd_i = 
                                          (match tyd_i with 
                                           TyD.Ty_alpha _ ->  addTyD tyMap tyd_i 
                                          | _ -> addTyD tyMap tyd_i  
                                          ) 
                                        in
                                         snd (sortfortyd_i)
                                    )
                                        
                            ) shape
        in              
        if (List.length z3_sorts_for_shape > 2) then 
          let mrel = mkMStrucRel (Var.toString name, z3_sorts_for_shape) in 
          let relMap = RelMap.add relMap (Var.toString name) mrel in 
          (tyMap, constMap, relMap)
        else 
          if (List.length z3_sorts_for_shape = 2) then 
            let mrel = mkStrucRel (Var.toString name, z3_sorts_for_shape) in 
            let relMap = RelMap.add relMap (Var.toString name) mrel in 
            (tyMap, constMap, relMap)
          else 
            raise (VCEncodingFailed "Qualifier Processing with incorrect number of sorts")  

      
    in 
    
    let processPrimEq (tyMap, constMap, relMap) (primR, def) =
         let () = Printf.printf "%s" (" \nprocessPrimEq PrimEq  ") in 
          
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
               | ConstMap.ConstNotFound v -> raise (VCEex ("Var "^v^" not found"))(* const_true  *)  
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

      

      (*Adding the sorts from the environment tydbinds and typenames *)
      let () = Printf.printf "%s" (" \n ******processTyDBind starting *****") in 
             
      let (tyMap, constMap, relMap) = List.fold_left (processTyDBind) (tyMap, constMap, relMap) tydbinds in  
      
      let () = Printf.printf "%s" (" \n ******Adding Typenames to tyMap*****") in 
      let (tyMap, constMap, relMap) = List.fold_left (processTypenames) (tyMap, constMap, relMap) typenames in 

      let () = Printf.printf "%s" (" \n ******Adding Qualifiers to relMap  *****") in 
      let (tyMap, constMap, relMap) = List.fold_left (processQualifiers) (tyMap, constMap, relMap) qualifiers in 



    (* ---- Type refinement encoding begins ---- *)
    (*encoding for base pred*)
    let rec encodeBasePred (tyMap, constMap, relMap) (bp)  = 
        
      let () = Printf.printf "%s" (" \n ******encodeBasePred *****") in 
    
        let
          open BP in 
          let encodeBaseExpr bexp = 
            let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp " in 
          
            match bexp with  
             (Int i) -> 
              let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp Int " in 
              let i_const = mkInt i in 
              let (i_const_exp, iconst_sort) =ast_expr_sort_pair i_const in 
              let i_const_eq_i = mk_Integer_eq (i_const_exp, mk_Numeric_constant i) in
              let _ = dischargeAssertion  i_const_eq_i in 
              i_const
              
              (* mkConst(string_of_int i, int_sort) *)
            | Bool true -> 
              let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp BoolT " in 
          
                const_true 
            | Bool false -> 
              let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$-encdode BaseExp BoolF" in 
          
              const_false
            | Var v -> 
              let () = Printf.printf "%s " ("\n $$$$$$$$$$$$$$$$$-encdode BaseExp Var %%%%%%%%%%%%%%%%%%%%%%"^(Ident.name v)) in 
              getConstForVar constMap v
            | Str s ->
              let () = Printf.printf "%s " ("\n $$$$$$$$$$$$$$$$$-encdode BaseExp Str "^(s)) in 
              let s_const = mkStr s in 
              s_const
        in
          let () = Printf.printf "%s " "\n $$$$$$$$$$$$$$$$$" in 
          match bp with
           Eq (e1,e2) -> 
            let () = Printf.printf "%s " ("\n $$$$$$$$$$$$$$$$$ BasePredicate Eq  "^(BP.toString bp)^" \n ") in 
              mkConstEqAssertion (encodeBaseExpr e1, encodeBaseExpr e2)
           | Iff (bp1,bp2) -> 
              let () = Printf.printf "%s "  ("\n $$$$$$$$$$$$$$$$$ BasePredicate Iff  "^ (BP.toString bp)^" \n ") in 
          
              mkIff ( (encodeBasePred (tyMap, constMap, relMap) bp1),
                (encodeBasePred (tyMap, constMap, relMap) bp2))
           | Gt (e1, e2) -> 
                mkConstGtAssertion (encodeBaseExpr e1, encodeBaseExpr e2)
                (* raise (Unimplemented "encodeBasePred Gt case is missing")  *)
        in 
      (*encoding for r*)        
     let rec encodeRelExpr (tyMap, constMap, relMap) (e) =
    
      let () = Printf.printf "%s" (" \n ******encodeRelExpr *****") in 
      let () = Printf.printf "%s "  ("\n RelExp  "^ (RelLang.exprToString e)^" \n ") in 
    
        let open RelLang in 
        let encodeRelElem (tyMap, constMap, relMap) = fun x -> 
          let () = Printf.printf "%s" (" \n ******encodeRelElem  *****") in 
    
          match x with 
            | (Int i) -> mkInt i 
            | Bool true -> const_true 
            | Bool false -> const_false
            | Var v -> getConstForVar constMap v
        in
          let () = Printf.printf "%s" (" \n ******encodeRelExpr here *****") in 
    
         match e with 
            V elm -> 
                 let () = Printf.printf "%s" (" \n ******encodeRelExpr T *****") in 
                 mkSingletonSet( [encodeRelElem (tyMap, constMap, relMap) elm])
 
           |T els -> 
                let () = Printf.printf "%s" (" \n ******encodeRelExpr T *****") in 
                (match Vector.length els with 
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
            | ADD (e1, e2) ->
              let () = Printf.printf "%s" (" \n ******encodeRelExpr ADD *****") in 
               
               mkAddition ( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                (encodeRelExpr (tyMap, constMap, relMap) e2)) 
             | SUBS (e1, e2) ->
              let () = Printf.printf "%s" (" \n ******encodeRelExpr SUBS *****") in 
                mkSubstraction( (encodeRelExpr (tyMap, constMap, relMap) e1), 
                (encodeRelExpr (tyMap, constMap, relMap) e2)) 

             | R (RInst {rel=rid;_},v) -> 
              let () = Printf.printf "%s" (" \n ******encodeRelExpr R *****") in 
              
              let srforR = getStrucRelForRelId relMap rid in 
              let SR{ty;rel} = srforR in 
               let list_layout_ty = List.map (fun sor-> sort_layout sor) ty in 
               let str_ty  = (List.fold_left (fun acc l -> acc^(Layout.toString l) ) "{ " list_layout_ty)^" }" in 

              let ()  = Printf.printf "%s" ("Type "^str_ty) in 
              let const = getConstForVar constMap v in 
              let out = mkStrucRelApp (
                (getStrucRelForRelId relMap rid), (getConstForVar constMap v)) in 
              out 
            | MultiR (RInst {rel=rid;_}, args) -> 
             
                 let ()  = Printf.printf "%s" ("\n *******encodeRelExpr MultiR******** ") in 
                let srforR = getStrucRelForRelId relMap rid in 
                let MSR{mty;mrel} = srforR in 
                let str_ty  = (List.fold_left (fun acc s -> acc^(sortToString s)^" :-> " ) "{" mty )^" }" in 

              let ()  = Printf.printf "%s" ("Type "^str_ty) in 


              let argument_list = List.map (fun v -> getConstForVar constMap v) args in 
              let arg_exp_sort_list = List.map (fun argument -> ast_expr_sort_pair argument) argument_list in 
              let  arg_sort_list = List.map (fun (_, s) -> sortToZ3Sort s) arg_exp_sort_list in  
              let arg_exp_list = List.map (fun (v,_ ) -> v) arg_exp_sort_list in  
              let cosnt_for_arg_list = List.map (fun v -> getConstForVar constMap v) args in               
           
              let ()  = Printf.printf "%s" ("arguments "^(List.fold_left (fun acca (arg_exp)-> (acca^", "^Expr.to_string arg_exp)) "Arg Exps " arg_exp_list )) in 
              let ()  = Printf.printf "%s" ("arguments Sorts "^(List.fold_left(fun accs s -> (accs^", "^Z3.Sort.to_string s) ) "Arg Sorts " arg_sort_list)) in 
               (*We need to create a set by application*) 
               let ufApp = mkMStrucRelApp  (srforR, cosnt_for_arg_list) in 
                let ()  = Printf.printf "%s" ("Uninterpreted Function App Encoding Done ") in
                ufApp
         
              
      in 
      
      (*encoding for rn*)
      let rec encodeNumericExpr (tyMap, constMap, relMap) (e) = 
        let () = Printf.printf "%s" (" \n ******encodeNumericExpr *****") in 
        let open RelLang in 
        let encodeNumericElem (tyMap, constMap, relMap) = fun x -> 
          match x with 
            | (Int i) -> 
                    let () = Printf.printf "%s" "\n Encoding Numeric Elem \n " in 
                    let res = mk_Numeric_constant i in 
                    let () = Printf.printf "%s" "\n Encoding Numeric Elem Success \n " in 
                      res
            | Bool true -> raise (VCEex ("Incorrect argument to a numeric expression "^(RelLang.exprToString e) ))
            | Bool false -> raise (VCEex ("Incorrect argument to a numeric expression "^(RelLang.exprToString e) ))
            | Var v -> 
                        let () = Printf.printf "%s" "\n Encoding Numeric Elem Var Case \n " in 
                        let () = Printf.printf "%s" ("\n "^(Ident.name v)) in 
                        let astforconst = getConstForVar constMap v in 
                        let (ast_exp, ast_sort) =ast_expr_sort_pair astforconst in 
                         ast_exp 
             

        in
        match e with 
        |  V elm -> encodeNumericElem (tyMap, constMap, relMap) elm       
          |T els -> 
                (* If expression is a tuple then it must be a Singleton of type int*) 
                let () = Printf.printf "%s" (" \n ******encodeNumericExpr T *****") in 
                (
                match Vector.length els with 
                    0 -> raise (VCEex ("Incorrect numeric expression "^(RelLang.exprToString e) )) 
                    | 1 -> let numericValue = encodeNumericElem (tyMap, constMap, relMap) (List.hd els) in 
                            numericValue
                    | _ -> raise (VCEex ("Incorrect number of numeric arguments "^(RelLang.exprToString e) ))
                  )
            | ADD (e1, e2) ->
               mk_Integer_addition ( (encodeNumericExpr (tyMap, constMap, relMap) e1), 
                (encodeNumericExpr (tyMap, constMap, relMap) e2)) 
            
            | SUBS (e1, e2) ->
               mk_Integer_substraction ( (encodeNumericExpr (tyMap, constMap, relMap) e1), 
                (encodeNumericExpr (tyMap, constMap, relMap) e2)) 
            
               (*For Single argument relations, define a Uninterpreted function *) 
            | R (RInst {rel=rid;_},v) -> 
              let () = Printf.printf "%s" (" \n ******encodeNumericExpr R *****") in 
              (*get the function for the numeric relation if present, else add the function to tthe relMap
              create the function application*)
              let srforR = getStrucRelForRelId relMap rid in 
              let SR{ty;rel} = srforR in 
              let list_layout_ty = List.map (fun sor-> sort_layout sor) ty in 
              let str_ty  = (List.fold_left (fun acc l -> acc^(Layout.toString l) ) "{" list_layout_ty)^" }" in 

              let ()  = Printf.printf "%s" ("Type "^str_ty) in 
              let () = Printf.printf "%s" ("argument Name"^(Ident.name v)) in 

              let argument = getConstForVar constMap v in 
              let astLayout = ast_layout argument in 
              let (arg_exp, arg_sort) =ast_expr_sort_pair argument in 
              
                        
              let reln_required_arg_sort = sortToZ3Sort arg_sort in 
              let ()  = Printf.printf "%s" ("argument Sort "^(Z3.Sort.to_string reln_required_arg_sort)) in 
         
              
              let relate = mk_Integer_func_decl (RelId.toString rid, [reln_required_arg_sort], (mk_int_sort())) in 
              let ()  = Printf.printf "%s" ("relation "^(FuncDecl.to_string relate)) in 
              
              let ()  = Printf.printf "%s" ("arguments "^(Expr.to_string arg_exp)) in 
              let ()  = Printf.printf "%s" ("argument Sort "^(Z3.Sort.to_string reln_required_arg_sort)) in 
             
               let relApp = mk_Integer_rel_app  (relate, [arg_exp]) in 
                let ()  = Printf.printf "%s" ("relation App Done ") in
                relApp 
             (*Define a multi argument Uninterpreted function *) 
           | MultiR (RInst {rel=rid;_}, args) -> 
                let ()  = Printf.printf "%s" ("\n *******encodeNumericExpr MultiR******** "^(RelId.toString rid)) in 
                let srforR = getStrucRelForRelId relMap rid in 
                let MSR{mty;mrel} = srforR in 
               let str_ty  = (List.fold_left (fun acc s -> acc^(sortToString s)^" :-> " ) "{" mty )^" }" in 

              let ()  = Printf.printf "%s" ("Type "^str_ty) in 


              let argument_list = List.map (fun v -> getConstForVar constMap v) args in 
              let arg_exp_sort_list = List.map (fun argument -> ast_expr_sort_pair argument) argument_list in 
              let  arg_sort_list = List.map (fun (_, s) -> sortToZ3Sort s) arg_exp_sort_list in  
              let arg_exp_list = List.map (fun (v,_ ) -> v) arg_exp_sort_list in  
          
              let uf = mk_Integer_func_decl (RelId.toString rid, arg_sort_list, (mk_int_sort())) in 
              let ()  = Printf.printf "%s" ("uf "^(FuncDecl.to_string uf)) in 
              let ()  = Printf.printf "%s" ("arguments "^(List.fold_left (fun acca (arg_exp)-> (acca^", "^Expr.to_string arg_exp)) "Arg Exps " arg_exp_list )) in 
              let ()  = Printf.printf "%s" ("arguments Sorts "^(List.fold_left(fun accs s -> (accs^", "^Z3.Sort.to_string s) ) "Arg Sorts " arg_sort_list)) in 
             
               let ufApp = mk_Integer_rel_app  (uf, arg_exp_list) in 
                let ()  = Printf.printf "%s" ("Uninterpreted Function App Encoding Done ") in
                ufApp
         
         


            | _ ->  raise (VCEex ("Incorrect numeric expression "^(RelLang.exprToString e) ))
             
          

        in
      (*encoding for rn > rn*)  
      let encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2) = 
        let () = Printf.printf "%s" (" \n ******encodeNumericGrtAssertion *****") in 
        let encoding_lhs =  encodeNumericExpr (tyMap, constMap, relMap) e1 in 
        let () = Printf.printf "%s" (" \n ******encodeNumericGrtAssertion LHS done *****") in 
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion RHS  *****") in 
        let encoding_rhs = encodeNumericExpr (tyMap, constMap, relMap) e2 in 
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion RHS done *****") in 
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion creating EQ  *****") in 
        let gt_assertion = mk_Integer_gt (encoding_lhs,  encoding_rhs) in 
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion creating EQ  DONE*****") in 
      
        gt_assertion

      in

        (*Encoding of rn == rn*)
      let encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2) = 
            let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion *****") in 
               
          let encoding_lhs =  encodeNumericExpr (tyMap, constMap, relMap) e1 in 
            let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion LHS done *****") in 
        
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion RHS  *****") in 
      
          let encoding_rhs = encodeNumericExpr (tyMap, constMap, relMap) e2 in 
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion RHS done *****") in 
        
        
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion creating EQ  *****") in 
               
        let eq_assertion = mk_Integer_eq (encoding_lhs,  encoding_rhs) in 
        let () = Printf.printf "%s" (" \n ******encodeNumericEqAssertion creating EQ  DONE*****") in 
        
          eq_assertion

      in
       let encodeRelPred (tyMap, constMap, relMap) (rp:RP.t)  =
          let () = Printf.printf "%s" (" \n ******encodeRelPred  *****"^(RP.toString rp)) in 
          let  open RelLang in 
          let f = (encodeRelExpr (tyMap, constMap, relMap)) in 
          let  open RP in 
        
        match  rp with 
         | NEq (e1, e2) -> 
              (match (e1, e2) with 
                 (_, ADD (_,_)) 
                | (ADD (_,_), _)  
                | (_, SUBS(_,_))
                | (SUBS(_,_), _)->    
                         let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION SUBS "^(RelLang.exprToString (e1) )^" = "^(RelLang.exprToString (e2) ) ) in  
                      encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
              

                (*for R and MultiR*)
                |(R (rie1, id1) as r1, R (rie2, id2) as r2 ) ->
          
                     let () = Printf.printf "%s" ("\n Case :: Both Rel Exp ") in  
                 
                     let RInst {rel;_} = rie1 in
                     let relId1 = RelId.toString rel in 
                      
                     let RInst {rel;_} = rie2 in
                     let relId2 = RelId.toString rel in 
                    

                     let codomainsort_r1 = getSRCodomainSort relMap relId1 in  
                     let codomainsort_r2 = getSRCodomainSort relMap relId2 in 

                     (match (codomainsort_r1, codomainsort_r2) with 
                        ( Int s1, Int s2) -> 
                       encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)

                     | (_, _)  -> 

                       raise (IncorrectRelSort ("Numeric Expression with non numeric arguments in "^(relId1)^" OR "^(relId2)))
                     )
                     
                |(R (rie, id), _) ->
                    let RInst {rel;_} = rie in
                    let relId = RelId.toString rel in 
                    let codomainsort_r = getSRCodomainSort relMap relId in 

                     (match (codomainsort_r) with 
                        ( Int s1) -> 
                       encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                     | _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
                 )


                 | (_, R (rie, id))  ->               
                      let RInst {rel;_} = rie in 
                      let relId = RelId.toString rel in 
                      let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 2"^relId) in 
                       let codomainsort_r = getSRCodomainSort relMap relId in 

                     (match (codomainsort_r) with 
                        ( Int s1) -> 
                       encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                     | _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
                     )
                (*If either of the lhs or rhs is a MR then we can simple create equality expression*)
                | (MultiR (rie1, idl1) as r1, MultiR (rie2, idl2) as r2 ) ->
          
                     let () = Printf.printf "%s" ("\n Case :: Both Rel Exp ") in  
                 
                     let RInst {rel;_} = rie1 in
                     let relId1 = RelId.toString rel in 
                      
                     let RInst {rel;_} = rie2 in
                     let relId2 = RelId.toString rel in 
                    

                     let codomainsort_r1 = getSRCodomainSort relMap relId1 in  
                     let codomainsort_r2 = getSRCodomainSort relMap relId2 in 

                     (match (codomainsort_r1, codomainsort_r2) with 
                        ( Int s1, Int s2) -> 
                         encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                     | (s1, s2)  -> 
                              if (not (same_sort s1 s2)) then 
                                 raise (IncorrectRelSort ("MultiR case Numeric Expression with non numeric arguments in "^(relId1)^" OR "^(relId2)))
                              else
                                mkEqAssertion  (f e1, f e2)
                     )
                     
                |(MultiR (rie, id), _) ->
                    let () = Printf.printf "%s" ("\n Case NEq (MR , Other) ") in 
                    let RInst {rel;_} = rie in
                    let relId = RelId.toString rel in 
                    let codomainsort_r = getSRCodomainSort relMap relId in 

                     (match (codomainsort_r) with 
                        ( Int s1) -> 
                         encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                     | _  -> 
                            
                            mkEqAssertion (f e1, f e2)
                     
                     )


                | (_, MultiR (rie, id))  ->               
                      let RInst {rel;_} = rie in 
                      let relId = RelId.toString rel in 
                      let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 2"^relId) in 
                       let codomainsort_r = getSRCodomainSort relMap relId in 

                     (match (codomainsort_r) with 
                        ( Int s1) -> 
                       encodeNumericEqAssertion (tyMap, constMap, relMap) (e1, e2)
                     |  _  -> 
                                
                          mkEqAssertion  (f e1, f e2)
                     
                     )

                (*Incorrect case*) 
                | (_, _) ->  raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")


            )


        |Eq (e1,e2) -> (*if either of e1 or e2 is an arithmatic relation like rlen, then make arithmeticEqAssertion*)
              (match (e1, e2) with 
                
                 |(R (rie1, id1) as r1, R (rie2, id2) as r2 ) ->
                      mkSetEqAssertion (f e1, f e2)       
                 |(R (rie, id), _) ->
                      mkSetEqAssertion (f e1, f e2)    
                 | (_, R (rie, id))  ->               
                    mkSetEqAssertion (f e1, f e2)    
                  (*Case singleton set expression*)
                 
                | (_,_) -> 
                   let () = Printf.printf "%s" ("\n RELATIONAL EXPRESSION CASE "^(RelLang.exprToString ( e1) )^" = "^(RelLang.exprToString (e2) )) in 
                      mkSetEqAssertion (f e1, f e2)
            )      
        |Grt ( e1, e2) -> 
              (match (e1, e2) with 
              | (*simplest case*) (T el1, T el2)  -> 
                        encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2) 
             
              | (_, ADD (_,_)) 
              | (ADD (_,_), _)  
              | (_, SUBS(_,_))
              | (SUBS(_,_), _)->    

                      let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION SUBS "^(RelLang.exprToString (e1) )^" = "^(RelLang.exprToString (e2) ) ) in  
                      encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
              
              

                (*for R and MultiR*)
                |(R (rie1, id1) as r1, R (rie2, id2) as r2 ) ->
          
                     let () = Printf.printf "%s" ("\n Case :: Both Rel Exp ") in  
                 
                     let RInst {rel;_} = rie1 in
                     let relId1 = RelId.toString rel in 
                      
                     let RInst {rel;_} = rie2 in
                     let relId2 = RelId.toString rel in 
                    

                     let codomainsort_r1 = getSRCodomainSort relMap relId1 in  
                     let codomainsort_r2 = getSRCodomainSort relMap relId2 in 

                     (match (codomainsort_r1, codomainsort_r2) with 
                        ( Int s1, Int s2) -> 
                       encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
                     | _  -> raise (IncorrectRelSort ("Numeric Expression with non numeric arguments in "^(relId1)^" OR "^(relId2))) 
                     )
                     
                |(R (rie, id), _) ->
                    let RInst {rel;_} = rie in
                    let relId = RelId.toString rel in 
                    let codomainsort_r = getSRCodomainSort relMap relId in 

                     (match (codomainsort_r) with 
                        ( Int s1) -> 
                       encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
                     |  _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
                     )


                 | (_, R (rie, id))  ->               
                      let RInst {rel;_} = rie in 
                      let relId = RelId.toString rel in 
                      let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 2"^relId) in 
                       let codomainsort_r = getSRCodomainSort relMap relId in 

                     (match (codomainsort_r) with 
                        ( Int s1) -> 
                       encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
                     | _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
                     )

                | (MultiR (rie1, idl1) as r1, MultiR (rie2, idl2) as r2 ) ->
          
                     let () = Printf.printf "%s" ("\n Case :: Both Rel Exp ") in  
                 
                     let RInst {rel;_} = rie1 in
                     let relId1 = RelId.toString rel in 
                      
                     let RInst {rel;_} = rie2 in
                     let relId2 = RelId.toString rel in 
                    

                     let codomainsort_r1 = getSRCodomainSort relMap relId1 in  
                     let codomainsort_r2 = getSRCodomainSort relMap relId2 in 

                     (match (codomainsort_r1, codomainsort_r2) with 
                        ( Int s1, Int s2) -> 
                       encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
                     | (_, _)  -> raise (IncorrectRelSort "Numeric Expression with non numeric arguments")
                     )
                     
                |(MultiR (rie, id), _) ->
                    let () = Printf.printf "%s" ("encode RelPredicate Grt (MR , Other)") in   
                    let RInst {rel;_} = rie in
                    let relId = RelId.toString rel in 
                    let codomainsort_r = getSRCodomainSort relMap relId in 
                    let () = Printf.printf "%s" (">>>>") in 
                     (match (codomainsort_r) with 
                        ( Int s1) -> 
                       encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
                     |  _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
                     )


                | (_, MultiR (rie, id))  ->               
                      let RInst {rel;_} = rie in 
                      let relId = RelId.toString rel in 
                      let () = Printf.printf "%s" ("\n NUMERICAL EXPRESSION CASE 2"^relId) in 
                       let codomainsort_r = getSRCodomainSort relMap relId in 

                     (match (codomainsort_r) with 
                        ( Int s1) -> 
                       encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
                     |  _  -> raise (IncorrectRelSort "Numeric Expression with non-numeric arguments")
                     )

                        
                 (*Case singleton set expression*)
                | (T el1, T el2) ->
                    let () = Printf.printf "%s" ("\n singleton Set Eq CASE "^(RelLang.exprToString ( e1) )^" = "^(RelLang.exprToString (e2) )) in 
                    encodeNumericGrtAssertion (tyMap, constMap, relMap) (e1, e2)
                | (_, _) ->  raise (IncorrectRelSort "Numeric Expression Grt (e1, e2) with non-numeric arguments")


         
              )

          | Sub (e1,e2) -> mkSubSetAssertion (f e1, f e2)
          | SubEq (e1,e2) -> (fun s -> mkOr( Vector.new2 (mkSetEqAssertion s,
              mkSubSetAssertion s))) (f e1, f e2)
          (*TODO We need to generate Z3 for Grt *)                     
        in 
        
       let encodeSimplePred (tyMap, constMap, relMap) (sp ) =
          
         let () = Printf.printf "%s" (" \n ******encodeSimplePred *****") in 

         match  sp with  
          (VC.Base bp) -> encodeBasePred (tyMap, constMap, relMap) bp
        | (VC.Rel rp) -> encodeRelPred (tyMap, constMap, relMap) rp  
        | VC.True -> mk_true () 
        | VC.False -> mk_false () 
        in    
      let assertSimplePred  (tyMap, constMap, relMap) = dischargeAssertion << encodeSimplePred (tyMap, constMap, relMap) in 

      let rec encodeVCPred (tyMap, constMap, relMap) vcp = 
              (*TODO We are working directly on the Predicate*)
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


      (*main entry*) 
      let (tyMap, constMap, relMap) = addSelUpdate (tyMap, constMap, relMap) in    
      let _ = assertVCPred (tyMap, constMap, relMap) anteP in 
      (*
       * We check the SAT of ¬conseqP
       *)
      let _ = dischargeAssertion (mkNot (encodeVCPred (tyMap, constMap, relMap) conseqP)) in 
      let solverDischarged = getSolver () in 
      let expressions_list = Solver.get_assertions solverDischarged  in  


      let () = Printf.printf "%s" ("\n# of Z3 expressions "^(string_of_int (List.length expressions_list))) in   
      let () = Printf.originalPrint "%s" ("\nsolver \n "^(Solver.to_string solverDischarged)) in   
     
      let res =   Solver.check solverDischarged [] in
 
      let () = Solver.reset solverDischarged in 
     
    
      match  res with 
           SATISFIABLE -> Failure
         | UNKNOWN -> Undef 
         | UNSATISFIABLE -> Success
        | _ -> raise SolverTimeout



    
