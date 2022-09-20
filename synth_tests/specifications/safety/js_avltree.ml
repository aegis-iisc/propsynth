(*This is a lowlevel avltree from the *)


type ('k, 'v) t = 
|	Empty
|	Node of ('k, 'v) t * 'k * 'v * int * ('k, 'v) t
|	Leaf of 'k * 'v

val empty : ('k, 'v) t
val invariant : ('k, 'v) t -> compare:('k -> 'k -> int) -> unit
check invariants, raise an exception if any invariants fail

val add : ?replace:bool ->
       ('k, 'v) t ->
       compare:('k -> 'k -> int) ->
       added:bool Pervasives.ref -> key:'k -> data:'v -> ('k, 'v) t
(*adds the specified key and data to the tree destructively 
(previous t's are no longer valid) using the specified comparison function. O(log(N)) time, O(1) space. The returned t is the new root node of the tree, and should be used on all further calls to any other function in this module. The bool ref, added, will be set to true if a new node is added to the tree, or false if an existing node is replaced (in the case that the key already exists). If replace (default true) is true then add will overwrite any existing mapping for key. 
If replace is false, and there is an existing mapping for key then add has no effect.*)
val first : ('k, 'v) t -> ('k * 'v) option
val last : ('k, 'v) t -> ('k * 'v) option
val find : ('k, 'v) t -> compare:('k -> 'k -> int) -> 'k -> 'v option
if the specified key exists in the tree, return the corresponding value. O(log(N)) time and O(1) space.
val mem : ('k, 'v) t -> compare:('k -> 'k -> int) -> 'k -> bool
return true if key is present in the tree, otherwise return false.
val remove : ('k, 'v) t ->
       removed:bool Pervasives.ref ->
       compare:('k -> 'k -> int) -> 'k -> ('k, 'v) t
remove key destructively from the tree if it exists, return the new root node. Previous root nodes are not usable anymore, do so at your peril. the removed ref will be set to true if a node was actually removed, or false otherwise.

(*delete key and associated value from the subtree at node *)
val removeNode : 
val fold : ('k, 'v) t -> init:'a -> f:(key:'k -> data:'v -> 'a -> 'a) -> 'a
fold over the tree
val iter : ('k, 'v) t -> f:(key:'k -> data:'v -> unit) -> unit
iterate over the tree


(*provide low level definitions*)
val balance : 


val rotatetR : 


val rotateL : 