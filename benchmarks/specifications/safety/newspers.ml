


(*think each policy as a library 
function which can dynamically grant the permissions the post condition for this function
is the policy conclusion and the preconditions are the policy antecedants*)



type url
type readableFiles = file list ref 
type readableHistory = url list ref
type allowedHost = url list ref
type readUrls = url list ref 
type alloweddomains = dom list ref

predicate CanReadFile :: file => Prop
predicate UrlHost :: url ⇒ string ⇒ Prop
predicate CanRequest :: url ⇒ string ⇒ Prop
predicate CanReadHistory :: string ⇒ Prop




val requestReadFile : f:file -> {mem readableFiles f}
							v : bool  
							{v = true <=> CanReadFile f} 


val requestReadHistory : u : url ->  { mem readableHistory u}
							v : bool 
								{v = true <=> CanReadHistory u} 


val requestRequest : s : string -> u : url -> 
										{FlowsFrom s prefs /\ AllowedHost (UrlHost u)}
										v : bool 
										{v = true <=> CanRequest s u}	

val revokeReadFile : f:file -> {CanReadFile f}
								v : unit 
								{not CanReadFile f} 

val readFile: f:file -> {CanReadFile f} 
							s:string
						{FlowsFrom s f}

val mkUrl: h:string → u:url{UrlHost u h}

val sendRequest: u:url → s:string{CanRequest u s} → 
							resp:resp
							{Stisfy (s, resp)}

val gethistoryOnSite: 
			h:string -> {CanReadHistory h} v : url list 
			{\forall y.
				Elems (y) => mem readableHistory y }

(*some notion of correct parsing*)
val parseResponse: resp →  {true} 
						v : list url {\forall y. Elems (v, y) => ElemsResp (resp, v)}


val munge: digg:list url → history:list url → {\forall y.Elems (y) => mem readableHistory y }
													v : list url
											  {\forall y.Elems (y) 
											    /\ mem y v => not mem history 
											  }	

val nodesInOrder: o:list url → r:elt → list (e:elt{FlowsFrom e r})

(*requires a loop*)
val orderNode : r:elt -> 
				priority: elt list ->{\forall. x Elems (priority, x)
													-> FlowsFrom x r} 
														v : elt  
												{Ordered v}		
(*synthesis query 1*)
val getPopularStories : 
	f : file -> 
	h : string -> 
	u : url ->  {mem allowedHost h}
					(x,y):(resp * url list)
				{\forall z. Elems (y, z) 
								=> ElemsResp (x, v)  )} 

\f h u. 

	if (!canReadFile (f)) then
		if (mem f readableFiles) then 
			_ <- requestReadFile f;
			s = readFile f 
			url = mkUrl h u
			if (!canRequest url s) then 
				_ <- requestRequest url s 
				res = sendRequest url s
				parseResponse res
			else 
				res = sendRequest url s
				parseResponse res	
		else 
			[]		
	else		
		s = readFile f 
		url = mkUrl h u
		if (!canRequest url s) then 
			_ <- requestRequest url s 
			res = sendRequest url s
			parseResponse res
		else 
			res = sendRequest url s
			parseResponse res

(* synthesis query2
reorder all the children of a root with a domain dom *)
val reorder : f : file -> 
			  h : string 
			  r : elt -> 
			  dom : url -> {mem allowedHost h} 
											v : elt
										 {Oredered v}	  


if (domain r = dom ) then
	  let popular = getPopularStories f h dom in
	  (*synthesize the code for allowing 
	  the pre-condition for getHistoryOnSite*)
	  let h = getHistoryOnSite dom in
	  let ordering = munge popular h in
	  (*synthesize the code for allowing 
	  the pre-condition for nodesInOrder*)
	  let nodes = nodesInOrder ordering root in
	  orderNode r nodes 

else 
	()

(*we can have several such queries*)