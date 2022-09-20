(*similar queries as the Queue and hashtable example*)

sig
  module Elt :
    sig
      type 'a t = 'a Bag.Elt.t
      val equal : 'a t -> 'a t -> bool
      val sexp_of_t :
        ('a -> Std_internal.Sexp.t) -> 'a t -> Std_internal.Sexp.t
      val value : 'a t -> 'a
    end
  type 'a t = 'a Bag.t
  val mem : ?equal:('a -> 'a -> bool) -> 'a t -> 'a -> bool
  val length : 'a t -> int
  val is_empty : 'a t -> bool
  val iter : 'a t -> f:('a -> unit) -> unit
  val fold : 'a t -> init:'accum -> f:('accum -> 'a -> 'accum) -> 'accum
  val exists : 'a t -> f:('a -> bool) -> bool
  val for_all : 'a t -> f:('a -> bool) -> bool
  val count : 'a t -> f:('a -> bool) -> int
  val find : 'a t -> f:('a -> bool) -> 'a option
  val find_map : 'a t -> f:('a -> 'b option) -> 'b option
  val to_list : 'a t -> 'a list
  val to_array : 'a t -> 'a array
  val invariant : 'a t -> unit
  val create : unit -> 'a t
  val add : 'a t -> 'a -> 'a Elt.t
  val remove : 'a t -> 'a Elt.t -> unit
  val choose : 'a t -> 'a Elt.t option
  val remove_one : 'a t -> 'a option
  val clear : 'a t -> unit
  val fold_elt : 'a t -> init:'b -> f:('b -> 'a Elt.t -> 'b) -> 'b
  val iter_elt : 'a t -> f:('a Elt.t -> unit) -> unit
  val find_elt : 'a t -> f:('a -> bool) -> 'a Elt.t option
  val until_empty : 'a t -> ('a -> unit) -> unit
  val transfer : src:'a t -> dst:'a t -> unit
  val of_list : 'a list -> 'a t
  val unchecked_iter : 'a t -> f:('a -> unit) -> unit
  val sexp_of_t : ('a -> Sexplib.Sexp.t) -> 'a t -> Sexplib.Sexp.t
end