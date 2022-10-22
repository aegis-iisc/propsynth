
  EXPLORED Args.parser output 
 EXPLORED learningOn  true
 EXPLORED bidirectionality  true
 EXPLORED effect-filter  false
 EXPLORED specfile :: tests_specsynth/ulist_quant.spec
 EXPLORED goal Number :: 0
 EXPLORED Max path length :: 3stexcwhitespace var: slen
whitespace colon
whitespace var: list
whitespace colon
whitespace var: int
semicolon
stexcwhitespace var: ulist
whitespace colon
whitespace var: list
whitespace colon
whitespace var: bool
semicolon
stexcwhitespace var: shd
whitespace colon
whitespace var: list
whitespace colon
whitespace var: int
semicolon
stexcwhitespace var: smem
whitespace colon
whitespace var: list
whitespace colon
whitespace var: int
whitespace colon
whitespace var: bool
semicolon
var: subs
whitespace colon
whitespace lparen
var: n
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
whitespace var: int
whitespace pipe
whitespace var: v
whitespace equalopwhitespace var: n
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
whitespace lambdalparen
var: u
whitespace colon
whitespace var: int
rparen
dotwhitespace var: smem
whitespace lparen
var: v
comma
whitespace var: u
rparen
whitespace equalopwhitespace falsewhitespace conjwhitespace whitespace notwhitespace lparen
var: shd
whitespace lparen
var: v
rparen
whitespace equalopwhitespace var: u
rparen
whitespace conjwhitespace var: slen
whitespace lparen
var: v
rparen
whitespace equalopwhitespace int: 0
whitespace conjwhitespace var: ulist
whitespace lparen
var: v
rparen
whitespace equalopwhitespace truercurly
semicolon
var: sizecheck
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
whitespace conjwhitespace whitespace lbrace
var: v
equalopfalserbrace
whitespace iffwhitespace lbrace
var: s
lessthanopint: 0
rbrace
rcurly
semicolon
var: cons
whitespace colon
whitespace lparen
var: x
whitespace colon
whitespace lcurly
var: v
whitespace colon
whitespace var: int
whitespace pipe
whitespace lbrace
var: v
lessthanopint: 0
rbrace
whitespace disjwhitespace lbrace
var: v
equalopint: 0
rbrace
rcurly
rparen
whitespace arrow
whitespace whitespace lparen
var: xs
whitespace colon
whitespace lcurly
var: v
whitespace colon
whitespace var: list
whitespace pipe
whitespace var: ulist
whitespace lparen
var: v
rparen
whitespace equalopwhitespace truercurly
rparen
whitespace arrow
whitespace whitespace lcurly
var: v
whitespace colon
whitespace var: list
whitespace pipe
whitespace whitespace lambdalparen
var: u
whitespace colon
whitespace var: int
rparen
dotwhitespace whitespace lparen
var: smem
whitespace lparen
var: v
comma
whitespace var: u
rparen
whitespace equalopwhitespace truewhitespace iffwhitespace lparen
var: smem
whitespace lparen
var: xs
comma
whitespace var: u
rparen
whitespace equalopwhitespace truewhitespace disjwhitespace lbrace
var: u
whitespace equalopwhitespace var: x
rbrace
rparen
rparen
whitespace conjwhitespace lparen
var: shd
whitespace lparen
var: v
rparen
whitespace equalopwhitespace var: u
whitespace iffwhitespace lbrace
var: u
whitespace equalopwhitespace var: x
rbrace
rparen
whitespace conjwhitespace lparen
var: shd
whitespace lparen
var: v
rparen
whitespace equalopwhitespace var: u
whitespace implieswhitespace var: smem
whitespace lparen
var: v
comma
whitespace var: u
rparen
whitespace equalopwhitespace truerparen
whitespace conjwhitespace lparen
var: slen
whitespace lparen
var: v
rparen
whitespace equalopwhitespace var: slen
whitespace lparen
var: xs
rparen
whitespace pluswhitespace int: 1
rparen
whitespace conjwhitespace lparen
var: ulist
whitespace lparen
var: v
rparen
whitespace equalopwhitespace truerparen
whitespace rcurly
semicolon
whitespace var: goal
whitespace colon
whitespace lparen
var: s
whitespace colon
whitespace lcurly
whitespace var: v
whitespace colon
whitespace var: int
whitespace pipe
whitespace lbrace
var: v
lessthanopint: 0
rbrace
whitespace disjwhitespace lbrace
var: v
equalopint: 0
rbrace
rcurly
rparen
whitespace arrow
whitespace whitespace lparen
var: x0
whitespace colon
whitespace lcurly
var: v
whitespace colon
whitespace var: int
whitespace pipe
whitespace lbrace
var: v
lessthanopint: 0
rbrace
whitespace disjwhitespace lbrace
var: v
equalopint: 0
rbrace
rcurly
rparen
whitespace arrow
whitespace whitespace lcurly
var: v
whitespace colon
whitespace var: list
whitespace pipe
whitespace lambdalparen
var: u
whitespace colon
whitespace var: int
rparen
dotwhitespace whitespace var: slen
whitespace lparen
var: v
rparen
whitespace equalopwhitespace var: s
whitespace conjwhitespace var: ulist
whitespace lparen
var: v
rparen
whitespace equalopwhitespace truewhitespace conjwhitespace whitespace lparen
var: smem
whitespace lparen
var: v
comma
whitespace var: u
rparen
whitespace equalopwhitespace truewhitespace implieswhitespace lbrace
var: u
whitespace equalopwhitespace var: x0
rbrace
rparen
rcurly
semicolon
RelSpec {  SRs ;  PRs ;  TSs  
 Assume false
 name subs : 
 params :
 Type  Arrow ( ( n : {v:Ty_int | true} ) -> {v:Ty_int | (v) ==((n) -- (1))} 
 Assume false
 name nil : 
 params :
 Type {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , 
 	 Conj <c (slen)(v) ==(0)
 	 , (ulist)(v) = (true) >c  >c  >c  }} 
 Assume false
 name sizecheck : 
 params :
 Type  Arrow ( ( s : {var_v0:Ty_int | true} ) -> {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 v = false
  s > 0 >c } 
 Assume false
 name cons : 
 params :
 Type  Arrow ( ( x : {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c DoubleImpl 
 (smem)( , v, u ) = (true)
  
 Disj <d  (smem)( , xs, u ) = (true)
 	,   u = x>d 
 	 , 
 	 Conj <c DoubleImpl 
 (shd)(v) = (u)
  u = x
 	 , 
 	 Conj <c 
 	 Impl < (shd)(v) = (u)
 	 (smem)( , v, u ) = (true) >
 	 , 
 	 Conj <c (slen)(v) ==((slen)(xs) + (1))
 	 , (ulist)(v) = (true) >c  >c  >c  >c  }} 
 Assume false
 name goal : 
 params :
 Type  Arrow ( ( s : {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } ) ->  Arrow ( ( x0 : {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }};  Formulas  }
 INITIAL GAMMA 
 
 goal :  Arrow ( ( s : {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } ) ->  Arrow ( ( x0 : {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 cons :  Arrow ( ( x : {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c DoubleImpl 
 (smem)( , v, u ) = (true)
  
 Disj <d  (smem)( , xs, u ) = (true)
 	,   u = x>d 
 	 , 
 	 Conj <c DoubleImpl 
 (shd)(v) = (u)
  u = x
 	 , 
 	 Conj <c 
 	 Impl < (shd)(v) = (u)
 	 (smem)( , v, u ) = (true) >
 	 , 
 	 Conj <c (slen)(v) ==((slen)(xs) + (1))
 	 , (ulist)(v) = (true) >c  >c  >c  >c  }}
 sizecheck :  Arrow ( ( s : {var_v0:Ty_int | true} ) -> {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 v = false
  s > 0 >c }
 nil : {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , 
 	 Conj <c (slen)(v) ==(0)
 	 , (ulist)(v) = (true) >c  >c  >c  }}
 subs :  Arrow ( ( n : {v:Ty_int | true} ) -> {v:Ty_int | (v) ==((n) -- (1))}
 INITIAL SIGMA 
 
 TypeNames 
 
 Qualifiers 
 
 Qual slen :  :-> Ty_alphalist :-> Ty_int
 Qual ulist :  :-> Ty_alphalist :-> Ty_bool
 Qual shd :  :-> Ty_alphalist :-> Ty_int
 Qual smem :  :-> Ty_alphalist :-> Ty_int :-> Ty_bool
 Show ***********Calling S-FUNC synthesize***************
 Show Uncurried , s:{v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }, x0:{v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 Decreasing Measure s
 Decreasing Type {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }
 Calculated Decreasing Predicate s > v
 Calculated Decreased Goal Type  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c } ) ->  Arrow ( ( x0 : {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s1)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 Show Trying :: Top-level Match
 Show :: Synthesize Match {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 Show :: List Ty_int
 Show :: Non List Case
 Match-case failed :: Try Top-level If-then-else 
 **********************************************
 iSynthesize If-THEN-ELSE {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 **********************************************
  *********************Synthesizing the Guard*******************
 iSynthesize Boolean Guard {var_v1:Ty_bool | true}
  *********************Synthesizing the Guard*******************
 esynthesizeScalar for {var_v1:Ty_bool | true}
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 sizecheck
 ############################################################
  Synthesizing the Function application Pure Component sizecheck
 ############################################################
  *************** Trying Arrow Component ************sizecheck :  Arrow ( ( s : {var_v0:Ty_int | true} ) -> {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 v = false
  s > 0 >c }
  *************** Synthesizing Args ei : ti for ************sizecheck
 ##################################################################################
  Synthesizing the 1th argument for Function sizecheck
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v0:Ty_int | true}
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }
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
  *************** Trying Arrow Component ************subs :  Arrow ( ( n : {v:Ty_int | true} ) -> {v:Ty_int | (v) ==((n) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | true}
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }
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
 EI x0
 Possible Arg Options 
 EI s
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs x0
 Finding Already seen tree for apply subs  (, x0 )
 Typechecking the Term apply subs  (, x0 )
 Against {var_v0:Ty_int | true}
 Argument x0 :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  x0 > 0
 	,   x0 = 0>d 
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:Ty_int | (v) ==((x0) -- (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv0 = apply subs  (, x0 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Typechecking the Term apply subs  (, s )
 Against {var_v0:Ty_int | true}
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d 
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
 let _lbv1 = apply subs  (, s )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for sizecheck 4
 Possible Arg Options 
 EI x0
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI _lbv1
 Possible Arg Options 
 EI _lbv0
 Apply Single Argument Case : f (ei) Case sizecheck
  Case : f (ei) Case sizecheck x0
 Finding Already seen tree for apply sizecheck  (, x0 )
 Typechecking the Term apply sizecheck  (, x0 )
 Against {var_v1:Ty_bool | true}
 Argument x0 :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  x0 > 0
 	,   x0 = 0>d 
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
  
 	 Conj <c x0 = 0
 	 , DoubleImpl 
 v = false
  x0 > 0 >c }
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv2 = apply sizecheck  (, x0 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Case : f (ei) Case sizecheck s
 Finding Already seen tree for apply sizecheck  (, s )
 Typechecking the Term apply sizecheck  (, s )
 Against {var_v1:Ty_bool | true}
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d 
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
 let _lbv3 = apply sizecheck  (, s )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Case : f (ei) Case sizecheck _lbv1
 Finding Already seen tree for apply sizecheck  (, _lbv1 )
 Typechecking the Term apply sizecheck  (, _lbv1 )
 Against {var_v1:Ty_bool | true}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
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
 Against {var_v1:Ty_bool | true}
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))
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
 Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard apply sizecheck  (, s )
  *********************Synthesizing the True branch*******************
 Show :: True Predicate 
 	 Conj <c var_v2 = true
 	 , DoubleImpl 
 var_v2 = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 var_v2 = false
  s > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , 
 	 Conj <c (slen)(v) ==(0)
 	 , (ulist)(v) = (true) >c  >c  >c  }}                                                                                                                                                                                            
# of Final Z3 expressions 26
 Final solver 
 (declare-sort T43)
(declare-fun |0| () Int)
(declare-fun set0 (Bool) Bool)
(declare-fun var_u3 () Int)
(declare-fun set1 (Int) Bool)
(declare-fun set2 (Bool) Bool)
(declare-fun set3 (Bool) Bool)
(declare-fun var_u4 () Int)
(declare-fun set4 (Int) Bool)
(declare-fun set5 (Bool) Bool)
(declare-fun ulist (T43 Bool) Bool)
(declare-fun nil () T43)
(declare-fun slen (T43) Int)
(declare-fun shd (T43 Int) Bool)
(declare-fun smem (T43 Int Bool) Bool)
(declare-fun s () Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun set6 (Bool) Bool)
(declare-fun set7 (Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((bv0 Bool)) (= (set0 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set1 bv0) (and (= bv0 var_u3)))))
(assert (forall ((bv0 Bool)) (= (set2 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((bv0 Bool)) (= (set3 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set4 bv0) (and (= bv0 var_u4)))))
(assert (forall ((bv0 Bool)) (= (set5 bv0) (and (= bv0 true)))))
(assert (forall ((var_u4 Int) (var_u3 Int))
  (let ((a!1 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!2 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!3 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!4 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!5 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|)))))
        (a!6 (not (forall ((bv0 Int)) (= (shd nil bv0) (set1 bv0)))))
        (a!7 (not (forall ((bv0 Int)) (= (shd nil bv0) (set4 bv0))))))
    (and (or (> s |0|) (= s |0|))
         (or (> x0 |0|) (= x0 |0|))
         (= _lbv0 (- x0 1))
         (= _lbv1 (- s 1))
         a!1
         a!2
         a!3
         a!4
         a!5
         (forall ((bv0 Bool)) (= (smem nil var_u3 bv0) (set0 bv0)))
         a!6
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set2 bv0)))
         (= var_v2 true)
         a!5
         (forall ((bv0 Bool)) (= (smem nil var_u4 bv0) (set3 bv0)))
         a!7
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set5 bv0)))))))
(assert (forall ((bv0 Bool)) (= (set6 bv0) (and (= bv0 true)))))
(assert (forall ((bv0 Bool)) (= (set7 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (forall ((var_u5 Int))
             (let ((a!1 (=> (forall ((bv0 Bool))
                              (= (smem nil var_u5 bv0) (set7 bv0)))
                            (= var_u5 x0))))
               (and (= (slen nil) s)
                    (forall ((bv0 Bool)) (= (ulist nil bv0) (set6 bv0)))
                    a!1)))))
  (not a!1)))

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
 	 Conj <c var_v2 = false
 	 , DoubleImpl 
 var_v2 = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 var_v2 = false
  s > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , 
 	 Conj <c (slen)(v) ==(0)
 	 , (ulist)(v) = (true) >c  >c  >c  }}                                                                                                                                                                                            
# of Final Z3 expressions 26
 Final solver 
 (declare-sort T47)
(declare-fun |0| () Int)
(declare-fun set8 (Bool) Bool)
(declare-fun var_u6 () Int)
(declare-fun set9 (Int) Bool)
(declare-fun set10 (Bool) Bool)
(declare-fun set11 (Bool) Bool)
(declare-fun var_u7 () Int)
(declare-fun set12 (Int) Bool)
(declare-fun set13 (Bool) Bool)
(declare-fun ulist (T47 Bool) Bool)
(declare-fun nil () T47)
(declare-fun slen (T47) Int)
(declare-fun shd (T47 Int) Bool)
(declare-fun smem (T47 Int Bool) Bool)
(declare-fun s () Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun set14 (Bool) Bool)
(declare-fun set15 (Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((bv0 Bool)) (= (set8 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set9 bv0) (and (= bv0 var_u6)))))
(assert (forall ((bv0 Bool)) (= (set10 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((bv0 Bool)) (= (set11 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set12 bv0) (and (= bv0 var_u7)))))
(assert (forall ((bv0 Bool)) (= (set13 bv0) (and (= bv0 true)))))
(assert (forall ((var_u7 Int) (var_u6 Int))
  (let ((a!1 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!2 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!3 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!4 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!5 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|)))))
        (a!6 (not (forall ((bv0 Int)) (= (shd nil bv0) (set9 bv0)))))
        (a!7 (not (forall ((bv0 Int)) (= (shd nil bv0) (set12 bv0))))))
    (and (or (> s |0|) (= s |0|))
         (or (> x0 |0|) (= x0 |0|))
         (= _lbv0 (- x0 1))
         (= _lbv1 (- s 1))
         a!1
         a!2
         a!3
         a!4
         a!5
         (forall ((bv0 Bool)) (= (smem nil var_u6 bv0) (set8 bv0)))
         a!6
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set10 bv0)))
         (= var_v2 false)
         a!5
         (forall ((bv0 Bool)) (= (smem nil var_u7 bv0) (set11 bv0)))
         a!7
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set13 bv0)))))))
(assert (forall ((bv0 Bool)) (= (set14 bv0) (and (= bv0 true)))))
(assert (forall ((bv0 Bool)) (= (set15 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (forall ((var_u8 Int))
             (let ((a!1 (=> (forall ((bv0 Bool))
                              (= (smem nil var_u8 bv0) (set15 bv0)))
                            (= var_u8 x0))))
               (and (= (slen nil) s)
                    (forall ((bv0 Bool)) (= (ulist nil bv0) (set14 bv0)))
                    a!1)))))
  (not a!1)))

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
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c } ) ->  Arrow ( ( x0 : {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s1)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                       
# of Final Z3 expressions 25
 Final solver 
 (declare-sort T50)
(declare-fun set16 (Bool) Bool)
(declare-fun var_u9 () Int)
(declare-fun set17 (Int) Bool)
(declare-fun set18 (Bool) Bool)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun ulist (T50 Bool) Bool)
(declare-fun nil () T50)
(declare-fun slen (T50) Int)
(declare-fun shd (T50 Int) Bool)
(declare-fun smem (T50 Int Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set16 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set17 bv0) (and (= bv0 var_u9)))))
(assert (forall ((bv0 Bool)) (= (set18 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u9 Int))
  (let ((a!1 (not (forall ((bv0 Int)) (= (shd nil bv0) (set17 bv0)))))
        (a!2 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!3 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!4 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!5 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!6 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|))))))
    (and (forall ((bv0 Bool)) (= (smem nil var_u9 bv0) (set16 bv0)))
         a!1
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set18 bv0)))
         (or (> x0 |0|) (= x0 |0|))
         (= _lbv0 (- x0 1))
         (= _lbv1 (- s 1))
         a!2
         a!3
         a!4
         a!5
         a!6
         (or (> s |0|) (= s |0|))
         (= var_v2 false)
         a!6
         (or (> s |0|) (= s |0|))))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                       
