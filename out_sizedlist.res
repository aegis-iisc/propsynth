
  EXPLORED Args.parser output 
 EXPLORED learningOn  true
 EXPLORED bidirectionality  true
 EXPLORED effect-filter  false
 EXPLORED specfile :: tests_specsynth/sizedlist_qunat.spec
 EXPLORED goal Number :: 0
 EXPLORED Max path length :: 3stexcwhitespace var: slen
whitespace colon
whitespace var: list
whitespace colon
whitespace var: int
semicolon
stexcwhitespace var: slist
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
stexcwhitespace var: sorder
whitespace colon
whitespace var: list
whitespace colon
whitespace var: int
whitespace colon
whitespace var: int
whitespace colon
whitespace var: bool
semicolon
stexcwhitespace var: smem
whitespace colon
whitespace var: list
whitespace colon
whitespace var: int
whitespace colon
whitespace var: bool
semicolon
var: gt_eq_int_gen
whitespace colon
whitespace lparen
var: n3
colon
whitespace var: int
rparen
whitespace arrow
whitespace lcurly
var: v
whitespace colon
whitespace var: int
whitespace pipe
whitespace lbrace
var: v
whitespace lessthanopwhitespace var: n3
rbrace
whitespace disjwhitespace lbrace
var: v
equalopvar: n3
rbrace
rcurly
semicolon
whitespace var: subs
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
var: Nil
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
dotwhitespace var: slen
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
var: Cons
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
whitespace truercurly
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
lparen
var: u
whitespace equalopwhitespace var: slen
whitespace lparen
var: xs
rparen
whitespace pluswhitespace int: 1
rparen
whitespace implieswhitespace var: slen
whitespace lparen
var: v
rparen
whitespace equalopwhitespace var: u
rparen
whitespace rcurly
semicolon
whitespace var: goal
whitespace colon
whitespace lparen
var: size
whitespace colon
whitespace lcurly
whitespace var: v
whitespace colon
whitespace var: int
whitespace pipe
whitespace truercurly
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
dotwhitespace whitespace lparen
var: slen
whitespace lparen
var: v
rparen
whitespace equalopwhitespace var: u
whitespace implieswhitespace lparen
whitespace lparen
lbrace
var: u
whitespace lessthanopwhitespace int: 0
rbrace
whitespace disjwhitespace lbrace
var: u
whitespace equalopwhitespace int: 0
rbrace
rparen
whitespace conjwhitespace notwhitespace lbrace
var: u
whitespace lessthanopwhitespace var: size
rbrace
rparen
rparen
rcurly
semicolon
RelSpec {  SRs ;  PRs ;  TSs  
 Assume false
 name gt_eq_int_gen : 
 params :
 Type  Arrow ( ( n3 : {var_v0:int | true} ) -> {v:int | 
 Disj <d  v > n3
 	,   v = n3>d } 
 Assume false
 name subs : 
 params :
 Type  Arrow ( ( n : {v:int | true} ) -> {v:int | (v) ==((n) -- (1))} 
 Assume false
 name Nil : 
 params :
 Type {v:int list | Forall 
 	 
 Key =u Value = int{ (slen)(v) ==(0) }} 
 Assume false
 name sizecheck : 
 params :
 Type  Arrow ( ( s : {var_v1:int | true} ) -> {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 v = false
  s > 0 >c } 
 Assume false
 name Cons : 
 params :
 Type  Arrow ( ( x : {v:int | 
 Disj <d  v > 0
 	,   v = 0>d } ) ->  Arrow ( ( xs : {v:int list | true} ) -> {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (u) ==((slen)(xs) + (1))
 	 (slen)(v) ==(u) > }} 
 Assume false
 name goal : 
 params :
 Type  Arrow ( ( size : {v:int | true} ) -> {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size >c  > }};  Formulas  }
 INITIAL GAMMA 
 
 goal :  Arrow ( ( size : {v:int | true} ) -> {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size >c  > }}
 Cons :  Arrow ( ( x : {v:int | 
 Disj <d  v > 0
 	,   v = 0>d } ) ->  Arrow ( ( xs : {v:int list | true} ) -> {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (u) ==((slen)(xs) + (1))
 	 (slen)(v) ==(u) > }}
 sizecheck :  Arrow ( ( s : {var_v1:int | true} ) -> {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 v = false
  s > 0 >c }
 Nil : {v:int list | Forall 
 	 
 Key =u Value = int{ (slen)(v) ==(0) }}
 subs :  Arrow ( ( n : {v:int | true} ) -> {v:int | (v) ==((n) -- (1))}
 gt_eq_int_gen :  Arrow ( ( n3 : {var_v0:int | true} ) -> {v:int | 
 Disj <d  v > n3
 	,   v = n3>d }
 INITIAL SIGMA 
 
 TypeNames 
 
 Qualifiers 
 
 Qual slen :  :-> int list :-> int
 Qual slist :  :-> int list :-> Ty_bool
 Qual shd :  :-> int list :-> int
 Qual sorder :  :-> int list :-> int :-> int :-> Ty_bool
 Qual smem :  :-> int list :-> int :-> Ty_bool
 Show ***********Calling S-FUNC synthesize***************
 Show Uncurried , size:{v:int | true} -> {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size >c  > }}
 Decreasing Measure size
 Decreasing Type {v:int | true}
 Calculated Decreasing Predicate size > v
 Calculated Decreased Goal Type  Arrow ( ( size1 : {v:int | 
 	 Conj <c true
 	 , size > v >c } ) -> {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size1 >c  > }}
 Show Trying :: Top-level Match
 Show :: Synthesize Match {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size >c  > }}
 Show :: List int
 Show :: Non List Case
 Match-case failed :: Try Top-level If-then-else 
 **********************************************
 iSynthesize If-THEN-ELSE {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size >c  > }}
 **********************************************
  *********************Synthesizing the Guard*******************
 iSynthesize Boolean Guard {var_v2:Ty_bool | true}
  *********************Synthesizing the Guard*******************
 esynthesizeScalar for {var_v2:Ty_bool | true}
 >>>>>>>>>>>>>>>>>> No Scalar found in Environment, Trying esynthesizePureApp <<<<<<<<<<<<<<<<<< 
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 sizecheck
 ############################################################
  Synthesizing the Function application Pure Component sizecheck
 ############################################################
  *************** Trying Arrow Component ************sizecheck :  Arrow ( ( s : {var_v1:int | true} ) -> {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c s = 0
 	 , DoubleImpl 
 v = false
  s > 0 >c }
  *************** Synthesizing Args ei : ti for ************sizecheck
 ##################################################################################
  Synthesizing the 1th argument for Function sizecheck
  Trying Arguments in Scalars 
 esynthesizeScalar for {var_v1:int | true}
 
 Enumerating a Scalar Term size
 
 Type of the Scalar Term {v:int | true}
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
 subs, 
 gt_eq_int_gen
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n : {v:int | true} ) -> {v:int | (v) ==((n) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:int | true}
 
 Enumerating a Scalar Term size
 
 Type of the Scalar Term {v:int | true}
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
 ############################################################
 Max depth reached
 ############################################################
 >>>>>>>>>>>>>>>>>>> 1th Args option for subs : size
  DEPTH vs MAX  2 vs 3
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 Ith Argument Options for subs
 EI size
 # of Possible Argument Options for subs 1
 Possible Arg Options 
 EI size
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs size
 Finding Already seen tree for apply subs  (, size )
 Typechecking apply subs  (, size )
 Against {var_v1:int | true}
 Typechecking the Term apply subs  (, size )
 Against {var_v1:int | true}
 Argument size :: {v:int | true} | true
 AppType Type {v:int | (v) ==((size) -- (1))}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:int | (v) ==((size) -- (1))}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv0 = apply subs  (, size )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 >>>>>>>>>>>>>>>>>>> 1th Args option for sizecheck : size
 >>>>>>>>>>>>>>>>>>> 1th Args option for sizecheck : apply subs  (, size )
  DEPTH vs MAX  1 vs 3
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 Ith Argument Options for sizecheck
 EI size
 EI apply subs  (, size )
 # of Possible Argument Options for sizecheck 2
 Possible Arg Options 
 EI size
 Possible Arg Options 
 EI apply subs  (, size )
 Apply Single Argument Case : f (ei) Case sizecheck
  Case : f (ei) Case sizecheck size
 Finding Already seen tree for apply sizecheck  (, size )
 Typechecking apply sizecheck  (, size )
 Against {var_v2:Ty_bool | true}
 Typechecking the Term apply sizecheck  (, size )
 Against {var_v2:Ty_bool | true}
 Argument size :: {v:int | true} | true
 AppType Type {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c size = 0
 	 , DoubleImpl 
 v = false
  size > 0 >c }
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
  
 	 Conj <c size = 0
 	 , DoubleImpl 
 v = false
  size > 0 >c }
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv1 = apply sizecheck  (, size )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Case : f (ei) Case sizecheck _lbv0
 Finding Already seen tree for apply sizecheck  (, _lbv0 )
 Typechecking apply sizecheck  (, apply subs  (, size ) )
 Against {var_v2:Ty_bool | true}
 Typechecking the Term apply sizecheck  (, _lbv0 )
 Against {var_v2:Ty_bool | true}
 Argument _lbv0 :: {v:int | (v) ==((size) -- (1))} | (_lbv0) ==((size) -- (1))
 AppType Type {v:Ty_bool | DoubleImpl 
 v = true
  
 	 Conj <c _lbv0 = 0
 	 , DoubleImpl 
 v = false
  _lbv0 > 0 >c }
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
 let _lbv2 = apply sizecheck  (, _lbv0 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Show :: Synthesizing The IF-THEN-ELSE for Next Boolean Guard apply sizecheck  (, size )
  *********************Synthesizing the True branch*******************
 Show :: True Predicate 
 	 Conj <c var_v3 = true
 	 , DoubleImpl 
 var_v3 = true
  
 	 Conj <c size = 0
 	 , DoubleImpl 
 var_v3 = false
  size > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size >c  > }}
 
 Enumerating a Scalar Term Nil
 
 Type of the Scalar Term {v:int list | Forall 
 	 
 Key =u Value = int{ (slen)(v) ==(0) }}                                                                                                                  
# of Final Z3 expressions 12
 Final solver 
 (declare-sort T28 0)
(declare-fun |0| () Int)
(declare-fun slen (T28) Int)
(declare-fun Nil () T28)
(declare-fun size () Int)
(declare-fun var_v3 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv1 () Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u5 Int) (var_u4 Int))
  (let ((a!1 (= (= _lbv1 true)
                (and (= size |0|) (= (= _lbv1 false) (> size |0|)))))
        (a!2 (= (= _lbv2 true)
                (and (= _lbv0 |0|) (= (= _lbv2 false) (> _lbv0 |0|)))))
        (a!3 (= (= var_v3 true)
                (and (= size |0|) (= (= var_v3 false) (> size |0|))))))
    (and (= _lbv0 (- size 1))
         a!1
         a!2
         a!3
         (= (slen Nil) 0)
         (= var_v3 true)
         a!3
         (= (slen Nil) 0)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (let ((a!1 (forall ((var_u6 Int))
             (=> (= (slen Nil) var_u6)
                 (and (or (> var_u6 |0|) (= var_u6 |0|)) (not (> var_u6 size)))))))
  (not a!1)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Show :: Found a Few Macthing Scalars 
 *********************************************
 True Branch :: Successfully Synthesisized
 *********************************************
 if apply sizecheck  (, size )
 	 then 
 ***********
 Nil
 *********************************************
 ************ Synthesize False Branch**************
 *********************************************
 False Branch :: Trying False Branch
 Show :: Synthesizing the false branch
 Show :: False Predicate 
 	 Conj <c var_v3 = false
 	 , DoubleImpl 
 var_v3 = true
  
 	 Conj <c size = 0
 	 , DoubleImpl 
 var_v3 = false
  size > 0 >c  >c 
 Show ***********Calling Scalar synthesize***************
 esynthesizeScalar for {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size >c  > }}
 
 Enumerating a Scalar Term Nil
 
 Type of the Scalar Term {v:int list | Forall 
 	 
 Key =u Value = int{ (slen)(v) ==(0) }}                                                                                                                  
# of Final Z3 expressions 12
 Final solver 
 (declare-sort T32 0)
(declare-fun |0| () Int)
(declare-fun slen (T32) Int)
(declare-fun Nil () T32)
(declare-fun size () Int)
(declare-fun var_v3 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv1 () Bool)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u8 Int) (var_u7 Int))
  (let ((a!1 (= (= _lbv1 true)
                (and (= size |0|) (= (= _lbv1 false) (> size |0|)))))
        (a!2 (= (= _lbv2 true)
                (and (= _lbv0 |0|) (= (= _lbv2 false) (> _lbv0 |0|)))))
        (a!3 (= (= var_v3 true)
                (and (= size |0|) (= (= var_v3 false) (> size |0|))))))
    (and (= _lbv0 (- size 1))
         a!1
         a!2
         a!3
         (= (slen Nil) 0)
         (= var_v3 false)
         a!3
         (= (slen Nil) 0)))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (let ((a!1 (forall ((var_u9 Int))
             (=> (= (slen Nil) var_u9)
                 (and (or (> var_u9 |0|) (= var_u9 |0|)) (not (> var_u9 size)))))))
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
 Cons
 ############################################################
  Synthesizing the Function application Pure Component goal
 ############################################################
  *************** Trying Arrow Component ************goal :  Arrow ( ( size1 : {v:int | 
 	 Conj <c true
 	 , size > v >c } ) -> {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size1 >c  > }}
  *************** Synthesizing Args ei : ti for ************goal
 ##################################################################################
  Synthesizing the 1th argument for Function goal
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:int | 
 	 Conj <c true
 	 , size > v >c }
 
 Enumerating a Scalar Term size
 
 Type of the Scalar Term {v:int | true}                                                                                                       
# of Final Z3 expressions 10
 Final solver 
 (declare-sort T35 0)
(declare-fun |0| () Int)
(declare-fun size () Int)
(declare-fun var_v3 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv1 () Bool)
(declare-fun slen (T35) Int)
(declare-fun Nil () T35)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u10 Int))
  (let ((a!1 (= (= _lbv1 true)
                (and (= size |0|) (= (= _lbv1 false) (> size |0|)))))
        (a!2 (= (= _lbv2 true)
                (and (= _lbv0 |0|) (= (= _lbv2 false) (> _lbv0 |0|)))))
        (a!3 (= (= var_v3 true)
                (and (= size |0|) (= (= var_v3 false) (> size |0|))))))
    (and (= (slen Nil) 0) (= _lbv0 (- size 1)) a!1 a!2 a!3 (= var_v3 false) a!3))))
