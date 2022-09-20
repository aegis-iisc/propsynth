exception ParserError of string 
open Printf 
open SpecLang

exception LexingError of string 
let load_file f =
  let ic = open_in f in
  let n = (in_channel_length ic) in
  let s = really_input_string ic n in 
  close_in ic;
  (s)


let lex_and_parse s= 
  
    
    let lexbuf = 
      try 
      Lexing.from_string s  
      with 
      | _ -> raise (ParserError "Error in Lexing ")
    in   
    let v = Lexing.lexeme lexbuf in 
    
    let ast = 
      try 
       SpecParser.start SpecLexer.token lexbuf 
      with 
      | e -> raise (e) 
    in
    ast 

  (* print the ast*)
  
let lex_and_parse_file file = 
    let s = load_file file in 
     Printf.printf "%s" s; 
     try
      let ast = lex_and_parse s in            
    ast
    with 
    | e -> raise e
(* 
let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    while true do
      let result = SpecParser.start SpecLexer.token lexbuf in
      let resStr = RelSpec.toString result in
      Printf.printf "%s" (resStr);
      print_newline(); 
      flush stdout  
    done
  with 
  | e ->
    raise e 
 *)

