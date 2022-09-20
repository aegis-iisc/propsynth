(*a set of DOM APIs and queries*)
(*source : Verified Security for Browser Extensions*)

(*think of capabilities as a global mutable list 
*)

type elt = string

type capabilities = elt list ref

(*a fragment of DOM API*)

val firstChild: p:elt → {true}
						e:elt
						{EltParent e p}
val getAttr: e:elt → a:string → v:string{EltAttr e a v}
val textContent: e:elt -> {CanRead e} v : list string {\forall x. Elems (v) -> ValueOf e x}

val removeCapability : e : elt -> {CanRead e} v : unit {not CanRead e}

val 

val getChild : p:elt→ int→ r:option elt
	{∀ ch. r=Some ch⇒ EltParent p ch && FlowsFrom r p}

val parentNode: ch:elt → p:elt{EltParent p ch}

val getEltById: d:doc→ x:string→ c:elt{EltDoc c d && EltAttr c ”id” x}

val tagName : ce:elt → r:string{EltTagName ce r}


val requestRead : e:elt -> {not CanRead e} v : unit {CanRead e}

(* Protected access to data *)
val getAttr : e:elt → k:string
				{CanReadAttr e k} →
				 r:string
				 {EltAttr e k r && FlowsFrom r e}

val setAttr : e:elt→ k:string→ v:string →
 {CanWriteAttr e k v}
 	unit
 	{EltAttr e k v}

val getValue : e:elt{CanReadValue e} → s:string{EltTextValue e s}

val createElt : d:doc → t:string → e:elt{EltDoc e d && EltTagName e t && CanEdit e}

val appendChild : p:elt → c:elt -> {CanAppend c p} v : unit
											{EltParent p c}


predicate getWebSitePolicy = 
∀e, p. (EltParent e p && EltTagName p ”div” && EltAttr p ”class” ”website”)
-> CanRead e

predicate canReadChildValue ∀(e:elt), (p:elt). (EltAncestor e p && EltTagName p ”div” &&
CanReadAttr a /\ 
EltAttr p ”class” a) ⇒ CanReadValue e

(*The policy statement above summarizes the behavior
of getWebsite, the part of FacePalm that reads sensitive data out
of a Facebook page. Informally, this policy allows an extension
to read text contained within <div class="website"> elements*)

(*goal1*)
val getWebsite e : elt -> attr : string  -> 
			{true} (x,y) : (elt * string list) {not EltAttr e a y /\ 
													EltAncestor e x 
													\forall z. Elems (y,z) => 
													ValueOf x y
													\/ 
													Empty y} 



 
let getWebsite e attr  =
let b1 = tagName e "div" in 	
let b2 = getAttr e "class" in
if (b1) then 
	if (attr = website) then 
			let fc = firstChild e  
			textContent fc  
			else ""
	else 
		let _ = requestRead e in 
		let fc = firstChild e  
		textContent fc  
			else ""		