
let strEq str1 str2 = (str1 = str2)  
module ConstantMapKey = 
       struct
         type t = string
         let equal (t1, t2)  =  strEq t1 t2
       end

module ConstantMapValue = 
       struct
         type t = Z3_encode.ast
         let equal (t1, t2) = Z3_encode.sameAst t1 t2            
        end

module ConstMap = Applicativemap.ApplicativeMap (ConstantMapKey) (ConstantMapValue)

type t = ConstMap.t
exception ConstNotFound of ConstantMapKey.t
  
let empty = ConstMap.empty
let mem = ConstMap.mem
let find env relId = 
    try (ConstMap.find env relId) 
  with 
  | (ConstMap.KeyNotFound k) -> raise (ConstNotFound k)

let add = fun env -> fun var desc -> ConstMap.add env var desc 

let remove = ConstMap.remove