# of Final Z3 expressions 25
 Final solver 
 (declare-sort T54)
(declare-fun set19 (Bool) Bool)
(declare-fun var_u10 () Int)
(declare-fun set20 (Int) Bool)
(declare-fun set21 (Bool) Bool)
(declare-fun |0| () Int)
(declare-fun x0 () Int)
(declare-fun s () Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv2 () Bool)
(declare-fun ulist (T54 Bool) Bool)
(declare-fun nil () T54)
(declare-fun slen (T54) Int)
(declare-fun shd (T54 Int) Bool)
(declare-fun smem (T54 Int Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set19 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set20 bv0) (and (= bv0 var_u10)))))
(assert (forall ((bv0 Bool)) (= (set21 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u10 Int))
  (let ((a!1 (not (forall ((bv0 Int)) (= (shd nil bv0) (set20 bv0)))))
        (a!2 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!3 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!4 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!5 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!6 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|))))))
    (and (forall ((bv0 Bool)) (= (smem nil var_u10 bv0) (set19 bv0)))
         a!1
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set21 bv0)))
         (or (> s |0|) (= s |0|))
         (= _lbv0 (- x0 1))
         (= _lbv1 (- s 1))
         a!2
         a!3
         a!4
         a!5
         a!6
         (or (> x0 |0|) (= x0 |0|))
         (= var_v2 false)
         a!6
         (or (> x0 |0|) (= x0 |0|))))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> x0 |0|) (= x0 |0|)) (> s x0))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((x0) -- (1))}
 standardized VC STANDARD VC_BEGIN TyDBINDS  
 
 goal --->  Function type  
 cons --->  Function type  
 sizecheck --->  Function type  
 nil --->  Ty_alphalist  
 subs --->  Function type  
 s --->  Ty_int  
 x0 --->  Ty_int  
 _lbv1 --->  Ty_int  
 _lbv2 --->  Ty_bool  
 _lbv3 --->  Ty_bool  
 _lbv4 --->  Ty_bool  
 _lbv5 --->  Ty_bool  
 var_v2 --->  Ty_bool  
 _lbv0 --->  Ty_int  
 var_u11 --->  Ty_int 
 	 ANTE \Forall (TyDBINDS  
 
 var_u11 --->  Ty_int ).Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Rel (smem)( , nil, var_u11 ) = (false) AND 
 	 Not Rel (shd)(nil) = (var_u11) AND 
 	 Conj  AND 
 	 Rel (slen)(nil) ==(0) AND 
 	 Rel (ulist)(nil) = (true) AND 
 	 Disj  OR 
 	  Base s > 0 OR 
 	  Base s = 0 AND 
 	 Disj  OR 
 	  Base x0 > 0 OR 
 	  Base x0 = 0 AND 
 	 Rel (_lbv1) ==((s) -- (1)) AND 
 	 Base _lbv2 = true <=> Conj  AND 
 	 Base x0 = 0 AND 
 	 Base _lbv2 = false <=> Base x0 > 0 AND 
 	 Base _lbv3 = true <=> Conj  AND 
 	 Base s = 0 AND 
 	 Base _lbv3 = false <=> Base s > 0 AND 
 	 Base _lbv4 = true <=> Conj  AND 
 	 Base _lbv1 = 0 AND 
 	 Base _lbv4 = false <=> Base _lbv1 > 0 AND 
 	 Base _lbv5 = true <=> Conj  AND 
 	 Base _lbv0 = 0 AND 
 	 Base _lbv5 = false <=> Base _lbv0 > 0 AND 
 	 Base var_v2 = true <=> Conj  AND 
 	 Base s = 0 AND 
 	 Base var_v2 = false <=> Base s > 0 AND 
 	 Rel (_lbv0) ==((x0) -- (1)) AND 
 	 Base var_v2 = false AND 
 	 Base var_v2 = true <=> Conj  AND 
 	 Base s = 0 AND 
 	 Base var_v2 = false <=> Base s > 0 AND 
 	 Rel (_lbv0) ==((x0) -- (1)) 
 	 ------------------------

	 CONS Conj  AND 
 	 Disj  OR 
 	  Base _lbv0 > 0 OR 
 	  Base _lbv0 = 0 AND 
 	 Base s > _lbv0
 
