exception EX of string
let rec n_cartesian_product = function
    | [] -> [[]]
    | x :: xs ->
        let rest = n_cartesian_product xs in
        List.concat (List.map (fun i -> List.map (fun rs -> i :: rs) rest) x) 



let () = 
    let num_args = (Array.length Sys.argv) - 1 in 
    if num_args = 1 
    then  
    let spec_file = Sys.argv.(1) in 
    let _ = Printf.printf "%s" ("\nspecfile :: "^spec_file) in 
    let rel_ast = elaborateSMLWithSpec spec_file in 
    let string_ast = RelSpec.toString rel_ast in 
    let (e1, e2) = SB.buildSigma rel_ast in 
    		Printf.printf "%s" string_ast;
      Printf.printf "%s" "Parsing specs done";  
     
    (*run the initial environment builder*)    
     
   
  else
    let exception_msg = (" Incorrect Number of argumnets, required 1, provided "^(string_of_int num_args)^" Usage :: ./compile.native <path_to_ml_file> <path_to_spec_file>") in  
    raise (CompilerEx  exception_msg)
 
  