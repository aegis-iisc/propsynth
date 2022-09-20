map : ( x_1 : { v : a | true }) -> ( x_2 : { v : b | true }) -> ( x_3 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [b] | true } {\(h : heap), (v : [b]), (h' : heap). [h' = h]};
reverse : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
intersperse : ( x_1 : { v : a | true }) -> ( x_2 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
intercalate : ( x_1 : { v : [a] | true }) -> ( x_2 : { v : [lista] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};

