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
partition :   ( x_1 : { v : a | true }) -> ( x_2 : { v : Bool | true })   -> ( x_3 : { v : [a] | true }) ->   ( x_4 : { v : pairlist | true }) -> 
   State {\(h : heap). true } v : {v : pairlist | true } {\(h : heap), (v : pairlist), (h' : heap). [h' = h]};
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
drawTree : ( x_1 : { v : Tree | true }) -> ( x_2 : { v : String | true }) -> State {\(h : heap). true } v : {v : String | true } {\(h : heap), (v : String), (h' : heap). [h' = h]};
buildG : ( x_1 : { v : Bounds | true }) -> ( x_2 : { v : [Edge] | true }) -> State {\(h : heap). true } v : {v : Graph | true } {\(h : heap), (v : Graph), (h' : heap). [h' = h]};
vertices : ( x_1 : { v : Graph | true }) -> State {\(h : heap). true } v : {v : [Vertex] | true } {\(h : heap), (v : [Vertex]), (h' : heap). [h' = h]};
edges : ( x_1 : { v : Graph | true }) -> State {\(h : heap). true } v : {v : [Edge] | true } {\(h : heap), (v : [Edge]), (h' : heap). [h' = h]};
outdegree : ( x_1 : { v : Graph | true }) -> 
                  ( x_2 : { v : Array | true }) -> 
                  ( x_3 : { v : Vertex | true }) -> 
                  State {\(h : heap). true } v : {v : Int | true } {\(h : heap), (v : Int), (h' : heap). [h' = h]};
indegree : ( x_1 : { v : Graph | true }) -> ( x_2 : { v : Array | true }) ->  ( x_3 : { v : Vertex | true }) -> 
         State {\(h : heap). true } v : {v : Int | true } {\(h : heap), (v : Int), (h' : heap). [h' = h]};
transposeG : ( x_1 : { v : Graph | true }) -> State {\(h : heap). true } v : {v : Graph | true } {\(h : heap), (v : Graph), (h' : heap). [h' = h]};
dfs : ( x_1 : { v : Graph | true }) -> ( x_2 : { v : [Vertex] | true }) -> ( x_3 : { v : Forest | true }) -> State {\(h : heap). true } v : {v : Vertex | true } {\(h : heap), (v : Vertex), (h' : heap). [h' = h]};
dff : ( x_1 : { v : Graph | true }) -> ( x_2 : { v : Forest | true }) -> 
   State {\(h : heap). true } v : {v : Vertex | true } {\(h : heap), (v : Vertex), (h' : heap). [h' = h]};
topSort : ( x_1 : { v : Graph | true }) -> State {\(h : heap). true } v : {v : [Vertex] | true } {\(h : heap), (v : [Vertex]), (h' : heap). [h' = h]};
components : ( x_1 : { v : Graph | true }) -> ( x_2 : { v : Forest | true }) ->  State {\(h : heap). true } v : {v : Vertex | true } {\(h : heap), (v : Vertex), (h' : heap). [h' = h]};
scc : ( x_1 : { v : Graph | true }) -> ( x_2 : { v : Forest | true }) ->  State {\(h : heap). true } v : {v : Vertex | true } {\(h : heap), (v : Vertex), (h' : heap). [h' = h]};
bcc : ( x_1 : { v : Graph | true }) -> ( x_2 : { v : Forest | true }) -> State {\(h : heap). true } v : {v : [Vertex] | true } {\(h : heap), (v : [Vertex]), (h' : heap). [h' = h]};
reachable : ( x_1 : { v : Graph | true }) -> ( x_2 : { v : Vertex | true }) -> State {\(h : heap). true } v : {v : [Vertex] | true } {\(h : heap), (v : [Vertex]), (h' : heap). [h' = h]};
path : ( x_1 : { v : Graph | true }) -> ( x_2 : { v : Vertex | true }) -> ( x_3 : { v : Vertex | true }) -> State {\(h : heap). true } v : {v : Bool | true } {\(h : heap), (v : Bool), (h' : heap). [h' = h]};
empty : State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
singleton : ( x_1 : { v : a | true }) -> State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
fromList : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
fromAscList : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
fromDescList : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
fromDistinctAscList : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
fromDistinctDescList : ( x_1 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
powerSet : ( x_1 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : SetofSeta | true } {\(h : heap), (v : SetofSeta), (h' : heap). [h' = h]};
insert : ( x_1 : { v : a | true }) -> ( x_2 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
delete : ( x_1 : { v : a | true }) -> ( x_2 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
member : ( x_1 : { v : a | true }) -> ( x_2 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Bool | true } {\(h : heap), (v : Bool), (h' : heap). [h' = h]};
notMember : ( x_1 : { v : a | true }) -> ( x_2 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Bool | true } {\(h : heap), (v : Bool), (h' : heap). [h' = h]};
null : ( x_1 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Bool | true } {\(h : heap), (v : Bool), (h' : heap). [h' = h]};
size : ( x_1 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Int | true } {\(h : heap), (v : Int), (h' : heap). [h' = h]};
isSubsetOf : ( x_1 : { v : Seta | true }) -> ( x_2 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Bool | true } {\(h : heap), (v : Bool), (h' : heap). [h' = h]};
isProperSubsetOf : ( x_1 : { v : Seta | true }) -> ( x_2 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Bool | true } {\(h : heap), (v : Bool), (h' : heap). [h' = h]};
disjoint : ( x_1 : { v : Seta | true }) -> ( x_2 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Bool | true } {\(h : heap), (v : Bool), (h' : heap). [h' = h]};
union : ( x_1 : { v : Seta | true }) -> ( x_2 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
unions : ( x_1 : { v : [Seta] | true }) -> 
            State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};
difference : ( x_1 : { v : Seta | true }) -> ( x_2 : { v : Seta | true }) -> State {\(h : heap). true } v : {v : Seta | true } {\(h : heap), (v : Seta), (h' : heap). [h' = h]};


goal0 : ( x_1 : { v : a | true }) -> ( x_2 : { v : Bool | true })   -> ( x_3 : { v : [a] | true }) -> State {\(h : heap). true } v : {v : pairlist | true } {\(h : heap), (v : pairlist), (h' : heap). [h' = h]};
goal1 : (l : pairablist) -> a;
goal2 : (x : [int]) -> (p : pair) -> State {\(h : heap). true } v : {v : bool | true } {\(h : heap), (v : bool), (h' : heap). [h' = h]};
goal3 :  (x : Int) -> (l : [a]) ->
State {\(h : heap). true } v : {v : [a] | true } {\(h : heap), (v : [a]), (h' : heap). [h' = h]};