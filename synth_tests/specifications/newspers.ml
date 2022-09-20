


(*think each policy as a library 
function which can dynamically grant the permissions the post condition for this function
is the policy conclusion and the preconditions are the policy antecedants*)



type url
type readableFiles = file list ref 
type readableHistory = url list ref
type allowedHost = url list ref
type readUrls = url list ref 

predicate CanReadFile :: file => Prop
predicate UrlHost :: url ⇒ string ⇒ Prop
predicate CanRequest :: url ⇒ string ⇒ Prop
predicate CanReadHistory :: string ⇒ Prop




val requestReadFile : f:file -> {not CanReadFile f /\ Readable f}
							v : unit {CanReadFile f} 


val requestReadHistory : u : url ->  {not CanReadHistory u /\ ReadableHistory u}
							v : unit {CanReadHistory u} 


val requestRequest : s : string -> u : url -> 
										{FlowsFrom s prefs /\ AllowedHost (UrlHost u)}
										v : unit 
										{CanRequest s u}	

val revokeReadFile : f:file -> {CanReadFile f}v : unit {not CanReadFile f} 

val readFile: f:file -> {CanReadFile f} 
							s:string
						{FlowsFrom s f}

val mkUrl: h:string → u:url{UrlHost u h}

val sendRequest: u:url → s:string{CanRequest u s} → resp:resp
val historyOnSite: host:string -> {CanReadHistory h} url list {true}

val parseResponse: response → list url


val munge: digg:list url → history:list url → list url
val nodesInOrder: o:list url → r:elt → list (e:elt{FlowsFrom e r})

val orderNode : r:elt -> priority: elt list -> {\forall. x Elems (priority, x)
													-> FlowsFrom x r} 
														url list 
												{Ordered v}		
(*synthesis query 1*)
val getPopularStories : 
	f : file -> h : string -> u : url ->  url list 

\f h u. 

	if (!canReadFile (f)) then
		_ <- requestReadFile f;
		s = readFile f 
		url = mkUrl allowedhost allowedurl
		if (!canRequest url s) then 
			_ <- requestRequest url s 
			res = sendRequest url s
			parseResponse res
		else 
			res = sendRequest url s
			parseResponse res	
	else		
		s = readFile f 
		url = mkUrl allowedhost allowedurl
		if (!canRequest url s) then 
			_ <- requestRequest url s 
			res = sendRequest url s
			parseResponse res
		else 
			res = sendRequest url s
			parseResponse res

(* synthesis query 2
reorder all the children of a root with a domain dom *)
val reorder : r : elt -> dom : domain -> {true} 
											v : url list
										 {Oredered v}	  



