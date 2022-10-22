
  EXPLORED Args.parser output 
 EXPLORED learningOn  true
 EXPLORED bidirectionality  true
 EXPLORED effect-filter  false
 EXPLORED specfile :: tests_specsynth/case4.spec
 EXPLORED goal Number :: 0
 EXPLORED Max path length :: 3stexcwhitespace var: slen
whitespace colon
whitespace var: list
whitespace colon
whitespace var: int
semicolon
var: subs
whitespace colon
whitespace lparen
var: n1
whitespace colon
whitespace var: int
rparen
whitespace arrow
whitespace lcurly
var: v
whitespace colon
whitespace var: int
whitespace pipe
whitespace var: v
whitespace equalopwhitespace var: n1
whitespace ar-minuswhitespace int: 1
rcurly
semicolon
var: nil
whitespace colon
whitespace lcurly
var: v
whitespace colon
whitespace var: list
whitespace pipe
whitespace var: slen
whitespace lparen
var: v
rparen
whitespace equalopwhitespace int: 0
rcurly
semicolon
var: int_gen
whitespace colon
whitespace var: int
semicolon
whitespace var: sizecheck
whitespace colon
whitespace lparen
var: s
whitespace colon
whitespace var: int
rparen
whitespace arrow
whitespace whitespace lcurly
var: v
whitespace colon
whitespace var: bool
whitespace pipe
whitespace lbrace
var: v
equaloptruerbrace
whitespace iffwhitespace lbrace
var: s
equalopint: 0
rbrace
whitespace conjwhitespace lbrace
var: v
equalopfalserbrace
whitespace iffwhitespace lbrace
var: s
whitespace lessthanopwhitespace int: 0
rbrace
rcurly
semicolon
var: cons
whitespace colon
whitespace lparen
var: x
whitespace colon
whitespace var: int
rparen
whitespace arrow
whitespace lparen
var: xs
whitespace colon
whitespace var: list
rparen
whitespace arrow
whitespace lcurly
var: v
whitespace colon
whitespace var: list
whitespace pipe
whitespace var: slen
lparen
var: v
rparen
whitespace equalopwhitespace var: slen
whitespace lparen
var: xs
rparen
whitespace pluswhitespace int: 1
rcurly
semicolon
whitespace var: goal
whitespace colon
whitespace lparen
var: s
whitespace colon
whitespace lcurly
var: v
whitespace colon
whitespace var: int
whitespace pipe
whitespace truercurly
rparen
whitespace arrow
whitespace lcurly
var: v
whitespace colon
whitespace var: list
whitespace pipe
whitespace var: slen
whitespace lparen
var: v
rparen
whitespace equalopwhitespace var: s
rcurly
semicolon
RelSpec {  SRs ;  PRs ;  TSs  
 Assume false
 name subs : 
 params :
 Type  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))} 
 Assume false
 name nil : 
 params :
 Type {v:Ty_alphalist | (slen)(v) ==(0)} 
 Assume false
 name int_gen : 
 params :
 Type {var_v1:Ty_int | true} 
 Assume false
 name sizecheck : 
 params :
 Type  Arrow ( ( s : {var_v2:Ty_int | true} ) -> {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 v = false
  s > 0 >c } 
 Assume false
 name cons : 
 params :
 Type  Arrow ( ( x : {var_v3:Ty_int | true} ) ->  Arrow ( ( xs : {var_v4:Ty_alphalist | true} ) -> {v:Ty_alphalist | (slen)(v) ==((slen)(xs) + (1))} 
 Assume false
 name goal : 
 params :
 Type  Arrow ( ( s : {v:Ty_int | true} ) -> {v:Ty_alphalist | (slen)(v) ==(s)};  Formulas  }
 INITIAL GAMMA 
 
 goal :  Arrow ( ( s : {v:Ty_int | true} ) -> {v:Ty_alphalist | (slen)(v) ==(s)}
 cons :  Arrow ( ( x : {var_v3:Ty_int | true} ) ->  Arrow ( ( xs : {var_v4:Ty_alphalist | true} ) -> {v:Ty_alphalist | (slen)(v) ==((slen)(xs) + (1))}
 sizecheck :  Arrow ( ( s : {var_v2:Ty_int | true} ) -> {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 v = false
  s > 0 >c }
 int_gen : {var_v1:Ty_int | true}
 nil : {v:Ty_alphalist | (slen)(v) ==(0)}
 subs :  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))}
 INITIAL SIGMA 
 
 TypeNames 
 
 Qualifiers 
 
 Qual slen :  :-> Ty_alphalist :-> Ty_int
 Show ***********Calling S-FUNC synthesize***************
 Show Uncurried , s:{v:Ty_int | true} -> {v:Ty_alphalist | (slen)(v) ==(s)}
 Decreasing Measure s
 Decreasing Type {v:Ty_int | true}
 Calculated Decreasing Predicate s > v
 Calculated Decreased Goal Type  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c } ) -> {v:Ty_alphalist | (slen)(v) ==(s1)}
 Show Trying :: Top-level Match
 Show :: Synthesize Match {v:Ty_alphalist | (slen)(v) ==(s)}
 Show :: List Ty_int
 Show :: Non List Case
 Match-case failed :: Try Top-level If-then-else 
 **********************************************
 iSynthesize If-THEN-ELSE {v:Ty_alphalist | (slen)(v) ==(s)}
 **********************************************
 iSynthesize Boolean {var_v5:Ty_bool | true}
 esynthesizeScalar for {var_v5:Ty_bool | true}
  Enumeration for 
 spec 
 {var_v5:Ty_bool | true}
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 sizecheck
 ############################################################
  Synthesizing the Function application Pure Component sizecheck
 ############################################################
  *************** Trying Arrow Component ************sizecheck :  Arrow ( ( s : {var_v2:Ty_int | true} ) -> {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 v = false
  s > 0 >c }
  *************** Synthesizing Args ei : ti for ************sizecheck
 ##################################################################################
  Synthesizing the 1th argument for Function sizecheck
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v0:Ty_int | true}
  Enumeration for 
 spec 
 {var_v0:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for subs 2
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI int_gen
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Typechecking the Term apply subs  (, s )
 Against {var_v2:Ty_int | true}
 Argument s :: {v:Ty_int | true} | true
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_int | (v) ==((s) -- (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv0 = apply subs  (, s )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Case : f (ei) Case subs int_gen
 Finding Already seen tree for apply subs  (, int_gen )
 Typechecking the Term apply subs  (, int_gen )
 Against {var_v2:Ty_int | true}
 Argument int_gen :: {var_v1:Ty_int | true} | true
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_int | (v) ==((int_gen) -- (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv1 = apply subs  (, int_gen )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for sizecheck 4
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI int_gen
 Possible Arg Options 
 EI _lbv1
 Possible Arg Options 
 EI _lbv0
 Apply Single Argument Case : f (ei) Case sizecheck
  Case : f (ei) Case sizecheck s
 Finding Already seen tree for apply sizecheck  (, s )
 Typechecking the Term apply sizecheck  (, s )
 Against {var_v5:Ty_bool | true}
 Argument s :: {v:Ty_int | true} | true
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 v = false
  s > 0 >c }
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv2 = apply sizecheck  (, s )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Case : f (ei) Case sizecheck int_gen
 Finding Already seen tree for apply sizecheck  (, int_gen )
 Typechecking the Term apply sizecheck  (, int_gen )
 Against {var_v5:Ty_bool | true}
 Argument int_gen :: {var_v1:Ty_int | true} | true
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c int_gen = 0
 	 , DoubleImpl 
 v = false
  int_gen > 0 >c }
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv3 = apply sizecheck  (, int_gen )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Case : f (ei) Case sizecheck _lbv1
 Finding Already seen tree for apply sizecheck  (, _lbv1 )
 Typechecking the Term apply sizecheck  (, _lbv1 )
 Against {var_v5:Ty_bool | true}
 Argument _lbv1 :: {v:Ty_int | (v) ==((int_gen) -- (1))} | (_lbv1) ==((int_gen) -- (1))
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c _lbv1 = 0
 	 , DoubleImpl 
 v = false
  _lbv1 > 0 >c }
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv4 = apply sizecheck  (, _lbv1 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Case : f (ei) Case sizecheck _lbv0
 Finding Already seen tree for apply sizecheck  (, _lbv0 )
 Typechecking the Term apply sizecheck  (, _lbv0 )
 Against {var_v5:Ty_bool | true}
 Argument _lbv0 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv0) ==((s) -- (1))
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c _lbv0 = 0
 	 , DoubleImpl 
 v = false
  _lbv0 > 0 >c }
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv5 = apply sizecheck  (, _lbv0 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard apply sizecheck  (, apply subs  (, s ) )
  *********************Synthesizing the True branch*******************
 Show :: True Predicate 
 	 Conj <c var_v6 = true
 	 , DoubleImpl 
 var_v6 = true
  
 	 Conj <c _lbv0 = 0
 	 , DoubleImpl 
 var_v6 = false
  _lbv0 > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | (slen)(v) ==(s)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (slen)(v) ==(s)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | (slen)(v) ==(0)}                                                                                                                                                
# of Final Z3 expressions 24
 Final solver 
 (declare-sort T13 0)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun slen (T13) Int)
(declare-fun nil () T13)
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen nil) 0))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen nil) 0))
(assert (not (= (slen nil) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 goal, 
 cons
 ############################################################
  Synthesizing the Function application Pure Component goal
 ############################################################
  *************** Trying Arrow Component ************goal :  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c } ) -> {v:Ty_alphalist | (slen)(v) ==(s1)}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}                                                                                                                                                     
