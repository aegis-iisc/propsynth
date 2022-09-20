x1 : {v : int | [v = 0]};
y1 : {v : int | [v = 2]};

isZero : (x : {v : int | true}) -> {v : bool | ([v = true] <=> [x = 0]) };
goal : {v : bool | [v = true]};
