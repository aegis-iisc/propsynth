Source : On the automated verification of web applications with embedded SQL


type code = Cs  | Cu 
NS = {nletter : string; user : string ; subscribed : bool ; code : code ; articles_read : [string]} list


inv dataBaseInv = Inv

subscribe : n : string -> u : string -> 
					State {pre_subscribe}
					v : code 
					{post_subscribe}


unsubscibe : n : string -> u : string -> 
					State {pre_unsubscribe}
					v : code 
					{post_unsubscribe}



change_password : u : string -> 



read : n : string -> u : string -> 
					v : [string]
				Post {} 


confirm : c : code -> 
				State {pre_confirm}
					v : code 
					{post_confirm}



confirm_incorrect : 
			c : code -> 
				State {pre_confirm_inc}
					v : code 
					{post_confirm_inc}




(*user database commands*)

modify_user : u : string 
				State {pre_user}
				v : unit 
				{post_user}	

delete_user : u : string -> State ??


add_user : u : string -> ??


list_user 



(*email*)

change_pwd : 

delete_email : 



synthesize the following program : 

	(*Think of a transaction to read allow a user to allow an article to read and again close the 
		subscription*)
	goal : n : string -> u : string -> d : { v : date | data < today} 
			->  State {not ((n, u \in NS)}
				v : articles list
				{(n, u \in NS) /\ subscribed (n, u)= false /\ articles_read (n, u) = v} 



		 	_ <- add_user u;
		 	_ <- add_nl n u ; 
		 	cs <- subscribe n u;
		 	confirm cs;
		 	change_password u;
		 	read n;
		 	cu <- unsubscribe n u;
		 	confirm cu;













