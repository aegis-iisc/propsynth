
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
rcurly
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
whitespace var: int
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
whitespace var: int
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
dotwhitespace whitespace var: smem
whitespace lparen
var: v
comma
whitespace var: u
rparen
whitespace equalopwhitespace truewhitespace implieswhitespace lbrace
var: u
whitespace equalopwhitespace var: x0
rbrace
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
 	 , (slen)(v) ==(0) >c  >c  }} 
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
 Type  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }} 
 Assume false
 name goal : 
 params :
 Type  Arrow ( ( s : {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }};  Formulas  }
 INITIAL GAMMA 
 
 goal :  Arrow ( ( s : {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
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
 	 , (slen)(v) ==(0) >c  >c  }}
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
 	,   v = 0>d }, x0:{var_v2:Ty_int | true} -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Decreasing Measure s
 Decreasing Type {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }
 Calculated Decreasing Predicate s > v
 Calculated Decreased Goal Type  Arrow ( ( s1 : {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Show Trying :: Top-level Match
 Show :: Synthesize Match {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Show :: List Ty_int
 Show :: Non List Case
 Match-case failed :: Try Top-level If-then-else 
 **********************************************
 iSynthesize If-THEN-ELSE {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 **********************************************
 iSynthesize Boolean {var_v3:Ty_bool | true}
 esynthesizeScalar for {var_v3:Ty_bool | true}
  Enumeration for 
 spec 
 {var_v3:Ty_bool | true}
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
  Enumeration for 
 spec 
 {var_v0:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
  Enumeration for 
 spec 
 {v:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Argument x0 :: {var_v2:Ty_int | true} | true
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
 Against {var_v3:Ty_bool | true}
 Argument x0 :: {var_v2:Ty_int | true} | true
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
 Against {var_v3:Ty_bool | true}
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
 Against {var_v3:Ty_bool | true}
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
 Against {var_v3:Ty_bool | true}
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
 Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard apply sizecheck  (, apply subs  (, x0 ) )
  *********************Synthesizing the True branch*******************
 Show :: True Predicate 
 	 Conj <c var_v4 = true
 	 , DoubleImpl 
 var_v4 = true
  
 	 Conj <c _lbv0 = 0
 	 , DoubleImpl 
 var_v4 = false
  _lbv0 > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  Enumeration for 
 spec 
 {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                           
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T43 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun set0 (Bool) Bool)
(declare-fun smem (T43 Int Bool) Bool)
(declare-fun var_u5 () Int)
(declare-fun nil () T43)
(declare-fun set1 (Int) Bool)
(declare-fun shd (T43 Int) Bool)
(declare-fun slen (T43) Int)
(declare-fun set2 (Bool) Bool)
(declare-fun var_u6 () Int)
(declare-fun set3 (Int) Bool)
(declare-fun set4 (Bool) Bool)
(declare-fun var_u7 () Int)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set0 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u5 bv0) (set0 bv0))))
(assert (forall ((bv0 Int)) (= (set1 bv0) (and (= bv0 var_u5)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set1 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set2 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u6 bv0) (set2 bv0))))
(assert (forall ((bv0 Int)) (= (set3 bv0) (and (= bv0 var_u6)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set3 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set4 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem nil var_u7 bv0) (set4 bv0)))
               (= var_u7 x0))))
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
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                          
# of Final Z3 expressions 35
 Final solver 
 (declare-sort T46 0)
(declare-fun set5 (Bool) Bool)
(declare-fun smem (T46 Int Bool) Bool)
(declare-fun var_u8 () Int)
(declare-fun nil () T46)
(declare-fun set6 (Int) Bool)
(declare-fun shd (T46 Int) Bool)
(declare-fun slen (T46) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set5 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u8 bv0) (set5 bv0))))
(assert (forall ((bv0 Int)) (= (set6 bv0) (and (= bv0 var_u8)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set6 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                               
# of Final Z3 expressions 32
 Final solver 
 (declare-sort T50 0)
(declare-fun set7 (Bool) Bool)
(declare-fun smem (T50 Int Bool) Bool)
(declare-fun var_u9 () Int)
(declare-fun nil () T50)
(declare-fun set8 (Int) Bool)
(declare-fun shd (T50 Int) Bool)
(declare-fun slen (T50) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set7 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u9 bv0) (set7 bv0))))
(assert (forall ((bv0 Int)) (= (set8 bv0) (and (= bv0 var_u9)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set8 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
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
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T54 0)
(declare-fun set9 (Bool) Bool)
(declare-fun smem (T54 Int Bool) Bool)
(declare-fun var_u10 () Int)
(declare-fun nil () T54)
(declare-fun set10 (Int) Bool)
(declare-fun shd (T54 Int) Bool)
(declare-fun slen (T54) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set9 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u10 bv0) (set9 bv0))))
(assert (forall ((bv0 Int)) (= (set10 bv0) (and (= bv0 var_u10)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set10 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T58 0)
(declare-fun set11 (Bool) Bool)
(declare-fun smem (T58 Int Bool) Bool)
(declare-fun var_u11 () Int)
(declare-fun nil () T58)
(declare-fun set12 (Int) Bool)
(declare-fun shd (T58 Int) Bool)
(declare-fun slen (T58) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set11 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u11 bv0) (set11 bv0))))
(assert (forall ((bv0 Int)) (= (set12 bv0) (and (= bv0 var_u11)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set12 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- s 1)))
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
  Enumeration for 
 spec 
 {v:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv1 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                       
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T78 0)
(declare-fun set13 (Bool) Bool)
(declare-fun smem (T78 Int Bool) Bool)
(declare-fun var_u12 () Int)
(declare-fun nil () T78)
(declare-fun set14 (Int) Bool)
(declare-fun shd (T78 Int) Bool)
(declare-fun slen (T78) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun set15 (Bool) Bool)
(declare-fun var_u13 () Int)
(declare-fun v () T78)
(declare-fun set16 (Bool) Bool)
(declare-fun var_u14 () Int)
(declare-fun set17 (Bool) Bool)
(declare-fun var_u15 () Int)
(assert (forall ((bv0 Bool)) (= (set13 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u12 bv0) (set13 bv0))))
(assert (forall ((bv0 Int)) (= (set14 bv0) (and (= bv0 var_u12)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set14 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set15 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u13 bv0) (set15 bv0))) (= var_u13 x0)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (forall ((bv0 Bool)) (= (set16 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u14 bv0) (set16 bv0))) (= var_u14 x0)))
(assert (forall ((bv0 Bool)) (= (set17 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u15 bv0) (set17 bv0)))
               (= var_u15 x0))))
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv1 ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                   
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T82 0)
(declare-fun set18 (Bool) Bool)
(declare-fun smem (T82 Int Bool) Bool)
(declare-fun var_u16 () Int)
(declare-fun nil () T82)
(declare-fun set19 (Int) Bool)
(declare-fun shd (T82 Int) Bool)
(declare-fun slen (T82) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun set20 (Bool) Bool)
(declare-fun var_u17 () Int)
(declare-fun v () T82)
(declare-fun set21 (Bool) Bool)
(declare-fun var_u18 () Int)
(declare-fun set22 (Bool) Bool)
(declare-fun var_u19 () Int)
(assert (forall ((bv0 Bool)) (= (set18 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u16 bv0) (set18 bv0))))
(assert (forall ((bv0 Int)) (= (set19 bv0) (and (= bv0 var_u16)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set19 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set20 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u17 bv0) (set20 bv0))) (= var_u17 s)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set21 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u18 bv0) (set21 bv0))) (= var_u18 s)))
(assert (forall ((bv0 Bool)) (= (set22 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u19 bv0) (set22 bv0)))
               (= var_u19 x0))))
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv0 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                       
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T86 0)
(declare-fun set23 (Bool) Bool)
(declare-fun smem (T86 Int Bool) Bool)
(declare-fun var_u20 () Int)
(declare-fun nil () T86)
(declare-fun set24 (Int) Bool)
(declare-fun shd (T86 Int) Bool)
(declare-fun slen (T86) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun set25 (Bool) Bool)
(declare-fun var_u21 () Int)
(declare-fun v () T86)
(declare-fun set26 (Bool) Bool)
(declare-fun var_u22 () Int)
(declare-fun set27 (Bool) Bool)
(declare-fun var_u23 () Int)
(assert (forall ((bv0 Bool)) (= (set23 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u20 bv0) (set23 bv0))))
(assert (forall ((bv0 Int)) (= (set24 bv0) (and (= bv0 var_u20)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set24 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set25 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u21 bv0) (set25 bv0))) (= var_u21 x0)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (forall ((bv0 Bool)) (= (set26 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u22 bv0) (set26 bv0))) (= var_u22 x0)))
(assert (forall ((bv0 Bool)) (= (set27 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u23 bv0) (set27 bv0)))
               (= var_u23 x0))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv0 ), x0 )
 Finding Already seen tree for apply goal  (, _lbv0 ), s )
 Typechecking apply goal  (, apply subs  (, x0 ) ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv0 ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                   
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T90 0)
(declare-fun set28 (Bool) Bool)
(declare-fun smem (T90 Int Bool) Bool)
(declare-fun var_u24 () Int)
(declare-fun nil () T90)
(declare-fun set29 (Int) Bool)
(declare-fun shd (T90 Int) Bool)
(declare-fun slen (T90) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun set30 (Bool) Bool)
(declare-fun var_u25 () Int)
(declare-fun v () T90)
(declare-fun set31 (Bool) Bool)
(declare-fun var_u26 () Int)
(declare-fun set32 (Bool) Bool)
(declare-fun var_u27 () Int)
(assert (forall ((bv0 Bool)) (= (set28 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u24 bv0) (set28 bv0))))
(assert (forall ((bv0 Int)) (= (set29 bv0) (and (= bv0 var_u24)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set29 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set30 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u25 bv0) (set30 bv0))) (= var_u25 s)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set31 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u26 bv0) (set31 bv0))) (= var_u26 s)))
(assert (forall ((bv0 Bool)) (= (set32 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u27 bv0) (set32 bv0)))
               (= var_u27 x0))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv0 ), s )
  ###################################################
  The Choice of Function goal Was Ill Fated Try Next Choice of function
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
  Enumeration for 
 spec 
 {v:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                     
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T119 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun set33 (Bool) Bool)
(declare-fun smem (T119 Int Bool) Bool)
(declare-fun var_u28 () Int)
(declare-fun nil () T119)
(declare-fun set34 (Int) Bool)
(declare-fun shd (T119 Int) Bool)
(declare-fun slen (T119) Int)
(declare-fun set35 (Bool) Bool)
(declare-fun var_u29 () Int)
(declare-fun set36 (Int) Bool)
(declare-fun set37 (Bool) Bool)
(declare-fun ulist (T119 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set33 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u28 bv0) (set33 bv0))))
(assert (forall ((bv0 Int)) (= (set34 bv0) (and (= bv0 var_u28)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set34 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set35 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u29 bv0) (set35 bv0))))
(assert (forall ((bv0 Int)) (= (set36 bv0) (and (= bv0 var_u29)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set36 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set37 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set37 bv0)))))

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
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                          
# of Final Z3 expressions 35
 Final solver 
 (declare-sort T122 0)
