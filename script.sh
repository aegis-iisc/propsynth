ocamlbuild -use-menhir -tag thread -use-ocamlfind -pkg z3 applicativemap.ml vector.ml specLang.ml typedTransLang.ml  transTypeChecker.ml -I vcencode -I specparser main/morpheus.native 

camlbuild -use-menhir -tag thread -use-ocamlfind -pkg z3 applicativemap.ml vector.ml -I speclang -I specparser -I sigmabuilder -I translang -I typing -I vcencode  main/morpheus.native 

-- for effsynth building 
ocamlbuild -use-menhir -tag thread -use-ocamlfind -pkg z3 applicativemap.ml vector.ml -I speclang -I specparser -I sigmabuilder  -I translang -I typing -I vcencode -I synthesis main/effsynth.native


-- latest 
 ocamlbuild -use-menhir -tag thread -use-ocamlfind -pkg z3 applicativemap.ml vector.ml -I speclang -I specparser -I sigmabuilder -I typechecking -I vcencode  -I synlang -I synthesis main/effsynth.native

