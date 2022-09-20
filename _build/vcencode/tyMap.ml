
open SpecLang
module TypeDMapKey =
       struct
         type t = TyD.t
         let equal(t1,t2)  =  TyD.sametype t1 t2
       end

module TypeDMapValue =
       struct
         type t = Z3_encode.sort
         let equal (t1, t2) = Z3_encode.same_sort t1 t2  
       end


module TyMap = Applicativemap.ApplicativeMap (TypeDMapKey) (TypeDMapValue) 

exception TyDNotFound of TypeDMapKey.t
  
type t = TyMap.t

let empty = TyMap.empty
let mem = TyMap.mem
let find t tyd = 
    try (TyMap.find t tyd) 
  with 
  | (TyMap.KeyNotFound k) -> raise (TyDNotFound k)

let add = fun t -> fun tyd sort -> TyMap.add t tyd sort 

let remove = TyMap.remove