(declare-fun set38 (Bool) Bool)
(declare-fun smem (T122 Int Bool) Bool)
(declare-fun var_u30 () Int)
(declare-fun nil () T122)
(declare-fun set39 (Int) Bool)
(declare-fun shd (T122 Int) Bool)
(declare-fun slen (T122) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set38 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u30 bv0) (set38 bv0))))
(assert (forall ((bv0 Int)) (= (set39 bv0) (and (= bv0 var_u30)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set39 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                               
# of Final Z3 expressions 32
 Final solver 
 (declare-sort T126 0)
(declare-fun set40 (Bool) Bool)
(declare-fun smem (T126 Int Bool) Bool)
(declare-fun var_u31 () Int)
(declare-fun nil () T126)
(declare-fun set41 (Int) Bool)
(declare-fun shd (T126 Int) Bool)
(declare-fun slen (T126) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set40 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u31 bv0) (set40 bv0))))
(assert (forall ((bv0 Int)) (= (set41 bv0) (and (= bv0 var_u31)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set41 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
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
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T130 0)
(declare-fun set42 (Bool) Bool)
(declare-fun smem (T130 Int Bool) Bool)
(declare-fun var_u32 () Int)
(declare-fun nil () T130)
(declare-fun set43 (Int) Bool)
(declare-fun shd (T130 Int) Bool)
(declare-fun slen (T130) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set42 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u32 bv0) (set42 bv0))))
(assert (forall ((bv0 Int)) (= (set43 bv0) (and (= bv0 var_u32)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set43 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T134 0)
(declare-fun set44 (Bool) Bool)
(declare-fun smem (T134 Int Bool) Bool)
(declare-fun var_u33 () Int)
(declare-fun nil () T134)
(declare-fun set45 (Int) Bool)
(declare-fun shd (T134 Int) Bool)
(declare-fun slen (T134) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set44 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u33 bv0) (set44 bv0))))
(assert (forall ((bv0 Int)) (= (set45 bv0) (and (= bv0 var_u33)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set45 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- s 1)))
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
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                     
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T171 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun set46 (Bool) Bool)
(declare-fun smem (T171 Int Bool) Bool)
(declare-fun var_u34 () Int)
(declare-fun nil () T171)
(declare-fun set47 (Int) Bool)
(declare-fun shd (T171 Int) Bool)
(declare-fun slen (T171) Int)
(declare-fun set48 (Bool) Bool)
(declare-fun var_u35 () Int)
(declare-fun set49 (Int) Bool)
(declare-fun set50 (Bool) Bool)
(declare-fun ulist (T171 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set46 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u34 bv0) (set46 bv0))))
(assert (forall ((bv0 Int)) (= (set47 bv0) (and (= bv0 var_u34)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set47 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set48 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u35 bv0) (set48 bv0))))
(assert (forall ((bv0 Int)) (= (set49 bv0) (and (= bv0 var_u35)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set49 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set50 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set50 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 Found Constructors with required return type
  
 ********************** HERE BEFORE 
 Show No more choices for ConsApp
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
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                          
# of Final Z3 expressions 35
 Final solver 
 (declare-sort T174 0)
(declare-fun set51 (Bool) Bool)
(declare-fun smem (T174 Int Bool) Bool)
(declare-fun var_u36 () Int)
(declare-fun nil () T174)
(declare-fun set52 (Int) Bool)
(declare-fun shd (T174 Int) Bool)
(declare-fun slen (T174) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set51 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u36 bv0) (set51 bv0))))
(assert (forall ((bv0 Int)) (= (set52 bv0) (and (= bv0 var_u36)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set52 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                               
# of Final Z3 expressions 32
 Final solver 
 (declare-sort T178 0)
(declare-fun set53 (Bool) Bool)
(declare-fun smem (T178 Int Bool) Bool)
(declare-fun var_u37 () Int)
(declare-fun nil () T178)
(declare-fun set54 (Int) Bool)
(declare-fun shd (T178 Int) Bool)
(declare-fun slen (T178) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set53 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u37 bv0) (set53 bv0))))
(assert (forall ((bv0 Int)) (= (set54 bv0) (and (= bv0 var_u37)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set54 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
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
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T182 0)
(declare-fun set55 (Bool) Bool)
(declare-fun smem (T182 Int Bool) Bool)
(declare-fun var_u38 () Int)
(declare-fun nil () T182)
(declare-fun set56 (Int) Bool)
(declare-fun shd (T182 Int) Bool)
(declare-fun slen (T182) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set55 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u38 bv0) (set55 bv0))))
(assert (forall ((bv0 Int)) (= (set56 bv0) (and (= bv0 var_u38)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set56 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 33
 Final solver 
 (declare-sort T186 0)
(declare-fun set57 (Bool) Bool)
(declare-fun smem (T186 Int Bool) Bool)
(declare-fun var_u39 () Int)
(declare-fun nil () T186)
(declare-fun set58 (Int) Bool)
(declare-fun shd (T186 Int) Bool)
(declare-fun slen (T186) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(assert (forall ((bv0 Bool)) (= (set57 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u39 bv0) (set57 bv0))))
(assert (forall ((bv0 Int)) (= (set58 bv0) (and (= bv0 var_u39)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set58 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= _lbv1 (- s 1)))
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
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                     
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T223 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun set59 (Bool) Bool)
(declare-fun smem (T223 Int Bool) Bool)
(declare-fun var_u40 () Int)
(declare-fun nil () T223)
(declare-fun set60 (Int) Bool)
(declare-fun shd (T223 Int) Bool)
(declare-fun slen (T223) Int)
(declare-fun set61 (Bool) Bool)
(declare-fun var_u41 () Int)
(declare-fun set62 (Int) Bool)
(declare-fun set63 (Bool) Bool)
(declare-fun ulist (T223 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set59 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u40 bv0) (set59 bv0))))
(assert (forall ((bv0 Int)) (= (set60 bv0) (and (= bv0 var_u40)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set60 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v4 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set61 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u41 bv0) (set61 bv0))))
(assert (forall ((bv0 Int)) (= (set62 bv0) (and (= bv0 var_u41)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set62 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set63 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set63 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 Found Constructors with required return type
  
 ********************** HERE BEFORE 
 Show No more choices for ConsApp
 Failed Synthesizing any True Branch exp for the selected guard_lbv5
 Try Next guard
 Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard apply sizecheck  (, apply subs  (, s ) )
  *********************Synthesizing the True branch*******************
 Show :: True Predicate 
 	 Conj <c var_v42 = true
 	 , DoubleImpl 
 var_v42 = true
  
 	 Conj <c _lbv1 = 0
 	 , DoubleImpl 
 var_v42 = false
  _lbv1 > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  Enumeration for 
 spec 
 {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                                  
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T227 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set64 (Bool) Bool)
(declare-fun smem (T227 Int Bool) Bool)
(declare-fun var_u43 () Int)
(declare-fun nil () T227)
(declare-fun set65 (Int) Bool)
(declare-fun shd (T227 Int) Bool)
(declare-fun slen (T227) Int)
(declare-fun set66 (Bool) Bool)
(declare-fun var_u44 () Int)
(declare-fun set67 (Int) Bool)
(declare-fun set68 (Bool) Bool)
(declare-fun var_u45 () Int)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set64 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u43 bv0) (set64 bv0))))
(assert (forall ((bv0 Int)) (= (set65 bv0) (and (= bv0 var_u43)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set65 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set66 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u44 bv0) (set66 bv0))))
(assert (forall ((bv0 Int)) (= (set67 bv0) (and (= bv0 var_u44)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set67 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set68 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem nil var_u45 bv0) (set68 bv0)))
               (= var_u45 x0))))
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
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                                 
# of Final Z3 expressions 38
 Final solver 
 (declare-sort T230 0)
(declare-fun set69 (Bool) Bool)
(declare-fun smem (T230 Int Bool) Bool)
(declare-fun var_u46 () Int)
(declare-fun nil () T230)
(declare-fun set70 (Int) Bool)
(declare-fun shd (T230 Int) Bool)
(declare-fun slen (T230) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set69 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u46 bv0) (set69 bv0))))
(assert (forall ((bv0 Int)) (= (set70 bv0) (and (= bv0 var_u46)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set70 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                                                      
# of Final Z3 expressions 35
 Final solver 
 (declare-sort T234 0)
(declare-fun set71 (Bool) Bool)
(declare-fun smem (T234 Int Bool) Bool)
(declare-fun var_u47 () Int)
(declare-fun nil () T234)
(declare-fun set72 (Int) Bool)
(declare-fun shd (T234 Int) Bool)
(declare-fun slen (T234) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set71 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u47 bv0) (set71 bv0))))
(assert (forall ((bv0 Int)) (= (set72 bv0) (and (= bv0 var_u47)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set72 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
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
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T238 0)
(declare-fun set73 (Bool) Bool)
(declare-fun smem (T238 Int Bool) Bool)
(declare-fun var_u48 () Int)
(declare-fun nil () T238)
(declare-fun set74 (Int) Bool)
(declare-fun shd (T238 Int) Bool)
(declare-fun slen (T238) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set73 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u48 bv0) (set73 bv0))))
(assert (forall ((bv0 Int)) (= (set74 bv0) (and (= bv0 var_u48)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set74 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T242 0)
(declare-fun set75 (Bool) Bool)
(declare-fun smem (T242 Int Bool) Bool)
(declare-fun var_u49 () Int)
(declare-fun nil () T242)
(declare-fun set76 (Int) Bool)
(declare-fun shd (T242 Int) Bool)
(declare-fun slen (T242) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set75 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u49 bv0) (set75 bv0))))
(assert (forall ((bv0 Int)) (= (set76 bv0) (and (= bv0 var_u49)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set76 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> _lbv1 |0|) (= _lbv1 |0|)) (> s _lbv1))))

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
  *************** Trying Arrow Component ************subs :  Arrow ( ( n : {v:Ty_int | true} ) -> {v:Ty_int | (v) ==((n) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | true}
  Enumeration for 
 spec 
 {v:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
  Synthesizing the 2th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show Potential Functions
  , 
 subs
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 6
 Possible Arg Options 
 EI _lbv1
 EI x0
 Possible Arg Options 
 EI _lbv1
 EI s
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv1 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                                              
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T262 0)
(declare-fun set77 (Bool) Bool)
(declare-fun smem (T262 Int Bool) Bool)
(declare-fun var_u50 () Int)
(declare-fun nil () T262)
(declare-fun set78 (Int) Bool)
(declare-fun shd (T262 Int) Bool)
(declare-fun slen (T262) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set79 (Bool) Bool)
(declare-fun var_u51 () Int)
(declare-fun v () T262)
(declare-fun set80 (Bool) Bool)
(declare-fun var_u52 () Int)
(declare-fun set81 (Bool) Bool)
(declare-fun var_u53 () Int)
(assert (forall ((bv0 Bool)) (= (set77 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u50 bv0) (set77 bv0))))
(assert (forall ((bv0 Int)) (= (set78 bv0) (and (= bv0 var_u50)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set78 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set79 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u51 bv0) (set79 bv0))) (= var_u51 x0)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (forall ((bv0 Bool)) (= (set80 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u52 bv0) (set80 bv0))) (= var_u52 x0)))
(assert (forall ((bv0 Bool)) (= (set81 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u53 bv0) (set81 bv0)))
               (= var_u53 x0))))
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv1 ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                                          
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T266 0)
(declare-fun set82 (Bool) Bool)
(declare-fun smem (T266 Int Bool) Bool)
(declare-fun var_u54 () Int)
(declare-fun nil () T266)
(declare-fun set83 (Int) Bool)
(declare-fun shd (T266 Int) Bool)
(declare-fun slen (T266) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set84 (Bool) Bool)
(declare-fun var_u55 () Int)
(declare-fun v () T266)
(declare-fun set85 (Bool) Bool)
(declare-fun var_u56 () Int)
(declare-fun set86 (Bool) Bool)
(declare-fun var_u57 () Int)
(assert (forall ((bv0 Bool)) (= (set82 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u54 bv0) (set82 bv0))))
(assert (forall ((bv0 Int)) (= (set83 bv0) (and (= bv0 var_u54)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set83 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set84 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u55 bv0) (set84 bv0))) (= var_u55 s)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set85 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u56 bv0) (set85 bv0))) (= var_u56 s)))
(assert (forall ((bv0 Bool)) (= (set86 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u57 bv0) (set86 bv0)))
               (= var_u57 x0))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), s )
 Finding Already seen tree for apply goal  (, _lbv1 ), x0 )
 Typechecking apply goal  (, apply subs  (, s ) ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv1 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                                              
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T270 0)
(declare-fun set87 (Bool) Bool)
(declare-fun smem (T270 Int Bool) Bool)
(declare-fun var_u58 () Int)
(declare-fun nil () T270)
(declare-fun set88 (Int) Bool)
(declare-fun shd (T270 Int) Bool)
(declare-fun slen (T270) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set89 (Bool) Bool)
(declare-fun var_u59 () Int)
(declare-fun v () T270)
(declare-fun set90 (Bool) Bool)
(declare-fun var_u60 () Int)
(declare-fun set91 (Bool) Bool)
(declare-fun var_u61 () Int)
(assert (forall ((bv0 Bool)) (= (set87 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u58 bv0) (set87 bv0))))
(assert (forall ((bv0 Int)) (= (set88 bv0) (and (= bv0 var_u58)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set88 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set89 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u59 bv0) (set89 bv0))) (= var_u59 x0)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (forall ((bv0 Bool)) (= (set90 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u60 bv0) (set90 bv0))) (= var_u60 x0)))
(assert (forall ((bv0 Bool)) (= (set91 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u61 bv0) (set91 bv0)))
               (= var_u61 x0))))
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv1 ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                                          
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T274 0)
(declare-fun set92 (Bool) Bool)
(declare-fun smem (T274 Int Bool) Bool)
(declare-fun var_u62 () Int)
(declare-fun nil () T274)
(declare-fun set93 (Int) Bool)
(declare-fun shd (T274 Int) Bool)
(declare-fun slen (T274) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set94 (Bool) Bool)
(declare-fun var_u63 () Int)
(declare-fun v () T274)
(declare-fun set95 (Bool) Bool)
(declare-fun var_u64 () Int)
(declare-fun set96 (Bool) Bool)
(declare-fun var_u65 () Int)
(assert (forall ((bv0 Bool)) (= (set92 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u62 bv0) (set92 bv0))))
(assert (forall ((bv0 Int)) (= (set93 bv0) (and (= bv0 var_u62)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set93 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set94 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u63 bv0) (set94 bv0))) (= var_u63 s)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set95 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u64 bv0) (set95 bv0))) (= var_u64 s)))
(assert (forall ((bv0 Bool)) (= (set96 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u65 bv0) (set96 bv0)))
               (= var_u65 x0))))
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv0 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                                              
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T278 0)
(declare-fun set97 (Bool) Bool)
(declare-fun smem (T278 Int Bool) Bool)
(declare-fun var_u66 () Int)
(declare-fun nil () T278)
(declare-fun set98 (Int) Bool)
(declare-fun shd (T278 Int) Bool)
(declare-fun slen (T278) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set99 (Bool) Bool)
(declare-fun var_u67 () Int)
(declare-fun v () T278)
(declare-fun set100 (Bool) Bool)
(declare-fun var_u68 () Int)
(declare-fun set101 (Bool) Bool)
(declare-fun var_u69 () Int)
(assert (forall ((bv0 Bool)) (= (set97 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u66 bv0) (set97 bv0))))
(assert (forall ((bv0 Int)) (= (set98 bv0) (and (= bv0 var_u66)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set98 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set99 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u67 bv0) (set99 bv0))) (= var_u67 x0)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (forall ((bv0 Bool)) (= (set100 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u68 bv0) (set100 bv0))) (= var_u68 x0)))
(assert (forall ((bv0 Bool)) (= (set101 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u69 bv0) (set101 bv0)))
               (= var_u69 x0))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv0 ), x0 )
 Finding Already seen tree for apply goal  (, _lbv0 ), s )
 Typechecking apply goal  (, apply subs  (, x0 ) ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv0 ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                                          
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T282 0)
(declare-fun set102 (Bool) Bool)
(declare-fun smem (T282 Int Bool) Bool)
(declare-fun var_u70 () Int)
(declare-fun nil () T282)
(declare-fun set103 (Int) Bool)
(declare-fun shd (T282 Int) Bool)
(declare-fun slen (T282) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set104 (Bool) Bool)
(declare-fun var_u71 () Int)
(declare-fun v () T282)
(declare-fun set105 (Bool) Bool)
(declare-fun var_u72 () Int)
(declare-fun set106 (Bool) Bool)
(declare-fun var_u73 () Int)
(assert (forall ((bv0 Bool)) (= (set102 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u70 bv0) (set102 bv0))))
(assert (forall ((bv0 Int)) (= (set103 bv0) (and (= bv0 var_u70)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set103 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set104 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u71 bv0) (set104 bv0))) (= var_u71 s)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set105 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u72 bv0) (set105 bv0))) (= var_u72 s)))
(assert (forall ((bv0 Bool)) (= (set106 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u73 bv0) (set106 bv0)))
               (= var_u73 x0))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv0 ), s )
  ###################################################
  The Choice of Function goal Was Ill Fated Try Next Choice of function
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
  Enumeration for 
 spec 
 {v:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                            
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T311 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set107 (Bool) Bool)
(declare-fun smem (T311 Int Bool) Bool)
(declare-fun var_u74 () Int)
(declare-fun nil () T311)
(declare-fun set108 (Int) Bool)
(declare-fun shd (T311 Int) Bool)
(declare-fun slen (T311) Int)
(declare-fun set109 (Bool) Bool)
(declare-fun var_u75 () Int)
(declare-fun set110 (Int) Bool)
(declare-fun set111 (Bool) Bool)
(declare-fun ulist (T311 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set107 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u74 bv0) (set107 bv0))))
(assert (forall ((bv0 Int)) (= (set108 bv0) (and (= bv0 var_u74)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set108 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set109 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u75 bv0) (set109 bv0))))
(assert (forall ((bv0 Int)) (= (set110 bv0) (and (= bv0 var_u75)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set110 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set111 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set111 bv0)))))

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
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                                 
# of Final Z3 expressions 38
 Final solver 
 (declare-sort T314 0)
