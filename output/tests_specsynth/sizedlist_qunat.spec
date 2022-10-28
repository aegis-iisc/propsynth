(*generated using Cobalt *) 

 (* Program *) 
let rec goal    (size : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( gt_eq_int_gen  n )  ::  ( goal   ( subs  size )  ) 
 (* Program *) 
let rec goal    (size : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( gt_eq_int_gen  size1 )  ::  ( goal   ( subs  size )  ) 
 (* Program *) 
let rec goal    (size : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( gt_eq_int_gen  s )  ::  ( goal   ( subs  size )  ) 
 (* Program *) 
let rec goal    (size : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( gt_eq_int_gen   ( subs  size )  )  ::  ( goal   ( subs  size )  ) 
 (* Program *) 
let rec goal    (size : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( gt_eq_int_gen  size )  ::  ( goal   ( subs  size )  ) 
 (* Program *) 
let rec goal    (size : int) : (int list) = 
 	 if (  ( sizecheck  size )  ) 
 then 
 	 [] 
 else 
 	 ( subs  size )  ::  ( goal   ( subs  size )  ) 
