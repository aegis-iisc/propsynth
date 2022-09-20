
mkNatural : (x : {v : [Word] | true}) -> 
                        State {\(h : heap). true }
                            v : {v : Natural | true}
                        {\(h : heap), (v : Natural), (h' : heap). [h' = h]};