(declare-fun set112 (Bool) Bool)
(declare-fun smem (T314 Int Bool) Bool)
(declare-fun var_u76 () Int)
(declare-fun nil () T314)
(declare-fun set113 (Int) Bool)
(declare-fun shd (T314 Int) Bool)
(declare-fun slen (T314) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set112 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u76 bv0) (set112 bv0))))
(assert (forall ((bv0 Int)) (= (set113 bv0) (and (= bv0 var_u76)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set113 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                                                      
# of Final Z3 expressions 35
 Final solver 
 (declare-sort T318 0)
(declare-fun set114 (Bool) Bool)
(declare-fun smem (T318 Int Bool) Bool)
(declare-fun var_u77 () Int)
(declare-fun nil () T318)
(declare-fun set115 (Int) Bool)
(declare-fun shd (T318 Int) Bool)
(declare-fun slen (T318) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set114 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u77 bv0) (set114 bv0))))
(assert (forall ((bv0 Int)) (= (set115 bv0) (and (= bv0 var_u77)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set115 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
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
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T322 0)
(declare-fun set116 (Bool) Bool)
(declare-fun smem (T322 Int Bool) Bool)
(declare-fun var_u78 () Int)
(declare-fun nil () T322)
(declare-fun set117 (Int) Bool)
(declare-fun shd (T322 Int) Bool)
(declare-fun slen (T322) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set116 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u78 bv0) (set116 bv0))))
(assert (forall ((bv0 Int)) (= (set117 bv0) (and (= bv0 var_u78)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set117 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T326 0)
(declare-fun set118 (Bool) Bool)
(declare-fun smem (T326 Int Bool) Bool)
(declare-fun var_u79 () Int)
(declare-fun nil () T326)
(declare-fun set119 (Int) Bool)
(declare-fun shd (T326 Int) Bool)
(declare-fun slen (T326) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set118 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u79 bv0) (set118 bv0))))
(assert (forall ((bv0 Int)) (= (set119 bv0) (and (= bv0 var_u79)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set119 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> _lbv1 |0|) (= _lbv1 |0|)) (> s _lbv1))))

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
 ##################################################################################
  Synthesizing the 2th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 4
 Possible Arg Options 
 EI _lbv1
 EI _lbv1
 Possible Arg Options 
 EI _lbv1
 EI _lbv0
 Possible Arg Options 
 EI _lbv1
 EI x0
 Possible Arg Options 
 EI _lbv1
 EI s
 Show f (ei, e2, ....en) Case
 Finding Already seen tree for apply goal  (, _lbv1 ), _lbv1 )
 Typechecking apply goal  (, apply subs  (, s ) ), apply subs  (, s ) )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Typechecking the Term apply goal  (, _lbv1 ), _lbv1 )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))                                                                                                                                                                                                        