# of Final Z3 expressions 23
 Final solver 
 (declare-sort T16 0)
(declare-fun slen (T16) Int)
(declare-fun nil () T16)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (not (> s int_gen)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}                                                                                                                                                     
# of Final Z3 expressions 23
 Final solver 
 (declare-sort T20 0)
(declare-fun slen (T20) Int)
(declare-fun nil () T20)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (not (> s s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}                                                                                                                                                     
# of Final Z3 expressions 24
 Final solver 
 (declare-sort T24 0)
(declare-fun slen (T24) Int)
(declare-fun nil () T24)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (not (> s _lbv0)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}                                                                                                                                                     
# of Final Z3 expressions 24
 Final solver 
 (declare-sort T28 0)
(declare-fun slen (T28) Int)
(declare-fun nil () T28)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun int_gen () Int)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (not (> s _lbv1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 FaileD the subtype check T_vi <: T_goal
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v0:Ty_int | true}
  Enumeration for 
 spec 
 {var_v0:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}
 ################################################
 Skipping Variable _lbv1 As Outer Function Call is subs
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for subs 2
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI int_gen
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Found _lbv0
  Case : f (ei) Case subs int_gen
 Finding Already seen tree for apply subs  (, int_gen )
 Found _lbv1
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 3
 Possible Arg Options 
 EI _lbv0
 Possible Arg Options 
 EI _lbv1
 Possible Arg Options 
 EI _lbv0
 Apply Single Argument Case : f (ei) Case goal
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Typechecking the Term apply goal  (, _lbv0 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv0 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv0) ==((s) -- (1))                                                                                                                                                
# of Final Z3 expressions 26
 Final solver 
 (declare-sort T34 0)
(declare-fun slen (T34) Int)
(declare-fun nil () T34)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun v () T34)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen v) _lbv0))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= (slen v) _lbv0))
(assert (not (= (slen v) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv0 )
  Case : f (ei) Case goal _lbv1
 Finding Already seen tree for apply goal  (, _lbv1 )
 Typechecking the Term apply goal  (, _lbv1 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((int_gen) -- (1))} | (_lbv1) ==((int_gen) -- (1))                                                                                                                                                
# of Final Z3 expressions 26
 Final solver 
 (declare-sort T38 0)
(declare-fun slen (T38) Int)
(declare-fun nil () T38)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun v () T38)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen v) _lbv1))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= (slen v) _lbv1))
(assert (not (= (slen v) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 )
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Typechecking the Term apply goal  (, _lbv0 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv0 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv0) ==((s) -- (1))                                                                                                                                                
# of Final Z3 expressions 26
 Final solver 
 (declare-sort T42 0)
(declare-fun slen (T42) Int)
(declare-fun nil () T42)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun v () T42)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen v) _lbv0))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= (slen v) _lbv0))
(assert (not (= (slen v) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv0 )
  ###################################################
  The Choice of Function goal Was Ill Fated Try Next Choice of function
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v3:Ty_int | true} ) ->  Arrow ( ( xs : {var_v4:Ty_alphalist | true} ) -> {v:Ty_alphalist | (slen)(v) ==((slen)(xs) + (1))}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v3:Ty_int | true}
  Enumeration for 
 spec 
 {var_v3:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v0:Ty_int | true}
  Enumeration for 
 spec 
 {var_v0:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}
 ################################################
 Skipping Variable _lbv1 As Outer Function Call is subs
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for subs 2
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI int_gen
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Found _lbv0
  Case : f (ei) Case subs int_gen
 Finding Already seen tree for apply subs  (, int_gen )
 Found _lbv1
 ##################################################################################
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v4:Ty_alphalist | true}
  Enumeration for 
 spec 
 {var_v4:Ty_alphalist | true}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | (slen)(v) ==(0)}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 goal, 
 cons
 ############################################################
  Synthesizing the Function application Pure Component goal
 ############################################################
  *************** Trying Arrow Component ************goal :  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c } ) -> {v:Ty_alphalist | (slen)(v) ==(s1)}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}                                                                                                                                                     
