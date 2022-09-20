(* module name : <signature> = <implemenation> *)
module type Key = sig

  type t 
  val equal : t*t -> bool
end 
module type Value =  sig

 type t
 val equal : t*t -> bool    

  
end 

module ApplicativeMap (K : Key) (V : Value) =
    
struct
	module Key = K
	module Val = V 

	exception KeyNotFound of Key.t
type t = (Key.t * Val.t) list

let empty = []

let mem map k  = List.exists (fun (k', v) -> Key.equal (k, k')) map

(*The function used for synthesizing a term of type Evar for a given type, enumerate and find*)
let enumerate map value = List.filter (fun (k, v') -> Val.equal (value, v')) map 


(*returns the Value field of the key macthing the given key*)
let find map k  =  
  		try 
  			let found = List.find (fun (k', v) -> Key.equal (k, k')) map in 
        snd (found)
  		with  
  		| Not_found -> raise (KeyNotFound k)

let remove map k = List.remove_assoc k map

let add map k v = 
    let map = remove map k in 
    (k,v) :: map 

let map f t = List.map f t

let replace map k v = 
    let l = remove map k in 
    add l k v  


end 