# of Final Z3 expressions 40
 Final solver 
 (declare-sort T346 0)
(declare-fun set120 (Bool) Bool)
(declare-fun smem (T346 Int Bool) Bool)
(declare-fun var_u80 () Int)
(declare-fun nil () T346)
(declare-fun set121 (Int) Bool)
(declare-fun shd (T346 Int) Bool)
(declare-fun slen (T346) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set122 (Bool) Bool)
(declare-fun var_u81 () Int)
(declare-fun v () T346)
(declare-fun set123 (Bool) Bool)
(declare-fun var_u82 () Int)
(declare-fun set124 (Bool) Bool)
(declare-fun ulist (T346 Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set120 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u80 bv0) (set120 bv0))))
(assert (forall ((bv0 Int)) (= (set121 bv0) (and (= bv0 var_u80)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set121 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set122 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u81 bv0) (set122 bv0)))
    (= var_u81 _lbv1)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= _lbv1 (- s 1)))
(assert (forall ((bv0 Bool)) (= (set123 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u82 bv0) (set123 bv0)))
    (= var_u82 _lbv1)))
(assert (forall ((bv0 Bool)) (= (set124 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist v bv0) (set124 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), _lbv1 )
 Finding Already seen tree for apply goal  (, _lbv1 ), _lbv0 )
 Typechecking apply goal  (, apply subs  (, s ) ), apply subs  (, x0 ) )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Typechecking the Term apply goal  (, _lbv1 ), _lbv0 )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))                                                                                                                                                                                                        
# of Final Z3 expressions 40
 Final solver 
 (declare-sort T350 0)
(declare-fun set125 (Bool) Bool)
(declare-fun smem (T350 Int Bool) Bool)
(declare-fun var_u83 () Int)
(declare-fun nil () T350)
(declare-fun set126 (Int) Bool)
(declare-fun shd (T350 Int) Bool)
(declare-fun slen (T350) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set127 (Bool) Bool)
(declare-fun var_u84 () Int)
(declare-fun v () T350)
(declare-fun set128 (Bool) Bool)
(declare-fun var_u85 () Int)
(declare-fun set129 (Bool) Bool)
(declare-fun ulist (T350 Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set125 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u83 bv0) (set125 bv0))))
(assert (forall ((bv0 Int)) (= (set126 bv0) (and (= bv0 var_u83)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set126 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set127 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u84 bv0) (set127 bv0)))
    (= var_u84 _lbv0)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= _lbv0 (- x0 1)))
(assert (forall ((bv0 Bool)) (= (set128 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u85 bv0) (set128 bv0)))
    (= var_u85 _lbv0)))
(assert (forall ((bv0 Bool)) (= (set129 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist v bv0) (set129 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), _lbv0 )
 Finding Already seen tree for apply goal  (, _lbv1 ), x0 )
 Typechecking apply goal  (, apply subs  (, s ) ), x0 )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Typechecking the Term apply goal  (, _lbv1 ), x0 )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                                        
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T354 0)
(declare-fun set130 (Bool) Bool)
(declare-fun smem (T354 Int Bool) Bool)
(declare-fun var_u86 () Int)
(declare-fun nil () T354)
(declare-fun set131 (Int) Bool)
(declare-fun shd (T354 Int) Bool)
(declare-fun slen (T354) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set132 (Bool) Bool)
(declare-fun var_u87 () Int)
(declare-fun v () T354)
(declare-fun set133 (Bool) Bool)
(declare-fun var_u88 () Int)
(declare-fun set134 (Bool) Bool)
(declare-fun ulist (T354 Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set130 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u86 bv0) (set130 bv0))))
(assert (forall ((bv0 Int)) (= (set131 bv0) (and (= bv0 var_u86)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set131 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set132 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u87 bv0) (set132 bv0))) (= var_u87 x0)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (forall ((bv0 Bool)) (= (set133 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u88 bv0) (set133 bv0))) (= var_u88 x0)))
(assert (forall ((bv0 Bool)) (= (set134 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist v bv0) (set134 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), x0 )
 Finding Already seen tree for apply goal  (, _lbv1 ), s )
 Typechecking apply goal  (, apply subs  (, s ) ), s )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Typechecking the Term apply goal  (, _lbv1 ), s )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                                    
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T358 0)
(declare-fun set135 (Bool) Bool)
(declare-fun smem (T358 Int Bool) Bool)
(declare-fun var_u89 () Int)
(declare-fun nil () T358)
(declare-fun set136 (Int) Bool)
(declare-fun shd (T358 Int) Bool)
(declare-fun slen (T358) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set137 (Bool) Bool)
(declare-fun var_u90 () Int)
(declare-fun v () T358)
(declare-fun set138 (Bool) Bool)
(declare-fun var_u91 () Int)
(declare-fun set139 (Bool) Bool)
(declare-fun ulist (T358 Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set135 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u89 bv0) (set135 bv0))))
(assert (forall ((bv0 Int)) (= (set136 bv0) (and (= bv0 var_u89)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set136 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set137 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u90 bv0) (set137 bv0))) (= var_u90 s)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set138 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u91 bv0) (set138 bv0))) (= var_u91 s)))
(assert (forall ((bv0 Bool)) (= (set139 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist v bv0) (set139 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), s )
  ###################################################
  The Choice of Function goal Was Ill Fated Try Next Choice of function
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                            
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T379 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set140 (Bool) Bool)
(declare-fun smem (T379 Int Bool) Bool)
(declare-fun var_u92 () Int)
(declare-fun nil () T379)
(declare-fun set141 (Int) Bool)
(declare-fun shd (T379 Int) Bool)
(declare-fun slen (T379) Int)
(declare-fun set142 (Bool) Bool)
(declare-fun var_u93 () Int)
(declare-fun set143 (Int) Bool)
(declare-fun set144 (Bool) Bool)
(declare-fun ulist (T379 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set140 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u92 bv0) (set140 bv0))))
(assert (forall ((bv0 Int)) (= (set141 bv0) (and (= bv0 var_u92)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set141 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set142 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u93 bv0) (set142 bv0))))
(assert (forall ((bv0 Int)) (= (set143 bv0) (and (= bv0 var_u93)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set143 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set144 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set144 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 Found Constructors with required return type
  
 ********************** HERE BEFORE 
 Show No more choices for ConsApp
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
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                                 
# of Final Z3 expressions 38
 Final solver 
 (declare-sort T382 0)
(declare-fun set145 (Bool) Bool)
(declare-fun smem (T382 Int Bool) Bool)
(declare-fun var_u94 () Int)
(declare-fun nil () T382)
(declare-fun set146 (Int) Bool)
(declare-fun shd (T382 Int) Bool)
(declare-fun slen (T382) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set145 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u94 bv0) (set145 bv0))))
(assert (forall ((bv0 Int)) (= (set146 bv0) (and (= bv0 var_u94)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set146 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                                                      
# of Final Z3 expressions 35
 Final solver 
 (declare-sort T386 0)
(declare-fun set147 (Bool) Bool)
(declare-fun smem (T386 Int Bool) Bool)
(declare-fun var_u95 () Int)
(declare-fun nil () T386)
(declare-fun set148 (Int) Bool)
(declare-fun shd (T386 Int) Bool)
(declare-fun slen (T386) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set147 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u95 bv0) (set147 bv0))))
(assert (forall ((bv0 Int)) (= (set148 bv0) (and (= bv0 var_u95)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set148 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
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
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T390 0)
(declare-fun set149 (Bool) Bool)
(declare-fun smem (T390 Int Bool) Bool)
(declare-fun var_u96 () Int)
(declare-fun nil () T390)
(declare-fun set150 (Int) Bool)
(declare-fun shd (T390 Int) Bool)
(declare-fun slen (T390) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set149 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u96 bv0) (set149 bv0))))
(assert (forall ((bv0 Int)) (= (set150 bv0) (and (= bv0 var_u96)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set150 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 36
 Final solver 
 (declare-sort T394 0)
(declare-fun set151 (Bool) Bool)
(declare-fun smem (T394 Int Bool) Bool)
(declare-fun var_u97 () Int)
(declare-fun nil () T394)
(declare-fun set152 (Int) Bool)
(declare-fun shd (T394 Int) Bool)
(declare-fun slen (T394) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(assert (forall ((bv0 Bool)) (= (set151 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u97 bv0) (set151 bv0))))
(assert (forall ((bv0 Int)) (= (set152 bv0) (and (= bv0 var_u97)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set152 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> _lbv1 |0|) (= _lbv1 |0|)) (> s _lbv1))))

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
 ##################################################################################
  Synthesizing the 2th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 # of Possible Argument Options for goal 4
 Possible Arg Options 
 EI _lbv1
 EI _lbv1
 Possible Arg Options 
 EI _lbv1
 EI _lbv0
 Possible Arg Options 
 EI _lbv1
 EI x0
 Possible Arg Options 
 EI _lbv1
 EI s
 Show f (ei, e2, ....en) Case
 Finding Already seen tree for apply goal  (, _lbv1 ), _lbv1 )
 Typechecking apply goal  (, apply subs  (, s ) ), apply subs  (, s ) )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Typechecking the Term apply goal  (, _lbv1 ), _lbv1 )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))                                                                                                                                                                                                        
# of Final Z3 expressions 40
 Final solver 
 (declare-sort T414 0)
(declare-fun set153 (Bool) Bool)
(declare-fun smem (T414 Int Bool) Bool)
(declare-fun var_u98 () Int)
(declare-fun nil () T414)
(declare-fun set154 (Int) Bool)
(declare-fun shd (T414 Int) Bool)
(declare-fun slen (T414) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set155 (Bool) Bool)
(declare-fun var_u99 () Int)
(declare-fun v () T414)
(declare-fun set156 (Bool) Bool)
(declare-fun var_u100 () Int)
(declare-fun set157 (Bool) Bool)
(declare-fun ulist (T414 Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set153 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u98 bv0) (set153 bv0))))
(assert (forall ((bv0 Int)) (= (set154 bv0) (and (= bv0 var_u98)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set154 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set155 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u99 bv0) (set155 bv0)))
    (= var_u99 _lbv1)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= _lbv1 (- s 1)))
(assert (forall ((bv0 Bool)) (= (set156 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u100 bv0) (set156 bv0)))
    (= var_u100 _lbv1)))
(assert (forall ((bv0 Bool)) (= (set157 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist v bv0) (set157 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), _lbv1 )
 Finding Already seen tree for apply goal  (, _lbv1 ), _lbv0 )
 Typechecking apply goal  (, apply subs  (, s ) ), apply subs  (, x0 ) )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Typechecking the Term apply goal  (, _lbv1 ), _lbv0 )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))                                                                                                                                                                                                        