# of Final Z3 expressions 23
 Final solver 
 (declare-sort T53 0)
(declare-fun slen (T53) Int)
(declare-fun nil () T53)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (not (> s int_gen)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}                                                                                                                                                     
# of Final Z3 expressions 23
 Final solver 
 (declare-sort T57 0)
(declare-fun slen (T57) Int)
(declare-fun nil () T57)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (not (> s s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}                                                                                                                                                     
# of Final Z3 expressions 24
 Final solver 
 (declare-sort T61 0)
(declare-fun slen (T61) Int)
(declare-fun nil () T61)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (not (> s _lbv0)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}                                                                                                                                                     
# of Final Z3 expressions 24
 Final solver 
 (declare-sort T65 0)
(declare-fun slen (T65) Int)
(declare-fun nil () T65)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun int_gen () Int)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (not (> s _lbv1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 FaileD the subtype check T_vi <: T_goal
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 1
 Possible Arg Options 
 EI _lbv0
 Apply Single Argument Case : f (ei) Case goal
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Typechecking the Term apply goal  (, _lbv0 )
 Against {var_v4:Ty_alphalist | true}
 Argument _lbv0 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv0) ==((s) -- (1))
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_alphalist | (slen)(v) ==(_lbv0)}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv6 = apply goal  (, _lbv0 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for cons 12
 Possible Arg Options 
 EI _lbv1
 EI nil
 Possible Arg Options 
 EI _lbv1
 EI _lbv6
 Possible Arg Options 
 EI _lbv0
 EI nil
 Possible Arg Options 
 EI _lbv0
 EI _lbv6
 Possible Arg Options 
 EI s
 EI nil
 Possible Arg Options 
 EI s
 EI _lbv6
 Possible Arg Options 
 EI int_gen
 EI nil
 Possible Arg Options 
 EI int_gen
 EI _lbv6
 Possible Arg Options 
 EI _lbv1
 EI nil
 Possible Arg Options 
 EI _lbv1
 EI _lbv6
 Possible Arg Options 
 EI _lbv0
 EI nil
 Possible Arg Options 
 EI _lbv0
 EI _lbv6
 Show f (ei, e2, ....en) Case
 Finding Already seen tree for apply cons  (, _lbv1 ), nil )
 Typechecking apply cons  (, apply subs  (, int_gen ) ), nil )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Typechecking the Term apply cons  (, _lbv1 ), nil )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((int_gen) -- (1))} | (_lbv1) ==((int_gen) -- (1))
 Argument nil :: {v:Ty_alphalist | (slen)(v) ==(0)} | (slen)(nil) ==(0)                                                                                                                                                
# of Final Z3 expressions 28
 Final solver 
 (declare-sort T70 0)
(declare-fun slen (T70) Int)
(declare-fun nil () T70)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun _lbv6 () T70)
(declare-fun v () T70)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen v) (+ (slen nil) 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= (slen nil) 0))
(assert (= (slen v) (+ (slen nil) 1)))
(assert (not (= (slen v) s)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_alphalist | (slen)(v) ==((slen)(nil) + (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv7 = apply cons  (, _lbv1 ), nil )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Finding Already seen tree for apply cons  (, _lbv1 ), _lbv6 )
 Typechecking apply cons  (, apply subs  (, int_gen ) ), apply goal  (, apply subs  (, s ) ) )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Typechecking the Term apply cons  (, _lbv1 ), _lbv6 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((int_gen) -- (1))} | (_lbv1) ==((int_gen) -- (1))
 Argument _lbv6 :: {v:Ty_alphalist | (slen)(v) ==(_lbv0)} | (slen)(_lbv6) ==(_lbv0)                                                                                                                                                
# of Final Z3 expressions 29
 Final solver 
 (declare-sort T74 0)
(declare-fun slen (T74) Int)
(declare-fun nil () T74)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun _lbv6 () T74)
(declare-fun _lbv7 () T74)
(declare-fun v () T74)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen _lbv7) (+ (slen nil) 1)))
(assert (= (slen v) (+ (slen _lbv6) 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen v) (+ (slen _lbv6) 1)))
(assert (not (= (slen v) s)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_alphalist | (slen)(v) ==((slen)(_lbv6) + (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv8 = apply cons  (, _lbv1 ), _lbv6 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Finding Already seen tree for apply cons  (, _lbv0 ), nil )
 Typechecking apply cons  (, apply subs  (, s ) ), nil )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Typechecking the Term apply cons  (, _lbv0 ), nil )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv0 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv0) ==((s) -- (1))
 Argument nil :: {v:Ty_alphalist | (slen)(v) ==(0)} | (slen)(nil) ==(0)                                                                                                                                                
# of Final Z3 expressions 30
 Final solver 
 (declare-sort T78 0)
