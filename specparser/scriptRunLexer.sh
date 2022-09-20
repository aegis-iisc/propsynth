#/bin/sh
cp specLexermll.bkp specLexer.mll
ocamllex specLexer.mll
cp specLexer.mll specLexermll.bkp
rm specLexer.mll
