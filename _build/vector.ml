include List
let size = List.length
exception VectorExc of string 
(* A function from list to string *)
let toString (tStr : 'a -> string) (l : 'a list) : string=
	List.fold_left (fun acc x -> acc^(tStr x)) ":" l

let rec zip lst1 lst2 = match lst1,lst2 with
  | [],_ -> []
  | _, []-> []
  | (x::xs),(y::ys) -> (x,y) :: (zip xs ys);;


let ua a = match a with (a,b)->a;;
let ub a = match a with (a,b)->b;;  

let snd (x, y) = y
let (<<) f g x = f (g x)

type ('a, 'b) continue = 
  Continue of 'a
  | Done of 'b 


let sub (v, i) = List.nth v i

let  tabulate (i, f) = Array.to_list (Array.init i f) 


let dropPrefix (v, n) = tabulate (length v - n, fun i -> sub (v, i + n))

let dropSuffix (v, n) = tabulate (length v - n, fun i -> sub (v, i))


let mapAndFold (v, b, f) =
   let r = ref b in 
   let v = List.map(fun x ->
                   let (c, b) = f (x, !r) in 
                   let _ = r := b in 
                    c
                   ) v 
   in (v, !r)



let fold' (v, start, b, f, g) =
   let n = size v in 
    let rec loop (i, b) =
         if i >= n
            then g b
         else
            match f (i, sub (v, i), b) with
               Continue b -> loop (i + 1, b)
             | Done c -> c
   in
      if (0 <= start) && (start <= n)
         then loop (start, b)
      else raise (VectorExc "Vector.fold'")
   

(* let rec unzip list =
  match list with
    [] -> ([],[])
    | (a,b)::ns -> (a::ua(unzip(ns)),b::ub(unzip(ns)));;

 *)

let unzip ls = List.split ls


let new0 () = []


let new1 x = [x]

let new2 (x, y) = [x;y]

let peekMap (l, f) = 
   let rec loop l =
         match l with 
          [] -> None
          | x :: l ->
               (match f x with
                   None -> loop l
                 | Some y -> Some y)
   	in
      loop l
   

(* let rec loop_and_solve  (v, f, g) = 
		match v with 
		[] -> None
		| x :: xs -> match f x with  
						Some y ->  Some (y, xs)
						| None -> loop_and_solve f xs
 *)


let loopi (v, f, g) =
   fold' (v, 0, (),
          (fun (i, a, ()) -> (match f (i, a) with
                               None -> Continue ()
                             | Some b -> Done b)),
          g)
let loop (v, f, g) = loopi (v, (f << snd), g)



let toList a = fold_right :: a []

let  toListMap (a, f) = fold_right (fun a ac -> f a :: ac) [] a

let fromList ls = ls


let mapAndFold (v, b, f) =
   let r = ref b in 
    let v = List.map  (fun x ->
                   let (c, b) = f (x, !r) in 
                    let  _ = r := b
                   in c
                   ) v 
   in 
   (v, !r)
   
let map (v, f) = List.map f v 

let map2 (v1, v2, f) = List.map2 (fun e1 e2 -> f (e1,e2) ) v1 v2  

let map2AndFold (v, v', b, f) =
   let r = ref b in 
    let v = map2 (v, v', fun (x, x') ->
               let (y, b) = f (x, x', !r) in 
                let  _ = r := b in 
               y)
   in (v, !r)
   



let forall (v, f) = List.for_all f v

let forall2 (v1, v2, f) = List.for_all2 f v1 v2

(*f : (a,b) -> b *)
let fold (l, acc, f ) = 
  let f' a b = f (b,a) in 
   List.fold_left f' acc l

let foldl (l, acc, f) = List.fold_left f acc l

let foldr (l, acc, f) = List.fold_right f l acc

let mapi (a, f) = tabulate (length a, fun i -> f (i, sub (a, i)))


let isSome x = 
  match x with 
    | None -> false 
    | Some b -> true

let doit (f, mapi) =
      let n = ref 0 in 
      let b = mapi (fun x ->
                       let  b = f x in 
                        let _ = if isSome b then n := 1 + !n else ()
                       in b ) in 

                      
         let  r = ref 0 in 
         let rec loop (i: int) =
            match sub (b, i) with
               None -> loop (i + 1)
             | Some b -> (r := i + 1; b)
      in tabulate (!n, fun _ -> loop (!r))
      
   
 let keepAllMapi (a, f) = doit (f, fun f -> mapi (a, f))

let keepAllMap (v, f) = keepAllMapi (v, (f << snd))



let toListMap (a, f) = List.fold_right (fun a ac -> (f a :: ac)) a [] 
(*[1,2,3]*-> ([1,2], 3) *)
let split_last l  = 
  if List.length l = 0 then (failwith "split last applied on empty")
  else     
  let reversed = List.rev l in 
  let last = List.hd reversed in 
  let remaining = List.tl reversed in 
  let rev_remaining = List.rev remaining in 
  (rev_remaining, last)
  
exception Failure of string
let rec index v filtermap =
    let rec index_value lst f = 
      match lst with
        | [] -> -1
        | h :: t -> if (f h) = true then 0 else (1 + index_value t f) in 
    let value = index_value v filtermap in     
  if (value = -1) then None else (Some value)
 
 let prefix lst i = 
    let array_lst = Array.of_list lst in 
    let array_prefix = Array.sub array_lst 0 i in 
    Array.to_list array_prefix

let rec sublist b e l = 
    match l with
    [] -> failwith "sublist"
  | h :: t -> 
     let tail = if e=0 then [] else sublist (b-1) (e-1) t in
     if b>0 then tail else h :: tail


