len : ref int;


createTriple  :  (x : { v : int | true}) ->  
				 (y : { v : [char] | true}) -> 
				 (z : {v : [char] | true}) -> 
				 	{v : triple | length (z) + length (y) == x}; 	

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

fail :  State {\(h : heap).
				true} 
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
					asciichar(v) = true };


many_n_alphanum : State {\(h : heap).
				true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					sel (h', len) = sel (h, len) /\
					cmem (v, e) = true => 
						(charcode (e) = cc => 
						 asciialphanum (cc) = true)};



many_n_natural : (n : {v : int | true} -> 
                State {\(h : heap).true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					sel (h', len) == sel (h, len) /\
					asciichar(v) = true /\
                    len (v) == n };



goal1 : State {\(h : heap).
				sel (h, len) == 0} 
				v : { v : pair | true} 
			  	{\(h: heap),(v : pair),(h': heap).
					\(CP : [char]),(I : int).
					
                    snd (v) = CP => 
                    (
                     (asciichar (CP) = true /\   
                     fst (v) = intval(cp) /\ 
				     sel (h', len) == fst (v) /\
                     fst (v) > 4) 
                     \/ false
                    )
                     };
	  
	
	goal1 = 
		
		
		[[  
            x <- many_natural;
			let x_int = intValOf (x) in 
			if (x_int > 4) then 
				putFuel x_int;
				return (x_int, x)
			else 
				fail
		 
		]]	


goal2 : n : int ->  State {\(h : heap).
				sel (h, len) = 0} 
				v : { v : pair | true} 
			  	{\(h: heap),(v : pair),(h': heap).
					\(CP : [char]),(I : int).
					
                    snd (v) = CP => 
                    (
                     (asciichar (CP) = true /\   
                     len (CP) == n /\
                     fst (v) = intval(cp) /\ 
				     sel (h', len) == fst (v) /\
                     fst (v) > 4
                     ) 
                     \/ false
                    )
                };  
	 

     	goal2 = 
		
		
		[[  
            x <- many_n_natural n;
			let x_int = intValOf (x) in 
			if (x_int > 4) then 
				putFuel x_int;
				return (x_int, x)
			else 
				fail
		 
		]]	



content : (n : int) ->  State {\(h : heap). true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					length (v) = sel (h, len) /\
				    sel (h', len) == 0};
