exception ParserError of string 
open Printf 
open SpecLang
module TypeSpec= RelSpec.TypeSpec 
module Formula = RelSpec.Formula
module TEnv = Environment.TypingEnv 
module ConsEnv = Environment.Constructors


module Printf = struct 
  let printf d s = Printf.printf d ""
  let originalPrint = Printf.printf 
end  
exception LexingError of string 
let load_file f =
  let ic = open_in f in
  let n = (in_channel_length ic) in
  let s = really_input_string ic n in 
  close_in ic;
  (s)

(*Lex and Parse the specification file*)
let lexAndParseLSpec s= 
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
let parseLSpecFile file = 
    let s = load_file file in 
     Printf.printf "%s" s; 
    try
      let ast = lexAndParseLSpec s in            
      ast
    with 
    | e -> raise e


(*Populate the Gamma, Formulas, and Sigma*)
let elaborateEnvs ast = 
 let RelSpec.T {typedefs;typespecs;preds;quals;_} = ast in 
 let gamma = TEnv.empty in
 let sigma = ConsEnv.empty in 
 let gamma  = List.fold_left (fun tmap ts -> let TypeSpec.T{ name;refty;_} = ts in                                      
                               let stringName = Var.toString name in 
                               if (String.length name >= 4) then 
                                  let sub_name = String.sub name 0 4 in 
                                  (if sub_name = "goal" then
                                    tmap 
                                  else
                                    TEnv.add tmap stringName refty
                                  )
                               else 
                                    TEnv.add tmap stringName refty ) gamma typespecs in

 let (typenames, sigma) = List.fold_left 
                              (fun (typenames, sigma) tdef -> 
                                  let Algebraic.TD {typename;constructors} = tdef in 
                                  let rec addToSigma  (consmap:ConsEnv.t) (cons: Algebraic.constructor list) : ConsEnv.t  =
                                    match cons with 
                                      | [] ->  consmap
                                      | x :: xs -> 
                                          let Algebraic.Const {name;args} = x in 
                                          let argTupleTyd = TyD.Ty_tuple args in 
                                          let argsRefTy = RefTy.fromTyD argTupleTyd in

                                          let consBaseType = TyD.Ty_arrow (argTupleTyd, TyD.fromString typename) in 
                                          let consRefType = RefTy.fromTyD consBaseType in 
                                          let consmap = ConsEnv.add consmap name consRefType in 
                                          addToSigma consmap xs 

                                  in    
                                 match constructors with 
                                 | [] -> ((typename :: typenames), sigma)
                                 |  _::_ -> (typenames, (addToSigma sigma constructors))
                                ) ([], sigma) typedefs in  


 let goalTypespecList = List.filter (fun ts -> let TypeSpec.T{name;refty;_} = ts in 
                        if (String.length name >= 4) then 
                          let sub_name = String.sub name 0 4 in 
                          if sub_name = "goal" then true else false
                        else 
                          false) typespecs in 
 let goals = List.map 
                (fun goalTypespec -> 
                let TypeSpec.T{name;refty;_} = goalTypespec in 
                refty) goalTypespecList in 
 (*TODO populate sigma*)
 (gamma, sigma, typenames, quals, goals)