(declare-fun slen (T78) Int)
(declare-fun nil () T78)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun _lbv6 () T78)
(declare-fun _lbv7 () T78)
(declare-fun _lbv8 () T78)
(declare-fun v () T78)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen _lbv7) (+ (slen nil) 1)))
(assert (= (slen _lbv8) (+ (slen _lbv6) 1)))
(assert (= (slen v) (+ (slen nil) 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= (slen nil) 0))
(assert (= (slen v) (+ (slen nil) 1)))
(assert (not (= (slen v) s)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_alphalist | (slen)(v) ==((slen)(nil) + (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv9 = apply cons  (, _lbv0 ), nil )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Finding Already seen tree for apply cons  (, _lbv0 ), _lbv6 )
 Typechecking apply cons  (, apply subs  (, s ) ), apply goal  (, apply subs  (, s ) ) )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Typechecking the Term apply cons  (, _lbv0 ), _lbv6 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv0 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv0) ==((s) -- (1))
 Argument _lbv6 :: {v:Ty_alphalist | (slen)(v) ==(_lbv0)} | (slen)(_lbv6) ==(_lbv0)                                                                                                                                                
# of Final Z3 expressions 31
 Final solver 
 (declare-sort T82 0)
(declare-fun slen (T82) Int)
(declare-fun nil () T82)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun _lbv6 () T82)
(declare-fun _lbv7 () T82)
(declare-fun _lbv8 () T82)
(declare-fun _lbv9 () T82)
(declare-fun v () T82)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen _lbv7) (+ (slen nil) 1)))
(assert (= (slen _lbv8) (+ (slen _lbv6) 1)))
(assert (= (slen _lbv9) (+ (slen nil) 1)))
(assert (= (slen v) (+ (slen _lbv6) 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen v) (+ (slen _lbv6) 1)))
(assert (not (= (slen v) s)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_alphalist | (slen)(v) ==((slen)(_lbv6) + (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv10 = apply cons  (, _lbv0 ), _lbv6 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Finding Already seen tree for apply cons  (, s ), nil )
 Typechecking apply cons  (, s ), nil )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Typechecking the Term apply cons  (, s ), nil )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument s :: {v:Ty_int | true} | true
 Argument nil :: {v:Ty_alphalist | (slen)(v) ==(0)} | (slen)(nil) ==(0)                                                                                                                                                
# of Final Z3 expressions 31
 Final solver 
 (declare-sort T86 0)
(declare-fun slen (T86) Int)
(declare-fun nil () T86)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun _lbv6 () T86)
(declare-fun _lbv7 () T86)
(declare-fun _lbv8 () T86)
(declare-fun _lbv9 () T86)
(declare-fun _lbv10 () T86)
(declare-fun v () T86)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen _lbv7) (+ (slen nil) 1)))
(assert (= (slen _lbv8) (+ (slen _lbv6) 1)))
(assert (= (slen _lbv9) (+ (slen nil) 1)))
(assert (= (slen _lbv10) (+ (slen _lbv6) 1)))
(assert (= (slen v) (+ (slen nil) 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen nil) 0))
(assert (= (slen v) (+ (slen nil) 1)))
(assert (not (= (slen v) s)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_alphalist | (slen)(v) ==((slen)(nil) + (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv11 = apply cons  (, s ), nil )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Finding Already seen tree for apply cons  (, s ), _lbv6 )
 Typechecking apply cons  (, s ), apply goal  (, apply subs  (, s ) ) )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Typechecking the Term apply cons  (, s ), _lbv6 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument s :: {v:Ty_int | true} | true
 Argument _lbv6 :: {v:Ty_alphalist | (slen)(v) ==(_lbv0)} | (slen)(_lbv6) ==(_lbv0)                                                                                                                                                
# of Final Z3 expressions 32
 Final solver 
 (declare-sort T90 0)
(declare-fun slen (T90) Int)
(declare-fun nil () T90)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun _lbv6 () T90)
(declare-fun _lbv7 () T90)
(declare-fun _lbv8 () T90)
(declare-fun _lbv9 () T90)
(declare-fun _lbv10 () T90)
(declare-fun _lbv11 () T90)
(declare-fun v () T90)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen _lbv7) (+ (slen nil) 1)))
(assert (= (slen _lbv8) (+ (slen _lbv6) 1)))
(assert (= (slen _lbv9) (+ (slen nil) 1)))
(assert (= (slen _lbv10) (+ (slen _lbv6) 1)))
(assert (= (slen _lbv11) (+ (slen nil) 1)))
(assert (= (slen v) (+ (slen _lbv6) 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen v) (+ (slen _lbv6) 1)))
(assert (not (= (slen v) s)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_alphalist | (slen)(v) ==((slen)(_lbv6) + (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv12 = apply cons  (, s ), _lbv6 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Finding Already seen tree for apply cons  (, int_gen ), nil )
 Typechecking apply cons  (, int_gen ), nil )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Typechecking the Term apply cons  (, int_gen ), nil )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument int_gen :: {var_v1:Ty_int | true} | true
 Argument nil :: {v:Ty_alphalist | (slen)(v) ==(0)} | (slen)(nil) ==(0)                                                                                                                                                
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T94 0)
(declare-fun slen (T94) Int)
(declare-fun nil () T94)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun _lbv6 () T94)
(declare-fun _lbv7 () T94)
(declare-fun _lbv8 () T94)
(declare-fun _lbv9 () T94)
(declare-fun _lbv10 () T94)
(declare-fun _lbv11 () T94)
(declare-fun _lbv12 () T94)
(declare-fun v () T94)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen _lbv7) (+ (slen nil) 1)))
(assert (= (slen _lbv8) (+ (slen _lbv6) 1)))
(assert (= (slen _lbv9) (+ (slen nil) 1)))
(assert (= (slen _lbv10) (+ (slen _lbv6) 1)))
(assert (= (slen _lbv11) (+ (slen nil) 1)))
(assert (= (slen _lbv12) (+ (slen _lbv6) 1)))
(assert (= (slen v) (+ (slen nil) 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen nil) 0))
(assert (= (slen v) (+ (slen nil) 1)))
(assert (not (= (slen v) s)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_alphalist | (slen)(v) ==((slen)(nil) + (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv13 = apply cons  (, int_gen ), nil )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Finding Already seen tree for apply cons  (, int_gen ), _lbv6 )
 Typechecking apply cons  (, int_gen ), apply goal  (, apply subs  (, s ) ) )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Typechecking the Term apply cons  (, int_gen ), _lbv6 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument int_gen :: {var_v1:Ty_int | true} | true
 Argument _lbv6 :: {v:Ty_alphalist | (slen)(v) ==(_lbv0)} | (slen)(_lbv6) ==(_lbv0)                                                                                                                                                
# of Final Z3 expressions 34
 Final solver 
 (declare-sort T98 0)
(declare-fun slen (T98) Int)
(declare-fun nil () T98)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun _lbv6 () T98)
(declare-fun _lbv7 () T98)
(declare-fun _lbv8 () T98)
(declare-fun _lbv9 () T98)
(declare-fun _lbv10 () T98)
(declare-fun _lbv11 () T98)
(declare-fun _lbv12 () T98)
(declare-fun _lbv13 () T98)
(declare-fun v () T98)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen _lbv7) (+ (slen nil) 1)))
(assert (= (slen _lbv8) (+ (slen _lbv6) 1)))
(assert (= (slen _lbv9) (+ (slen nil) 1)))
(assert (= (slen _lbv10) (+ (slen _lbv6) 1)))
(assert (= (slen _lbv11) (+ (slen nil) 1)))
(assert (= (slen _lbv12) (+ (slen _lbv6) 1)))
(assert (= (slen _lbv13) (+ (slen nil) 1)))
(assert (= (slen v) (+ (slen _lbv6) 1)))
(assert (= var_v6 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) _lbv0))
(assert (= (slen v) (+ (slen _lbv6) 1)))
(assert (not (= (slen v) s)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_alphalist | (slen)(v) ==((slen)(_lbv6) + (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv14 = apply cons  (, int_gen ), _lbv6 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Finding Already seen tree for apply cons  (, _lbv1 ), nil )
 Found _lbv7
 Finding Already seen tree for apply cons  (, _lbv1 ), _lbv6 )
 Found _lbv8
 Finding Already seen tree for apply cons  (, _lbv0 ), nil )
 Found _lbv9
 Finding Already seen tree for apply cons  (, _lbv0 ), _lbv6 )
 Found _lbv10
 *********************************************
 True Branch :: Successfully Synthesisized
 *********************************************
 if apply sizecheck  (, apply subs  (, s ) )
 	 then 
 ***********
 apply cons  (, apply subs  (, s ) ), apply goal  (, apply subs  (, s ) ) )
 ***********
 apply cons  (, apply subs  (, s ) ), nil )
 ***********
 apply cons  (, apply subs  (, int_gen ) ), apply goal  (, apply subs  (, s ) ) )
 ***********
 apply cons  (, apply subs  (, int_gen ) ), nil )
 ***********
 apply cons  (, int_gen ), apply goal  (, apply subs  (, s ) ) )
 ***********
 apply cons  (, int_gen ), nil )
 ***********
 apply cons  (, s ), apply goal  (, apply subs  (, s ) ) )
 ***********
 apply cons  (, s ), nil )
 ***********
 apply cons  (, apply subs  (, s ) ), apply goal  (, apply subs  (, s ) ) )
 ***********
 apply cons  (, apply subs  (, s ) ), nil )
 ***********
 apply cons  (, apply subs  (, int_gen ) ), apply goal  (, apply subs  (, s ) ) )
 ***********
 apply cons  (, apply subs  (, int_gen ) ), nil )
 *********************************************
 ************ Synthesize False Branch**************
 *********************************************
 False Branch :: Trying False Branch
 Show :: Synthesizing the false branch
 Show :: False Predicate 
 	 Conj <c var_v6 = false
 	 , DoubleImpl 
 var_v6 = true
  
 	 Conj <c _lbv0 = 0
 	 , DoubleImpl 
 var_v6 = false
  _lbv0 > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | (slen)(v) ==(s)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (slen)(v) ==(s)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | (slen)(v) ==(0)}                                                                                                                                                
