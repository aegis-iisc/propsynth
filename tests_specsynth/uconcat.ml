(* An library implementatiom of stacks using  unique list *)
(* type 'a t = { v : 'a list | unique v} *)
type 'a t = 'a list  

exception Empty

(*Invariant *)
measure unique [] = true
               x :: xs = not smem (x, xs) /\ unique xs


(*empty : {v : 'a t | unique v}*)
let empty = []



(* is_empty :  
(s1 : {v : 'a t | unique v}) -> 
-> {v : bool | \(u:a). 
            ([v=true] => sempty (s) = true /\ smem (s, u) = false) }; *)

let is_empty = function [] -> true | _ -> false


let rec contains x s =  
    List.exists (fun y -> y == x) s

let push x s = 
        if (contains x s) then s
        else (x::s)

let top = 
    function [] -> raise Empty 
            | x :: s -> x 

let tail = function [] -> raise Empty 
            | _ :: s -> s

let size = List.length
(* we need to prove, that it takes two unique stack and returns another unique stack *)
(*
(s1 : {v : 'a t | unique v}) -> 
(s2 : {v : 'a t | unique v}) -> 

{v : 'a t | \(u : a).
            unique v /\
            (shd (v, u) = true => (shd (s1, u) = true \/ shd (s2, u) = true)) /\
            (smem (v, u) = true <=> (smem (s1, u) = true \/ smem (s2, u) = true))};

 *)
let rec concat s1 s2 = 
    if is_empty s1 then s2
    else
        let x = top s1 in 
        if (contains x s2) then
            concat (tail s1) s2
        else      
            push (top s1) (concat (tail s1) s2)
(* 
let () = 
    let s1 = [1;2;4] in 
    let s2 = [2;4;6] in 
    let s = concat s1 s2 in
    let string4s = List.fold_left (fun acc x -> acc^"::"^(string_of_int x) ) ""  s in 
    Printf.printf "%s" string4s
 *)
