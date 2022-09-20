Leaf : {name : [char]| true} -> {ind : int | true} -> { v : tree | leaf (v) = true /\ indent (v) == ind};
Node : {name : [char]| true} -> {ind : int | true} -> {sub : [tree] | true} -> { v: tree | leaf (v) = false /\ indent (v) = ind /\ children (v) = sub};


t_case :  StExc {\(h:heap). true} tree {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ <<offsidetree (v, I)>>};

t_case_exp : StExc {\(h:heap). true} tree {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ <<offsidetree(v, I)>>};
							
t_alt : StExc {\(h:heap). true} tree {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ <<offsidetree(v, I)>>};

t_expr : StExc {\(h:heap). true} tree {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ <<offsidetree(v, I)>>};

t_const :  StExc {\(h:heap). true} tree {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ <<offsidetree(v, I)>>};

t_id :  StExc {\(h:heap). true} tree {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ <<offsidetree(v, I)>>};
t_of : StExc {\(h:heap). true} tree {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ <<offsidetree(v, I)>>};


t_alts : StExc {\(h:heap). true} [tree] {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ <<offsidetreeList (v, I)>>};
							