(assert (not (> size size)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term n
 
 Type of the Scalar Term {v:int | true}                                                                                                       
# of Final Z3 expressions 10
 Final solver 
 (declare-sort T39 0)
(declare-fun |0| () Int)
(declare-fun size () Int)
(declare-fun var_v3 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv1 () Bool)
(declare-fun slen (T39) Int)
(declare-fun Nil () T39)
(declare-fun n () Int)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u11 Int))
  (let ((a!1 (= (= _lbv1 true)
                (and (= size |0|) (= (= _lbv1 false) (> size |0|)))))
        (a!2 (= (= _lbv2 true)
                (and (= _lbv0 |0|) (= (= _lbv2 false) (> _lbv0 |0|)))))
        (a!3 (= (= var_v3 true)
                (and (= size |0|) (= (= var_v3 false) (> size |0|))))))
    (and (= (slen Nil) 0) (= _lbv0 (- size 1)) a!1 a!2 a!3 (= var_v3 false) a!3))))
(assert (not (> size n)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:int | (v) ==((size) -- (1))}                                                                                                       
# of Final Z3 expressions 10
 Final solver 
 (declare-sort T43 0)
(declare-fun |0| () Int)
(declare-fun size () Int)
(declare-fun _lbv0 () Int)
(declare-fun var_v3 () Bool)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv1 () Bool)
(declare-fun slen (T43) Int)
(declare-fun Nil () T43)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u12 Int))
  (let ((a!1 (= (= _lbv1 true)
                (and (= size |0|) (= (= _lbv1 false) (> size |0|)))))
        (a!2 (= (= _lbv2 true)
                (and (= _lbv0 |0|) (= (= _lbv2 false) (> _lbv0 |0|)))))
        (a!3 (= (= var_v3 true)
                (and (= size |0|) (= (= var_v3 false) (> size |0|))))))
    (and (= (slen Nil) 0)
         a!1
         a!2
         a!3
         (= _lbv0 (- size 1))
         (= var_v3 false)
         a!3
         (= _lbv0 (- size 1))))))
