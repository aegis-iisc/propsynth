

int_gen : unit -> {v : int | [v > 0] \/ [v=0]};
list_gen : (s : {v : int | [v > 0] \/ [v=0]}) -> {v : list | slen (v) == s};
subs : (n1 : int) -> (n2 : int) -> {v : int | v = n1 -- n2};
nil : {v : list | len (v) == 0};
cons : (x : int) -> (xs : list) -> {v : list | slen(v) == slen (xs) + 1}; 

let rec list_gen (size : int) : int list =
  let (b : bool) = size == 0 in
  if b then []
  else
    let (size2 : int) = size - 1 in
    let (l : int list) = list_gen size2 in
    let (x : int) = int_gen () in
    let (l2 : int list) = x :: l in
    l2
