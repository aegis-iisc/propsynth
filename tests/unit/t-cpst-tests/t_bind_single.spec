zero : int;
t_second : State  {\(h : heap). true} intpair {\(h : heap), (v : intpair), (h' : heap). fstint (v) == zero /\ sndint (v) == 1 };
t_bind : State  {\(h : heap). true} intpair {\(h : heap), (v : intpair), (h' : heap). fstint (v) == 0 /\ sndint (v) == 1 };



