(*generated using Cobalt *) 

 (* Program *) 
let rec goal    (size : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( subs  size )  ::  ( goal   ( subs  size )  ) 
 (* Program *) 
let rec goal    (size : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( subs  size )  ::  ( goal   ( subs  size )  ) 
