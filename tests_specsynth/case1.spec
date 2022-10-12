qualifier mem : list :-> int :-> bool;
qualifier len : list :-> int;


type list = Nil | Cons of int * list;

Nil : {v : list | len (v) == 0};
Cons : (x : int) -> (xs : list) -> {v : list | len(v) == len (xs) + 1}; 

zero  : {v : int | [v = 0]}; 
goal : (s : list) -> {v : int | v == len (s)};
