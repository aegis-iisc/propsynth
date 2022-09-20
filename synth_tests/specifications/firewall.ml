
(*database a record of {fields:value}*)
type dID = {devid : int} list ref

type cSend = {senderid : int ; receiverid : int} list ref

predicate Invfirewall = ∃x (Device(x) ∧ ∀y(Device(y) → CanSend(y, x)))

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


goal_pure : d : int -> s: int list ->  {true} 
									v : int 
		 							{true}

(*safety remove d and add s to the list maintaining the Inv*)
goal1 : d : int -> s: int list ->  {Device (d)} 
									v : int 
								  {∀y. Elems (s, y) => 
														Device (y) 
												/\ not (Device (d))}				 


(*given a list of devices, remove them from the dID and cSend maintaining the 
inv and return the central element*)
goal2 : s : int list -> {true} 
						v : int  
						{∀y. Elems (s, y) => 
							not Device (y) 
						/\ (Device (v)) /\ ∀z. (Device(z) → (CanSend(y, v)) }				 

