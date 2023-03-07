# Propsynth 
A purely functional, refinement-type guided synthesis for [Cobalt](https://dl.acm.org/doi/abs/10.1145/3563310).
This takes a pure-function spec, along with a small library (function signatures) and synthesis all possible programs of a given function call length k and given nested depth.

This parameter k and nested depths can be can be pass as an argument as follows:
./effsynth.native -cdcl -bi -k 3 nested 3 tests_specsynth/case4.spec 

### Building Cobalt from Source:
We have successfully tried building Cobalt on Linux (Ubuntu 16.04) and Mac(macOs Monterey). We discuss the instructions for the Ubuntu build and running.

 ### Prerequisites:
To build Cobalt following dependencies must be installed:

*  [OCaml]() (Version >= 4.03)

```
#install opam
$ apt-get install opam

#environment setup
$ opam init
$ eval `opam env`

# install a specific version of the OCaml base compiler
$ opam switch create 4.03
$ eval `opam env`

# check OCaml installation
$ which ocaml
/Users/.../.opam/4.03.0/bin/ocaml

$ ocaml -version
The OCaml toplevel, version >= 4.03.0
```

*  [Z3 SMT Solver](https://github.com/Z3Prover/z3)
```
$ opam install "z3>=4.7.1"
$ eval $(opam env)
```

*  Menhir for parsing the specification language
```
$ opam install menhir
$ eval $(opam env)
```

*  [OCamlbuild](https://github.com/ocaml/ocamlbuild/) version >= 0.12
```
$ opam install "ocamlbuild>=0.12"
$ eval $(opam env)
```

To Run the Evaluations.

*  [Python3](https://www.python.org/download/releases/3.0/)
```
$ apt-get install python3
```

### Building Cobalt

After all the dependencies are installed, Cobalt can be directly built using *ocamlbuild* using the script `build.sh` in the project root directory.

```

$ ./build.sh

```

The above build script will create a native executable `effsynth.native` in the project's root directory

### test: Test Running Cobalt

Cobalt takes the following arguments: 
```
$ ./effsynth.native [-cdcl] [-bi] [-k *default 3*] [-nested *default 1*] <path_to_specfile>

$ ./effsynth.native -cdcl -bi -k 5 tests_specsynth/ulist_quant.spec

```
 This should produce a list of synthesized programs in 
`output/tests_specsynth/ulist_quant.spec` directory.

### Generating Poirot benchmarks:
The 5 benchmarks in `Table2` in Poirot[https://github.com/zhezhouzz/underapproximation_type.git] are in `test_specsynth/Poirot_benchmaks` directory.

Run the following command to generate the programs used in Poirot for UniqueList: 

```
$ ./effsynth.native -cdcl -bi -k 5 tests_specsynth/Poirot_benchmarks/Poirot_uniquelist.spec
```
This will generate a file `output/tests_specsynth/Poirot_benchmaks/Poirot_uniquelist.spec` containing the required programs.

Similarly following commands for different benchmarks:
```
$ ./effsynth.native -cdcl -bi -k 4 -nested 3 tests_specsynth/Poirot_benchmarks/Poirot_sizedlist.spec
$ ./effsynth.native -cdcl -bi -k 4 -nested 2 tests_specsynth/Poirot_benchmarks/Poirot_sortedlist.spec
$ ./effsynth.native -cdcl -bi -k 4 -nested 3 tests_specsynth/Poirot_benchmarks/Poirot_sizedbst.spec
...
```

