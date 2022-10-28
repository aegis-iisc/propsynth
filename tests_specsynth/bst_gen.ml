let rec bst_gen_v2 (diff : int) (lo : int) (hi : int) : int tree =
  if diff <= 1 then Leaf
  else if bool_gen () then Leaf
  else
    let (lo1 : int) = lo + 1 in
    let (hi1 : int) = hi - 1 in
    let (x : int) = int_range lo1 hi1 in
    let (diff1 : int) = x - lo in
    let (lt : int tree) = bst_gen_v2 diff1 lo x in
    let (diff2 : int) = hi - x in
    let (rt : int tree) = bst_gen_v2 diff2 x hi in
    Node (x, lt, rt)



leaf : {v : tree | \(u : int).
                    tmem (v, u) = false /\ sortedtree (v) = true};
(* 
let[@library] node =
  let (root : [%over: int]) = (true : [%v: int]) in
  let (sizel : [%over: int]) = (v >= 0 : [%v: int]) in
  let (dummy : [%under: int tree]) =
    (fun (u : [%forall: int]) ->
       implies (mem v u) (root - sizel < u && u < root)
       && sorted v && len v sizel
      : [%v: int tree])
  in
  let (sizer : [%over: int]) = (v >= 0 : [%v: int]) in
  let (dummy : [%under: int tree]) =
    (fun (u : [%forall: int]) ->
       implies (mem v u) (root < u && u < root + sizer)
       && sorted v && len v sizer
      : [%v: int tree])
  in
  (fun (u : [%forall: int]) ->
     implies (mem v u) (root - sizel < u && u < root + sizer) && sorted v
    : [%v: int tree])     *)


let[@library] int_range =
  let (a : [%over: int]) = (true : [%v: int]) in
  let (b : [%over: int]) = (a <= v : [%v: int]) in
  (a <= v && v <= b : [%v: int])


int_range : (a : int) -> (b : int) -> {v : int | v}

bool_gen : unit -> {v : bool | [v=true] <=> [v=true] /\ [v=false] <=> [v=false]} 

node : (root : int) -> (sizel : {v : int | ([v>0] \/ [v=0])} -> 
                       (ltree : {v : tree | \(u:int). 
                                (tmem (v, u) = true => [root > u] /\ (u > root -- sizel) ) /\ sortedtree (v) = true }) -> 
                       (sizer : {v : int | ([v>0] \/ [v=0])} -> 
                       (rtree : {v : tree | \(u:int). 
                                (tmem (v, u) = true =>  [u > root] /\(root > u -- sizer) ) /\ sortedtree (v) = true }) ->
                       {v: tree | \(u : int). (tmem (v, u) => (u > (soot -- sizel) /\ root > u -- sizer)) 
                                  /\ sortedtree (v) = true    
                      
             
                                  
let bst_gen_v1 =
  let (lo : [%over: int]) = (true : [%v: int]) in
  let (hi : [%over: int]) = (lo <= v : [%v: int]) in
  (len v 0 : [%v: int tree])

let[@inv? n when 0] bst_gen_v2 =
  let (d : [%over: int]) = (0 <= v : [%v: int]) in
  let (lo : [%over: int]) = (true : [%v: int]) in
  let (hi : [%over: int]) = (v == lo + d : [%v: int]) in
  (fun (u : [%forall: int]) ->
     implies (mem v u) (lo < u && u < hi)
     && sorted v
     && implies (u < d) (len v u)
    : [%v: int tree])