VC_END                                                                                                                                                                                            
# of Final Z3 expressions 23
 Final solver 
 (declare-sort T58)
(declare-fun set22 (Bool) Bool)
(declare-fun var_u11 () Int)
(declare-fun set23 (Int) Bool)
(declare-fun set24 (Bool) Bool)
(declare-fun |0| () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv2 () Bool)
(declare-fun ulist (T58 Bool) Bool)
(declare-fun nil () T58)
(declare-fun slen (T58) Int)
(declare-fun shd (T58 Int) Bool)
(declare-fun smem (T58 Int Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set22 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set23 bv0) (and (= bv0 var_u11)))))
(assert (forall ((bv0 Bool)) (= (set24 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u11 Int))
  (let ((a!1 (not (forall ((bv0 Int)) (= (shd nil bv0) (set23 bv0)))))
        (a!2 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!3 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!4 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!5 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!6 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|))))))
    (and (forall ((bv0 Bool)) (= (smem nil var_u11 bv0) (set22 bv0)))
         a!1
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set24 bv0)))
         (or (> s |0|) (= s |0|))
         (or (> x0 |0|) (= x0 |0|))
         (= _lbv1 (- s 1))
         a!2
         a!3
         a!4
         a!5
         a!6
         (= _lbv0 (- x0 1))
         (= var_v2 false)
         a!6
         (= _lbv0 (- x0 1))))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> _lbv0 |0|) (= _lbv0 |0|)) (> s _lbv0))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
 standardized VC STANDARD VC_BEGIN TyDBINDS  
 
 goal --->  Function type  
 cons --->  Function type  
 sizecheck --->  Function type  
 nil --->  Ty_alphalist  
 subs --->  Function type  
 s --->  Ty_int  
 x0 --->  Ty_int  
 _lbv0 --->  Ty_int  
 _lbv2 --->  Ty_bool  
 _lbv3 --->  Ty_bool  
 _lbv4 --->  Ty_bool  
 _lbv5 --->  Ty_bool  
 var_v2 --->  Ty_bool  
 _lbv1 --->  Ty_int  
 var_u12 --->  Ty_int 
 	 ANTE \Forall (TyDBINDS  
 
 var_u12 --->  Ty_int ).Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Conj  AND 
 	 Rel (smem)( , nil, var_u12 ) = (false) AND 
 	 Not Rel (shd)(nil) = (var_u12) AND 
 	 Conj  AND 
 	 Rel (slen)(nil) ==(0) AND 
 	 Rel (ulist)(nil) = (true) AND 
 	 Disj  OR 
 	  Base s > 0 OR 
 	  Base s = 0 AND 
 	 Disj  OR 
 	  Base x0 > 0 OR 
 	  Base x0 = 0 AND 
 	 Rel (_lbv0) ==((x0) -- (1)) AND 
 	 Base _lbv2 = true <=> Conj  AND 
 	 Base x0 = 0 AND 
 	 Base _lbv2 = false <=> Base x0 > 0 AND 
 	 Base _lbv3 = true <=> Conj  AND 
 	 Base s = 0 AND 
 	 Base _lbv3 = false <=> Base s > 0 AND 
 	 Base _lbv4 = true <=> Conj  AND 
 	 Base _lbv1 = 0 AND 
 	 Base _lbv4 = false <=> Base _lbv1 > 0 AND 
 	 Base _lbv5 = true <=> Conj  AND 
 	 Base _lbv0 = 0 AND 
 	 Base _lbv5 = false <=> Base _lbv0 > 0 AND 
 	 Base var_v2 = true <=> Conj  AND 
 	 Base s = 0 AND 
 	 Base var_v2 = false <=> Base s > 0 AND 
 	 Rel (_lbv1) ==((s) -- (1)) AND 
 	 Base var_v2 = false AND 
 	 Base var_v2 = true <=> Conj  AND 
 	 Base s = 0 AND 
 	 Base var_v2 = false <=> Base s > 0 AND 
 	 Rel (_lbv1) ==((s) -- (1)) 
 	 ------------------------

	 CONS Conj  AND 
 	 Disj  OR 
 	  Base _lbv1 > 0 OR 
 	  Base _lbv1 = 0 AND 
 	 Base s > _lbv1
 
