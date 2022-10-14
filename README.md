# propsynth 
A purely functional, refinement-type guided synthesis for Cobalt.
This takes a pure-function spec, along with a small library (function signatures) and synthesis all possible programs of a given function call length k.
This parameter k can be pass as an argument as follows:
./effsynth.native -cdcl -bi -k 3 tests_specsynth/case4.spec 

# Dependencies:
1. OCaml (Version >= 4.03)
2. Z3 
3. OCamlLex 

# To build:
./build.sh 

# To run:
./effsynth.native [-bi] [-cdcl] [-effect] <path-to-spec-file>

# Example
./effsynth.native -bi -cdcl synth_tests/unit/checked/other_units/u_test3.spec 
./effsynth.native -cdcl -bi -k 3 tests_specsynth/case4.spec 

# Structure
- Type/Specification Language : ./speclang/specLang.ml
- Program/Term Language       : ./synlang/lambdasyn.ml 
- Type-Synthesis Rules 	      : ./synthesis/synthesis.ml
- Tests 		      : ./synth_tests/
- Verification Conditions     : ./typechecking/verificationC.ml
- VCtoZ3 Encoding 	      : ./vcencode/vcencode.ml


