 
Cons : {head : [char] | true} -> {tail : [[char]] | true } -> State {\(h:head). sel (h, ind) = I /\ offsie (head,I) = true 
												/\ offsideList (tail, I) = true 
												  } [[char]] 
								{\(h:heap),(v : [[char]]), (h':heap). 
								   offsideList (v, I) = true }
annot : StExc {\(h:heap). true} tree {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ 
							leaf (v) = false /\ indent (v) = I /\ offsideList (v, I) = true};

finalqf :  State {\(h:heap).true} tree {\(h:heap), (v:[true]), (h' : heap). sel (h', ind) = sel (h, ind) /\ sel(h, ind) = I /\ leaf (v) = false /\ indent (v) = I /\ offsideList (v, I) = true};
finalother : State {\(h:heap).true} tree {\(h:heap), (v:unit), (h' : heap). sel (h', ind) = sel (h, ind) /\ sel(h, ind) = I /\ leaf (v) = true /\ ident (v) > I};


