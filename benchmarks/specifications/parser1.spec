(*Consider a parser for the grammar  
	
	png_chunk -> x : length . y : typespec . z : content {Triple (x, y, z)} 
    
    length -> Natural {Pair (int , char list)}
    typespec -> many 4 UpperCase 
    content -> many AlphaNum

	data-dependent constraints : 
		length (content) = length (length) - length (typespec)



	The outline of the synthesis problem: 
	let fuel = ref 0;


	The library : 

	getFuel : State {true} v : int {len' = len /\ v = plen}

	putFuel : x: Int -> State {true} v : unit {len' = x}


	Natural : State {true} (x,y)  v : char list {\forall e \in elems (v) . CharCode (v) \in (asciidigit)}

	UpperCase : State {true} v : char {CharCode (v) \in (asciiupper)}

	AlphaNum : State {true} v : char  {CharCode (v) \in (asciialphanum)}


	length : State {len = 0}  (x,y) : (int, char list) { len' = x /\ len' > 1 /\ IntValOf (y) = x}
	
	typespec : State  {len > 1} v : char list  { len' = plen - 4}

	content ::State {len > 0 } v : char list {length(v) = len /\ len' = 0}

	(*In this case we do NOT need to provide the grammar*)
	query : State {len = 0} 
				(x,y, z) : (int * char list * char list)
			{length (z) + length (y) = x  
					/\ len' = 0}		

	*)




