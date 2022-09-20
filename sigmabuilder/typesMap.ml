
open SpecLang
module TypesKey =
       struct
         type t = Ident.t
         let equal(t1,t2)  = Ident.equal t1 t2
       end

module TypesValue = 
       struct
         type t = RefinementType.t
        end


module TypesMap = Applicativemap.ApplicativeMap (TypesKey) (TypesValue) 

exception TypeNotFound of TypesKey.t
  
type t = TypesMap.t

let empty = TypesMap.empty
let mem = TypesMap.mem
let find t tyd = 
    try (TypesMap.find t tyd) 
  with 
  | (TypesMap.KeyNotFound k) -> raise (TypeNotFound k)

let add = fun tmap -> fun name ty -> TypesMap.add tmap name ty 
let remove = TypesMap.remove