# of Final Z3 expressions 40
 Final solver 
 (declare-sort T418 0)
(declare-fun set158 (Bool) Bool)
(declare-fun smem (T418 Int Bool) Bool)
(declare-fun var_u101 () Int)
(declare-fun nil () T418)
(declare-fun set159 (Int) Bool)
(declare-fun shd (T418 Int) Bool)
(declare-fun slen (T418) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set160 (Bool) Bool)
(declare-fun var_u102 () Int)
(declare-fun v () T418)
(declare-fun set161 (Bool) Bool)
(declare-fun var_u103 () Int)
(declare-fun set162 (Bool) Bool)
(declare-fun ulist (T418 Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set158 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u101 bv0) (set158 bv0))))
(assert (forall ((bv0 Int)) (= (set159 bv0) (and (= bv0 var_u101)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set159 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set160 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u102 bv0) (set160 bv0)))
    (= var_u102 _lbv0)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= _lbv0 (- x0 1)))
(assert (forall ((bv0 Bool)) (= (set161 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u103 bv0) (set161 bv0)))
    (= var_u103 _lbv0)))
(assert (forall ((bv0 Bool)) (= (set162 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist v bv0) (set162 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), _lbv0 )
 Finding Already seen tree for apply goal  (, _lbv1 ), x0 )
 Typechecking apply goal  (, apply subs  (, s ) ), x0 )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Typechecking the Term apply goal  (, _lbv1 ), x0 )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                                        
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T422 0)
(declare-fun set163 (Bool) Bool)
(declare-fun smem (T422 Int Bool) Bool)
(declare-fun var_u104 () Int)
(declare-fun nil () T422)
(declare-fun set164 (Int) Bool)
(declare-fun shd (T422 Int) Bool)
(declare-fun slen (T422) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set165 (Bool) Bool)
(declare-fun var_u105 () Int)
(declare-fun v () T422)
(declare-fun set166 (Bool) Bool)
(declare-fun var_u106 () Int)
(declare-fun set167 (Bool) Bool)
(declare-fun ulist (T422 Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set163 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u104 bv0) (set163 bv0))))
(assert (forall ((bv0 Int)) (= (set164 bv0) (and (= bv0 var_u104)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set164 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set165 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u105 bv0) (set165 bv0)))
    (= var_u105 x0)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (forall ((bv0 Bool)) (= (set166 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u106 bv0) (set166 bv0)))
    (= var_u106 x0)))
(assert (forall ((bv0 Bool)) (= (set167 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist v bv0) (set167 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), x0 )
 Finding Already seen tree for apply goal  (, _lbv1 ), s )
 Typechecking apply goal  (, apply subs  (, s ) ), s )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Typechecking the Term apply goal  (, _lbv1 ), s )
 Against {v:Ty_alphalist | (ulist)(v) = (true)}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                                    
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T426 0)
(declare-fun set168 (Bool) Bool)
(declare-fun smem (T426 Int Bool) Bool)
(declare-fun var_u107 () Int)
(declare-fun nil () T426)
(declare-fun set169 (Int) Bool)
(declare-fun shd (T426 Int) Bool)
(declare-fun slen (T426) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set170 (Bool) Bool)
(declare-fun var_u108 () Int)
(declare-fun v () T426)
(declare-fun set171 (Bool) Bool)
(declare-fun var_u109 () Int)
(declare-fun set172 (Bool) Bool)
(declare-fun ulist (T426 Bool) Bool)
(assert (forall ((bv0 Bool)) (= (set168 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u107 bv0) (set168 bv0))))
(assert (forall ((bv0 Int)) (= (set169 bv0) (and (= bv0 var_u107)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set169 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set170 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u108 bv0) (set170 bv0))) (= var_u108 s)))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set171 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u109 bv0) (set171 bv0))) (= var_u109 s)))
(assert (forall ((bv0 Bool)) (= (set172 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist v bv0) (set172 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv1 ), s )
  ###################################################
  The Choice of Function goal Was Ill Fated Try Next Choice of function
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                            
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T447 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun set173 (Bool) Bool)
(declare-fun smem (T447 Int Bool) Bool)
(declare-fun var_u110 () Int)
(declare-fun nil () T447)
(declare-fun set174 (Int) Bool)
(declare-fun shd (T447 Int) Bool)
(declare-fun slen (T447) Int)
(declare-fun set175 (Bool) Bool)
(declare-fun var_u111 () Int)
(declare-fun set176 (Int) Bool)
(declare-fun set177 (Bool) Bool)
(declare-fun ulist (T447 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set173 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u110 bv0) (set173 bv0))))
(assert (forall ((bv0 Int)) (= (set174 bv0) (and (= bv0 var_u110)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set174 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v42 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (forall ((bv0 Bool)) (= (set175 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u111 bv0) (set175 bv0))))
(assert (forall ((bv0 Int)) (= (set176 bv0) (and (= bv0 var_u111)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set176 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set177 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set177 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 Found Constructors with required return type
  
 ********************** HERE BEFORE 
 Show No more choices for ConsApp
 Failed Synthesizing any True Branch exp for the selected guard_lbv4
 Try Next guard
 Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard apply sizecheck  (, s )
  *********************Synthesizing the True branch*******************
 Show :: True Predicate 
 	 Conj <c var_v112 = true
 	 , DoubleImpl 
 var_v112 = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 var_v112 = false
  s > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  Enumeration for 
 spec 
 {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                                                         
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T451 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun set178 (Bool) Bool)
(declare-fun smem (T451 Int Bool) Bool)
(declare-fun var_u113 () Int)
(declare-fun nil () T451)
(declare-fun set179 (Int) Bool)
(declare-fun shd (T451 Int) Bool)
(declare-fun slen (T451) Int)
(declare-fun set180 (Bool) Bool)
(declare-fun var_u114 () Int)
(declare-fun set181 (Int) Bool)
(declare-fun set182 (Bool) Bool)
(declare-fun var_u115 () Int)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set178 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u113 bv0) (set178 bv0))))
(assert (forall ((bv0 Int)) (= (set179 bv0) (and (= bv0 var_u113)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set179 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set180 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u114 bv0) (set180 bv0))))
(assert (forall ((bv0 Int)) (= (set181 bv0) (and (= bv0 var_u114)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set181 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set182 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem nil var_u115 bv0) (set182 bv0)))
               (= var_u115 x0))))
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
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                                                        
# of Final Z3 expressions 41
 Final solver 
 (declare-sort T454 0)
(declare-fun set183 (Bool) Bool)
(declare-fun smem (T454 Int Bool) Bool)
(declare-fun var_u116 () Int)
(declare-fun nil () T454)
(declare-fun set184 (Int) Bool)
(declare-fun shd (T454 Int) Bool)
(declare-fun slen (T454) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set183 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u116 bv0) (set183 bv0))))
(assert (forall ((bv0 Int)) (= (set184 bv0) (and (= bv0 var_u116)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set184 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                                                                             
# of Final Z3 expressions 38
 Final solver 
 (declare-sort T458 0)
(declare-fun set185 (Bool) Bool)
(declare-fun smem (T458 Int Bool) Bool)
(declare-fun var_u117 () Int)
(declare-fun nil () T458)
(declare-fun set186 (Int) Bool)
(declare-fun shd (T458 Int) Bool)
(declare-fun slen (T458) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set185 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u117 bv0) (set185 bv0))))
(assert (forall ((bv0 Int)) (= (set186 bv0) (and (= bv0 var_u117)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set186 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
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
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T462 0)
(declare-fun set187 (Bool) Bool)
(declare-fun smem (T462 Int Bool) Bool)
(declare-fun var_u118 () Int)
(declare-fun nil () T462)
(declare-fun set188 (Int) Bool)
(declare-fun shd (T462 Int) Bool)
(declare-fun slen (T462) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set187 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u118 bv0) (set187 bv0))))
(assert (forall ((bv0 Int)) (= (set188 bv0) (and (= bv0 var_u118)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set188 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T466 0)
(declare-fun set189 (Bool) Bool)
(declare-fun smem (T466 Int Bool) Bool)
(declare-fun var_u119 () Int)
(declare-fun nil () T466)
(declare-fun set190 (Int) Bool)
(declare-fun shd (T466 Int) Bool)
(declare-fun slen (T466) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set189 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u119 bv0) (set189 bv0))))
(assert (forall ((bv0 Int)) (= (set190 bv0) (and (= bv0 var_u119)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set190 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv1 (- s 1)))
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
  Enumeration for 
 spec 
 {v:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv1 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                                                                     
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T486 0)
(declare-fun set191 (Bool) Bool)
(declare-fun smem (T486 Int Bool) Bool)
(declare-fun var_u120 () Int)
(declare-fun nil () T486)
(declare-fun set192 (Int) Bool)
(declare-fun shd (T486 Int) Bool)
(declare-fun slen (T486) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun set193 (Bool) Bool)
(declare-fun var_u121 () Int)
(declare-fun v () T486)
(declare-fun set194 (Bool) Bool)
(declare-fun var_u122 () Int)
(declare-fun set195 (Bool) Bool)
(declare-fun var_u123 () Int)
(assert (forall ((bv0 Bool)) (= (set191 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u120 bv0) (set191 bv0))))
(assert (forall ((bv0 Int)) (= (set192 bv0) (and (= bv0 var_u120)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set192 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set193 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u121 bv0) (set193 bv0)))
    (= var_u121 x0)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (forall ((bv0 Bool)) (= (set194 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u122 bv0) (set194 bv0)))
    (= var_u122 x0)))
(assert (forall ((bv0 Bool)) (= (set195 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u123 bv0) (set195 bv0)))
               (= var_u123 x0))))
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv1 ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                                                                 
# of Final Z3 expressions 45
 Final solver 
 (declare-sort T490 0)
