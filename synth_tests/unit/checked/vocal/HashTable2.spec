
type key;
type table;
qualifier hdom : heap :-> ref table :-> bool;
qualifier hsel : heap :-> ref table :-> table;
qualifier hmem : table :-> key :-> bool;
qualifier hsize : table :-> int;  
qualifier hvmem : table :-> a :-> bool;
qualifier hlen : [a] :-> int;

create : (n : int) -> 
         State {\(h : heap). true} 
			v : ref table 
		{ \(h : heap), (v : ref table), (h' : heap). 
				\(H' : table).
			      hdom (h', v) = true /\
                  hsel (h', v) = H' /\
                  hsize (H') = 0};


clear : (ht : ref table) -> 
         State {\(h : heap). hdom (h, ht) = true} 
			v : {v : unit | true} 
		{ \(h : heap), (v : unit), (h' : heap). 
				\(H' : table), (H : table).
			      hdom (h', ht) = true /\
                  hsel (h', ht) = H' /\
                  hsize (H') = 0};



reset : (ht : ref table) -> 
         State {\(h : heap). hdom (h, ht) = true} 
			v : {v : unit | true} 
		{ \(h : heap), (v : unit), (h' : heap). 
				\(H' : table), (H : table).
			      hdom (h', ht) = true /\
                  hsel (h', ht) = H' /\
                  hsize (H') = 0};



copy : (ht1 : ref table) -> 
            State {\(h : heap).
                \(H1: table). 
                        dom (h, ht1) = true
                 } 
			     v : { v : ref table | true} 
                {\(h : heap), (v : ref table), (h' : heap). 
				 \(H1: table), (HN : table). 
                    dom (h', v) = true /\
                    hsel (h, ht1) = H1 /\ 
                    hsel (h', v) = HN /\
                    hsel (h', ht1) = hsel (h, ht1) /\
                    keyset (HN) = keyset (H1) /\
                    hsize (HN) = hsize  (H1) 
                };



population: (ht1 : ref table) -> 
            State {\(h : heap).
                \(H1: table). 
                        dom (h, ht1) = true
                 } 
			     v : { v : int | true} 
                {\(h : heap), (v : int ), (h' : heap). 
				 \(H1: table). 
                    hsel (h, ht1) = H1 /\ 
                    hsel (h', ht1) = hsel (h, ht1) /\
                    v = hsize (H1)
                };

length : (ht1 : ref table) -> 
            State {\(h : heap).
                \(H1: table). 
                        dom (h, ht1) = true
                 } 
			     v : { v : int | true} 
                {\(h : heap), (v : int ), (h' : heap). 
				 \(H1: table). 
                    hsel (h, ht1) = H1 /\ 
                    hsel (h', ht1) = hsel (h, ht1) /\
                    v = hsize (H1)
                };


iter: (k : key) -> 
     (f : (val : a) -> unit) -> 
     (ht : ref table) -> 
     unit;

fold: (f : (k : key) -> (v : a) -> (i: b) -> b) -> 
        (ht : ref table) -> 
        (init : b) -> 
        {res : b | true};



add :  (ht : ref table)  -> 
       (k : key) ->
       (val : a) -> 
       State {\(h : heap).
                        \(H : table).     
                        hdom (h, ht) = true /\
                        (hsel (h, ht) = H => hmem (H, k) = false)} 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit), (h' : heap). 
				 \(H : table), (H' : table). 
                    hsel (h, ht) = H /\ 
                    hsel (h', ht) = H' /\
                    hmem (H', k) = true /\
                    hvmem (H', val) = true /\
                    hsize (H') ==  hsize (H) + 1
                };



remove :  (ht : ref table)  -> 
       (k : key) ->
       State {\(h : heap).
                           \(H : table).
                  hdom (h, ht) = true /\
                  hsel (h, ht) = H /\
                  hmem (H,k) = true
                } 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit), (h' : heap). 
				 \(H: table), (H' : table). 
                    hsel (h, ht) = H /\ 
                    hsel (h', ht) = H' /\
                    hmem (H', k) = false /\
                    hsize (H') ==  hsize (H) -- 1
                };


find: (ht : ref table)  -> 
       (k : key) ->
       State {\(h : heap).
                  hdom (h, ht) = true 
                 } 
			     v : { v : [a]| true} 
                {\(h : heap), (v : [a]), (h' : heap). 
				 \(H: table), (H' : table). 
                    hsel (h, ht) = H/\ 
                    hsel (h', ht) = H' /\
                    [H' = H] /\
                    (hmem (H, k) = true 
                        => not (hlen (v) = 0))
                    /\
                    (hmem (H, k) = false => 
                    (hlen (v) = 0))
                    
                };

 mem: (ht : ref table)  -> 
       (k : key) ->
       State {\(h : heap).
                  hdom (h, ht) = true 
                 } 
			     v : { v : bool | true} 
                {\(h : heap), (v : bool), (h' : heap). 
				 \(H: table), (H' : table). 
                    hsel (h, ht) = H /\ 
                    hsel (h', ht) = H' /\
                    [H' = H] /\
                    ([v = true] <=> (hmem (H, k) = true)) /\
                     ([v = false]<=> (hmem (H, k) = false)) 
                    
                };

goal : (ht : ref table)  -> 
       (k : key) ->
       (val : a) ->  
        State {\(h : heap).
                    \(H : table).
                  hdom (h, ht) = true /\
                  hsel (h, ht) = H 
                 } 
			     v : { v : unit | true} 
                {\(h : heap), (v : unit), (h' : heap). 
				 \(H: table), (H' : table). 
                    hsel (h, ht) = H /\ 
                    hsel (h', ht) = H' /\
                    hvmem (H', val) = true /\
                    hmem (H', k) = true
                 
                };

