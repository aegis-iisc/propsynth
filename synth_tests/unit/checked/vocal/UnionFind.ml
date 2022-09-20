(*Disjoint set forests implementation *)
type 'a content =
  | Link of (('a content) ref)
  | Root of (int) * 'a

(* Disjoint set lists
type 'a content = {rep : ('a content)ref;
                   next : ('a content) ref;
                   image : 'a}

type 'a set = {head : ('a content) ref; 
                tail : ('a content) ref}                    *)

type 'a elem = ('a content) ref



let make : type a. a ->  ((a content) ref) = fun v -> (ref (Root (0 , v)))

let make : type a. a -> ((a content) ref) = fun v -> 
                      

let rec find : type a. ((a content) ref) ->  ((a content) ref) =
  fun x -> match (!x) with
    | Root (_, _) -> x
    | Link y -> (let rx = find y in (x := (Link rx)); rx)


(* A function specialization 
let rec find : type a. ((a content) ref) ->  ((a content) ref) =
  fun x -> match (!x) with
    | Root (_, _) -> x
    | Link y -> (let rx = find y in rx) *)



let eq : type a. ((a content) ref) -> ((a content) ref) ->  (bool) =
  fun x y -> let a = find x in let b = find y in (a == b)

let get : type a. ((a content) ref) ->  a =
  fun x -> let xv = find x in
           match (!xv) with
           | Root (_, v) -> v
           | Link _ -> assert false (* absurd *)

let set : type a. ((a content) ref) -> a ->  unit =
  fun x v -> let rx = find x in
             match (!rx) with
             | Root (r, _) -> (rx := (Root (r, v)))
             | Link _ -> assert false (* absurd *)

let link : type a. ((a content) ref) -> ((a content) ref) ->  unit =
  fun x y -> if (x == y)
             then ()
             else
               begin match ((!x), (!y)) with
               | (Root (rx,
                 vx),
                 Root (ry,
                 _)) ->
                 if rx < ry
                 then (x := (Link y))
                 else
                   begin
                     (y := (Link x));
                     if rx = ry then (x := (Root (rx + 1, vx)))
                   end
               | (_, _) -> assert false (* absurd *)
               end

let union_aux : type a. ((a content) ref) -> ((a content) ref) ->  unit =
  fun x y -> let a = find x in let b = find y in link a b

let union : type a. ((a content) ref) -> ((a content) ref) ->  unit =
  fun x y -> union_aux x y



(*client *)
(*{not equiv a b} unit {img a <= img b <=> equiv a b}*)
a : int elem -> b : int elem -> 

let x_a = get a in 
let x_b = get b in 
if (x_a <= x_b) then 
  union a b 
else 
   ()  
(* 
 *)