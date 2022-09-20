(*provide dom related properties
Src : Verified Security for Browser Extensions

*)


(APIs)
val tagName: e:elt →t:string{EltTagName e t} 

val firstChild: p:elt →e:elt{EltParent e p} 

val getAttr: e:elt →a:string →v:string{EltAttr e a v} 

val textContent: e:elt{CanRead e} →string


(Refined APIs)







prop EltAncestor :: elt ⇒ elt ⇒ Prop 
assume ∀e1, e2. EltParent e1 e2 ⇒ EltAncestor e1 e2 

assume ∀e1, e2, e3. EltParent e1 e2 && EltParent e2 e3 ⇒ EltAncestor e1 e3 

assume ∀(e:elt). CanReadAttr e ‘‘class’’ 

assume ∀(e:elt), (p:elt). (EltAncestor e p && EltTagName p ”div” && 
EltAttr p ”class” ”website”) ⇒ CanReadValue e


7let extensionCode e = 
8 let t = tagName e ‘‘div’’ in 
9 let a = getAttr e ‘‘class’’ in
10 if t = "div" && a = "website" 
11 then match getChild e 0 with 
12∣ Some c →Some (getValue c)
13∣ None →None
14 else None Lines




All the example for the security of DOM libraries have the following form:
A Policy P defining as axioms what priviledges are allowed to the extension.
A set of APIs, have pre and post priviledge requirements and updates to the Global set of predicates in a Log (L)of true facts (Think as an environment)


Typechecking :: 

P |- (L, e) Safe



This does allow, rejecting incorrect programs w.r.t P and L while searching,
 but will not able to guide the synthesis process as required by our approach.


(*Here in English the functional specification for a NewsPers extension using APIs *)

1) When the user browses to nytimes.com, NewsPers reads a configuration file on the local file system, that specifies a user’s news preferences.
2) It sends data from this preferences file to digg.com, a social news website, and obtains a response that lists currently popular stories.
3) It consults the user’s browsing history to determine which of these popular stories on nytimes.com have not been read before by the user.
4) Finally, it re-arranges the nytimes.com page, placing unread popular stories towards the top




(*Policy in English*)

For this extension, we aim to enforce a policy that ensures
1) that digg.com only obtains data from the configuration file, and 

2) that no information about browsing history is leaked to nytimes.com (in addition to what it may already know). 



These are capability based systems 
