(*example of a recursion + higher order*)


visited : int list;
type rose = Fork of (int * rose list)
			| Empty


(*whole List library*)
addVisited : a : int -> State {\(h : heap). sel (h, visited) = in /\ 
											unique in}
						v : unit  
						
						{\(h : heap), (v : unit), (h' : heap). 
							sel (h', visited) = out /\ 
							sel (h, visited) = in /\ 
							elems (out) = elems (in) U {(a)}
							unique out};


getVisited : State {\(h : heap). true } 
						v : int list 
					{\(h : heap), (v : rtree), (h' : heap). 
						sel (h', visited) = sel (h, visited)
						v = sel (h, visited)};


foo : 




bar : 



(*How do we handle effectful lambdas, whose body is a computation
Expand the APPEff rule*)
goal : (rtree : rose) -> State {\(h : heap). true}
					v : rose 
					{\(h : heap), (v : rose), (h' : heap). 
						sel (h', visited) = out
						/\ not (empty out) 
						/\ unique out 
						/\ elems (out) = elems (rtree)};


goal : ls : list -> State {\(h:heap). true}
						v : list 
						{\(h : heap), (v : rose), (h' : heap). 
							(sel (h', visited) = sel (h, visited) /\ len (v) = 0 )
							\/ 
							(sel (h', visited) = out
							/\ not (empty out) 
							/\ elems (out) = elems (rtree))
						}