VC_END                                                                                                                                                                                            
# of Final Z3 expressions 23
 Final solver 
 (declare-sort T62)
(declare-fun set25 (Bool) Bool)
(declare-fun var_u12 () Int)
(declare-fun set26 (Int) Bool)
(declare-fun set27 (Bool) Bool)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun ulist (T62 Bool) Bool)
(declare-fun nil () T62)
(declare-fun slen (T62) Int)
(declare-fun shd (T62 Int) Bool)
(declare-fun smem (T62 Int Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set25 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set26 bv0) (and (= bv0 var_u12)))))
(assert (forall ((bv0 Bool)) (= (set27 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u12 Int))
  (let ((a!1 (not (forall ((bv0 Int)) (= (shd nil bv0) (set26 bv0)))))
        (a!2 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!3 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!4 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!5 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!6 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|))))))
    (and (forall ((bv0 Bool)) (= (smem nil var_u12 bv0) (set25 bv0)))
         a!1
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set27 bv0)))
         (or (> s |0|) (= s |0|))
         (or (> x0 |0|) (= x0 |0|))
         (= _lbv0 (- x0 1))
         a!2
         a!3
         a!4
         a!5
         a!6
         (= _lbv1 (- s 1))
         (= var_v2 false)
         a!6
         (= _lbv1 (- s 1))))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> _lbv1 |0|) (= _lbv1 |0|)) (> s _lbv1))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n : {v:Ty_int | true} ) -> {v:Ty_int | (v) ==((n) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | true}
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((x0) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
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
 EI x0
 Possible Arg Options 
 EI s
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs x0
 Finding Already seen tree for apply subs  (, x0 )
 Found _lbv0
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Found _lbv1
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
 ##################################################################################
  Synthesizing the 2th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                  
# of Final Z3 expressions 25
 Final solver 
 (declare-sort T74)
(declare-fun set28 (Bool) Bool)
(declare-fun var_u13 () Int)
(declare-fun set29 (Int) Bool)
(declare-fun set30 (Bool) Bool)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun ulist (T74 Bool) Bool)
(declare-fun nil () T74)
(declare-fun slen (T74) Int)
(declare-fun shd (T74 Int) Bool)
(declare-fun smem (T74 Int Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set28 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set29 bv0) (and (= bv0 var_u13)))))
(assert (forall ((bv0 Bool)) (= (set30 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u13 Int))
  (let ((a!1 (not (forall ((bv0 Int)) (= (shd nil bv0) (set29 bv0)))))
        (a!2 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!3 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!4 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!5 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!6 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|))))))
    (and (forall ((bv0 Bool)) (= (smem nil var_u13 bv0) (set28 bv0)))
         a!1
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set30 bv0)))
         (or (> x0 |0|) (= x0 |0|))
         (= _lbv0 (- x0 1))
         (= _lbv1 (- s 1))
         a!2
         a!3
         a!4
         a!5
         a!6
         (or (> s |0|) (= s |0|))
         (= var_v2 false)
         a!6
         (or (> s |0|) (= s |0|))))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (or (> s |0|) (= s |0|))))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                  
