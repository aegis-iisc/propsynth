
step1 : State {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). h =  h' };		
step2 : StExc {\(h: heap). true} bool {\(h: heap), (v : bool), (h' : heap). elems (v) C select (h, inp)};  