# of Final Z3 expressions 24
 Final solver 
 (declare-sort T103 0)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun slen (T103) Int)
(declare-fun nil () T103)
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen nil) 0))
(assert (= var_v6 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen nil) 0))
(assert (not (= (slen nil) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 goal, 
 cons
 ############################################################
  Synthesizing the Function application Pure Component goal
 ############################################################
  *************** Trying Arrow Component ************goal :  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c } ) -> {v:Ty_alphalist | (slen)(v) ==(s1)}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}                                                                                                                                                     
# of Final Z3 expressions 23
 Final solver 
 (declare-sort T106 0)
(declare-fun slen (T106) Int)
(declare-fun nil () T106)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= var_v6 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (not (> s int_gen)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}                                                                                                                                                     
# of Final Z3 expressions 23
 Final solver 
 (declare-sort T110 0)
(declare-fun slen (T110) Int)
(declare-fun nil () T110)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= var_v6 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (not (> s s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}                                                                                                                                                     
# of Final Z3 expressions 24
 Final solver 
 (declare-sort T114 0)
(declare-fun slen (T114) Int)
(declare-fun nil () T114)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= var_v6 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (not (> s _lbv0)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}                                                                                                                                                     
# of Final Z3 expressions 24
 Final solver 
 (declare-sort T118 0)
(declare-fun slen (T118) Int)
(declare-fun nil () T118)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun int_gen () Int)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= var_v6 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (not (> s _lbv1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 FaileD the subtype check T_vi <: T_goal
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v0:Ty_int | true}
  Enumeration for 
 spec 
 {var_v0:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}
 ################################################
 Skipping Variable _lbv1 As Outer Function Call is subs
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for subs 2
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI int_gen
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Found _lbv0
  Case : f (ei) Case subs int_gen
 Finding Already seen tree for apply subs  (, int_gen )
 Found _lbv1
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 3
 Possible Arg Options 
 EI _lbv0
 Possible Arg Options 
 EI _lbv1
 Possible Arg Options 
 EI _lbv0
 Apply Single Argument Case : f (ei) Case goal
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
  Case : f (ei) Case goal _lbv1
 Finding Already seen tree for apply goal  (, _lbv1 )
 Typechecking the Term apply goal  (, _lbv1 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((int_gen) -- (1))} | (_lbv1) ==((int_gen) -- (1))                                                                                                                                                
# of Final Z3 expressions 27
 Final solver 
 (declare-sort T124 0)
(declare-fun slen (T124) Int)
(declare-fun nil () T124)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun _lbv6 () T124)
(declare-fun v () T124)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= (slen _lbv6) s))
(assert (= (slen v) _lbv1))
(assert (= var_v6 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= (slen v) _lbv1))
(assert (not (= (slen v) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 )
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
 Show :: Successfully Synthesisized False Branch 
 Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard apply sizecheck  (, apply subs  (, int_gen ) )
  *********************Synthesizing the True branch*******************
 Show :: True Predicate 
 	 Conj <c var_v7 = true
 	 , DoubleImpl 
 var_v7 = true
  
 	 Conj <c _lbv1 = 0
 	 , DoubleImpl 
 var_v7 = false
  _lbv1 > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | (slen)(v) ==(s)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (slen)(v) ==(s)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | (slen)(v) ==(0)}                                                                                                                                                                       
# of Final Z3 expressions 27
 Final solver 
 (declare-sort T129 0)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun slen (T129) Int)
(declare-fun nil () T129)
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= (slen nil) 0))
(assert (= var_v7 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= (slen nil) 0))
(assert (not (= (slen nil) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 goal, 
 cons
 ############################################################
  Synthesizing the Function application Pure Component goal
 ############################################################
  *************** Trying Arrow Component ************goal :  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c } ) -> {v:Ty_alphalist | (slen)(v) ==(s1)}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}                                                                                                                                                                            
# of Final Z3 expressions 26
 Final solver 
 (declare-sort T132 0)
(declare-fun slen (T132) Int)
(declare-fun nil () T132)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= var_v7 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (not (> s int_gen)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}                                                                                                                                                                            
# of Final Z3 expressions 26
 Final solver 
 (declare-sort T136 0)
