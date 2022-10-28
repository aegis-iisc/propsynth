(*generated using Cobalt *) 

 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  x0 )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  s )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  s )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons  x0  ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons  x0 nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )  nil )  
 else 
 	 ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )  nil )  
 else 
 	 ( cons   ( subs  x0 )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )  nil )  
 else 
 	 ( cons   ( subs  s )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )  nil )  
 else 
 	 ( cons   ( subs  s )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )  nil )  
 else 
 	 ( cons  x0  ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  x0 )  nil )  
 else 
 	 ( cons  x0 nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  x0 )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  s )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  s )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons  x0  ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )   ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons  x0 nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )  nil )  
 else 
 	 ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )  nil )  
 else 
 	 ( cons   ( subs  x0 )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )  nil )  
 else 
 	 ( cons   ( subs  s )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )  nil )  
 else 
 	 ( cons   ( subs  s )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )  nil )  
 else 
 	 ( cons  x0  ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons   ( subs  s )  nil )  
 else 
 	 ( cons  x0 nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0  ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0  ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  x0 )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0  ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  s )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0  ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons   ( subs  s )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0  ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons  x0  ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0  ( goal   ( subs  s )  x )  )  
 else 
 	 ( cons  x0 nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0 nil )  
 else 
 	 ( cons   ( subs  x0 )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0 nil )  
 else 
 	 ( cons   ( subs  x0 )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0 nil )  
 else 
 	 ( cons   ( subs  s )   ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0 nil )  
 else 
 	 ( cons   ( subs  s )  nil ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0 nil )  
 else 
 	 ( cons  x0  ( goal   ( subs  s )  x )  ) 
 (* Program *) 
let rec goal    (s : int)  (x0 : int) : (int list) = 
 	 if (  ( sizecheck  x0 )  ) 
 then 
 	  ( cons  x0 nil )  
 else 
 	 ( cons  x0 nil ) 