(declare-fun set196 (Bool) Bool)
(declare-fun smem (T490 Int Bool) Bool)
(declare-fun var_u124 () Int)
(declare-fun nil () T490)
(declare-fun set197 (Int) Bool)
(declare-fun shd (T490 Int) Bool)
(declare-fun slen (T490) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun set198 (Bool) Bool)
(declare-fun var_u125 () Int)
(declare-fun v () T490)
(declare-fun set199 (Bool) Bool)
(declare-fun var_u126 () Int)
(declare-fun set200 (Bool) Bool)
(declare-fun var_u127 () Int)
(assert (forall ((bv0 Bool)) (= (set196 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u124 bv0) (set196 bv0))))
(assert (forall ((bv0 Int)) (= (set197 bv0) (and (= bv0 var_u124)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set197 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set198 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u125 bv0) (set198 bv0))) (= var_u125 s)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set199 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u126 bv0) (set199 bv0))) (= var_u126 s)))
(assert (forall ((bv0 Bool)) (= (set200 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u127 bv0) (set200 bv0)))
               (= var_u127 x0))))
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv0 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                                                                     
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T494 0)
(declare-fun set201 (Bool) Bool)
(declare-fun smem (T494 Int Bool) Bool)
(declare-fun var_u128 () Int)
(declare-fun nil () T494)
(declare-fun set202 (Int) Bool)
(declare-fun shd (T494 Int) Bool)
(declare-fun slen (T494) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun set203 (Bool) Bool)
(declare-fun var_u129 () Int)
(declare-fun v () T494)
(declare-fun set204 (Bool) Bool)
(declare-fun var_u130 () Int)
(declare-fun set205 (Bool) Bool)
(declare-fun var_u131 () Int)
(assert (forall ((bv0 Bool)) (= (set201 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u128 bv0) (set201 bv0))))
(assert (forall ((bv0 Int)) (= (set202 bv0) (and (= bv0 var_u128)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set202 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set203 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u129 bv0) (set203 bv0)))
    (= var_u129 x0)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (forall ((bv0 Bool)) (= (set204 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u130 bv0) (set204 bv0)))
    (= var_u130 x0)))
(assert (forall ((bv0 Bool)) (= (set205 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u131 bv0) (set205 bv0)))
               (= var_u131 x0))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv0 ), x0 )
 Finding Already seen tree for apply goal  (, _lbv0 ), s )
 Typechecking apply goal  (, apply subs  (, x0 ) ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv0 ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                                                                 
# of Final Z3 expressions 45
 Final solver 
 (declare-sort T498 0)
(declare-fun set206 (Bool) Bool)
(declare-fun smem (T498 Int Bool) Bool)
(declare-fun var_u132 () Int)
(declare-fun nil () T498)
(declare-fun set207 (Int) Bool)
(declare-fun shd (T498 Int) Bool)
(declare-fun slen (T498) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun set208 (Bool) Bool)
(declare-fun var_u133 () Int)
(declare-fun v () T498)
(declare-fun set209 (Bool) Bool)
(declare-fun var_u134 () Int)
(declare-fun set210 (Bool) Bool)
(declare-fun var_u135 () Int)
(assert (forall ((bv0 Bool)) (= (set206 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u132 bv0) (set206 bv0))))
(assert (forall ((bv0 Int)) (= (set207 bv0) (and (= bv0 var_u132)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set207 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set208 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u133 bv0) (set208 bv0))) (= var_u133 s)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set209 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u134 bv0) (set209 bv0))) (= var_u134 s)))
(assert (forall ((bv0 Bool)) (= (set210 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u135 bv0) (set210 bv0)))
               (= var_u135 x0))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv0 ), s )
  ###################################################
  The Choice of Function goal Was Ill Fated Try Next Choice of function
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
  Enumeration for 
 spec 
 {v:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                                                   
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T527 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun set211 (Bool) Bool)
(declare-fun smem (T527 Int Bool) Bool)
(declare-fun var_u136 () Int)
(declare-fun nil () T527)
(declare-fun set212 (Int) Bool)
(declare-fun shd (T527 Int) Bool)
(declare-fun slen (T527) Int)
(declare-fun set213 (Bool) Bool)
(declare-fun var_u137 () Int)
(declare-fun set214 (Int) Bool)
(declare-fun set215 (Bool) Bool)
(declare-fun ulist (T527 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set211 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u136 bv0) (set211 bv0))))
(assert (forall ((bv0 Int)) (= (set212 bv0) (and (= bv0 var_u136)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set212 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set213 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u137 bv0) (set213 bv0))))
(assert (forall ((bv0 Int)) (= (set214 bv0) (and (= bv0 var_u137)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set214 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set215 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set215 bv0)))))

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
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                                                        
# of Final Z3 expressions 41
 Final solver 
 (declare-sort T530 0)
(declare-fun set216 (Bool) Bool)
(declare-fun smem (T530 Int Bool) Bool)
(declare-fun var_u138 () Int)
(declare-fun nil () T530)
(declare-fun set217 (Int) Bool)
(declare-fun shd (T530 Int) Bool)
(declare-fun slen (T530) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set216 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u138 bv0) (set216 bv0))))
(assert (forall ((bv0 Int)) (= (set217 bv0) (and (= bv0 var_u138)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set217 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                                                                             
# of Final Z3 expressions 38
 Final solver 
 (declare-sort T534 0)
(declare-fun set218 (Bool) Bool)
(declare-fun smem (T534 Int Bool) Bool)
(declare-fun var_u139 () Int)
(declare-fun nil () T534)
(declare-fun set219 (Int) Bool)
(declare-fun shd (T534 Int) Bool)
(declare-fun slen (T534) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set218 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u139 bv0) (set218 bv0))))
(assert (forall ((bv0 Int)) (= (set219 bv0) (and (= bv0 var_u139)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set219 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
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
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T538 0)
(declare-fun set220 (Bool) Bool)
(declare-fun smem (T538 Int Bool) Bool)
(declare-fun var_u140 () Int)
(declare-fun nil () T538)
(declare-fun set221 (Int) Bool)
(declare-fun shd (T538 Int) Bool)
(declare-fun slen (T538) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set220 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u140 bv0) (set220 bv0))))
(assert (forall ((bv0 Int)) (= (set221 bv0) (and (= bv0 var_u140)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set221 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T542 0)
(declare-fun set222 (Bool) Bool)
(declare-fun smem (T542 Int Bool) Bool)
(declare-fun var_u141 () Int)
(declare-fun nil () T542)
(declare-fun set223 (Int) Bool)
(declare-fun shd (T542 Int) Bool)
(declare-fun slen (T542) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set222 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u141 bv0) (set222 bv0))))
(assert (forall ((bv0 Int)) (= (set223 bv0) (and (= bv0 var_u141)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set223 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv1 (- s 1)))
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
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                                                   
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T579 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun set224 (Bool) Bool)
(declare-fun smem (T579 Int Bool) Bool)
(declare-fun var_u142 () Int)
(declare-fun nil () T579)
(declare-fun set225 (Int) Bool)
(declare-fun shd (T579 Int) Bool)
(declare-fun slen (T579) Int)
(declare-fun set226 (Bool) Bool)
(declare-fun var_u143 () Int)
(declare-fun set227 (Int) Bool)
(declare-fun set228 (Bool) Bool)
(declare-fun ulist (T579 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set224 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u142 bv0) (set224 bv0))))
(assert (forall ((bv0 Int)) (= (set225 bv0) (and (= bv0 var_u142)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set225 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set226 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u143 bv0) (set226 bv0))))
(assert (forall ((bv0 Int)) (= (set227 bv0) (and (= bv0 var_u143)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set227 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set228 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set228 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 Found Constructors with required return type
  
 ********************** HERE BEFORE 
 Show No more choices for ConsApp
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
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                                                        
# of Final Z3 expressions 41
 Final solver 
 (declare-sort T582 0)
(declare-fun set229 (Bool) Bool)
(declare-fun smem (T582 Int Bool) Bool)
(declare-fun var_u144 () Int)
(declare-fun nil () T582)
(declare-fun set230 (Int) Bool)
(declare-fun shd (T582 Int) Bool)
(declare-fun slen (T582) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set229 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u144 bv0) (set229 bv0))))
(assert (forall ((bv0 Int)) (= (set230 bv0) (and (= bv0 var_u144)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set230 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                                                                             
# of Final Z3 expressions 38
 Final solver 
 (declare-sort T586 0)
(declare-fun set231 (Bool) Bool)
(declare-fun smem (T586 Int Bool) Bool)
(declare-fun var_u145 () Int)
(declare-fun nil () T586)
(declare-fun set232 (Int) Bool)
(declare-fun shd (T586 Int) Bool)
(declare-fun slen (T586) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set231 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u145 bv0) (set231 bv0))))
(assert (forall ((bv0 Int)) (= (set232 bv0) (and (= bv0 var_u145)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set232 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
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
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T590 0)
(declare-fun set233 (Bool) Bool)
(declare-fun smem (T590 Int Bool) Bool)
(declare-fun var_u146 () Int)
(declare-fun nil () T590)
(declare-fun set234 (Int) Bool)
(declare-fun shd (T590 Int) Bool)
(declare-fun slen (T590) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set233 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u146 bv0) (set233 bv0))))
(assert (forall ((bv0 Int)) (= (set234 bv0) (and (= bv0 var_u146)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set234 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 39
 Final solver 
 (declare-sort T594 0)
(declare-fun set235 (Bool) Bool)
(declare-fun smem (T594 Int Bool) Bool)
(declare-fun var_u147 () Int)
(declare-fun nil () T594)
(declare-fun set236 (Int) Bool)
(declare-fun shd (T594 Int) Bool)
(declare-fun slen (T594) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(assert (forall ((bv0 Bool)) (= (set235 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u147 bv0) (set235 bv0))))
(assert (forall ((bv0 Int)) (= (set236 bv0) (and (= bv0 var_u147)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set236 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= _lbv1 (- s 1)))
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
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                                                   
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T631 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun set237 (Bool) Bool)
(declare-fun smem (T631 Int Bool) Bool)
(declare-fun var_u148 () Int)
(declare-fun nil () T631)
(declare-fun set238 (Int) Bool)
(declare-fun shd (T631 Int) Bool)
(declare-fun slen (T631) Int)
(declare-fun set239 (Bool) Bool)
(declare-fun var_u149 () Int)
(declare-fun set240 (Int) Bool)
(declare-fun set241 (Bool) Bool)
(declare-fun ulist (T631 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set237 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u148 bv0) (set237 bv0))))
(assert (forall ((bv0 Int)) (= (set238 bv0) (and (= bv0 var_u148)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set238 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v112 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (forall ((bv0 Bool)) (= (set239 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u149 bv0) (set239 bv0))))
(assert (forall ((bv0 Int)) (= (set240 bv0) (and (= bv0 var_u149)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set240 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set241 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set241 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 Found Constructors with required return type
  
 ********************** HERE BEFORE 
 Show No more choices for ConsApp
 Failed Synthesizing any True Branch exp for the selected guard_lbv3
 Try Next guard
 Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard apply sizecheck  (, x0 )
  *********************Synthesizing the True branch*******************
 Show :: True Predicate 
 	 Conj <c var_v150 = true
 	 , DoubleImpl 
 var_v150 = true
  
 	 Conj <c x0 = 0
 	 , DoubleImpl 
 var_v150 = false
  x0 > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  Enumeration for 
 spec 
 {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                                                                                
# of Final Z3 expressions 45
 Final solver 
 (declare-sort T635 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(declare-fun set242 (Bool) Bool)
(declare-fun smem (T635 Int Bool) Bool)
(declare-fun var_u151 () Int)
(declare-fun nil () T635)
(declare-fun set243 (Int) Bool)
(declare-fun shd (T635 Int) Bool)
(declare-fun slen (T635) Int)
(declare-fun set244 (Bool) Bool)
(declare-fun var_u152 () Int)
(declare-fun set245 (Int) Bool)
(declare-fun set246 (Bool) Bool)
(declare-fun var_u153 () Int)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set242 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u151 bv0) (set242 bv0))))
(assert (forall ((bv0 Int)) (= (set243 bv0) (and (= bv0 var_u151)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set243 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set244 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u152 bv0) (set244 bv0))))
(assert (forall ((bv0 Int)) (= (set245 bv0) (and (= bv0 var_u152)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set245 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set246 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem nil var_u153 bv0) (set246 bv0)))
               (= var_u153 x0))))
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
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                                                                               
# of Final Z3 expressions 44
 Final solver 
 (declare-sort T638 0)
(declare-fun set247 (Bool) Bool)
(declare-fun smem (T638 Int Bool) Bool)
(declare-fun var_u154 () Int)
(declare-fun nil () T638)
(declare-fun set248 (Int) Bool)
(declare-fun shd (T638 Int) Bool)
(declare-fun slen (T638) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set247 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u154 bv0) (set247 bv0))))
(assert (forall ((bv0 Int)) (= (set248 bv0) (and (= bv0 var_u154)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set248 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                                                                                                    
# of Final Z3 expressions 41
 Final solver 
 (declare-sort T642 0)
(declare-fun set249 (Bool) Bool)
(declare-fun smem (T642 Int Bool) Bool)
(declare-fun var_u155 () Int)
(declare-fun nil () T642)
(declare-fun set250 (Int) Bool)
(declare-fun shd (T642 Int) Bool)
(declare-fun slen (T642) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set249 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u155 bv0) (set249 bv0))))
(assert (forall ((bv0 Int)) (= (set250 bv0) (and (= bv0 var_u155)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set250 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
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
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T646 0)
(declare-fun set251 (Bool) Bool)
(declare-fun smem (T646 Int Bool) Bool)
(declare-fun var_u156 () Int)
(declare-fun nil () T646)
(declare-fun set252 (Int) Bool)
(declare-fun shd (T646 Int) Bool)
(declare-fun slen (T646) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set251 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u156 bv0) (set251 bv0))))
(assert (forall ((bv0 Int)) (= (set252 bv0) (and (= bv0 var_u156)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set252 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T650 0)
(declare-fun set253 (Bool) Bool)
(declare-fun smem (T650 Int Bool) Bool)
(declare-fun var_u157 () Int)
(declare-fun nil () T650)
(declare-fun set254 (Int) Bool)
(declare-fun shd (T650 Int) Bool)
(declare-fun slen (T650) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set253 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u157 bv0) (set253 bv0))))
(assert (forall ((bv0 Int)) (= (set254 bv0) (and (= bv0 var_u157)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set254 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv1 (- s 1)))
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
  Enumeration for 
 spec 
 {v:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv1 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                                                                                            
# of Final Z3 expressions 45
 Final solver 
 (declare-sort T670 0)
(declare-fun set255 (Bool) Bool)
(declare-fun smem (T670 Int Bool) Bool)
(declare-fun var_u158 () Int)
(declare-fun nil () T670)
(declare-fun set256 (Int) Bool)
(declare-fun shd (T670 Int) Bool)
(declare-fun slen (T670) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(declare-fun set257 (Bool) Bool)
(declare-fun var_u159 () Int)
(declare-fun v () T670)
(declare-fun set258 (Bool) Bool)
(declare-fun var_u160 () Int)
(declare-fun set259 (Bool) Bool)
(declare-fun var_u161 () Int)
(assert (forall ((bv0 Bool)) (= (set255 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u158 bv0) (set255 bv0))))
(assert (forall ((bv0 Int)) (= (set256 bv0) (and (= bv0 var_u158)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set256 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set257 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u159 bv0) (set257 bv0)))
    (= var_u159 x0)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (forall ((bv0 Bool)) (= (set258 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u160 bv0) (set258 bv0)))
    (= var_u160 x0)))
(assert (forall ((bv0 Bool)) (= (set259 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u161 bv0) (set259 bv0)))
               (= var_u161 x0))))
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv1 ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv1 :: {v:Ty_int | (v) ==((s) -- (1))} | (_lbv1) ==((s) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                                                                                        
# of Final Z3 expressions 48
 Final solver 
 (declare-sort T674 0)
(declare-fun set260 (Bool) Bool)
(declare-fun smem (T674 Int Bool) Bool)
(declare-fun var_u162 () Int)
(declare-fun nil () T674)
(declare-fun set261 (Int) Bool)
(declare-fun shd (T674 Int) Bool)
(declare-fun slen (T674) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(declare-fun set262 (Bool) Bool)
(declare-fun var_u163 () Int)
(declare-fun v () T674)
(declare-fun set263 (Bool) Bool)
(declare-fun var_u164 () Int)
(declare-fun set264 (Bool) Bool)
(declare-fun var_u165 () Int)
(assert (forall ((bv0 Bool)) (= (set260 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u162 bv0) (set260 bv0))))
(assert (forall ((bv0 Int)) (= (set261 bv0) (and (= bv0 var_u162)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set261 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set262 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u163 bv0) (set262 bv0))) (= var_u163 s)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set263 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u164 bv0) (set263 bv0))) (= var_u164 s)))
(assert (forall ((bv0 Bool)) (= (set264 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u165 bv0) (set264 bv0)))
               (= var_u165 x0))))
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
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv0 ), x0 )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))
 Argument x0 :: {var_v2:Ty_int | true} | true                                                                                                                                                                                                                                                            