(declare-fun slen (T136) Int)
(declare-fun nil () T136)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= var_v7 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (not (> s s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}                                                                                                                                                                            
# of Final Z3 expressions 27
 Final solver 
 (declare-sort T140 0)
(declare-fun slen (T140) Int)
(declare-fun nil () T140)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= var_v7 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (not (> s _lbv0)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}                                                                                                                                                                            
# of Final Z3 expressions 27
 Final solver 
 (declare-sort T144 0)
(declare-fun slen (T144) Int)
(declare-fun nil () T144)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun int_gen () Int)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= var_v7 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (not (> s _lbv1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 FaileD the subtype check T_vi <: T_goal
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v0:Ty_int | true}
  Enumeration for 
 spec 
 {var_v0:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}
 ################################################
 Skipping Variable _lbv1 As Outer Function Call is subs
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for subs 2
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI int_gen
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Found _lbv0
  Case : f (ei) Case subs int_gen
 Finding Already seen tree for apply subs  (, int_gen )
 Found _lbv1
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 3
 Possible Arg Options 
 EI _lbv0
 Possible Arg Options 
 EI _lbv1
 Possible Arg Options 
 EI _lbv0
 Apply Single Argument Case : f (ei) Case goal
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
  Case : f (ei) Case goal _lbv1
 Finding Already seen tree for apply goal  (, _lbv1 )
 Typechecking the Term apply goal  (, _lbv1 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((int_gen) -- (1))} | (_lbv1) ==((int_gen) -- (1))                                                                                                                                                                       
# of Final Z3 expressions 30
 Final solver 
 (declare-sort T150 0)
(declare-fun slen (T150) Int)
(declare-fun nil () T150)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun _lbv6 () T150)
(declare-fun v () T150)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= (slen _lbv6) s))
(assert (= (slen v) _lbv1))
(assert (= var_v7 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= (slen v) _lbv1))
(assert (not (= (slen v) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 )
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
 *********************************************
 True Branch :: Successfully Synthesisized
 *********************************************
 if apply sizecheck  (, apply subs  (, int_gen ) )
 	 then 
 ***********
 apply goal  (, apply subs  (, s ) )
 ***********
 apply goal  (, apply subs  (, s ) )
 *********************************************
 ************ Synthesize False Branch**************
 *********************************************
 False Branch :: Trying False Branch
 Show :: Synthesizing the false branch
 Show :: False Predicate 
 	 Conj <c var_v7 = false
 	 , DoubleImpl 
 var_v7 = true
  
 	 Conj <c _lbv1 = 0
 	 , DoubleImpl 
 var_v7 = false
  _lbv1 > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | (slen)(v) ==(s)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (slen)(v) ==(s)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | (slen)(v) ==(0)}                                                                                                                                                                       
# of Final Z3 expressions 27
 Final solver 
 (declare-sort T155 0)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun slen (T155) Int)
(declare-fun nil () T155)
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= (slen nil) 0))
(assert (= var_v7 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= (slen nil) 0))
(assert (not (= (slen nil) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 goal, 
 cons
 ############################################################
  Synthesizing the Function application Pure Component goal
 ############################################################
  *************** Trying Arrow Component ************goal :  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c } ) -> {v:Ty_alphalist | (slen)(v) ==(s1)}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}                                                                                                                                                                            
# of Final Z3 expressions 26
 Final solver 
 (declare-sort T158 0)
(declare-fun slen (T158) Int)
(declare-fun nil () T158)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= var_v7 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (not (> s int_gen)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}                                                                                                                                                                            
# of Final Z3 expressions 26
 Final solver 
 (declare-sort T162 0)
(declare-fun slen (T162) Int)
(declare-fun nil () T162)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= var_v7 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (not (> s s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}                                                                                                                                                                            
# of Final Z3 expressions 27
 Final solver 
 (declare-sort T166 0)
(declare-fun slen (T166) Int)
(declare-fun nil () T166)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= var_v7 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (not (> s _lbv0)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}                                                                                                                                                                            
# of Final Z3 expressions 27
 Final solver 
 (declare-sort T170 0)
(declare-fun slen (T170) Int)
(declare-fun nil () T170)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun int_gen () Int)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= var_v7 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (not (> s _lbv1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 FaileD the subtype check T_vi <: T_goal
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v0:Ty_int | true}
  Enumeration for 
 spec 
 {var_v0:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}
 ################################################
 Skipping Variable _lbv1 As Outer Function Call is subs
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for subs 2
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI int_gen
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Found _lbv0
  Case : f (ei) Case subs int_gen
 Finding Already seen tree for apply subs  (, int_gen )
 Found _lbv1
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 3
 Possible Arg Options 
 EI _lbv0
 Possible Arg Options 
 EI _lbv1
 Possible Arg Options 
 EI _lbv0
 Apply Single Argument Case : f (ei) Case goal
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
  Case : f (ei) Case goal _lbv1
 Finding Already seen tree for apply goal  (, _lbv1 )
 Typechecking the Term apply goal  (, _lbv1 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((int_gen) -- (1))} | (_lbv1) ==((int_gen) -- (1))                                                                                                                                                                       
# of Final Z3 expressions 30
 Final solver 
 (declare-sort T176 0)
(declare-fun slen (T176) Int)
(declare-fun nil () T176)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun _lbv6 () T176)
(declare-fun v () T176)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= (slen _lbv6) s))
(assert (= (slen v) _lbv1))
(assert (= var_v7 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= (slen v) _lbv1))
(assert (not (= (slen v) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 )
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
 Show :: Successfully Synthesisized False Branch 
 Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard apply sizecheck  (, int_gen )
  *********************Synthesizing the True branch*******************
 Show :: True Predicate 
 	 Conj <c var_v8 = true
 	 , DoubleImpl 
 var_v8 = true
  
 	 Conj <c int_gen = 0
 	 , DoubleImpl 
 var_v8 = false
  int_gen > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | (slen)(v) ==(s)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (slen)(v) ==(s)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | (slen)(v) ==(0)}                                                                                                                                                                                              
# of Final Z3 expressions 30
 Final solver 
 (declare-sort T181 0)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun slen (T181) Int)
(declare-fun nil () T181)
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= (slen nil) 0))
(assert (= var_v8 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= (slen nil) 0))
(assert (not (= (slen nil) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 goal, 
 cons
 ############################################################
  Synthesizing the Function application Pure Component goal
 ############################################################
  *************** Trying Arrow Component ************goal :  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c } ) -> {v:Ty_alphalist | (slen)(v) ==(s1)}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}                                                                                                                                                                                                   
# of Final Z3 expressions 29
 Final solver 
 (declare-sort T184 0)
(declare-fun slen (T184) Int)
(declare-fun nil () T184)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= var_v8 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (not (> s int_gen)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}                                                                                                                                                                                                   
# of Final Z3 expressions 29
 Final solver 
 (declare-sort T188 0)
