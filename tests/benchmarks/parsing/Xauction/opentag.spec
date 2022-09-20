formula guard_d1 = \(h:heap). chareq (i, open) = true;
formula guard_d2 =  \(h:heap). ident (i) = true;
formula guard_d3 = \(h:heap). not (ident (i) = true);
formula guard_d4 = \(h:heap). chareq (i, close) = true;
formula invariant_d2  = \(h:heap). included (h, h0, inp) = true ;

out : ref [char];
init : State {\(h:heap). true} ref [char] {\(h:heap), (v:ref [char]), (h' : heap). h = h'};

step_d1 :  State {\(h:heap). true} unit {\(h:heap), (v:unit), (h' : heap). sel (h, out) = outin /\ sel(h', out) = outout /\ elems (outout) = elems (outin) U {(i)}    };

step_d2 :  State {\(h:heap). true} unit {\(h:heap), (v:unit), (h' : heap). sel (h, out) = outin /\ sel(h', out) = outout /\ elems (outout) = elems (outin) U {(i)}    };

step_d3 :  State {\(h:heap). true} unit {\(h:heap), (v:unit), (h' : heap). sel (h, out) = outin /\ sel(h', out) = outout /\ elems (outout) = elems (outin) U {(i)}    };


step_d4 :  State {\(h:heap). true} unit {\(h:heap), (v:unit), (h' : heap). sel (h, out) = outin /\ sel(h', out) = outout /\ elems (outout) = elems (outin) U {(i)}    };

finalqf : State {\(h:heap).true} [char] {\(h:heap), (v:[char]), (h' : heap). sel (h, out) = outin /\ elems (v) = elems (outin)};
finalother : StExc {\(h:heap).true} err {\(h:heap), (v:unit), (h' : heap). h = h'};

annot : StExc {\(h : heap). true} [char] {\(h:heap),(v:[char]),(h':heap). included (h, h', inp) = true};

