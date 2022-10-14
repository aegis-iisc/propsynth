let rec bst_gen_v2 (lo : int) (hi : int) : int tree =
  if lo + 1 >= hi then Leaf
  else if bool_gen () then Leaf
  else
    let (lo1 : int) = lo + 1 in
    let (hi1 : int) = hi - 1 in
    let (x : int) = int_range lo1 hi1 in
    let (lt : int tree) = bst_gen_v2 lo x in
    let (rt : int tree) = bst_gen_v2 x hi in
    Node (x, lt, rt)