boundn : int;
br: int;
bg: int;
bb : int;
tba : State  {\(h:heap). true} 
	triple 
	{\(h : heap), (v: triple), (h' : heap). pr1 (v) == br /\ pr2 (v) == bg /\ pr3 (v) ==  bb };

tgba : 
       State  {\(h:heap). true} 
	triple 
	{\(h : heap), (v: triple), (h' : heap). pr1 (v) == br /\ pr2 (v) == bg /\ pr3 (v) == boundn };
 
trgba : 
       State  {\(h:heap). true} 
	triple 
	{\(h : heap), (v: triple), (h' : heap). pr1 (v) ==  br /\ pr2 (v) ==  boundn /\ pr3 (v) ==  boundn };

 
trgb : 
       State  {\(h:heap). true} 
	triple 
	{\(h : heap), (v: triple), (h' : heap). pr1 (v) ==  boundn /\ pr2 (v) ==  boundn /\ pr3 (v) ==  boundn};



