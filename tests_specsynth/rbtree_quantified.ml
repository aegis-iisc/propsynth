let[@library] int_gen =
  let (dummy : [%over: unit]) = (true : [%v: unit]) in
  (true : [%v: int])

let[@library] bool_gen =
  let (dummy : [%over: unit]) = (true : [%v: unit]) in
  (true : [%v: bool])




let[@library] eq =
  let (a : [%over: int]) = (true : [%v: int]) in
  let (b : [%over: int]) = (true : [%v: int]) in
  (iff v (a == b) : [%v: bool])

let[@library] neq =
  let (a : [%over: int]) = (true : [%v: int]) in
  let (b : [%over: int]) = (true : [%v: int]) in
  (iff v (a != b) : [%v: bool])

let[@library] lt =
  let (a : [%over: int]) = (true : [%v: int]) in
  let (b : [%over: int]) = (true : [%v: int]) in
  (iff v (a < b) : [%v: bool])

let[@library] gt =
  let (a : [%over: int]) = (true : [%v: int]) in
  let (b : [%over: int]) = (true : [%v: int]) in
  (iff v (a > b) : [%v: bool])

let[@library] le =
  let (a : [%over: int]) = (true : [%v: int]) in
  let (b : [%over: int]) = (true : [%v: int]) in
  (iff v (a <= b) : [%v: bool])

let[@library] ge =
  let (a : [%over: int]) = (true : [%v: int]) in
  let (b : [%over: int]) = (true : [%v: int]) in
  (iff v (a >= b) : [%v: bool])

let[@library] plus =
  let (a : [%over: int]) = (true : [%v: int]) in
  let (b : [%over: int]) = (true : [%v: int]) in
  (v == a + b : [%v: int])

let[@library] minus =
  let (a : [%over: int]) = (true : [%v: int]) in
  let (b : [%over: int]) = (true : [%v: int]) in
  (v == a - b : [%v: int])

let[@library] tt = (true : [%v: unit])
let[@library] nil = (len v 0 : [%v: int list])

let[@library] cons =
  let (dummy : [%under: int]) = (true : [%v: int]) in
  let (s : [%over: int]) = (v >= 0 : [%v: int]) in
  let (dummy : [%under: int list]) = (len v s : [%v: int list]) in
  (fun (u : [%forall: int]) -> implies (u == s + 1) (len v u) : [%v: int list])

let[@library] batchedq =
  let (s1 : [%over: int]) = (v >= 0 : [%v: int]) in
  let (dummy : [%under: int list]) = (len v s1 : [%v: int list]) in
  let (s2 : [%over: int]) = (v >= 0 : [%v: int]) in
  let (dummy : [%under: int list]) =
    (fun (u : [%forall: int]) -> implies (0 <= u && u <= s1) (len v u)
      : [%v: int list])
  in
  (len v s1 : [%v: int batchedq])

(* color black *)
let[@library] rbtleaf = (numblack v 0 && noredred v : [%v: int rbtree])

let[@library] rbtnode =
  let (c : [%over: bool]) = (not v : [%v: bool]) in
  let (sizel : [%over: int]) = (v >= 0 : [%v: int]) in
  let (dummy : [%under: int rbtree]) =
    (numblack v sizel && noredred v && implies (sizel == 0) (hdcolor v true)
      : [%v: int rbtree])
  in
  let (dummy : [%under: int]) = (true : [%v: int]) in
  let (sizer : [%over: int]) = (v == sizel : [%v: int]) in
  let (dummy : [%under: int rbtree]) =
    (numblack v sizer && noredred v && implies (sizer == 0) (hdcolor v true)
      : [%v: int rbtree])
  in
  (fun (u : [%forall: int]) ->
     hdcolor v false && implies (u == sizel + 1) (numblack v u && noredred v)
    : [%v: int rbtree])

(* color red *)
let[@library] rbtnode =
  let (c : [%over: bool]) = (v : [%v: bool]) in
  let (sizel : [%over: int]) = (v >= 0 : [%v: int]) in
  let (dummy : [%under: int rbtree]) =
    (numblack v sizel && noredred v && hdcolor v false : [%v: int rbtree])
  in
  let (dummy : [%under: int]) = (true : [%v: int]) in
  let (sizer : [%over: int]) = (v == sizel : [%v: int]) in
  let (dummy : [%under: int rbtree]) =
    (numblack v sizer && noredred v && hdcolor v false : [%v: int rbtree])
  in
  (hdcolor v true && numblack v sizel && noredred v : [%v: int rbtree])



let rbtree_gen =
  let (inv : [%over: int]) = (v >= 0 : [%v: int]) in
  let (c : [%over: bool]) = (true : [%v: bool]) in
  let (height : [%over: int]) =
    (v >= 0 && implies c (v + v == inv) && implies (not c) (v + v + 1 == inv)
      : [%v: int])
  in
  (* the height is the number of black nodes *)
  (numblack v height && noredred v
   && fun (u : [%forall: int]) ->
   (* parent is red; the hdcolor cannot be red *)
   (c && not (hdcolor v true))
   || (* parent is black; the hdcolor can be any color *)
   ((not c) && implies (height == 0) (hdcolor v true))
    : [%v: int rbtree])



    let rec rbtree_gen (inv : int) (color : bool) (height : int) : int rbtree =
      let (b : bool) = height == 0 in
      if b then
        if color then Rbtleaf
        else
          let (n1 : int) = int_gen () in
          let (lt1 : int rbtree) = Rbtleaf in
          let (rt1 : int rbtree) = Rbtleaf in
          let (res1 : int rbtree) = Rbtnode (true, lt1, n1, rt1) in
          res1
      else if color then
        let (height2 : int) = height - 1 in
        let (lt2 : int rbtree) = rbtree_gen (inv - 1) false height2 in
        let (rt2 : int rbtree) = rbtree_gen (inv - 1) false height2 in
        let (n2 : int) = int_gen () in
        let (res2 : int rbtree) = Rbtnode (false, lt2, n2, rt2) in
        res2
      else
        let (c : bool) = bool_gen () in
        if c then
          let (lt3 : int rbtree) = rbtree_gen (inv - 1) true height in
          let (rt3 : int rbtree) = rbtree_gen (inv - 1) true height in
          let (n3 : int) = int_gen () in
          let (res3 : int rbtree) = Rbtnode (true, lt3, n3, rt3) in
          res3
        else
          let (height4 : int) = height - 1 in
          let (lt4 : int rbtree) = rbtree_gen (inv - 2) false height4 in
          let (rt4 : int rbtree) = rbtree_gen (inv - 2) false height4 in
          let (n4 : int) = int_gen () in
          let (res4 : int rbtree) = Rbtnode (false, lt4, n4, rt4) in
          res4
       

