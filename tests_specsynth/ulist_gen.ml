unique list

let list_gen =
  let (s : [%over: int]) = (v >= 0 : [%v: int]) in
  let (x : [%over: int]) = (true : [%v: int]) in
  (len v s && fun (u : [%forall: int]) -> implies (mem v u) (u == x)
    : [%v: int list])

list_gen : (s : { v : int | [v>0] || [v=0]} -> (x0 : int) -> {v : int | slen (v) = s /\  }
let rec list_gen (size : int) (x : int) : int list =
  let (b : bool) = size == 0 in
  if b then []
  else
    let (size2 : int) = size - 1 in
    let (l : int list) = list_gen size2 x in
    let (l2 : int list) = x :: l in
    l2