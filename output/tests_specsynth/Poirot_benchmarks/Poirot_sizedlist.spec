(*generated using Cobalt *) 

 (* Program *) 
let rec goal    (size : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	if (  ( bool_gen  un )  ) 
 then 
 	  ( goal   ( subs  size )  )  
 else 
 	 ( goal   ( subs  size )  ) 
