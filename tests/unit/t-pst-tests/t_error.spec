l1 : [int];
l : [int];
l2 : [int];

init : State {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h' };  

formula guard1 = \(h : heap). ilssel (h,inp) = l  /\ hd (l) = i /\ ([i = 0]); 

formula guard2 = \(h : heap). ilssel (h,inp) = l  /\ hd (l) = i /\ ([i = 1]); 

finalqf : State  {\(h : heap). true} int {\(h : heap), (v : int), (h' : heap). [v = 0]};

finalother : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). h = h'}; 
step1 : State  {\(h : heap). true} unit {\(h : heap), (v : unit), (h' : heap). ilssel (h,inp) = l1 /\  ilssel (h', inp) = l2 /\ elems (l2) C= elems (l1)};  

step2 : State  {\(h : heap). true} error {\(h : heap), (v : error), (h' : heap). h = h'};  

finalother : State  {\(h : heap). true} error {\(h : heap), (v : error), (h' : heap). h = h'}; 


annot : StExc   {\(h : heap). true} 
		int  
		{\(h : heap), (v : int), (h' : heap). 
		(([v = 0] /\ ilssel (h,inp) = l1 /\ ilssel (h', inp) = l2) => (elems (l2) C= elems (l1))) 
			\/ 
			((ilssel (h', inp) = l2 /\ (elems (l2) = elems (l1)) ) => elems (l2) C= elems (l1)) };  


