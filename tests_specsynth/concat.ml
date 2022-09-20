(* An implementation of Stack using List *)
type 'a t = 'a list  

exception Empty

let empty = []

let is_empty = function [] -> true | _ -> false


let rec contains x s =  
    List.exists (fun y -> y == x) s


let push  = List.cons

let top = 
    function [] -> raise Empty 
            | x :: s -> x 

let tail = function [] -> raise Empty 
            | _ :: s -> s

let size = List.length


let rec concat s1 s2 = 
    if is_empty s1 then s2
    else push (top s1) (concat (tail s1) s2)


(*client*)
let rec reverse (s : 'a t ) =
    match l with
    [] -> []
    | (h :: t) -> concat (reverse t, [h])