(assert (not (> size _lbv0)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 Returned Successfully
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {var_v1:int | true}                                                                                                       
# of Final Z3 expressions 10
 Final solver 
 (declare-sort T47 0)
(declare-fun |0| () Int)
(declare-fun size () Int)
(declare-fun var_v3 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv1 () Bool)
(declare-fun slen (T47) Int)
(declare-fun Nil () T47)
(declare-fun s () Int)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u13 Int))
  (let ((a!1 (= (= _lbv1 true)
                (and (= size |0|) (= (= _lbv1 false) (> size |0|)))))
        (a!2 (= (= _lbv2 true)
                (and (= _lbv0 |0|) (= (= _lbv2 false) (> _lbv0 |0|)))))
        (a!3 (= (= var_v3 true)
                (and (= size |0|) (= (= var_v3 false) (> size |0|))))))
    (and (= (slen Nil) 0) (= _lbv0 (- size 1)) a!1 a!2 a!3 (= var_v3 false) a!3))))
(assert (not (> size s)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
 
 FaileD the subtype check T_vi <: T_goal
 Show :: Found a Few Macthing Scalars 
 ##################################################################################
  Next Trying Arguments of the form f (ei...) 
 ##################################################################################
  Entering Pure Fun Application: esynthesizePureApp 
 Show Potential Functions
  , 
 subs, 
 gt_eq_int_gen
 ############################################################
  Synthesizing the Function application Pure Component subs
 ############################################################
  *************** Trying Arrow Component ************subs :  Arrow ( ( n : {v:int | true} ) -> {v:int | (v) ==((n) -- (1))}
  *************** Synthesizing Args ei : ti for ************subs
 ##################################################################################
  Synthesizing the 1th argument for Function subs
  Trying Arguments in Scalars 
 esynthesizeScalar for {v:int | true}
 
 Enumerating a Scalar Term size
 
 Type of the Scalar Term {v:int | true}
# of Final Z3 expressions 2
 Final solver 
 (assert false)
(assert (not true))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
 
 Enumerating a Scalar Term n
 
 Type of the Scalar Term {v:int | true}
 ################################################
 Skipping Variable n As this a  Formal Parameter to the current function Call
 ################################################
 
 Enumerating a Scalar Term _lbv0
 
 Type of the Scalar Term {v:int | (v) ==((size) -- (1))}
 ################################################
 Skipping Variable _lbv0 As Outer Function Call is subs
 
 Enumerating a Scalar Term s
 
 Type of the Scalar Term {var_v1:int | true}
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
 ############################################################
 Max depth reached
 ############################################################
 >>>>>>>>>>>>>>>>>>> 1th Args option for subs : s
 >>>>>>>>>>>>>>>>>>> 1th Args option for subs : size
  DEPTH vs MAX  2 vs 3
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 Ith Argument Options for subs
 EI s
 EI size
 # of Possible Argument Options for subs 2
 Possible Arg Options 
 EI s
 Possible Arg Options 
 EI size
 Apply Single Argument Case : f (ei) Case subs
  Case : f (ei) Case subs s
 Finding Already seen tree for apply subs  (, s )
 Typechecking apply subs  (, s )
 Against {v:int | 
 	 Conj <c true
 	 , size > v >c }
 Typechecking the Term apply subs  (, s )
 Against {v:int | 
 	 Conj <c true
 	 , size > v >c }
 Argument s :: {var_v1:int | true} | true
 AppType Type {v:int | (v) ==((s) -- (1))}                                                                                                       
# of Final Z3 expressions 10
 Final solver 
 (declare-sort T61 0)
(declare-fun |0| () Int)
(declare-fun s () Int)
(declare-fun v () Int)
(declare-fun size () Int)
(declare-fun var_v3 () Bool)
(declare-fun _lbv0 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv1 () Bool)
(declare-fun slen (T61) Int)
(declare-fun Nil () T61)
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (forall ((var_u14 Int))
  (let ((a!1 (= (= _lbv1 true)
                (and (= size |0|) (= (= _lbv1 false) (> size |0|)))))
        (a!2 (= (= _lbv2 true)
                (and (= _lbv0 |0|) (= (= _lbv2 false) (> _lbv0 |0|)))))
        (a!3 (= (= var_v3 true)
                (and (= size |0|) (= (= var_v3 false) (> size |0|))))))
    (and (= (slen Nil) 0)
         (= _lbv0 (- size 1))
         a!1
         a!2
         a!3
         (= v (- s 1))
         (= var_v3 false)
         a!3
         (= v (- s 1))))))
(assert (not (> size v)))

 OutBuf:sat
:sat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Failed SMT $$$$$$$$$$$$$$
  FAILED Typechecking PURE APP For apply subs  (, s )
  Case : f (ei) Case subs size
 Finding Already seen tree for apply subs  (, size )
 Found _lbv0
 >>>>>>>>>>>>>>>>>>> 1th Args option for goal : apply subs  (, size )
 >>>>>>>>>>>>>>>>>>> 1th Args option for goal : apply subs  (, size )
  DEPTH vs MAX  1 vs 3
 ##################################################################################
  *************** Successfully Synthesized Args ei Forall i 
 Ith Argument Options for goal
 EI apply subs  (, size )
 EI apply subs  (, size )
 # of Possible Argument Options for goal 2
 Possible Arg Options 
 EI apply subs  (, size )
 Possible Arg Options 
 EI apply subs  (, size )
 Apply Single Argument Case : f (ei) Case goal
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Typechecking apply goal  (, apply subs  (, size ) )
 Against {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size >c  > }}
 Typechecking the Term apply goal  (, _lbv0 )
 Against {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > size >c  > }}
 Argument _lbv0 :: {v:int | (v) ==((size) -- (1))} | (_lbv0) ==((size) -- (1))
 AppType Type {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > _lbv0 >c  > }}                                                                                                                                                       
