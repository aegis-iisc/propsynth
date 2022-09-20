mkNatural : ( x_1 : { v : [Word] | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
isValidNatural : ( x_1 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Bool | true } {\(h : heap), (v : Bool), (h' : heap). [h' = h]};
plusNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
minusNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
timesNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
negateNatural : ( x_1 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
signumNatural : ( x_1 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
quotRemNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : PairNatural | true } {\(h : heap), (v : PairNatural), (h' : heap). [h' = h]};
quotNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
remNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
gcdNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
lcmNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
andNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
orNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
xorNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
bitNatural : ( x_1 : { v : Int | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
testBitNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Int | true }) -> State {\(h : heap). true } v : {v : Bool | true } {\(h : heap), (v : Bool), (h' : heap). [h' = h]};
popCountNatural : ( x_1 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Int | true } {\(h : heap), (v : Int), (h' : heap). [h' = h]};
shiftLNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Int | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
shiftRNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Int | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
naturalToInteger : ( x_1 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Integer | true } {\(h : heap), (v : Integer), (h' : heap). [h' = h]};
naturalToWord : ( x_1 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Word | true } {\(h : heap), (v : Word), (h' : heap). [h' = h]};
naturalToInt : ( x_1 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Int | true } {\(h : heap), (v : Int), (h' : heap). [h' = h]};
naturalFromInteger : ( x_1 : { v : Integer | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
wordToNatural : ( x_1 : { v : Word | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
intToNatural : ( x_1 : { v : Int | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
wordToNatural : ( x_1 : { v : Word | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
wordToNaturalBase : ( x_1 : { v : Word | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
powModNatural : ( x_1 : { v : Natural | true }) -> ( x_2 : { v : Natural | true }) -> ( x_3 : { v : Natural | true }) -> State {\(h : heap). true } v : {v : Natural | true } {\(h : heap), (v : Natural), (h' : heap). [h' = h]};
concat : ( x_1 : { v : [a] | true }) -> ( x_2 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
head : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : a | true } {\(h : heap), (v : a), (h' : heap). [h' = h]};
last : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : a | true } {\(h : heap), (v : a), (h' : heap). [h' = h]};
tail : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
init : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
map : ( x_1 : { v : a | true }) -> ( x_2 : { v : b | true }) -> ( x_3 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [b] | true } {\(h : heap), (v : [b]), (h' : heap). [h' = h]};
reverse : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
intersperse : ( x_1 : { v : a | true }) -> ( x_2 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
intercalate : ( x_1 : { v : [a] | true }) -> ( x_2 : { v : [lista] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
transpose : ( x_1 : { v : [lista] | true }) -> State {\(h : heap). true } v : {v : [lista] | true } {\(h : heap), (v : [lista]), (h' : heap). [h' = h]};
subsequences : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [lista] | true } {\(h : heap), (v : [lista]), (h' : heap). [h' = h]};
permutations : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [lista] | true } {\(h : heap), (v : [lista]), (h' : heap). [h' = h]};
foldl1' : ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : a | true }) -> ( x_4 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : a | true } {\(h : heap), (v : a), (h' : heap). [h' = h]};
scanl : ( x_1 : { v : b | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : b | true }) -> ( x_4 : { v : b | true }) -> ( x_5 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [b] | true } {\(h : heap), (v : [b]), (h' : heap). [h' = h]};
scanl' : ( x_1 : { v : b | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : b | true }) -> ( x_4 : { v : b | true }) -> ( x_5 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [b] | true } {\(h : heap), (v : [b]), (h' : heap). [h' = h]};
scanl1 : ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : a | true }) -> ( x_4 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
scanr : ( x_1 : { v : a | true }) -> ( x_2 : { v : b | true }) -> ( x_3 : { v : b | true }) -> ( x_4 : { v : b | true }) -> ( x_5 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [b] | true } {\(h : heap), (v : [b]), (h' : heap). [h' = h]};
scanr1 : ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : a | true }) -> ( x_4 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
iterate : ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : a | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
iterate' : ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : a | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
repeat : ( x_1 : { v : a | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
replicate : ( x_1 : { v : Int | true }) -> ( x_2 : { v : a | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
cycle : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
take : ( x_1 : { v : Int | true }) -> ( x_2 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
drop : ( x_1 : { v : Int | true }) -> ( x_2 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
splitAt : ( x_1 : { v : Int | true }) -> ( x_2 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : pairlist | true } {\(h : heap), (v : pairlist), (h' : heap). [h' = h]};
takeWhile :   ( x_1 : { v : a | true }) -> ( x_2 : { v : Bool | true })   -> ( x_3 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
dropWhile :   ( x_1 : { v : a | true }) -> ( x_2 : { v : Bool | true })   -> ( x_3 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
dropWhileEnd :   ( x_1 : { v : a | true }) -> ( x_2 : { v : Bool | true })   -> ( x_3 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
span :   ( x_1 : { v : a | true }) -> ( x_2 : { v : Bool | true })   -> ( x_3 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : pairlist | true } {\(h : heap), (v : pairlist), (h' : heap). [h' = h]};
break :   ( x_1 : { v : a | true }) -> ( x_2 : { v : Bool | true })   -> ( x_3 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : pairlist | true } {\(h : heap), (v : pairlist), (h' : heap). [h' = h]};
inits : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [lista] | true } {\(h : heap), (v : [lista]), (h' : heap). [h' = h]};
tails : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [lista] | true } {\(h : heap), (v : [lista]), (h' : heap). [h' = h]};
filter :   ( x_1 : { v : a | true }) -> ( x_2 : { v : Bool | true })   -> ( x_3 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
partition :   ( x_1 : { v : a | true }) -> 
            ( x_2 : { v : Bool | true })   -> 
                ( x_3 : { v : [a] | true }) ->   
                    State {\(h : heap). true } v : {v : pairlist | true } 
                    {\(h : heap), (v : pairlist), (h' : heap). [h' = h]};
dob : ( x_1 : { v : [a] | true }) -> ( x_2 : { v : Int | true }) -> State {\(h : heap). true } v : {v : a | true } {\(h : heap), (v : a), (h' : heap). [h' = h]};
findIndices :   ( x_1 : { v : a | true }) -> ( x_2 : { v : Bool | true })   -> ( x_3 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [Int] | true } {\(h : heap), (v : [Int]), (h' : heap). [h' = h]};
zip : ( x_1 : { v : [a] | true }) -> ( x_2 : { v : [b] | true }) -> State {\(h : heap). true } v : {v : [pair] | true } {\(h : heap), (v : [pair]), (h' : heap). [h' = h]};
zip3 : ( x_1 : { v : [a] | true }) -> ( x_2 : { v : [b] | true }) -> ( x_3 : { v : [c] | true }) -> State {\(h : heap). true } v : {v : [tuple] | true } {\(h : heap), (v : [tuple]), (h' : heap). [h' = h]};
zip4 : ( x_1 : { v : [a] | true }) -> ( x_2 : { v : [b] | true }) -> ( x_3 : { v : [c] | true }) -> ( x_4 : { v : [d] | true }) -> State {\(h : heap). true } v : {v : [tuple] | true } {\(h : heap), (v : [tuple]), (h' : heap). [h' = h]};
zip5 : ( x_1 : { v : [a] | true }) -> ( x_2 : { v : [b] | true }) -> ( x_3 : { v : [c] | true }) -> ( x_4 : { v : [d] | true }) -> ( x_5 : { v : [e] | true }) -> State {\(h : heap). true } v : {v : [tuple] | true } {\(h : heap), (v : [tuple]), (h' : heap). [h' = h]};
zip6 : ( x_1 : { v : [a] | true }) -> ( x_2 : { v : [b] | true }) -> ( x_3 : { v : [c] | true }) -> ( x_4 : { v : [d] | true }) -> ( x_5 : { v : [e] | true }) -> ( x_6 : { v : [f] | true }) -> State {\(h : heap). true } v : {v : [tuple] | true } {\(h : heap), (v : [tuple]), (h' : heap). [h' = h]};
zip7 : ( x_1 : { v : [a] | true }) -> ( x_2 : { v : [b] | true }) -> ( x_3 : { v : [c] | true }) -> ( x_4 : { v : [d] | true }) -> ( x_5 : { v : [e] | true }) -> ( x_6 : { v : [f] | true }) -> ( x_7 : { v : [g] | true }) -> State {\(h : heap). true } v : {v : [tuple] | true } {\(h : heap), (v : [tuple]), (h' : heap). [h' = h]};
zipWith :   ( x_1 : { v : a | true }) -> ( x_2 : { v : b | true }) -> ( x_3 : { v : c | true })   -> ( x_4 : { v : [a] | true }) -> ( x_5 : { v : [b] | true }) -> State {\(h : heap). true } v : {v : [c] | true } {\(h : heap), (v : [c]), (h' : heap). [h' = h]};
zipWith3 :   ( x_1 : { v : a | true }) -> ( x_2 : { v : b | true }) -> ( x_3 : { v : c | true }) -> ( x_4 : { v : d | true })   -> ( x_5 : { v : [a] | true }) -> ( x_6 : { v : [b] | true }) -> ( x_7 : { v : [c] | true }) -> State {\(h : heap). true } v : {v : [d] | true } {\(h : heap), (v : [d]), (h' : heap). [h' = h]};
zipWith4 :   ( x_1 : { v : a | true }) -> ( x_2 : { v : b | true }) -> ( x_3 : { v : c | true }) -> ( x_4 : { v : d | true }) -> ( x_5 : { v : e | true })   -> ( x_6 : { v : [a] | true }) -> ( x_7 : { v : [b] | true }) -> ( x_8 : { v : [c] | true }) -> ( x_9 : { v : [d] | true }) -> State {\(h : heap). true } v : {v : [e] | true } {\(h : heap), (v : [e]), (h' : heap). [h' = h]};
zipWith5 :   ( x_1 : { v : a | true }) -> ( x_2 : { v : b | true }) -> ( x_3 : { v : c | true }) -> ( x_4 : { v : d | true }) -> ( x_5 : { v : e | true }) -> ( x_6 : { v : f | true })   -> ( x_7 : { v : [a] | true }) -> ( x_8 : { v : [b] | true }) -> ( x_9 : { v : [c] | true }) -> ( x_10 : { v : [d] | true }) -> ( x_11 : { v : [e] | true }) -> State {\(h : heap). true } v : {v : [f] | true } {\(h : heap), (v : [f]), (h' : heap). [h' = h]};
zipWith6 :   ( x_1 : { v : a | true }) -> ( x_2 : { v : b | true }) -> ( x_3 : { v : c | true }) -> ( x_4 : { v : d | true }) -> ( x_5 : { v : e | true }) -> ( x_6 : { v : f | true }) -> ( x_7 : { v : g | true })   -> ( x_8 : { v : [a] | true }) -> ( x_9 : { v : [b] | true }) -> ( x_10 : { v : [c] | true }) -> ( x_11 : { v : [d] | true }) -> ( x_12 : { v : [e] | true }) -> ( x_13 : { v : [f] | true }) -> State {\(h : heap). true } v : {v : [g] | true } {\(h : heap), (v : [g]), (h' : heap). [h' = h]};
zipWith7 :   ( x_1 : { v : a | true }) -> ( x_2 : { v : b | true }) -> ( x_3 : { v : c | true }) -> ( x_4 : { v : d | true }) -> ( x_5 : { v : e | true }) -> ( x_6 : { v : f | true }) -> ( x_7 : { v : g | true }) -> ( x_8 : { v : h | true })   -> ( x_9 : { v : [a] | true }) -> ( x_10 : { v : [b] | true }) -> ( x_11 : { v : [c] | true }) -> ( x_12 : { v : [d] | true }) -> ( x_13 : { v : [e] | true }) -> ( x_14 : { v : [f] | true }) -> ( x_15 : { v : [g] | true }) -> State {\(h : heap). true } v : {v : [h] | true } {\(h : heap), (v : [h]), (h' : heap). [h' = h]};
lines : ( x_1 : { v : String | true }) -> State {\(h : heap). true } v : {v : [String] | true } {\(h : heap), (v : [String]), (h' : heap). [h' = h]};
words : ( x_1 : { v : String | true }) -> State {\(h : heap). true } v : {v : [String] | true } {\(h : heap), (v : [String]), (h' : heap). [h' = h]};
unlines : ( x_1 : { v : [String] | true }) -> State {\(h : heap). true } v : {v : String | true } {\(h : heap), (v : String), (h' : heap). [h' = h]};
unwords : ( x_1 : { v : [String] | true }) -> State {\(h : heap). true } v : {v : String | true } {\(h : heap), (v : String), (h' : heap). [h' = h]};
sort : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
insert : ( x_1 : { v : a | true }) -> ( x_2 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
nubBy :   ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : Bool | true })   -> ( x_4 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
deleteBy :   ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : Bool | true })   -> ( x_4 : { v : a | true }) -> ( x_5 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
deleteFirstsBy :   ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : Bool | true })   -> ( x_4 : { v : [a] | true }) -> ( x_5 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
unionBy :   ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : Bool | true })   -> ( x_4 : { v : [a] | true }) -> ( x_5 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
intersectBy :   ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : Bool | true })   -> ( x_4 : { v : [a] | true }) -> ( x_5 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
groupBy :   ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : Bool | true })   -> ( x_4 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [lista] | true } {\(h : heap), (v : [lista]), (h' : heap). [h' = h]};
sortBy :   ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : Ordering | true })   -> ( x_4 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
insertBy :   ( x_1 : { v : a | true }) -> ( x_2 : { v : a | true }) -> ( x_3 : { v : Ordering | true })   -> ( x_4 : { v : a | true }) -> ( x_5 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
Node : ( x_1 : { v : a | true }) -> ( x_2 : { v : Foresta | true }) -> State {\(h : heap). true } v : {v : Treea | true } {\(h : heap), (v : Treea), (h' : heap). [h' = h]};
rootLabel : ( x_1 : { v : Treea | true }) -> State {\(h : heap). true } v : {v : a | true } {\(h : heap), (v : a), (h' : heap). [h' = h]};
subForest : ( x_1 : { v : Treea | true }) -> State {\(h : heap). true } v : {v : Foresta | true } {\(h : heap), (v : Foresta), (h' : heap). [h' = h]};
unfoldTree :   ( x_1 : { v : b | true }) -> ( x_2 : { v : pairablist | true })   -> ( x_3 : { v : b | true }) -> State {\(h : heap). true } v : {v : Treea | true } {\(h : heap), (v : Treea), (h' : heap). [h' = h]};
unfoldForest :   ( x_1 : { v : b | true }) -> ( x_2 : { v : pairablist | true })   -> ( x_3 : { v : [b] | true }) -> State {\(h : heap). true } v : {v : Foresta | true } {\(h : heap), (v : Foresta), (h' : heap). [h' = h]};
foldTree :   ( x_1 : { v : a | true }) -> ( x_2 : { v : [b] | true }) -> ( x_3 : { v : b | true })   -> ( x_4 : { v : Treea | true }) -> State {\(h : heap). true } v : {v : b | true } {\(h : heap), (v : b), (h' : heap). [h' = h]};
flatten : ( x_1 : { v : Treea | true }) -> State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};
levels : ( x_1 : { v : Treea | true }) -> State {\(h : heap). true } v : {v : [lista] | true } {\(h : heap), (v : [lista]), (h' : heap). [h' = h]};
buildG : ( x_1 : { v : Bounds | true }) -> ( x_2 : { v : [Edge] | true }) -> State {\(h : heap). true } v : {v : Graph | true } {\(h : heap), (v : Graph), (h' : heap). [h' = h]};
vertices : ( x_1 : { v : Graph | true }) -> State {\(h : heap). true } v : {v : [Vertex] | true } {\(h : heap), (v : [Vertex]), (h' : heap). [h' = h]};
edges : ( x_1 : { v : Graph | true }) -> State {\(h : heap). true } v : {v : [Edge] | true } {\(h : heap), (v : [Edge]), (h' : heap). [h' = h]};
transposeG : ( x_1 : { v : Graph | true }) -> State {\(h : heap). true } v : {v : Graph | true } {\(h : heap), (v : Graph), (h' : heap). [h' = h]};



tbl : ref [int];
Tbl' : [int];
Tbl :  [int];
num : ref int;


mem : (s  : { v : int | true}) -> 
			State  
			{\(h : heap). true} 
			v : { v : bool | true} 
			
			{\(h : heap), (v : bool), (h' : heap). 
				\(Tbl' : [int]), (Tbl: [int]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				sel (h', num) == sel (h, num) /\
				ilssel (h', tbl) = ilssel (h, tbl) /\
				size (Tbl') == size (Tbl) /\
				([v=true] <=> ( mem(Tbl', s) = true))/\ 
				([v=false] <=> (mem (Tbl', s) = false))};


fresh_str : State 
			{\(h : heap). not (sel (h, num) > 2)} 
			v : { v : int | true} 
			{\(h : heap), (v : int), (h' : heap). 
				\(Tbl' : [int]).
				sel (h', num) == sel (h, num) + 1 /\
				ilssel (h', tbl) = Tbl' /\  
				ilssel (h', tbl) = ilssel (h, tbl) /\
				mem (Tbl', v) = false};



average_len : State  {\(h : heap).
					\(Tbl : [int]).
					Tbl = ilssel (h, tbl) 
					=> size (Tbl) > 0} 
				v : { v : float | true} 
			 {\(h : heap), (v : float), (h' : heap). 
				ilssel (h', tbl) = 	ilssel (h, tbl) 
				/\ 
				sel (h', num) == sel (h, num)
				};



add : (s : {v : int | true}) ->  
			State  {\(h : heap).
				\(Tbl : [int]). 
				ilssel (h, tbl) = Tbl =>  
				(mem (Tbl, s) = false)} 
				v : { v : unit | true} 
			{\(h : heap), (v : unit), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				ilssel (h', tbl) = Tbl'/\
				ilssel (h, tbl) = Tbl /\
				mem (Tbl', s) = true /\
				size (Tbl') == size (Tbl) + 1 /\
				sel (h', num) == sel (h, num) 
				};


goal : (s : {v : int | true}) -> 
		State {\(h : heap). 
			 \(Tbl : [int]). 
				sel (h, num) == 0 /\
				ilssel (h, tbl) = Tbl /\
				not  (0 > size (Tbl)) /\
				(mem (Tbl, s) = true)}
				v : {v : float | true}
		  	{\(h : heap), (v : float), (h' : heap). 
				\(Tbl' : [int]), (Tbl : [int]).
				(ilssel (h, tbl) = Tbl /\  
				ilssel (h', tbl) = Tbl')   
				=> 
				size (Tbl') == size (Tbl) + 2 
				
			};

