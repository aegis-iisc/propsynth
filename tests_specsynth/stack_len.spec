
qualifier mem : list :-> int :-> bool;
qualifier len : list :-> int;


type list = Nil | Cons of int * list;

zero  : {v : int | [v = 0]}; 


goal : (s : list) -> {v : int | v == len (s)};
