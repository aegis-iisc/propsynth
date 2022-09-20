Src : Paper : Maintaining Database Integrity with Refinement Types




We can define Inductive Specification 

Note : This is not very useful as the number of menthods are small.
I {txn} I

a schema of database as refinement types capturing inductive integrity constraints I.
there are pre-packeged set of methods with annotated pre- and post conditions like 

val checkMarriage : r:marriage row →[(s)] b:bool [(s’)(s = s’ ∧b = true ⇒CK Marriage(r))]

val hasKeyMarriage : k:(int ×int) →[(s)] b:bool [(s’)(

val deleteMarriagePK :


val insertMarriageRowi :

Also define 





4. We try to synthesize database programs (transactions) againts I and other pre- post conditions:


Eg. transaction:
let divorce_ref (A,B) =
if hasKeyMarriage(A, B) then
	deleteMarriagePK(A, B);
	deleteMarriagePK(B, A);
	Some(true)
	
	else 
	Some(false



Spec : 
val divorce ref: (int×int) →
{(s) FK Constraints(s)} 
	r:bool option {(t) r !=None ⇒FK Constraints(t)}