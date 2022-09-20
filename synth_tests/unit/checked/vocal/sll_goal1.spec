type cell;
type node;
qualifier lldom : heap :-> cell :-> bool;
qualifier llsel : heap :-> cell :-> node;
qualifier cons : node :-> bool;
qualifier content : node :-> a;
qualifier next : node :-> cell;
qualifier numcell : heap :-> int;


null : cell;
N : node;

create_cell : (c : cell) -> 
                State {\(h : heap). numcell (h) == 0}  
			v : {v : cell | true}  
		
                {\(h : heap), (v : cell), (h' : heap). 
				\(N' : node).
                   lldom (h', v) = true /\
                   llsel (h', v) = N' /\             
		            cons(N') = false /\
                   next (N') = null /\
                   numcell(h') == numcell(h) + 1
                  
        }; 

create_new_cell : (c : cell) -> 
                 State {\(h : heap). 
                \(N : node).
                        numcell (h) == 0 /\    
                        lldom (h, c) = true} 
			v : {v : cell | true}  
		{\(h : heap), (v : cell), (h' : heap). 
				\(N' : node).
                   lldom (h', v) = true /\
                   llsel (h', v) = N' /\             
		           cons(N') = false /\
                   next (N') = null /\
                   not [v = c] /\
                   numcell(h') == numcell(h) + 1
                  
        }; 



clear_cell : (c : cell) -> 
                 State {\(h : heap). \(N : node). 
                        lldom (h, c) = true /\ 
                        (llsel (h, c) = N => next (N) = null)} 
			v : {v : unit | true}  
		{\(h : heap), (v : unit), (h' : heap). 
				\(N' : node).
                   lldom (h', c) = false /\
                   [c = null] /\
                   numcell (h') == numcell (h) -- 1
        }; 

get_content : (c : cell) -> 
        State {\(h : heap). 
                \(N : node).
                lldom (h, c) = true /\
                (llsel (h, c) = N => cons (N) = true)} 
			v : {v : a | true}  
		{\(h : heap), (v : a), (h' : heap). 
				\(N' : node).
                   llsel (h, c) = N /\             
		   llsel (h', c) = llsel (h, c) /\ 
                  v = content (N') /\
                  numcell (h') == numcell (h)
                  
        };
 
set_next : (c : {v : cell | not (v = null)} ) ->
            (n : {v : cell| not (v = null) }) ->
               (data : a) -> 
        State {\(h : heap).         
                \(N : node).
                not [n= null] /\ 
                not [c=null] /\
                lldom (h, c) = true /\
                lldom (h, n) = true /\
                not [n=c] /\
                (llsel (h, c) = N => cons (N) = false) 
                 } 
				v : {v : unit | true}
		{\(h : heap), (v : unit), (h' : heap). 
				\(N' : node), (N : node).
		  llsel (h', c) = N' /\
                  llsel (h, c) = N /\
                  next (N') = n /\
                  content (N') = content (N) /\
                  cons (N') = true /\
                  numcell (h') == numcell (h)
        };       

set_content : (c : cell) ->
               (data : a) -> 
        State {\(h : heap).         
                \(N : node).
                lldom (h, c) = true /\
                (llsel (h, c) = N => cons (N) = true)} 
				v : {v : unit | true}
		{\(h : heap), (v : unit), (h' : heap). 
				\(N' : node), (N : node).
			      llsel (h', c) = N' /\
                  llsel (h, c) = N /\
                  content (N') = data /\
                  next (N') = next (N) /\
                  cons (N') = true /\
                  numcell (h') == numcell (h)
        };



get_next : (c : cell) -> 
         State {\(h : heap). 
                \(N : node).
                lldom (h, c) = true /\
                (llsel (h, c) = N => (cons (N) = true))} 
			v : {v : cell | true} 
		{\(h : heap), (v : cell), (h' : heap). 
				\(N' : node).
			      llsel (h', c) = N' /\
                  llsel (h', c) = llsel (h, c) /\ 
                  v = next (N') /\
                  numcell (h') == numcell (h)

        };


goal : (c : cell) ->
       (data : a) -> 
        State {\(h : heap).         
                \(N : node).
                lldom (h, c) = true /\
                llsel (h, c) = N /\ 
                cons (N) = true} 
			v : {v : unit | true}
		{\(h : heap), (v : unit), (h' : heap). 
				\(N' : node), (N : node).
		          llsel (h',c) = N' /\
                  llsel (h, c) = N /\
                  content (N') = data /\
                  cons (N') = true /\
                  numcell (h') == numcell (h)
        };

