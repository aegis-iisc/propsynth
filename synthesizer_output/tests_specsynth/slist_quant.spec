(*generated using Cobalt *) 

 (* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( subs  size )  ::  ( goal  size1 x0 ) 
 (* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( subs  size )  ::  ( goal   ( subs  size )  x0 ) 
 (* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( subs  size )  :: []
 (* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	x0 ::  ( goal  size1 x0 ) 
 (* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	x0 ::  ( goal   ( subs  size )  x0 ) 
 (* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	x0 :: []
 (* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( goal   ( subs  size )  x0 )  
 else 
 	 ( goal   ( subs  size )  x0 ) 
 (* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( goal   ( subs  size )  x0 )  
 else 
 	 ( goal   ( subs  size )  x0 ) 
 (* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( goal   ( subs  size )  x0 )  
 else 
 	 ( goal   ( subs  size )  x0 ) 
 (* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( goal   ( subs  size )  x0 )  
 else 
 	 ( goal   ( subs  size )  x0 ) 
