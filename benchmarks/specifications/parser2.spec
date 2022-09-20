(*This is another variant of the problem , where there are missing holes in the semantic actions of the subparsers
	and top-level, goal parser*)


(*Consider a parser for the grammar  
	
	png_chunk -> x : length . y : typespec . z : content {Triple (x, y, z)} 
    
    length -> Natural {Pair (int , char list)}
    typespec -> many  UpperCase 
    content -> many AlphaNum

	data-dependent constraints : 
		length (content) = length (length) - length (typespec)



	The outline of the synthesis problem: 
	


	let len = ref 0;


	The library : 

	getFuel : State {true} v : int {len' = len /\ v = len}

	putFuel : x: Int -> State {true} v : unit {len' = x}


	Natural : State {true} (x,y)  v : char list {\forall e \in elems (v) . CharCode (v) \in (asciidigit)}

	UpperCase : State {true} v : char {CharCode (v) \in (asciiupper)}

	AlphaNum : State {true} v : char  {CharCode (v) \in (asciialphanum)}


	IntValOf : ...

	CharCode : ...


	Many n p  : 

	length : State {len = 0}  
		(x,y) : (int, char list) 
		{len' = x /\ len' > 1 /\ IntValOf (y) = x}
	length = 
		x <- Natural;
		[??]

		(*this can be seen as a small query*)
		query_1 : (x : char list | \forall e \in elems (v) . CharCode (v) \in (asciidigit)} -> 
		 State {len = 0}  
		(x,y) : (int, char list) 
		{len' = x /\ len' > 1 /\ IntValOf (y) = x}

		[[  
			let x_int = IntValOf (x) in 
			if (x_int > 1) then 
				putFuel x_int;
				return (x_int, x)
			else 
				fail
		 
		]]	
	
	typespec : State  {len > 1} v : char list  { len' = len - length (v) 
													/\ length (v) = 4 /\ len' > 0}
	typespec = 
		x <- Many 4 Uppercase
		[[ 	
			let x_len = List.length (x) in 
			if (x_len = 4) then 


			else 
				 
			len' = len -  }


		]]
	content ::State {len > 0 } v : char list {length(v) = len /\ len' = 0}

	(*In this case we do NOT need to provide the grammar*)
	query : State {len = 0} 
				(x,y, z) : (int * char list * char list)
			{length (z) + length (y) = x  
					/\ len' = 0}		

	*)




