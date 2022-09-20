init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  


node : [char];
indent : int;
children : [tree];
ind : ref int;
I : int;
chs : [tree];
finalqf : State  {\(h : heap). sel (h, ind) == I } 
	tree 
	{\(h : heap), (v : tree), (h' : heap). node (v) = node /\ indent (v) > I  /\ children (v) = chs /\  offsideTreeList (I, chs) = true};
finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
annot : State  {\(h : heap). sel (h, ind) == I } 
	tree 
	{\(h : heap), (v : tree), (h' : heap). node (v) = node /\ indent (v) > sel (h, ind) /\ children (v) = chs /\  offsideTreeList (I, chs) = true };


   


