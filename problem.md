
Hi  Suresh,
1. Thanks for pointing me to DPOR, it totally makes sense to use a technique inspired from that to explore optimally by dividing into equivalence classes.

2. However, DPOR (or any other exploration technique we will use) has a clear notion of "equivalence" built-in; 
specifically, two traces are equivalent if two conflicting instructions
have the same order. More formally, ``` let t1 = ....i....j and t2 ....j...i, ``` be two traces
If ``` \forall i, j. R (i) \cap W (j) = \varnothing and W(i) \cap R (j) = \varnothing and W (i) \cap W(j) = \varnothing then t1 ~ t2 ``` 
Where i, j are instructions, and R/W are read and write location sets.

3. So before, we actually chalk out the algorithm (irrespective of DPOR-guided or something else),
 we MUST have a clear idea of equivalence relation between explored programs (which we can learn ideally.)

4. To make sense of this, I began experiments with standard RELATIONAL properties like __idempotence__ , __commutativity__ , __distributivity__, etc., 
and created example (synthetic) for Cobalt where pruning paths 
based on these relations will be useful. Following are few of these relations:

   -  __idempotence__ if ``` \forall x. f (f (x))  = f(x) then f* (f (x)) ~ f (x) ``` and this will help prune the space.
   
   - In effectful setting this is more intricate check: ``` \forall P : predicate, x, y. SP (P, f(x)) => SP (P, f (x) ;f (y)) then f (x); f (y) ~ f (x) ```. 
   Note, the implocation is modulo the goal property.
     e.g. In our Tbl example in cobalt. a term ``` (fresh_str (); fresh_str ()) ~ fresh_str () ``` 
     given our goal spec that says that ``` \exists s. mem (Tbl, s) = false /\ mem (Tbl', s) ```
   
   - I tried encoding this (with some adhoc notion of implication-modulo-goal for now, and using P as the given pre-condition) and can actually prune out several path exploration. 
   (Note, earlier in Cobalt this was encoded in the specs of libarie's , i.e. ``` fresh_str : {sel (h, num) <= 1} unit {sel (h', num) = sel (h num) + 1}) ``` 

    ### I also did similar experiments on paper with other properties:

   -  __commutativity__  in effectful setting is defined more like the non-conflicting property in DPOR. 
   If \forall f1, f2. again R (f1) \cap W (f2) = \varnothing and W(f1) \cap R (f2) = \varnothing and W (f1) \cap W(f2) = \varnothing then f1;f2 ~ f2; f1 

   - Similarly, I also defined on paper, a foraml definition of __distributivity__, which allows to treat programs 
    ``` ( x1 <- f1 (x, y); f2 (x1, z) ) ~ (x1 <- f2 (x, y); x2 <- f2 (x, z); f1 (x1, x2)) ```
   
   - while the __associativity__ is trivially true for the sequencing opertaion i.e. f1;(f2;f3) ~ (f1;f2);f3


 5. Now these experiments show (un-surprisingly) that guiding the synthesis with standard reational-equivalence properties (irrespective of the algorithm for now) optimizes the 
    exploration. However this raises two main questions:
    
    Q1. How interesting is the general problem, i.e. are there other such properties (say \phi_{rel}) which the synthesizer writer want to give which can be useful to guided
    the search process. Without having a positive answer to this (i.e. some non-standard \phi_{rel}, other than those given above), this although novel but will not be 
    well-motivated. 

    One step I am taking to answer this question is as follows: A very different property is the property inspired by focussed proof search (Used in multiple works), I am trying 
    to see if I can write that as some set of relational prpperties (albeit on the deduction rules in the synthesizer rather than terms in the program).


    ### Note: Maybe even these standard property set provided by us is still sufficiently interesting, I will appericiate your comment?

    Q2. Knowing that the general problem is interesting, then should our focus be first to non-effectful programs (the problem is not yet solved for that domain in a foundational way).
       However, there are multiple efforts (including ML techniques) at answering the question 
       "How to efficiently explore the search space in inductive synthesis (i/o- based)" and so we may get a lot of questions asking comparing with these.



       However, the problem is totally novel in the domain of effectful programs (Suslik as we discussed does not even do any clever pruning) and the baseline then is Cobalt.
       So my proposal is to target this space. However, this time to make strong comparison, 
       we should also extend Cobalt to allow separation formulas (this will help define and utilize interesting relational properties) and then clearly comapre apples to apples on some 
       benchmarks. If we can do this we have a strong story I believe. 

       However, attacking the problem first for effect-free language looks more tractable, so I do want to do that (more lower hanging).
 

  6. Conclusion: Thus to conclude, the specific instance of using standard relational properties to define equivalences show positive results, however we need to asnwer two Questions.
  Q1. The motivation for the general problem (what are other non-standard relational properties) . Q2. Shall we do it first on effectfree or effectful right away.
        

In order to answer Q1, we look at some of  the properties used by these works to prune the search space.       