zero : int;
t_bind : State  {\(h : heap). true} intpair {\(h : heap), (v : intpair), (h' : heap). fstint (v) == 0 /\ sndint (v) == 1 };


