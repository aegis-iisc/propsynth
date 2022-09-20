(*How do we handle polymorohism*)
type tbl = ref (int list)
predicate mem h tbl s = sel (h, tbl) = t /\ ({(s)} C= elems (t)) 

create : tref : tbl -> 
			{\(h : heap). not (dom h t)} 
				v : tbl 
			{\(h: heap), (v : tbl), (h' : heap). [v = tref] /\ sel (h', tref) = t /\ elems (t) = {()}}; 

mem : t : tbl -> s : string -> 
				{\(h : heap).true} 
					v : bool 
				{\(h: heap), (v : bool), (h' : heap). mem h' t s }; 

add : t:tbl -> s:string -> 
					{\(h : heap). not (mem h t s)}	
					{v:unit}
					{\(h: heap), (v : unit), (h' : heap). mem h' t s};

fresh_str : t:tbl ->
				{\(h : heap).true} 
				{v:string}
				{\(h: heap), (v : string), (h' : heap). not (mem h' t s)};

head : (l : int list) -> {v : int | hd (l) = v} 


tail : (l : int list) -> {v : int list | len (v) = len (l) -- 1 /\ elems (v) C= elems (l)}



(*TODO :: Rethink about this example*)
goal : tref : tbl -> 
		l : string list -> 
			{\(h : heap). empty h} 
			v : unit 
	   		{\(h: heap), (v : unit), (h' : heap). not (empty h) /\ sel (h', tref) = t 
	   			/\ elems (t) == elems (l) 
	   			/\ (len (t) = len (l)) };


let goal tref l  = 
	t <- create tref;
    fold (fun )

	   x <- head l;
		if (mem tref x) then 
			s <- fresh_str;
			add t s
		else 
			add t s
			 	 	
	}
	
}
