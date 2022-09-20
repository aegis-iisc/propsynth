#!/bin/bash
ocamlbuild -quiet -use-menhir -tag thread -use-ocamlfind -pkg z3 applicativemap.ml vector.ml -I speclang -I specparser -I sigmabuilder -I typechecking -I vcencode  -I synlang -I synthesis main/effsynth.native
