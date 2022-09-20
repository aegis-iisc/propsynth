fuel : ref int;
long : ref bool;
Len : int;
Tys : quad;
Con : [char];

hasTypeSpec : State {\(h:heap). true}
                v : { v : bool | true} 
				{\(h: heap),(v : bool),(h': heap).
                    sel (h', fuel) == sel (h, fuel) /\   
					([v=true] <=>  bsel (h', long) = true) /\
                    ([v=false] <=>  bsel (h', long) = false)};



createTriple  :  (x : { v : int | true}) ->  
				 (y : { v : quad | true}) -> 
				 (z : {v : [char] | true}) -> 
				 	{v : pngtriple | length (z) + 4 == x}; 	

getFuel : (u :{ v : unit | true})  -> 
				State {\(h : heap).true} 
				v : { v : int | true} 
				{\(h: heap),(v : int),(h': heap).
					sel (h', fuel) == sel (h, fuel) /\
					sel (h', fuel) == v};


putFuel : (x : { v : int | true})-> 
			State {\(h : heap).
				true} 
				v : { v : unit | true} 
				{\(h: heap),(v : unit),(h': heap).
					sel (h', fuel) == x};


natural : State {\(h : heap).
				true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					sel (h', fuel) == sel (h, fuel) /\
					asciinumber (v) = true};



uppercase  : State {\(h : heap).
				true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					\(e : char), (cc : int).
					sel (h', fuel) == sel (h, fuel) /\
					asciiupper (cc) = true};


alphanum : State {\(h : heap).
				true} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					\(e : char), (cc : int).
					sel (h', fuel) == sel (h, fuel) /\
					asciialphanum (cc) = true};

length : State {\(h : heap).
				sel (h, fuel) == 0} 
				v : { v : int | true} 
			  	{\(h: heap),(v : int),(h': heap).
					sel (h', fuel) == v /\
                    [v > 4] };




content : State {\(h : heap).
				sel (h, fuel) > 0} 
				v : { v : [char] | true} 
			  	{\(h: heap),(v : [char]),(h': heap).
					sel (h', fuel) == sel (h, fuel) -- length (v)
					/\ sel (h', fuel) == 0};



typespecFix : State {\(h : heap).
				sel (h, fuel) > 4 /\ 
                bsel (h, long) = false} 
				v : { v : quad | true} 
			  	{\(h: heap),(v : quad),(h': heap).
					sel (h',fuel) == sel (h, fuel) -- 4};


typespecVar : State {\(h : heap).
				sel (h, fuel) > 4 /\ bsel (h, long) = true} 
				v : { v : quad | true} 
			  	{\(h: heap),(v : quad),(h': heap).
					sel (h',fuel) == sel (h, fuel) -- quadlength (v)};



goal : (x : { v : unit | true}) -> State {\(h : heap).
				sel (h, fuel) == 0} 
				v : { v : pngtriple | true}
				{\(h: heap),(v : pngtriple),(h': heap).
				 \(Len : int), (Tys:quad), (Con:[char]).
				  (pnglen (v) = Len /\
				  pngts (v) = Tys /\
				  pngdata (v) = Con) => 	
                            (
					  		sel (h', fuel) == 0 /\
				  			(   Len == length (Con) + 4 \/ 
                                Len == length (Con) + quadlength (Tys)
                            )
						  )};