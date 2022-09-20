type triple = { pnglen : int ; ts : [char]; data : [char]}
let len = ref 0;
type pair = Pair of (int * [char])
len : ref int;

predicate asciidigit : int :-> bool 
predicate asciiupper : int :-> bool
predicate asciialphanum : ing :-> bool 
predicate charcode : char :-> int 
predicate pnglen : triple :-> int 
predicate ts : triple :-> [char]
predicate data : triple :-> [char]



getFuel : (u :{ v : unit | true})  -> 
				State {\(h : heap).true} 
				v : { v : int | true} 
				{\(h: heap),(v : int),(h': heap).
					sel (h', len) = sel (h, len) /\
					sel (h', len) = v};


putFuel : (x : { v : int | true})-> 
			State {\(h : heap).
				true} 
				v : { v : unit | true} 
				{\(h: heap),(v : unit),(h': heap).
					sel (h', len) = x};


natural : State {\(h : heap).
				true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : unit),(h': heap).
					\(e : char), (cc : int).
					sel (h', len) = sel (h, len) /\
					cmem (v, e) = true => 
						(charcode (e) = cc => 
						 asciidigit (cc) = true)};



uppercase  : State {\(h : heap).
				true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : unit),(h': heap).
					\(e : char), (cc : int).
					sel (h', len) = sel (h, len) /\
					cmem (v, e) = true => 
						(charcode (e) = cc => 
						 asciiupper (cc) = true)};


alphanum : State {\(h : heap).
				true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : unit),(h': heap).
					\(e : char), (cc : int).
					sel (h', len) = sel (h, len) /\
					cmem (v, e) = true => 
						(charcode (e) = cc => 
						 asciialphanum (cc) = true)};

length : State {\(h : heap).
				sel (h, len) = 0} 
				v : { v : pair | true} 
			  	{\(h: heap),(v : pair),(h': heap).
					\(cp : [char]),(i : int).
					(snd (v) = cp => fst (v) = intval(cp)) /\ 
					sel (h', len) = fst (v)};



typespec : State {\(h : heap).
				sel (h, len) > 4} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					sel (h', len) == sel (h, len) - 4
					/\ sel (h', len) > 0};



content : State {\(h : heap).
				sel (h, len) > 0} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					sel (h', len) == sel (h, len) - length (v)
					/\ sel (h', len) = 0};



goal : State {\(h : heap).
				sel (h, len) = 0} 
				v : { v : triple | true}
				{\(h: heap),(v : [char]),(h': heap).
				 sel (h', len) = 0 /\
				 \(x : int), (y:[char]), (z:[char]).
				  (pnglen (v) = x /\
				  ts (v) = y/\
				  data (v) = z) => length (y) + length (z) = length (x)};

