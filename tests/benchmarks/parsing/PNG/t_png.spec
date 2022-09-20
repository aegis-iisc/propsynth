formula inv =  \(h:heap),(base : int) . true;
f_step : {x : int| true} -> {y : [int] | true } -> 
			StExc {\(h:heap). true} [int] 
			{\(h:heap), (v : [int]), (h':heap). elems (v) = elems (y) U {(x)}}; 
base: {base : int | true};
annot : StExc {\(h:heap). true} [int] {\(h:heap),(v:[int]),(h':heap). true};