# of Final Z3 expressions 45
 Final solver 
 (declare-sort T678 0)
(declare-fun set265 (Bool) Bool)
(declare-fun smem (T678 Int Bool) Bool)
(declare-fun var_u166 () Int)
(declare-fun nil () T678)
(declare-fun set266 (Int) Bool)
(declare-fun shd (T678 Int) Bool)
(declare-fun slen (T678) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(declare-fun set267 (Bool) Bool)
(declare-fun var_u167 () Int)
(declare-fun v () T678)
(declare-fun set268 (Bool) Bool)
(declare-fun var_u168 () Int)
(declare-fun set269 (Bool) Bool)
(declare-fun var_u169 () Int)
(assert (forall ((bv0 Bool)) (= (set265 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u166 bv0) (set265 bv0))))
(assert (forall ((bv0 Int)) (= (set266 bv0) (and (= bv0 var_u166)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set266 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set267 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u167 bv0) (set267 bv0)))
    (= var_u167 x0)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (forall ((bv0 Bool)) (= (set268 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u168 bv0) (set268 bv0)))
    (= var_u168 x0)))
(assert (forall ((bv0 Bool)) (= (set269 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u169 bv0) (set269 bv0)))
               (= var_u169 x0))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv0 ), x0 )
 Finding Already seen tree for apply goal  (, _lbv0 ), s )
 Typechecking apply goal  (, apply subs  (, x0 ) ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Typechecking the Term apply goal  (, _lbv0 ), s )
 Against {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
 Argument _lbv0 :: {v:Ty_int | (v) ==((x0) -- (1))} | (_lbv0) ==((x0) -- (1))
 Argument s :: {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d } | 
 Disj <d  s > 0
 	,   s = 0>d                                                                                                                                                                                                                                                                        
# of Final Z3 expressions 48
 Final solver 
 (declare-sort T682 0)
(declare-fun set270 (Bool) Bool)
(declare-fun smem (T682 Int Bool) Bool)
(declare-fun var_u170 () Int)
(declare-fun nil () T682)
(declare-fun set271 (Int) Bool)
(declare-fun shd (T682 Int) Bool)
(declare-fun slen (T682) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(declare-fun set272 (Bool) Bool)
(declare-fun var_u171 () Int)
(declare-fun v () T682)
(declare-fun set273 (Bool) Bool)
(declare-fun var_u172 () Int)
(declare-fun set274 (Bool) Bool)
(declare-fun var_u173 () Int)
(assert (forall ((bv0 Bool)) (= (set270 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u170 bv0) (set270 bv0))))
(assert (forall ((bv0 Int)) (= (set271 bv0) (and (= bv0 var_u170)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set271 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set272 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u171 bv0) (set272 bv0))) (= var_u171 s)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (forall ((bv0 Bool)) (= (set273 bv0) (and (= bv0 true)))))
(assert (=> (forall ((bv0 Bool)) (= (smem v var_u172 bv0) (set273 bv0))) (= var_u172 s)))
(assert (forall ((bv0 Bool)) (= (set274 bv0) (and (= bv0 true)))))
(assert (let ((a!1 (=> (forall ((bv0 Bool)) (= (smem v var_u173 bv0) (set274 bv0)))
               (= var_u173 x0))))
  (not a!1)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply goal  (, _lbv0 ), s )
  ###################################################
  The Choice of Function goal Was Ill Fated Try Next Choice of function
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
  Enumeration for 
 spec 
 {v:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                                                                          
# of Final Z3 expressions 45
 Final solver 
 (declare-sort T711 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(declare-fun set275 (Bool) Bool)
(declare-fun smem (T711 Int Bool) Bool)
(declare-fun var_u174 () Int)
(declare-fun nil () T711)
(declare-fun set276 (Int) Bool)
(declare-fun shd (T711 Int) Bool)
(declare-fun slen (T711) Int)
(declare-fun set277 (Bool) Bool)
(declare-fun var_u175 () Int)
(declare-fun set278 (Int) Bool)
(declare-fun set279 (Bool) Bool)
(declare-fun ulist (T711 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set275 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u174 bv0) (set275 bv0))))
(assert (forall ((bv0 Int)) (= (set276 bv0) (and (= bv0 var_u174)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set276 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set277 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u175 bv0) (set277 bv0))))
(assert (forall ((bv0 Int)) (= (set278 bv0) (and (= bv0 var_u175)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set278 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set279 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set279 bv0)))))

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
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                                                                               
# of Final Z3 expressions 44
 Final solver 
 (declare-sort T714 0)
(declare-fun set280 (Bool) Bool)
(declare-fun smem (T714 Int Bool) Bool)
(declare-fun var_u176 () Int)
(declare-fun nil () T714)
(declare-fun set281 (Int) Bool)
(declare-fun shd (T714 Int) Bool)
(declare-fun slen (T714) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set280 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u176 bv0) (set280 bv0))))
(assert (forall ((bv0 Int)) (= (set281 bv0) (and (= bv0 var_u176)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set281 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                                                                                                    
# of Final Z3 expressions 41
 Final solver 
 (declare-sort T718 0)
(declare-fun set282 (Bool) Bool)
(declare-fun smem (T718 Int Bool) Bool)
(declare-fun var_u177 () Int)
(declare-fun nil () T718)
(declare-fun set283 (Int) Bool)
(declare-fun shd (T718 Int) Bool)
(declare-fun slen (T718) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set282 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u177 bv0) (set282 bv0))))
(assert (forall ((bv0 Int)) (= (set283 bv0) (and (= bv0 var_u177)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set283 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
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
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T722 0)
(declare-fun set284 (Bool) Bool)
(declare-fun smem (T722 Int Bool) Bool)
(declare-fun var_u178 () Int)
(declare-fun nil () T722)
(declare-fun set285 (Int) Bool)
(declare-fun shd (T722 Int) Bool)
(declare-fun slen (T722) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set284 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u178 bv0) (set284 bv0))))
(assert (forall ((bv0 Int)) (= (set285 bv0) (and (= bv0 var_u178)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set285 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T726 0)
(declare-fun set286 (Bool) Bool)
(declare-fun smem (T726 Int Bool) Bool)
(declare-fun var_u179 () Int)
(declare-fun nil () T726)
(declare-fun set287 (Int) Bool)
(declare-fun shd (T726 Int) Bool)
(declare-fun slen (T726) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set286 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u179 bv0) (set286 bv0))))
(assert (forall ((bv0 Int)) (= (set287 bv0) (and (= bv0 var_u179)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set287 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv1 (- s 1)))
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
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                                                                          
# of Final Z3 expressions 45
 Final solver 
 (declare-sort T763 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(declare-fun set288 (Bool) Bool)
(declare-fun smem (T763 Int Bool) Bool)
(declare-fun var_u180 () Int)
(declare-fun nil () T763)
(declare-fun set289 (Int) Bool)
(declare-fun shd (T763 Int) Bool)
(declare-fun slen (T763) Int)
(declare-fun set290 (Bool) Bool)
(declare-fun var_u181 () Int)
(declare-fun set291 (Int) Bool)
(declare-fun set292 (Bool) Bool)
(declare-fun ulist (T763 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set288 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u180 bv0) (set288 bv0))))
(assert (forall ((bv0 Int)) (= (set289 bv0) (and (= bv0 var_u180)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set289 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set290 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u181 bv0) (set290 bv0))))
(assert (forall ((bv0 Int)) (= (set291 bv0) (and (= bv0 var_u181)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set291 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set292 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set292 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 Found Constructors with required return type
  
 ********************** HERE BEFORE 
 Show No more choices for ConsApp
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
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c } ) ->  Arrow ( ( x0 : {var_v2:Ty_int | true} ) -> {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Impl < (smem)( , v, u ) = (true)
 	 u = x0 > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
  Enumeration for 
 spec 
 {v:Ty_int | 
 	 Conj <c 
 Disj <d  v > 0
 	,   v = 0>d 
 	 , s > v >c }
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {v:Ty_int | 
 Disj <d  v > 0
 	,   v = 0>d }                                                                                                                                                                                                                                                               
# of Final Z3 expressions 44
 Final solver 
 (declare-sort T766 0)
(declare-fun set293 (Bool) Bool)
(declare-fun smem (T766 Int Bool) Bool)
(declare-fun var_u182 () Int)
(declare-fun nil () T766)
(declare-fun set294 (Int) Bool)
(declare-fun shd (T766 Int) Bool)
(declare-fun slen (T766) Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun |0| () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set293 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u182 bv0) (set293 bv0))))
(assert (forall ((bv0 Int)) (= (set294 bv0) (and (= bv0 var_u182)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set294 bv0)))))
(assert (= (slen nil) 0))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (not (and (or (> s |0|) (= s |0|)) (> s s))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term x0
 
 Type of the Scalar Term {var_v2:Ty_int | true}                                                                                                                                                                                                                                                    
# of Final Z3 expressions 41
 Final solver 
 (declare-sort T770 0)
(declare-fun set295 (Bool) Bool)
(declare-fun smem (T770 Int Bool) Bool)
(declare-fun var_u183 () Int)
(declare-fun nil () T770)
(declare-fun set296 (Int) Bool)
(declare-fun shd (T770 Int) Bool)
(declare-fun slen (T770) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set295 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u183 bv0) (set295 bv0))))
(assert (forall ((bv0 Int)) (= (set296 bv0) (and (= bv0 var_u183)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set296 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
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
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T774 0)
(declare-fun set297 (Bool) Bool)
(declare-fun smem (T774 Int Bool) Bool)
(declare-fun var_u184 () Int)
(declare-fun nil () T774)
(declare-fun set298 (Int) Bool)
(declare-fun shd (T774 Int) Bool)
(declare-fun slen (T774) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun _lbv1 () Int)
(declare-fun x0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set297 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u184 bv0) (set297 bv0))))
(assert (forall ((bv0 Int)) (= (set298 bv0) (and (= bv0 var_u184)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set298 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv0 (- x0 1)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv0 (- x0 1)))
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
# of Final Z3 expressions 42
 Final solver 
 (declare-sort T778 0)
(declare-fun set299 (Bool) Bool)
(declare-fun smem (T778 Int Bool) Bool)
(declare-fun var_u185 () Int)
(declare-fun nil () T778)
(declare-fun set300 (Int) Bool)
(declare-fun shd (T778 Int) Bool)
(declare-fun slen (T778) Int)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv1 () Int)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(assert (forall ((bv0 Bool)) (= (set299 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u185 bv0) (set299 bv0))))
(assert (forall ((bv0 Int)) (= (set300 bv0) (and (= bv0 var_u185)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set300 bv0)))))
(assert (= (slen nil) 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv1 (- s 1)))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (= _lbv1 (- s 1)))
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
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v2:Ty_int | true}
  Enumeration for 
 spec 
 {var_v2:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 ############################################################
  Synthesizing the Function application Pure Component cons
 ############################################################
  *************** Trying Arrow Component ************cons :  Arrow ( ( x : {var_v1:Ty_int | true} ) ->  Arrow ( ( xs : {v:Ty_alphalist | (ulist)(v) = (true)} ) -> {v:Ty_alphalist | Forall 
 	 
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
 	 , (slen)(v) ==((slen)(xs) + (1)) >c  >c  >c  }}
  *************** Synthesizing Args ei : ti for ************cons
 ##################################################################################
  Synthesizing the 1th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:Ty_int | true}
  Enumeration for 
 spec 
 {var_v1:Ty_int | true}
 
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
 
 Type of the Scalar Term {var_v2:Ty_int | true}
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
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  Synthesizing the 2th argument for Function cons
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:Ty_alphalist | (ulist)(v) = (true)}
  Enumeration for 
 spec 
 {v:Ty_alphalist | (ulist)(v) = (true)}
 
 Enumerating a Scalar Term nil
 
 Type of the Scalar Term {v:Ty_alphalist | Forall 
 	 
 Key =u Value = Ty_int{ 
 	 Conj <c (smem)( , v, u ) = (false)
 	 , 
 	 Conj <c Negation (shd)(v) = (u)
 	 , (slen)(v) ==(0) >c  >c  }}                                                                                                                                                                                                                                          