# of Final Z3 expressions 25
 Final solver 
 (declare-sort T78)
(declare-fun set31 (Bool) Bool)
(declare-fun var_u14 () Int)
(declare-fun set32 (Int) Bool)
(declare-fun set33 (Bool) Bool)
(declare-fun |0| () Int)
(declare-fun x0 () Int)
(declare-fun s () Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv2 () Bool)
(declare-fun ulist (T78 Bool) Bool)
(declare-fun nil () T78)
(declare-fun slen (T78) Int)
(declare-fun shd (T78 Int) Bool)
(declare-fun smem (T78 Int Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set31 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set32 bv0) (and (= bv0 var_u14)))))
(assert (forall ((bv0 Bool)) (= (set33 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u14 Int))
  (let ((a!1 (not (forall ((bv0 Int)) (= (shd nil bv0) (set32 bv0)))))
        (a!2 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!3 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!4 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!5 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!6 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|))))))
    (and (forall ((bv0 Bool)) (= (smem nil var_u14 bv0) (set31 bv0)))
         a!1
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set33 bv0)))
         (or (> s |0|) (= s |0|))
         (= _lbv0 (- x0 1))
         (= _lbv1 (- s 1))
         a!2
         a!3
         a!4
         a!5
         a!6
         (or (> x0 |0|) (= x0 |0|))
         (= var_v2 false)
         a!6
         (or (> x0 |0|) (= x0 |0|))))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (or (> x0 |0|) (= x0 |0|))))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:Ty_int | (v) ==((x0) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term _lbv1
 
 Type of the Scalar Term {v:Ty_int | (v) ==((s) -- (1))}
 ################################################
 Skipping Variable _lbv1 As Outer Function Call is subs
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
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 4
 Possible Arg Options 
 EI _lbv1
 EI x0
 Possible Arg Options 
 EI _lbv1
 EI s
 Possible Arg Options 
 EI _lbv0
 EI x0
 Possible Arg Options 
 EI _lbv0
 EI s
 Show f (ei, e2, ....en) Case
 Finding Already seen tree for apply goal  (, _lbv1 ), x0 )
 Typechecking apply goal  (, apply subs  (, s ) ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 Typechecking the Term apply goal  (, _lbv1 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument x0 :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  x0 > 0
 	,   x0 = 0>d                                                                                                                                                                                                                      
# of Final Z3 expressions 29
 Final solver 
 (declare-sort T82)
(declare-fun set34 (Bool) Bool)
(declare-fun var_u15 () Int)
(declare-fun set35 (Int) Bool)
(declare-fun set36 (Bool) Bool)
(declare-fun |0| () Int)
(declare-fun set37 (Bool) Bool)
(declare-fun set38 (Bool) Bool)
(declare-fun set39 (Bool) Bool)
(declare-fun set40 (Bool) Bool)
(declare-fun x0 () Int)
(declare-fun smem (T82 Int Bool) Bool)
(declare-fun v () T82)
(declare-fun ulist (T82 Bool) Bool)
(declare-fun _lbv1 () Int)
(declare-fun slen (T82) Int)
(declare-fun s () Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv2 () Bool)
(declare-fun nil () T82)
(declare-fun shd (T82 Int) Bool)
(declare-fun set41 (Bool) Bool)
(declare-fun set42 (Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set34 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set35 bv0) (and (= bv0 var_u15)))))
(assert (forall ((bv0 Bool)) (= (set36 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((bv0 Bool)) (= (set37 bv0) (and (= bv0 true)))))
(assert (forall ((bv0 Bool)) (= (set38 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((bv0 Bool)) (= (set39 bv0) (and (= bv0 true)))))
(assert (forall ((bv0 Bool)) (= (set40 bv0) (and (= bv0 true)))))
(assert (forall ((var_u17 Int) (var_u16 Int) (var_u15 Int))
  (let ((a!1 (not (forall ((bv0 Int)) (= (shd nil bv0) (set35 bv0)))))
        (a!2 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!3 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!4 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!5 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!6 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|)))))
        (a!7 (=> (forall ((bv0 Bool)) (= (smem v var_u16 bv0) (set38 bv0)))
                 (= var_u16 x0)))
        (a!8 (=> (forall ((bv0 Bool)) (= (smem v var_u17 bv0) (set40 bv0)))
                 (= var_u17 x0))))
    (and (forall ((bv0 Bool)) (= (smem nil var_u15 bv0) (set34 bv0)))
         a!1
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set36 bv0)))
         (or (> s |0|) (= s |0|))
         (or (> x0 |0|) (= x0 |0|))
         (= _lbv0 (- x0 1))
         (= _lbv1 (- s 1))
         a!2
         a!3
         a!4
         a!5
         a!6
         (= (slen v) _lbv1)
         (forall ((bv0 Bool)) (= (ulist v bv0) (set37 bv0)))
         a!7
         (= var_v2 false)
         a!6
         (= _lbv1 (- s 1))
         (or (> x0 |0|) (= x0 |0|))
         (= (slen v) _lbv1)
         (forall ((bv0 Bool)) (= (ulist v bv0) (set39 bv0)))
         a!8))))
