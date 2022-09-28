
val swap:  arr : 'a array  -> {v : int | 0 <= v < length (arr) }
                   {v : int | 0 <= v < length (arr)} -> 
                   {v : 'a array | v.(i)) == arr.(j) /\
                                    v.(j) == arr.(j) /\
                                    forall k. (k != i /\ k != j) => v.(k) == arr.(k))};

(*@ 
     val swap: 'a array -> int -> int -> unit
   
     swap a i j
      requires 0 <= i < Array.length a && 0 <= j < Array.length a
      modifies a
      ensures  a.(i) = old a.(j)
      ensures  a.(j) = old a.(i)
      ensures  forall k. 0 <= k < Array.length a ->
               k <> i -> k <> j -> a.(k) = old a.(k) *)

(*functionalization is needed as arrays allow in place updates *)
let swap : type a. ((a array)) -> (int) -> (int) ->  'a array =
  fun a i j -> 
    let v = a.(i) in 
    let v2 = a.(j) in 
    let a_i = update (a, i, v2) in  
    let a_j = update (a_i, j, v) in 
    a_j
    

