s : [char];
bs  : [bidderinfo]

t_seller_info: State  {\(h : heap). true} 
		[bidderinfo]
		{\(h : heap), (v : seller), (h' : heap). disjoint_sellerbidder (s, v)};