(assert (forall ((bv0 Bool)) (= (set41 bv0) (and (= bv0 true)))))
(assert (forall ((bv0 Bool)) (= (set42 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (forall ((var_u18 Int))
             (let ((a!1 (=> (forall ((bv0 Bool))
                              (= (smem v var_u18 bv0) (set42 bv0)))
                            (= var_u18 x0))))
               (and (= (slen v) s)
                    (forall ((bv0 Bool)) (= (ulist v bv0) (set41 bv0)))
                    a!1)))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), x0 )
 Finding Already seen tree for apply goal  (, _lbv1 ), s )
 Typechecking apply goal  (, apply subs  (, s ) ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 Typechecking the Term apply goal  (, _lbv1 ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                                      
# of Final Z3 expressions 29
 Final solver 
 (declare-sort T86)
(declare-fun set43 (Bool) Bool)
(declare-fun var_u19 () Int)
(declare-fun set44 (Int) Bool)
(declare-fun set45 (Bool) Bool)
(declare-fun |0| () Int)
(declare-fun set46 (Bool) Bool)
(declare-fun set47 (Bool) Bool)
(declare-fun set48 (Bool) Bool)
(declare-fun set49 (Bool) Bool)
(declare-fun s () Int)
(declare-fun smem (T86 Int Bool) Bool)
(declare-fun v () T86)
(declare-fun ulist (T86 Bool) Bool)
(declare-fun _lbv1 () Int)
(declare-fun slen (T86) Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun nil () T86)
(declare-fun shd (T86 Int) Bool)
(declare-fun set50 (Bool) Bool)
(declare-fun set51 (Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set43 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set44 bv0) (and (= bv0 var_u19)))))
(assert (forall ((bv0 Bool)) (= (set45 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((bv0 Bool)) (= (set46 bv0) (and (= bv0 true)))))
(assert (forall ((bv0 Bool)) (= (set47 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((bv0 Bool)) (= (set48 bv0) (and (= bv0 true)))))
(assert (forall ((bv0 Bool)) (= (set49 bv0) (and (= bv0 true)))))
(assert (forall ((var_u21 Int) (var_u20 Int) (var_u19 Int))
  (let ((a!1 (not (forall ((bv0 Int)) (= (shd nil bv0) (set44 bv0)))))
        (a!2 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!3 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!4 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!5 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!6 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|)))))
        (a!7 (=> (forall ((bv0 Bool)) (= (smem v var_u20 bv0) (set47 bv0)))
                 (= var_u20 s)))
        (a!8 (=> (forall ((bv0 Bool)) (= (smem v var_u21 bv0) (set49 bv0)))
                 (= var_u21 s))))
    (and (forall ((bv0 Bool)) (= (smem nil var_u19 bv0) (set43 bv0)))
         a!1
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set45 bv0)))
         (or (> s |0|) (= s |0|))
         (or (> x0 |0|) (= x0 |0|))
         (= _lbv0 (- x0 1))
         (= _lbv1 (- s 1))
         a!2
         a!3
         a!4
         a!5
         a!6
         (= (slen v) _lbv1)
         (forall ((bv0 Bool)) (= (ulist v bv0) (set46 bv0)))
         a!7
         (= var_v2 false)
         a!6
         (= _lbv1 (- s 1))
         (or (> s |0|) (= s |0|))
         (= (slen v) _lbv1)
         (forall ((bv0 Bool)) (= (ulist v bv0) (set48 bv0)))
         a!8))))
