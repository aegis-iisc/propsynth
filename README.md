# effsynth 

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

# Structure
- Type/Specification Language : ./speclang/specLang.ml
- Program/Term Language       : ./synlang/lambdasyn.ml 
- Type-Synthesis Rules 	      : ./synthesis/synthesis.ml
- Tests 		      : ./synth_tests/
- Verification Conditions     : ./typechecking/verificationC.ml
- VCtoZ3 Encoding 	      : ./vcencode/vcencode.ml


