(*A priority Map Interface cf.*)
type 'k 'v pair = ('k * 'v) 
type 'k 'v pm = ('k * 'v) list

relation keys (pm) [] = {()} 
		 keys (x :: xs) {(x)} U keys (xs); 


prio : value : 'v -> priority
(*creates an empty k value priority map*)

empty : {true} v : 'k 'v pm {??}
is_empty : pm -> {v : bool | [v = true] => keys (pm) = {()};

insert : key : 'k -> val : 'v -> 
		{ \(h : heap).  
				not (mapped key pMap)} 
					v : unit 
		{\(h: heap), (v : unit), (h' : heap).
				mapped key pMap 
				/\ length (sel (h', pMap)) = length (sel (h, pMap)) + 1 
				/\ keys (sel (h', pMap)) = keys (sel (h, pMap)) U {(k)}};


decr :  key : 'k -> val : 'v -> 
		{ \(h : heap).  (mapped key pMap) /\ sel (h, pMap) = pm 
						/\ value (pm, key) > val} 
					v : unit 
		{\(h: heap), (v : unit), (h' : heap).
				mapped key pMap 
				/\ length (sel (h', pMap)) = length (sel (h, pMap)) 
				/\ keys (sel (h', pMap)) = keys (sel (h, pMap))
				/\ value (sel (h', pMap), key) = v};

remove : key : 'k -> 
		{ \(h : heap).  (mapped key pMap)} 
					v : unit 
		{\(h: heap), (v : unit), (h' : heap).
				not (mapped key pMap) 
				/\ length (sel (h', pMap)) = length (sel (h, pMap)) -- 1 
				/\ keys (sel (h', pMap)) = keys (sel (h, pMap)) - {(key)}};


lookup : key : 'k -> 
		{ \(h : heap).  true} 
					v : 'v 
		{\(h: heap), (v : 'v), (h' : heap).
				v = value  (sel (h, pMap), key)};
				
pop_min : { \(h : heap).  sel (h, pMap) = pm /\ not (empty pm)} 
					v :  'k 'v pair 
		{\(h: heap), (v : 'k 'v pair), (h' : heap).
				not (mapped (first (v)) pMap) 
				/\ length (sel (h', pMap)) = length (sel (h, pMap)) -- 1 
				/\ keys (sel (h', pMap)) = keys (sel (h, pMap)) - {(first (v))}};
		