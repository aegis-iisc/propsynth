type apair;
type plist;

qualifier llen : [a] :-> int;
qualifier pllen : [apair] :-> int;

qualifier lmem : [a] :-> a :-> bool;
qualifier lhd : [a] :-> a;
qualifier plhd : [apair] :-> apair;

qualifier last  : [a] :-> a;
qualifier pllast  : [apair] :-> apair;

qualifier ppr1  : apair :-> a;
qualifier ppr2  : apair :-> a;


qualifier nth : [a] :-> int :-> a;
qualifier lsnd : [a] :-> a;
qualifier pen : [a] :-> a;

qualifier fst : plist :-> [a];
qualifier snd : plist :-> [a];

ep : a;

length : (x : [a]) ->  {v : int |  llen (x) == v}; 

rev : (l : [a]) ->  {v : [a] | 
            llen (v) == llen (l) /\
            lhd (v) = last (l) /\
            last (v) = lhd (l) /\
            lsnd (v) = pen (l) /\
            pen (v) = lsnd (v)

        };



compare_lengths : (x : [a]) -> (y: [a]) ->  {v : int | [v = 0] <=> llen (x) == llen  (y)};



cons : (x : a) -> (xs : [a]) -> { v : [a] | llen (v) == llen (xs) + 1 /\
            lmem (v, x) = true /\
            lhd (v) = x /\
            lsnd (v) = lhd (xs) /\
            last (v) = last (xs) /\
            pen (v) = pen (xs)
        };



hd : (l : [a]) -> { v : a | lmem (l, v) = true /\
            lhd (l) = v
            
        };


tl : (l : [a]) -> { v : [a] |
            llen (v) == llen (l) -- 1 /\
            last (v) = last (l) /\
            lhd (v) = lsnd (l) /\
            pen (v) = pen (l)
        };

nth : (l : [a]) -> (n : int) ->  { v : a | lmem (l, v) = true /\
            nth (l, n) = v 
        };

append : (l1 : [a]) ->  (l2 : [a]) -> { v : [a] | 
            llen (v) == llen (l1) + llen (l2) /\
            lhd (v) = lhd (l1) /\
            lsnd (v) = lsnd (l1) /\
            last (v) = last (l2) /\
            pen (v) = pen (l2)
        };

combine : (l1 : [a]) ->  (l2 : {v : [a] | pllen (l1) == pllen (l2)}) -> 
        {v : [apair] | \(H : apair), (L : apair).
            pllen (v) == pllen (l1) /\
            plhd  (v) = H  /\
            pllast (v) = L /\
            ppr1 (H) = lhd (l1) /\
            ppr2 (H) = lhd (l2) /\
            ppr1 (L) = last (l1) /\
            ppr2 (L) = last (l2) 
        };


splitAt : (y:int) -> (l : { v : [a] | llen (v) > y}) -> 
                {v:plist | \(H : [a]), (L : [a]), (u : a), (w : u).
                    (fst (v) = H /\
                    snd (v) = L) =>  
                    llen (H) == y /\
                    llen (L) == llen (l) -- y /\
                    lmem (L, u) = true => lmem (l, u) = true /\
                    lmem (H, w) = true => lmem (l, w) = true
                };

null : (l : [a]) -> {v : bool | [v=true] <=> llen (l) == 0};

last : (l : [a]) -> { v : a | last (l) = v}; 

init : (l : [a]) -> { v : [a] | llen (v) == llen (v) --1}; 

take : (n : int) -> (l : [a]) -> { v : [a] | \(u : a). 
                                            llen (v) == n /\ 
                                            lmem (v, u) = true => lmem (z, u) = true}; 


goal : (n:int) -> (m : int) -> (z : {v : [a] | llen (v) > n /\ llen (v) > m})
     	-> { v : [a] | \(u : a).  
            llen (v) == llen (l) -- m /\
            lmem (v, u) = true => lmem (z, u) = true 
            
        };
