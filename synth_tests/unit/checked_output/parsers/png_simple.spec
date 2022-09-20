fuel : ref int;
Len : int;
Tys : quad;
Con : [char];



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



typespec : State {\(h : heap).
				sel (h, fuel) > 4} 
				v : { v : quad | true} 
			  	{\(h: heap),(v : quad),(h': heap).
					sel (h',fuel) == sel (h, fuel) -- 4};


goal : State {\(h : heap).
				sel (h, fuel) == 0} 
				v : { v : pngtriple | true}
				{\(h: heap),(v : pngtriple),(h': heap).
				 \(Len : int), (Tys:quad), (Con:[char]).
				  (pnglen (v) = Len /\
				  pngts (v) = Tys /\
				  pngdata (v) = Con) => 	
                            (
					  		sel (h', fuel) == 0 /\
				  			Len == (length (Con) + 4)
						  )};

\ ().
do locbound10 <- apply length  
( ---> do locbound22 <- apply typespec  
( ---> do locbound50 <- apply content  (

x <- createTriple (locbound10, locbound22, locbound50)
ret x 