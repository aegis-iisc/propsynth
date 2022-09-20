s : string;
bname : string;
brating :int;
t_bidder_info: State  {\(h : heap). true} 
		bidder
		{\(h : heap), (v : bidder), (h' : heap). not (name (bidder) == s) };


