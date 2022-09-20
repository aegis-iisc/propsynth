(* Copyright (C) 2009 Matthew Fluet.
 * Copyright (C) 1999-2006 Henry Cejtin, Matthew Fluet, Suresh
 *    Jagannathan, and Stephen Weeks.
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

let detailed = ref false

let switch d n x =
   if !detailed then d x else n x 

type t = T of {length : int; tree : tree}

and tree = 
 	Empty
  | String of string
  | Sequence of t list
  | Align of {force: bool; rows: t list}
  | Indent of t * int


let length (T {length; _}) = length


let length_tree tr = 
  match tr with 
  Empty -> 0
  | String s -> 1
  | Sequence ( tlist) -> List.length tlist
  | Align {force; rows} -> 0 (*correct later*)
  | Indent (t, i) -> length t 


let empty = T {length = 0; tree = Empty}

let isEmpty x = 
	match x with 
	(T {length = 0; _}) ->true
  |  _ -> false

let str s =
   match s with
      "" -> empty
    | _ -> T {length = String.length s; tree = String s}

let fold (l, b, f) = List.fold_left f b l

let seq ts =
    let ts = Vector.rev ts in 
   let len = List.length ts in 
   match len with
      0 -> empty
    | _ -> T {length = len; tree = Sequence ts}
   
  
let make force ts =
      let rec loop ts =
            match ts with
               [] -> (ts, 0)
             | t :: ts ->
                  let (ts, n) = loop ts
                    in match  length t with
                     0 -> (ts, n)
                   | n' -> (t :: ts, n + n' + 1) in 
                  
         let (ts, len) = loop ts
      in match len with
         0 -> empty
       | _ -> T {length = len - 1; tree = Align {force = force; rows = ts}}
   
let  align = make true
let  mayAlign = make false


let indent (t, n) = T {length = length t; tree = Indent (t, n)}

let tabSize: int = 8
(* 
let blanks (n) =
   String.concat String.make (n div tabSize, #"\t")
           String.make (n mod tabSize, #" ")
 *)
let outputTree (t, out) =
   let print s = print_string s in 
      let rec loop (T {tree; length}) =
         (print "(length "
          ; print (string_of_int length)
          ; print ")"
          ; (match tree with
                Empty -> print "Empty"
              | String s -> (print "(String "; print s; print ")")
              | Sequence ts -> loops ("Sequence", ts)
              | Align {rows;_} -> loops ("Align", rows)
              | Indent (t, n) -> (print "(Indent "
                                  ; print (string_of_int  n)
                                  ; print " "
                                  ; loop t
                                  ; print ")")))
      and loops (s, ts) = (print "("
                           ; print s
                           ; List.iter (fun t -> (print " " ; loop t)) ts 
                           ; print ")")
   in loop t
   
let toString t =
       let rec loop   accum (T {tree; _}) =
         match tree with
            Empty -> accum
          | String s -> s :: accum
          | Sequence ts -> List.fold_left (loop) (accum) ts 
          | Align {rows; _} ->
               (match rows with
                   [] -> accum
                 | t :: ts ->
                      let cur = loop accum t in 
                      List.fold_left (fun ac t  ->
                            loop (" " :: ac) t) cur ts  )
          | Indent (t, _) -> loop accum t 
   in
      String.concat " " (loop [] t)


   
let vector v = 
  T {length = 0; tree = Sequence v}
    

let separateLeft (ts, s) =
   match ts with
      [] -> []
    | [_] -> ts
    | t :: ts -> t :: (List.map (fun t -> seq [str s; t]) ts)
(* 
fun separateRight (ts, s) =
   rev (let val ts = rev ts
        in case ts of
           [] => []
         | [_] => ts
         | t :: ts => t :: (map (fn t => seq [t, str s]) ts)
        end) *)
