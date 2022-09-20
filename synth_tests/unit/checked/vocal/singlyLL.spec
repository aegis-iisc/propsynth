type cell;
type node;
qualifier lldom : heap :-> cell :-> bool;
qualifier llsel : heap :-> cell :-> node;
qualifier cons : node :-> bool;
qualifier content : node :-> a;
qualifier next : node :-> cell;


null : cell;


create_cell : (c : cell) -> 
                State {\(h : heap). true}  
			v : {v : cell | true}  
		
                {\(h : heap), (v : cell), (h' : heap). 
				\(N' : node).
                   lldom (h', v) = true /\
                   llsel (h', v) = N' /\             
		   cons(N') = false /\
                   next (N') = null
                  
        }; 

create_new_cell : (c : cell) -> 
                 State {\(h : heap). 
                \(N : node).
                        lldom (h, c) = true} 
			v : {v : cell | true}  
		{\(h : heap), (v : cell), (h' : heap). 
				\(N' : node).
                   lldom (h', v) = true /\
                   llsel (h', v) = N' /\             
		   cons(N') = false /\
                   next (N') = null /\
                   not [v = c]
        }; 



clear_cell : (c : cell) -> 
                 State {\(h : heap). \(N : node). 
                        lldom (h, c) = true /\ 
                        (llsel (h, c) = N => next (N) = null)} 
			v : {v : unit | true}  
		{\(h : heap), (v : unit), (h' : heap). 
				\(N' : node).
                   lldom (h', c) = false /\
                   [c = null]
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
                  v = content (N')
                  
        };
 
set_next : (c : cell) ->
            (n : {v : cell| true  }) ->
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
                  cons (N') = true
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
                  cons (N') = true
        };


get_next : (c : cell) -> 
         State {\(h : heap). 
                \(N : node).
                lldom (h, c) = true /\
                (llsel (h, c) = N => cons (N) = true)} 
			v : {v : cell | true} 
		{\(h : heap), (v : cell), (h' : heap). 
				\(N' : node).
			      llsel (h', c) = llsel (h, c) /\ 
                  v = next (N')
        };


(**
\lambda 
[c data]
n <- get_next c
_ <- set_content n data
retrun () 
)
goal0 : (c : cell) ->
        (data : a) -> 
        State {\(h : heap).         
                \(N : node).
                lldom (h, c) = true /\
                llsel (h, c) = N } 
			v : {v : unit | true}
		{\(h : heap), (v : unit), (h' : heap). 
				\(N' : node), (N : node).
		  llsel (h',c) = N' /\
                  llsel (h, c) = N /\
                  content (N') = data /\
                  cons (N') = true
        };

(**
\lambda 
[ data]
c <- create_cell
n <- get_next c
_ <- set_content n data
retrun () 
)
goal1 : (data : a) -> 
        State {\(h : heap).         
                true} 
		v : {v : cell | true}
		{\(h : heap), (v : cell), (h' : heap). 
		\(N' : node).
		  llsel (h', v) = N' /\
                  not (next (N') = null) /\
                  content (N') = data /\
                  cons (N') = true
        };

(**
\lambda 
[ c]
con <- get_content c
n <- get_next c
_ <- clear n
retrun () 
)
goal2 : (c : cell) ->
        State {\(h : heap).         
                \(N : node).
                lldom (h, c) = true /\
                llsel (h, c) = N /\ 
                cons (N) = false /\
                next (N) = null} 
			v : {v : unit | true}
		{\(h : heap), (v : unit), (h' : heap). 
				\(N' : node), (N : node).
		  llsel (h', c) = N' /\
                  llsel (h, c) = N /\
                  not (next (N') = null) /\
                  content (N') = data /\
                  cons (N') = true
        };


