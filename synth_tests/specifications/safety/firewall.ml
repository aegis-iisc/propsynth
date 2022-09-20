
(*database a record of {fields:value}*)
type dID = {devid : int} list ref

type cSend = {senderid : int ; receiverid : int} list ref

predicate Invfirewall = ∃x (Device(x) ∧ ∀y(Device(y) → CanSend(y, x)))
predicate device : int :-> bool 
predicate dsize : [int] :-> int 


(*adds the devId to dID table*)
add_device : d :  int -> state {not Device (d)} v : unit {Device (d)}


is_device : d : int -> state {true} v : bool {[true => Device (d)]/\ [false => not Device (d)]} 


diff_device : d : int -> state {DSize (d) > 1} v : int {Device (v) 
													/\ not (d = v)}

add_connection :  s : int -> r : int -> state {Device (s) /\ Device (r)}
												v : unit
											  {CanSend (s, r)}			
add_senders : r : int -> s : int list ->  
									state {Device (r)}
											v : unit
										{∀y. Elems (s) -> Device (y) /\
											 CanSend (y, r)}					

make_central : d : int ->  state {Device (d)} v : unit {∀y(Device(y) → CanSend(y, d))}


find_central : unit -> {v : int | ∀y(Device(y) → CanSend(y, v)}

delete_device : d : int -> state {∃x ((x != d) ∧ 
									Device(x) ∧ ∀y(Device(y) → CanSend(y, x)))}
									v : unit
								 {not (Device (d) /\ ∀y(Device(y) → not (CanSend(y, d)))}		 

delete_devices : d : [int] -> state {∃x ((x != d) ∧ 
									Device(x) ∧ ∀y(Device(y) → CanSend(y, x)))}
									v : unit
								 {not (Device (d) /\ ∀y(Device(y) → not (CanSend(y, d)))}		 



goal_pure : d : int -> s: int list ->  {true} 
									v : int 
		 							{true}

(*safety remove d and add s to the list maintaining the Inv*)
query1 : d : int -> s: int list ->  {Device (d)} 
									v : int 
								  {∀y. Elems (s, y) => 
														Device (y) 
												/\ not (Device (d))}				 


(*given a list of devices, remove them from the dID and cSend maintaining the 
inv *)
query2 : s : int list -> {true} 
						v : unit  
						{∀y. Elems (s, y) => 
							not Device (y) 
						/\ (Device (v)) /\ ∀z. (Device(z) → (CanSend(y, v)) }				 


(*given a list of devices, remove them from the dID and cSend maintaining the 
inv and return the central element*)
query3 : s : int list -> {true} 
						v : int  
						{∀y. Elems (s, y) => 
							not Device (y) 
						/\ (Device (v)) /\ ∀z. (Device(z) → (CanSend(y, v)) }				 


(*add a device if not present and make it central , if present remove all the devices connexted 
which can send to it, then add and make the new device central
requires, the Predicates over pre and post.
*)

query3 : d : int -> {true} 
						v : int  
					{∀z. Device_pre(z) /\ CanSend_pre (z, d) => not (Device (z)) 
						∀y. Device (y) => CanSend (y,v) 
						/\ (Device (v)) /\ ∀z. (Device(z) → (CanSend(y, v)) }				 

