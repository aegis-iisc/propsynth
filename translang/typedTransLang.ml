(*A languages for typed Transducer*)
open Printf
open SpecLang

module TyD = TyD
module RefTy = RefinementType
module P = Predicate
module BP = Predicate.BasePredicate
module RP = Predicate.RelPredicate
module Var = Var
module TyVar = Tyvar 

exception Error of string 
(*aliases for types in the specLang*)
type ty = RefTy.t 
type var = Var.t
type loc = TyD.loc
type tyvar = TyVar.t     
type lit = Con.t
type pred = P.t

(*\Sigma terms from the paper*)
type term = 
        | T_lam of var * term * ty (*checkable c *)
        | T_var of var 
        | T_app of term * term    
        | T_const of lit 
        | T_dref of term  (*synthesizable s , or no ty*)
        | T_cref of term 
        | T_assign of term * term  
        | T_let of term * term * term              
        | T_seq of term * term   
        | T_loc of loc 
        | T_unit     
        | T_cons of term * term 
        | T_nil             
        | T_match of term * term * term * term
        | T_data of (string *  (term list)) (*data constructor of name string and list of parameter *)                
                     
let is_v (t:term) : bool = 
  match t with 
  | T_lam _ -> true 
  | T_const _ -> true
  | T_loc _ -> true 
  | T_unit -> true  
  | T_nil _ -> true 
  | T_cons _  -> true  
  | T_data _ -> true   
  | _ -> false

let is_tvar (t:term) : bool = 
  match t with 
    | T_var _ -> true 
    | _ -> false

(*default placeholder term*)
let trivial_var v = T_var (Var.fromString v)
let trivial_assign v  = T_assign (T_var v, T_const (ILit 0)) 
let int_assign_term v i = T_assign (T_var v, T_cref (T_const (ILit i)))
let seq_term t1 t2 = T_seq (t1, t2) 
let lambda v btype = T_lam (v, (T_var v), btype)    
let dref r = T_dref (T_var r)    
let trivial_unit = T_unit
(*definition of transducers using the above definition of expression language with refernces as label*)
type state = string 
 
type delta = Del of {name: var;src:state; tgt : state; guard : (pred) ; step : (term); inv : (pred)} (*guard and step have to be typed term*)

type finalfun = Final of {fin : state -> (term * ty)}
(*\skip = \x . unit*)

(*TODO :: This is analogues to finalizer in a transducer. the type of the return value should be 
 **)
let getSkipType () = let ty = RefTy.MArrow ( Effect.Pure, (Predicate.getForAllTrue [Var.fromString "h", TyD.Ty_heap]), 
                                                TyD.Ty_int, 
                                             (Predicate.getForAllTrue [(Var.fromString "h", TyD.Ty_heap);(Var.fromString "v", TyD.Ty_unit);(Var.fromString "h'", TyD.Ty_heap) ])) in 
        ty 


let getSkipTerm () = let trm = T_lam ((Var.fromString "x"),  T_unit, getSkipType()) in trm 
(*define Path properties as a separate module*)

let string_of_delta _d = 
  let Del {name;src;tgt;guard;step} =_d in 
  "\del {  name "^name^ " ; "^ src^ " : "^tgt^" }" 

type path = Seq of (delta list) 
                  
let append_path (p:path) (_d : delta) =
  let Seq dlist = p in 
  Seq (List.append dlist [_d]) 

let terminal_node (p:path) : string option =
  match p with 
  | Seq plist -> try 
                   let last_d = List.hd (List.rev plist) in 
                   let Del {tgt;_} = last_d in 
                   Some tgt
                with
                  | Failure _-> None

(*is self loop*)
let is_selfloop del = 
    let Del{src;tgt;_} = del in 
    if (src = tgt) then true 
    else 
      false
                                          

let string_for_path p = 
  match p with 
  | Seq plist -> List.fold_left (fun (acc:string) (_d) -> (acc ^" --> "^(string_of_delta _d)^" ")) " path = " plist  



(*Each transducer must be annotated with a ty*)
type trans =  Trans of {regs : (term*ty) list;
                        states: string  list;
                        start:string;
                        (*init is a sequence of Theory terms whose type we *) 
                        init: (term * ty);
                        final:string list; 
                        finalizer : finalfun; 
                        deltas: (delta*ty) list;
                        (*given type for the Transducer*)
                        annot : ty}
 
type inp = char list



(*composition of transducers*)
type program (*check*)=  
     ST of trans (*check*) 
   | Lambda  of (term  (*check*) * ty * program (*check*) ) (*synth \x.T*)
   | Dot of (program (*check*) * program (*check*))  (*synth*)
   | Bind of (program (*check*) * program (*check*)) (*synth*)
   | Alt of (program (*check*) * program (*check*)) (*synth*)
   | Red of (term (*check*) * program (*check*)) (*synth*)
   | Fold of (
              program (*check*) * 
              (term * ty) (*f*) * 
               pred (*g : pred*) * 
              (term * ty) (*acc *) * 
              pred * (*inv*)
              ty (*type annotation*)
            )           
                 

type typedProgram = {prog : program; checkable : ty}

let is_lambda (p : program) = 
        match p with 
        | Lambda _ -> true 
        | _ -> false


          
let compose (p1 : program) (p2: program) : program 
        = p1




(*auxiliary functions over trans*)
let is_final_control (Trans{final;_}) (q : state) : bool = 
   List.mem q final 

(*procedure to lift a function with no input consumption into a trans, 
 * refer T*)
(*let liftInto (f:term ) : trans = *)


(*let liftTypeInto (fty: ty) : ty = *)
        