(declare-fun slen (T188) Int)
(declare-fun nil () T188)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= var_v8 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (not (> s s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}                                                                                                                                                                                                   
# of Final Z3 expressions 30
 Final solver 
 (declare-sort T192 0)
(declare-fun slen (T192) Int)
(declare-fun nil () T192)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= var_v8 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (not (> s _lbv0)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}                                                                                                                                                                                                   
# of Final Z3 expressions 30
 Final solver 
 (declare-sort T196 0)
(declare-fun slen (T196) Int)
(declare-fun nil () T196)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun int_gen () Int)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= var_v8 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (not (> s _lbv1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 FaileD the subtype check T_vi <: T_goal
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v0:Ty_int | true}
  Enumeration for 
 spec 
 {var_v0:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}
 ################################################
 Skipping Variable _lbv1 As Outer Function Call is subs
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for subs 2
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI int_gen
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Found _lbv0
  Case : f (ei) Case subs int_gen
 Finding Already seen tree for apply subs  (, int_gen )
 Found _lbv1
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 3
 Possible Arg Options 
 EI _lbv0
 Possible Arg Options 
 EI _lbv1
 Possible Arg Options 
 EI _lbv0
 Apply Single Argument Case : f (ei) Case goal
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
  Case : f (ei) Case goal _lbv1
 Finding Already seen tree for apply goal  (, _lbv1 )
 Typechecking the Term apply goal  (, _lbv1 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((int_gen) -- (1))} | (_lbv1) ==((int_gen) -- (1))                                                                                                                                                                                              
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T202 0)
(declare-fun slen (T202) Int)
(declare-fun nil () T202)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun _lbv6 () T202)
(declare-fun v () T202)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= (slen _lbv6) s))
(assert (= (slen v) _lbv1))
(assert (= var_v8 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= (slen v) _lbv1))
(assert (not (= (slen v) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 )
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
 *********************************************
 True Branch :: Successfully Synthesisized
 *********************************************
 if apply sizecheck  (, int_gen )
 	 then 
 ***********
 apply goal  (, apply subs  (, s ) )
 ***********
 apply goal  (, apply subs  (, s ) )
 *********************************************
 ************ Synthesize False Branch**************
 *********************************************
 False Branch :: Trying False Branch
 Show :: Synthesizing the false branch
 Show :: False Predicate 
 	 Conj <c var_v8 = false
 	 , DoubleImpl 
 var_v8 = true
  
 	 Conj <c int_gen = 0
 	 , DoubleImpl 
 var_v8 = false
  int_gen > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | (slen)(v) ==(s)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (slen)(v) ==(s)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | (slen)(v) ==(0)}                                                                                                                                                                                              
# of Final Z3 expressions 30
 Final solver 
 (declare-sort T207 0)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun slen (T207) Int)
(declare-fun nil () T207)
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= (slen nil) 0))
(assert (= var_v8 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= (slen nil) 0))
(assert (not (= (slen nil) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 goal, 
 cons
 ############################################################
  Synthesizing the Function application Pure Component goal
 ############################################################
  *************** Trying Arrow Component ************goal :  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c } ) -> {v:Ty_alphalist | (slen)(v) ==(s1)}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}                                                                                                                                                                                                   
# of Final Z3 expressions 29
 Final solver 
 (declare-sort T210 0)
(declare-fun slen (T210) Int)
(declare-fun nil () T210)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= var_v8 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (not (> s int_gen)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}                                                                                                                                                                                                   
# of Final Z3 expressions 29
 Final solver 
 (declare-sort T214 0)
(declare-fun slen (T214) Int)
(declare-fun nil () T214)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= var_v8 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (not (> s s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}                                                                                                                                                                                                   
# of Final Z3 expressions 30
 Final solver 
 (declare-sort T218 0)
(declare-fun slen (T218) Int)
(declare-fun nil () T218)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= var_v8 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (not (> s _lbv0)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}                                                                                                                                                                                                   
# of Final Z3 expressions 30
 Final solver 
 (declare-sort T222 0)
(declare-fun slen (T222) Int)
(declare-fun nil () T222)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun int_gen () Int)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= var_v8 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (not (> s _lbv1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 FaileD the subtype check T_vi <: T_goal
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v0:Ty_int | true}
  Enumeration for 
 spec 
 {var_v0:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}
 ################################################
 Skipping Variable _lbv1 As Outer Function Call is subs
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for subs 2
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI int_gen
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Found _lbv0
  Case : f (ei) Case subs int_gen
 Finding Already seen tree for apply subs  (, int_gen )
 Found _lbv1
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 3
 Possible Arg Options 
 EI _lbv0
 Possible Arg Options 
 EI _lbv1
 Possible Arg Options 
 EI _lbv0
 Apply Single Argument Case : f (ei) Case goal
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
  Case : f (ei) Case goal _lbv1
 Finding Already seen tree for apply goal  (, _lbv1 )
 Typechecking the Term apply goal  (, _lbv1 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((int_gen) -- (1))} | (_lbv1) ==((int_gen) -- (1))                                                                                                                                                                                              
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T228 0)
(declare-fun slen (T228) Int)
(declare-fun nil () T228)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun _lbv6 () T228)
(declare-fun v () T228)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= (slen _lbv6) s))
(assert (= (slen v) _lbv1))
(assert (= var_v8 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= (slen v) _lbv1))
(assert (not (= (slen v) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 )
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
 Show :: Successfully Synthesisized False Branch 
 Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard apply sizecheck  (, s )
  *********************Synthesizing the True branch*******************
 Show :: True Predicate 
 	 Conj <c var_v9 = true
 	 , DoubleImpl 
 var_v9 = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 var_v9 = false
  s > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | (slen)(v) ==(s)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (slen)(v) ==(s)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | (slen)(v) ==(0)}                                                                                                                                                                                                                     
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T233 0)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun var_v9 () Bool)
(declare-fun slen (T233) Int)
(declare-fun nil () T233)
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= (slen nil) 0))
(assert (= var_v9 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= (slen nil) 0))
(assert (not (= (slen nil) s)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Show :: Found a Few Macthing Scalars 
 *********************************************
 True Branch :: Successfully Synthesisized
 *********************************************
 if apply sizecheck  (, s )
 	 then 
 ***********
 nil
 *********************************************
 ************ Synthesize False Branch**************
 *********************************************
 False Branch :: Trying False Branch
 Show :: Synthesizing the false branch
 Show :: False Predicate 
 	 Conj <c var_v9 = false
 	 , DoubleImpl 
 var_v9 = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 var_v9 = false
  s > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | (slen)(v) ==(s)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (slen)(v) ==(s)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | (slen)(v) ==(0)}                                                                                                                                                                                                                     
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T237 0)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun var_v9 () Bool)
(declare-fun slen (T237) Int)
(declare-fun nil () T237)
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= (slen nil) 0))
(assert (= var_v9 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= (slen nil) 0))
(assert (not (= (slen nil) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 goal, 
 cons
 ############################################################
  Synthesizing the Function application Pure Component goal
 ############################################################
  *************** Trying Arrow Component ************goal :  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c } ) -> {v:Ty_alphalist | (slen)(v) ==(s1)}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c true
 	 , s > v >c }
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}                                                                                                                                                                                                                          
# of Final Z3 expressions 32
 Final solver 
 (declare-sort T240 0)
