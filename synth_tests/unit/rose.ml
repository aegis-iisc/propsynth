type rose  = Fork of (char  * rose list) 

let visited = ref [] 

let rec toString rtree = 
		match rtree with 
			| Fork (x, chs) -> ("\n Root : "^(Char.escaped x)^" \n \t Children [ "^
												(List.fold_left(fun accStr ti -> accStr^" \n |"^(toString ti)) " " chs)) 
(*val chop : 'a rose -> 'a rose option*)
(*rval chop : rtree : rose -> {\forall h. empty visited} v : rtree 
							  {\foralh h, v, h'. not (empty visited') 
												/\ unique visited' 
												/\ elems (visited') = elems (rtree) } *)
let rec chop rtree  = 
	
	let Fork (n, children) = rtree in 
	let v = (List.mem  n (!visited)) in 
	if (v) then 
		None 
	else 
		let () = visited := (n) :: (!visited) in 
		let accchildren = List.fold_left (fun accumulated rti ->  accumulated@[(chop rti)]) [] children in 
		let yeschildren = List.filter (fun rti -> match rti with 
											| None -> false 
											| Some _ -> true) accchildren in 
		let choppedChildren = List.map (fun ti -> let Some t = ti in 
											t
											) yeschildren in 

		Some (Fork (n, choppedChildren))

(*a recursive definition of list fold*) 
let accChildren ~f children acc = 
	 match children with 
	 	| [] -> acc 
	 	| x :: xs -> 
	 				 do{
	 				 	tx <- f x;
	 				 	acc <- acc@[tx];  
	 				 	accChildren f xs acc
	 				 	}


let rec choprec  rtree = 
	let Fork (n, children) = rtree in 
	let v = (List.mem  n (!visited)) in 
	if (v) then 
		None 
	else 
		do {
		  	add n visited ;
			accchildren <- accChildren choprec children [];
			choppedChildren = List.map (fun ti -> let Some t = ti in 
											t) yeschildren in 

		Some (Fork (n, choppedChildren))
		}



let () = 
	let () = Printf.printf "%s" ("HERE ") in 
	
	let rec tree =
		 	Fork ('r', [a;b;c;d;e;f;g;h;i;j]) 

			and a = Fork ('a', [g; j])  
			and b = Fork ('b', [a; i])  
			and c = Fork ('c', [e; h])  
			and  d = Fork ('d', []) 
			and e = Fork ('e', [d; h; j])  
			and f = Fork ('f', [i]) 
			and g = Fork ('g', [f; b]) 
			and  h = Fork ('h', []) 
			and  i = Fork ('i', [])  
		 	and j = Fork ('j', []) in 
	 
	let () = Printf.printf "%s" ("Original "^(toString tree)) in 
	let choppedtree = chop tree in 
	match choppedtree with 
		| None -> Printf.printf "%s" ("None")
		| Some t ->  Printf.printf "%s" ("Chopped "^(toString t)) 
		  
		
		
		