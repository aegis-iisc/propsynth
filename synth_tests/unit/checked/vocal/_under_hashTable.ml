type key;
type ('a * 'b) table = ('a * 'b)  list 
qualifier hdom : heap :-> ref table :-> bool;
qualifier hsel : heap :-> ref table :-> table;
qualifier hmem : table :-> key :-> bool;
qualifier hsize : table :-> int;  
qualifier hvmem : table :-> a :-> bool;
qualifier hlen : [a] :-> int;
qualifier keyset : table :-> [key];
