(* vector with a dummy element, size and actual list of elements*)
type 'a t = 'a * int * 'a list 


let rec create_aux (n :int) (dummy : 'a) (acc : 'a list) : ('a list) = 
    if (n == 0) then 
        acc
    else 
        create_aux (n-1) dummy (dummy :: acc) 



(* create : (capacity : { v : int | ( [v > 0] \/ [v=0]) /\ not [Max > v]}) -> 
         (dummy : a) ->  v : 'a t | vlen (V') == 0 /\ mem (v) = {dummy}}
*)


let create : type a. ?capacity: (int) -> a -> (a t) =
  fun ?capacity:capacity dummy -> 
        let capacity1 =
            match capacity with
                | None -> 0 
                | Some c -> c 
        in 
        let dlist = create_aux capacity1 dummy [] in 
        (dummy,0,dlist)



(* make :
        (dummy : a) ->   
        (n : { v : int | ( [v > 0] \/ [v=0]) /\ not [Max > v]}) -> 
        (x : a) -> 
        {v : 'a t | vlen (V') == 0 /\ 
            mem (v) = {(dummy)} U {(x)}}
*)


let make : type a. ?dummy: (a) -> int -> a -> (a t) =
   fun ?dummy:dummy n x -> 
        let dummy1 =
            match dummy with
                | None -> x 
                | Some d -> d 
        in 
        let dlist = create_aux n x [] in 
        (dummy1,n,dlist)

(* requires higher-order function
let init : type a. dummy:a -> (int) -> ((int) -> a) ->  (a t) =
  fun ~dummy:dummy n f -> let a = make  n dummy in
                          (let o = n - 1 in let o1 = 0 in
                           for i = o1 to o do (a.data).(i) <- f i done);
                          a *)





let unsafe_resize : type a. (a t) -> (int) ->  unit =
  fun a n -> let n_old = Array.length a.data in
             if n <= a.size
             then
               if n < n_old / 4
               then a.data <- Array.sub a.data (0 ) n
               else Array.fill a.data n (a.size - n) a.dummy
             else
               begin
                 if n > n_old
                 then begin
                   let n_div2 = n / 2 in
                   let n' =
                     if n_div2 >= n_old
                     then
                       if Sys.max_array_length  / 2 >= n_div2
                       then n
                       else Sys.max_array_length 
                     else
                       begin
                         if Sys.max_array_length  / 2 >= n_old
                         then 2 * n_old
                         else Sys.max_array_length  end in
                   let a' = Array.make n' a.dummy in
                   Array.blit a.data (0 ) a' (0 ) a.size; a.data <- a' end end;
             a.size <- n



(* resize : (vec : ref vec) -> 
         (n : { v : int | ([v > 0] \/ [v=0]) /\ not [Max > v]}) -> 
         (x : a) ->       
         State {\(h : heap).\(V : vec). 
                        vdom (h, vec) = true /\
                        (vsel (h, vec) = V => not (n > vlen (V)))
                        } 
			 v : { v : unit | true}    
             {\(h : heap), (v : unit), (h' : heap). 
			\(V : vec), (V' : vec).
	                vsel (h, vec) = V /\    
                    vsel (h', vec) = V' /\ 
                    vlen (V) > vlen (V') /\
                    vlen (V') = n 
                    }; *)




let resize : type a. (a t) -> (int) ->  unit =
  fun a n -> 
        if not (0  <= n && n <= Sys.max_array_length )
             then raise (Invalid_argument "resize");
        unsafe_resize a n



let clear : type a. (a t) ->  unit = fun a -> unsafe_resize a (0 )

val is_empty: 'a t -> bool
(** Return [true] if the given vector is empty, [false] otherwise. *)
(*@ r = is_empty a
      ensures r <-> Seq.length a.view = 0 *)

let is_empty : type a. (a t) ->  (bool) = fun a -> length a = 0 


