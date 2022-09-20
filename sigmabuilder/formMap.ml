open SpecLang
module FormKey =
       struct
         type t = Ident.t
         let equal(t1,t2)  = Ident.equal t1 t2
       end

module FormValue = 
       struct
         type t = Predicate.t
        end


module FormMap = Applicativemap.ApplicativeMap (FormKey) (FormValue) 

exception FormulaNotFound of FormKey.t
  
type t = FormMap.t

let empty = FormMap.empty
let mem = FormMap.mem
let find t tyd = 
    try (FormMap.find t tyd) 
  with 
  | (FormMap.KeyNotFound k) -> raise (FormulaNotFound k)

let add = fun fmap -> fun name pred -> FormMap.add fmap name pred
let remove = FormMap.remove

