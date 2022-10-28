(*program*)
let rec size_bst_gen (diff : int) (sizebound : int) (lo : int) (hi : int) :
    int tree =
  if diff <= 1 then Leaf
  else if sizebound <= 0 then Leaf
  else if bool_gen () then Leaf
  else
    let (x : int) = int_range lo hi in
    let (lt : int tree) = size_bst_gen (x - lo) (sizebound - 1) lo x in
    let (rt : int tree) = size_bst_gen (hi - x) (sizebound - 1) x hi in
    Node (x, lt, rt)



(*under*)
let[@library] int_range =
  let (a : [%over: int]) = (true : [%v: int]) in
  let (b : [%over: int]) = (1 + a < v : [%v: int]) in
  (a < v && v < b : [%v: int])

let[@library] bool_gen =
  let (dummy : [%over: unit]) = (true : [%v: unit]) in
  (true : [%v: bool])

let size_bst_gen =
  let (d : [%over: int]) = (0 <= v : [%v: int]) in
  let (s : [%over: int]) = (d <= v : [%v: int]) in
  let (lo : [%over: int]) = (true : [%v: int]) in
  let (hi : [%over: int]) = (v == lo + d : [%v: int]) in
  (fun (u : [%forall: int]) ->
     implies (mem v u) (lo < u && u < hi) && sorted v && rng v d
    : [%v: int tree])


 (*constructors*)


let[@library] leaf = (rng v 0 : [%v: int tree])

 let[@library] node =
  let (root : [%over: int]) = (true : [%v: int]) in
  let (range1 : [%over: int]) = (v >= 0 : [%v: int]) in
  let (dummy : [%under: int tree]) =
    (fun (u : [%forall: int]) ->
       implies (mem v u) (root - range1 < u && u < root)
       && sorted v && rng v range1
      : [%v: int tree])
  in
  let (ranger : [%over: int]) = (v >= 0 : [%v: int]) in
  let (dummy : [%under: int tree]) =
    (fun (u : [%forall: int]) ->
       implies (mem v u) (root < u && u < root + ranger)
       && sorted v && rng v ranger
      : [%v: int tree])
  in
  (fun (u : [%forall: int]) ->
     implies (u == range1 + ranger) (rng v u)
     && implies (mem v u) (root - range1 < u && u < root + ranger)
     && sorted v
    : [%v: int tree])   