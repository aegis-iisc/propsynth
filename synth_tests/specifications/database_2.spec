(*Databases
Source : On the automated verification of web applications with embedded SQL
*)

Papers with columns paperId, status, and session. The column status is over the bounded domain
consisting of undecided, accepted, or rejected. The column session ranges over the bounded
domain consisting of null,blank,invited,1,. . .,k;

PaperAuthor with columns userId and paperId;

ReviewerBids with columns userId and paperId;

ReviewerAssignments with columns userId and paperId;

Conflicts with columns userId and paperId



bid : usr : string -> paper : id -> State 


assign : 


display1_incorrect :

requires
forall x y (ReviewerBids(x,y) -> ~ Conflicts(x,y)) &&
forall x y (ReviewerAssignments(x,y) -> ~ Conflicts(x,y)) &&
forall x y (Out(x,y) <-> exists z w (Papers(x, z, w, y) & Authors(currentUser, x)))

UPDATE Out SET b0 = 0:5 WHERE /* b0 = 2:5 OR */ b0 = 3:5 OR b0 = 4:5;

ensures
forall x y (ReviewerBids(x,y) -> ~ Conflicts(x,y)) &&
forall x y (ReviewerAssignments(x,y) -> ~ Conflicts(x,y)) &&
forall title session (Out(title,session) -> (session = blank || session = invited || null ))


display2 : 

requires
forall x y (ReviewerBids(x,y) -> ~ Conflicts(x,y)) &&
forall x y (ReviewerAssignments(x,y) -> ~ Conflicts(x,y)) &&
forall x y (Out(x,y) <-> exists z w (Papers(x, z, w, y) & Authors(currentUser, x)))

UPDATE Out SET b0 = 0:5 WHERE b0 = 2:5 OR b0 = 3:5 OR b0 = 4:5;

ensures
forall x y (ReviewerBids(x,y) -> ~ Conflicts(x,y)) &&
forall x y (ReviewerAssignments(x,y) -> ~ Conflicts(x,y)) &&
forall title session (Out(title,session) -> (session = blank || session = invited || null))


goal : 

Invariants : 
Inv1 = ∀x y ReviewerBids(x,y) → ~Conflicts(x,y)
Inv2 = ∀D x ∀Dy ReviewerAssignments(x,y) → ~Conflicts(x,y)

pre 
forall p \in Paper. Paper (p, status) = undecided /\ Paper (p, session) = (invited || null) 

v : unit 

(*every paper is assigned to someone
 NO_CONFLICT given by the Inv1 and Inv2*)



