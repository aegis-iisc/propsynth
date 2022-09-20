formula guard1 = \(h:heap) . snd (i) > sel (h, ind);
formula guard2 = \(h:heap) . not (snd (i) >  sel (h, ind));

out : ref [char];
init : State {\(h:heap). true} ref [char] {\(h:heap), (v:ref [char]), (h' : heap). h = h'};
Leaf : {name : [char]| true} -> {ind : int | true} -> { v : tree | leaf (v) = true /\ indent (v) == ind};
Node : {name : [char]| true} -> {ind : int | true} -> {sub : [tree] | true} -> { v: tree | leaf (v) = false /\ indent (v) = ind /\ children (v) = sub};


step1 :  State {\(h:heap). true} unit {\(h:heap), (v:unit), (h' : heap). sel (h', out) == i};
step2 : State  {\(h:heap). true} unit {\(h:heap), (v:unit), (h' : heap). h = h'};

finalqf : State {\(h:heap).true} tree {\(h:heap), (v:unit), (h' : heap). sel (h', ind) = sel (h, ind) /\ sel(h, ind) = I /\ leaf (v) = true /\ ident (v) > I};
finalother : State  {\(h:heap).true} unit {\(h:heap), (v:unit), (h' : heap). h = h'};

 
annot : StExc {\(h:heap). true} tree {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ 
							leaf (v) = true /\ indent (v) > I};