# of Final Z3 expressions 16
 Final solver 
 (declare-sort T65 0)
(declare-fun |0| () Int)
(declare-fun _lbv0 () Int)
(declare-fun slen (T65) Int)
(declare-fun v () T65)
(declare-fun size () Int)
(declare-fun var_v3 () Bool)
(declare-fun size1 () Int)
(declare-fun _lbv2 () Bool)
(declare-fun _lbv1 () Bool)
(declare-fun Nil () T65)
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
(assert (forall ((var_u17 Int) (var_u16 Int) (var_u15 Int))
  (let ((a!1 (= (= _lbv1 true)
                (and (= size |0|) (= (= _lbv1 false) (> size |0|)))))
        (a!2 (= (= _lbv2 true)
                (and (= _lbv0 |0|) (= (= _lbv2 false) (> _lbv0 |0|)))))
        (a!3 (= (= var_v3 true)
                (and (= size |0|) (= (= var_v3 false) (> size |0|)))))
        (a!4 (=> (= (slen v) var_u16)
                 (and (or (> var_u16 |0|) (= var_u16 |0|))
                      (not (> var_u16 _lbv0)))))
        (a!5 (=> (= (slen v) var_u17)
                 (and (or (> var_u17 |0|) (= var_u17 |0|))
                      (not (> var_u17 _lbv0))))))
    (and (= (slen Nil) 0)
         (= _lbv0 (- size 1))
         a!1
         a!2
         a!3
         (> size size1)
         a!4
         (= var_v3 false)
         a!3
         (= _lbv0 (- size 1))
         a!5))))
(assert (= |0| 0))
(assert (= |0| 0))
(assert (let ((a!1 (forall ((var_u18 Int))
             (=> (= (slen v) var_u18)
                 (and (or (> var_u18 |0|) (= var_u18 |0|))
                      (not (> var_u18 size)))))))
  (not a!1)))

 OutBuf:unsat
:unsat

 $$$$$$$$$$$$ Returned $$$$$$$$$$$$$$$$$$$
 $$$$$$$$$$$$$ Success SMT $$$$$$$$$$$$$$
  Show *************** TypeChecking Succsessful {v:int list | Forall 
 	 
 Key =u Value = int{ 
 	 Impl < (slen)(v) ==(u)
 	 
 	 Conj <c 
 Disj <d  u > 0
 	,   u = 0>d 
 	 , Negation u > _lbv0 >c  > }}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 let _lbv3 = apply goal  (, _lbv0 )
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Case : f (ei) Case goal _lbv0
 Finding Already seen tree for apply goal  (, _lbv0 )
 Found _lbv3
 Show :: Successfully Synthesisized False Branch 
  Found a If Then Else solution
 *************************
 Success : 
 ************************* : 