(declare-fun slen (T240) Int)
(declare-fun nil () T240)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun var_v9 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= var_v9 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (not (> s int_gen)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}                                                                                                                                                                                                                          
# of Final Z3 expressions 32
 Final solver 
 (declare-sort T244 0)
(declare-fun slen (T244) Int)
(declare-fun nil () T244)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun var_v9 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= var_v9 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (not (> s s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}                                                                                                                                                                                                                          
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T248 0)
(declare-fun slen (T248) Int)
(declare-fun nil () T248)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun var_v9 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (= var_v9 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= _lbv0 (- s 1)))
(assert (not (> s _lbv0)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}                                                                                                                                                                                                                          
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T252 0)
(declare-fun slen (T252) Int)
(declare-fun nil () T252)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun int_gen () Int)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun var_v9 () Bool)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= var_v9 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (not (> s _lbv1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 FaileD the subtype check T_vi <: T_goal
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n1 : {var_v0:Ty_int | true} ) -> {v:Ty_int | (v) ==((n1) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v0:Ty_int | true}
  Enumeration for 
 spec 
 {var_v0:Ty_int | true}
 
 Enumerating a Scalar Term int_gen
 
 Type of the Scalar Term {var_v1:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((int_gen) -- (1))}
 ################################################
 Skipping Variable _lbv1 As Outer Function Call is subs
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for subs 2
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI int_gen
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Found _lbv0
  Case : f (ei) Case subs int_gen
 Finding Already seen tree for apply subs  (, int_gen )
 Found _lbv1
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 3
 Possible Arg Options 
 EI _lbv0
 Possible Arg Options 
 EI _lbv1
 Possible Arg Options 
 EI _lbv0
 Apply Single Argument Case : f (ei) Case goal
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
  Case : f (ei) Case goal _lbv1
 Finding Already seen tree for apply goal  (, _lbv1 )
 Typechecking the Term apply goal  (, _lbv1 )
 Against {v:Ty_alphalist | (slen)(v) ==(s)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((int_gen) -- (1))} | (_lbv1) ==((int_gen) -- (1))                                                                                                                                                                                                                     
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T258 0)
(declare-fun slen (T258) Int)
(declare-fun nil () T258)
(declare-fun s () Int)
(declare-fun _lbv0 () Int)
(declare-fun int_gen () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v6 () Bool)
(declare-fun var_v7 () Bool)
(declare-fun var_v8 () Bool)
(declare-fun var_v9 () Bool)
(declare-fun _lbv6 () T258)
(declare-fun v () T258)
(assert (= (slen nil) 0))
(assert (= _lbv0 (- s 1)))
(assert (= _lbv1 (- int_gen 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= s |0|) (= (= _lbv2 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= int_gen |0|) (= (= _lbv3 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v6 true) (and (= _lbv0 |0|) (= (= var_v6 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v7 true) (and (= _lbv1 |0|) (= (= var_v7 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v8 true) (and (= int_gen |0|) (= (= var_v8 false) (> int_gen |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= (slen _lbv6) s))
(assert (= (slen v) _lbv1))
(assert (= var_v9 false))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v9 true) (and (= s |0|) (= (= var_v9 false) (> s |0|)))))
(assert (= _lbv1 (- int_gen 1)))
(assert (= (slen v) _lbv1))
(assert (not (= (slen v) s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 )
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv6
 Show :: Successfully Synthesisized False Branch 
  Found a If Then Else solution
 
 let _lbv0 = apply subs  (, s ) 
 in 
 let _lbv1 = apply subs  (, int_gen ) 
 in 
 let _lbv2 = apply sizecheck  (, s ) 
 in 
 let _lbv3 = apply sizecheck  (, int_gen ) 
 in 
 let _lbv4 = apply sizecheck  (, _lbv1 ) 
 in 
 let _lbv5 = apply sizecheck  (, _lbv0 ) 
 in 
 let _lbv6 = apply goal  (, _lbv0 ) 
 in 
 let _lbv7 = apply cons  (, _lbv1 ), nil ) 
 in 
 let _lbv8 = apply cons  (, _lbv1 ), _lbv6 ) 
 in 
 let _lbv9 = apply cons  (, _lbv0 ), nil ) 
 in 
 let _lbv10 = apply cons  (, _lbv0 ), _lbv6 ) 
 in 
 let _lbv11 = apply cons  (, s ), nil ) 
 in 
 let _lbv12 = apply cons  (, s ), _lbv6 ) 
 in 
 let _lbv13 = apply cons  (, int_gen ), nil ) 
 in 
 let _lbv14 = apply cons  (, int_gen ), _lbv6 ) 
 in _lbv14
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, s ) ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, s ) ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, s ) ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, s ) ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, int_gen ) ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, int_gen ) ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, int_gen ) ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, int_gen ) ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, int_gen ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, int_gen ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, int_gen ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, int_gen ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, s ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, s ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, s ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, s ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, s ) ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, s ) ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, s ) ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, s ) ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, int_gen ) ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, int_gen ) ), apply goal  (, apply subs  (, s ) ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, int_gen ) ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, s ) ) ) then 
 apply cons  (, apply subs  (, int_gen ) ), nil ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, int_gen ) ) ) then 
 apply goal  (, apply subs  (, s ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, int_gen ) ) ) then 
 apply goal  (, apply subs  (, s ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, int_gen ) ) ) then 
 apply goal  (, apply subs  (, s ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, apply subs  (, int_gen ) ) ) then 
 apply goal  (, apply subs  (, s ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, int_gen ) ) then 
 apply goal  (, apply subs  (, s ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, int_gen ) ) then 
 apply goal  (, apply subs  (, s ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, int_gen ) ) then 
 apply goal  (, apply subs  (, s ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, int_gen ) ) then 
 apply goal  (, apply subs  (, s ) ) 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, s ) ) then 
 nil 
 else apply goal  (, apply subs  (, s ) )
 ***********
 If (apply sizecheck  (, s ) ) then 
 nil 
 else apply goal  (, apply subs  (, s ) )
 Success : { 
{v:Ty_alphalist | (slen)(v) ==(s)} 
 If (_lbv5 ) then 
 _lbv10 
 else _lbv6 
 }