# of Final Z3 expressions 45
 Final solver 
 (declare-sort T815 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun x0 () Int)
(declare-fun _lbv0 () Int)
(declare-fun _lbv1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv3 () Bool)
(declare-fun _lbv4 () Bool)
(declare-fun _lbv5 () Bool)
(declare-fun var_v4 () Bool)
(declare-fun var_v42 () Bool)
(declare-fun var_v112 () Bool)
(declare-fun var_v150 () Bool)
(declare-fun set301 (Bool) Bool)
(declare-fun smem (T815 Int Bool) Bool)
(declare-fun var_u186 () Int)
(declare-fun nil () T815)
(declare-fun set302 (Int) Bool)
(declare-fun shd (T815 Int) Bool)
(declare-fun slen (T815) Int)
(declare-fun set303 (Bool) Bool)
(declare-fun var_u187 () Int)
(declare-fun set304 (Int) Bool)
(declare-fun set305 (Bool) Bool)
(declare-fun ulist (T815 Bool) Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (or (> s |0|) (= s |0|)))
(assert (= _lbv0 (- x0 1)))
(assert (= _lbv1 (- s 1)))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv2 true) (and (= x0 |0|) (= (= _lbv2 false) (> x0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv3 true) (and (= s |0|) (= (= _lbv3 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv4 true) (and (= _lbv1 |0|) (= (= _lbv4 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= _lbv5 true) (and (= _lbv0 |0|) (= (= _lbv5 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v4 true) (and (= _lbv0 |0|) (= (= var_v4 false) (> _lbv0 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v42 true) (and (= _lbv1 |0|) (= (= var_v42 false) (> _lbv1 |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v112 true) (and (= s |0|) (= (= var_v112 false) (> s |0|)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set301 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u186 bv0) (set301 bv0))))
(assert (forall ((bv0 Int)) (= (set302 bv0) (and (= bv0 var_u186)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set302 bv0)))))
(assert (= (slen nil) 0))
(assert (= var_v150 true))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= (= var_v150 true) (and (= x0 |0|) (= (= var_v150 false) (> x0 |0|)))))
(assert (forall ((bv0 Bool)) (= (set303 bv0) (and (= bv0 false)))))
(assert (forall ((bv0 Bool)) (= (smem nil var_u187 bv0) (set303 bv0))))
(assert (forall ((bv0 Int)) (= (set304 bv0) (and (= bv0 var_u187)))))
(assert (not (forall ((bv0 Int)) (= (shd nil bv0) (set304 bv0)))))
(assert (= (slen nil) 0))
(assert (forall ((bv0 Bool)) (= (set305 bv0) (and (= bv0 true)))))
(assert (not (forall ((bv0 Bool)) (= (ulist nil bv0) (set305 bv0)))))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 ##################################################################################
  *************** Synthesizing Args ei : Failed for some  arg
 >>>>>>>>>>>>>>>>>>  No pureApp found, Call esynthesizeConsApp <<<<<<<<<<<<<< 
 Found Constructors with required return type
  
 ********************** HERE BEFORE 
 Show No more choices for ConsApp
 Failed Synthesizing any True Branch exp for the selected guard_lbv2
 Try Next guard
  If then else Failed :: Try CDCL without subdivision
 
 
 let _lbv0 = apply subs  (, x0 ) 
 in 
 let _lbv1 = apply subs  (, s ) 
 in 
 let _lbv2 = apply sizecheck  (, x0 ) 
 in 
 let _lbv3 = apply sizecheck  (, s ) 
 in 
 let _lbv4 = apply sizecheck  (, _lbv1 ) 
 in 
 let _lbv5 = apply sizecheck  (, _lbv0 ) 
 in _lbv5
 Synthesis returned witout result