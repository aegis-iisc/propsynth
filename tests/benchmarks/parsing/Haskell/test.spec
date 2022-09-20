
t_case :  StExc {\(h:heap). true} tree {\(h:heap), (v : tree), (h': heap ). sel(h', inp) C=  sel (h, inp) 
							/\ sel (h, ind) = I /\ <<offsidetree (v, I)>>};
						
