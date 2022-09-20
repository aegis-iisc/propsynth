(* 
type 'a set
  | Link of (('a set) ref)
  | Root of (int) * 'a

type elem = (content) ref
ufdom : heap :-> Set  
ufelems : uf :-> a Set 
ufimage  : uf :-> a

*)


create : (u : unit) -> 
            State {\(h : heap). true} 
			v : elem 
		{ \(h : heap), (v : elem), (h' : heap). 
				\(V : vec), (V' : vec).
			      dom (h', v) = true /\
                  vsel (h', v) = U' /\
                  ufelems (U') = empty /\
                  ufdom (h)
        }       



make : (el : a) -> 
        State {\(h : heap). true} 
			v : elem 
		{\(h : heap), (v : elem), (h' : heap). 
				\(U' : uf).
			      dom (h', v) = true /\
                  vsel (h', v) = U' /\
                  ufelems (U') = {(el)} /\
                  ufdom (h)
        };
        
        elem
(*@ e = make [uf: 'a uf] v
      (* requires $ O(1) *)
      modifies uf
      ensures  not (mem e (old uf.dom))
      ensures  uf.dom = Set.add e (old uf.dom)
      ensures  uf.rep = (old uf.rep)[e -> e]
      ensures  uf.img = (old uf.img)[e -> v]
*)
