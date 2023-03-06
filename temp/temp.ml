(* Program *) 
let rec goal    (size : int)  (x0 : int) : (int list) = 
if (  ( sizecheck  size )  ) 
then 
[] 
else 
( subs  size )  +:: x0 +::  ( goal   ( subs  size )  x0 ) 