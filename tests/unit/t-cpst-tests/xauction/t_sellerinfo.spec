sname : [char];
srating : int;

t_seller_info: State  {\(h : heap). true} 
		sellerinfo 
		{\(h : heap), (v : seller), (h' : heap). true};


