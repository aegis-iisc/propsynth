len : ref int;

type pngpair = Pair of int * [char];
type pngtriple = Triple of {len : int; ts : [char] ; data : [char]}; 

createTriple  :  (x : { v : int | true}) ->  
				 (y : { v : [char] | true}) -> 
				 (z : {v : [char] | true}) -> 
				 	{v : pngtriple | length (z) + length (y) == x}; 	

getFuel : (u :{ v : unit | true})  -> 
				State {\(h : heap).true} 
				v : { v : int | true} 
				{\(h: heap),(v : int),(h': heap).
					sel (h', len) == sel (h, len) /\
					sel (h', len) == v};


putFuel : (x : { v : int | true})-> 
			State {\(h : heap).
				true} 
				v : { v : unit | true} 
				{\(h: heap),(v : unit),(h': heap).
					sel (h', len) == x};

intValOf : (x : { v : [char] | true})-> 
            State {\(h : heap).
				true} 
				v : { v : int | true} 
				{\(h: heap),(v : int),(h': heap).
					sel (h', len) == sel (h, len) /\
                    v = intval (x)
                    };

fail : State {\(h : heap).true} 
				v : { v : unit | true} 
				{\(h: heap),(v : unit),(h': heap).
					sel (h', len) == sel (h, len) /\
                    false
                    };


many_natural : (n : {v : int | true} -> 
                State {\(h : heap).true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					sel (h', len) == sel (h, len) /\
					asciinumberlist(v) = true };


many_n_natural : (n : {v : int | true} -> 
                State {\(h : heap).true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					sel (h', len) == sel (h, len) /\
					asciinumberlist(v) = true /\
                    len (v) == n };


(*query1* *)
length : State {\(h : heap).
				sel (h, len) = 0} 
				v : { v : pngpair | true} 
			  	{\(h: heap),(v : pngpair),(h': heap).
					\(CP : [char]),(I : int).
					
                    (ppsnd (v) = CP => 
                    (
                     asciinumberlist (CP) = true /\   
                     ppfst (v) = intval(cp) /\ 
				     sel (h', len) == ppfst (v) ) \/ (false)
                     };
	  
(*similar query for content and ts? *)	