(assert (forall ((bv0 Bool)) (= (set50 bv0) (and (= bv0 true)))))
(assert (forall ((bv0 Bool)) (= (set51 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (forall ((var_u22 Int))
             (let ((a!1 (=> (forall ((bv0 Bool))
                              (= (smem v var_u22 bv0) (set51 bv0)))
                            (= var_u22 x0))))
               (and (= (slen v) s)
                    (forall ((bv0 Bool)) (= (ulist v bv0) (set50 bv0)))
                    a!1)))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), s )
 Finding Already seen tree for apply goal  (, _lbv0 ), x0 )
 Typechecking apply goal  (, apply subs  (, x0 ) ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 Typechecking the Term apply goal  (, _lbv0 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (slen)(v) ==(s)
 	 , 
 	 Conj <c (ulist)(v) = (true)
 	 , 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > >c  >c  }}
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))
 Argument x0 :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  x0 > 0
 	,   x0 = 0>d                                                                                                                                                                                                                      
# of Final Z3 expressions 29
 Final solver 
 (declare-sort T90)
(declare-fun set52 (Bool) Bool)
(declare-fun var_u23 () Int)
(declare-fun set53 (Int) Bool)
(declare-fun set54 (Bool) Bool)
(declare-fun |0| () Int)
(declare-fun set55 (Bool) Bool)
(declare-fun set56 (Bool) Bool)
(declare-fun set57 (Bool) Bool)
(declare-fun set58 (Bool) Bool)
(declare-fun x0 () Int)
(declare-fun smem (T90 Int Bool) Bool)
(declare-fun v () T90)
(declare-fun ulist (T90 Bool) Bool)
(declare-fun _lbv0 () Int)
(declare-fun slen (T90) Int)
(declare-fun s () Int)
(declare-fun var_v2 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv2 () Bool)
(declare-fun nil () T90)
(declare-fun shd (T90 Int) Bool)
(declare-fun set59 (Bool) Bool)
(declare-fun set60 (Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set52 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Int)) (= (set53 bv0) (and (= bv0 var_u23)))))
(assert (forall ((bv0 Bool)) (= (set54 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((bv0 Bool)) (= (set55 bv0) (and (= bv0 true)))))
(assert (forall ((bv0 Bool)) (= (set56 bv0) (and (= bv0 true)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((bv0 Bool)) (= (set57 bv0) (and (= bv0 true)))))
(assert (forall ((bv0 Bool)) (= (set58 bv0) (and (= bv0 true)))))
(assert (forall ((var_u25 Int) (var_u24 Int) (var_u23 Int))
  (let ((a!1 (not (forall ((bv0 Int)) (= (shd nil bv0) (set53 bv0)))))
        (a!2 (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
        (a!3 (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
        (a!4 (= (= _lbv4 true)
                (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
        (a!5 (= (= _lbv5 true)
                (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
        (a!6 (= (= var_v2 true) (and (= s |0|) (= (= var_v2 false) (> s |0|)))))
        (a!7 (=> (forall ((bv0 Bool)) (= (smem v var_u24 bv0) (set56 bv0)))
                 (= var_u24 x0)))
        (a!8 (=> (forall ((bv0 Bool)) (= (smem v var_u25 bv0) (set58 bv0)))
                 (= var_u25 x0))))
    (and (forall ((bv0 Bool)) (= (smem nil var_u23 bv0) (set52 bv0)))
         a!1
         (= (slen nil) 0)
         (forall ((bv0 Bool)) (= (ulist nil bv0) (set54 bv0)))
         (or (> s |0|) (= s |0|))
         (or (> x0 |0|) (= x0 |0|))
         (= _lbv0 (- x0 1))
         (= _lbv1 (- s 1))
         a!2
         a!3
         a!4
         a!5
         a!6
         (= (slen v) _lbv0)
         (forall ((bv0 Bool)) (= (ulist v bv0) (set55 bv0)))
         a!7
         (= var_v2 false)
         a!6
         (= _lbv0 (- x0 1))
         (or (> x0 |0|) (= x0 |0|))
         (= (slen v) _lbv0)
         (forall